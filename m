Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83154C9830D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0830110E165;
	Wed, 23 Sep 2026 21:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0fifdgyR";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E7AF10E165
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbPRTgHmTSOiPaDKI4z90wjiqm28s368/jbUrnSvXDnGUr9vq3X6jtkKXj6gyGN1B8RZ2iIYiSz4UrpGlPFEChgbmTGkE95xb1vKgvKNptIDrF5z4W2fZYMwTq4wYBmApE5LZvbYP5G8XFdmTgWHXWSrfdm3+SS6dvgc6lIugZl7DhAkNLc7FkxI0JrcSgbcaOBA4zA/Qx0QZNzCtV9BKJ4C6IGg5QkJcFBr2r+u5XfixRpF5lDzMck0vs1xHd5KphuJQ6eTEF0oU80Mk99Qb8VZk5da2Wy+xFOvOg/FcpoZhsPxcGWYn47sMVJMz/fuZLnMP2JibhBA9nlQTLnnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN4YEqmXjLsNTi23SQQgjVu9bvaAJpITgV+0nc7nfaQ=;
 b=XDdJO+pZ1NpGAVL7rQp/a3qXGbORREjPQhbEshYWiROSsc+i9Aq4EvJtfU7Hvbik6ycdkTteNi5uZNpiA3TGVKZX6WTFPqm4gEyN6eGViXKe28z1I8neO5HNHci3ekrVCWY0YeW96TP30+RNEBinLOaOBEYGCVLvpJGjBNLxtpIR+kQ3vVbVNKWvlMQ6WfM6QNtMFhAnyuxKEHf30wHLcgP2T6AXGCQdRcRSePlmdgqNxHpdLFnldyvETYsFVgg+T0L350HlWpvirIe7E26yKtJQlGMpGjPqcD5ThUOgCaqXCU9OZS9q3W4YesGR3UyQxlB5kUwx5eY8PCr2prXulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN4YEqmXjLsNTi23SQQgjVu9bvaAJpITgV+0nc7nfaQ=;
 b=0fifdgyRxbZTlNwgxLkfsjt0e+AXp/gWzdT0CyHJ3wPbgb9sDG7++GIMzBsGA3MGZqhhZm/UBDX9Sx32SRHdD1mRMSZHcSCP1wdBisF14hVztpoMGK61INoxogglsNXJynNMpaVkfJz5KqVrZxzI1ppvbnEI5yRqEUZW+AfztTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by MW3PR12MB4347.namprd12.prod.outlook.com
 (2603:10b6:303:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 21:57:18 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 21:57:18 +0000
Message-ID: <2a0655e8-9284-4ba9-b3bd-ce2eb2ae036a@amd.com>
Date: Wed, 23 Sep 2026 17:57:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix bo_va leak / WARN_ON in
 gem_object_open error path
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com,
 Christian.Koenig@amd.com
References: <20260923212838.1421843-1-mukul.joshi@amd.com>
 <20260923212838.1421843-2-mukul.joshi@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260923212838.1421843-2-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::7) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 3629cbd9-00c4-47a0-a765-08df19bda2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jDvhZpSHZH/npRknWmSh63s/Xs82oJD9P5VidrUWVy4poHFD+KVkMrnhBdUaBzprQlKFKmqku1jkRZs5GRe8Fi4czspDP+KhWu3FXioyMvnGdkoFCxfh9mLjhZoaF+QZISt6BVPSeHFmzhRLM7wPIOJx4cE7T5nDmFeNi0B2w5IMYGG7AXSeNRqHlW87cbUFEe2WdhX/tLmKGmoPXnxJyFea2+jFkPrFmSjoQ7d+YwuV+afL+H6Kt/lQYMvb5jF28eG75i0Y5mScnYig+D8M+Cbih44bbFWIcxnyUm4qEYoawJ3P9sxcHC5MhErqjpCWY8fJhf7lkJP2yRT+f2AOtg5YdpffCkUdyhMLW/XkilAagjcAk5Ut22Z0ZnOhmfW+ao4bBVCXwz4tw8kU95G9PDwGJR/lG1Qq/YhMPOdL6r6tMpuk0bAtW6UUKwqPLlH0Xe61r7jSHH4/uOOw3grerBx3cGdEcb466mCDvoth7ZnTka/vJfwImDUSjb7gp9KS5tjCllU+t6+sNLsA9nl1TU82X5XXtp3RAss2o8uRXqyIsKM8LVptQ4lV6IjBgy2KuWdAVu2qgs3lD6yXzWPNbfy0eRrwoKgLyI1lzqWzJnfmVQflEMCnt1c/SazZYzk3R/199Gp91IdbxyLWK7O/nXrNSelna2AvEwYP6NjH2ro=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THM0cG15L0dXYU1QeG9QSC9qYVl3VUJxR3l2bmVjbXFrcFhjMm1NOUJZQzQw?=
 =?utf-8?B?T0VQMUczVTVOSTFtbzliakJ2REtmKzU1RUJkdVl0THd0UUgyZFlQN3VPZGhG?=
 =?utf-8?B?T3FtL0x5SExtTzRnYUhncnAydWtUWk9CMWdJWU5VT0xheWZ0U0k1Qnk1Z1lV?=
 =?utf-8?B?ZmR2NGxrblpySDJqNjlpVGd3Q1FMZWVpdFA2YngzODZzbldOenZjdkQ4Ykor?=
 =?utf-8?B?Q1FFZE8rV3lHSUFOYWNaKzRlVXlySVJYV3ZTSVd0V1dhWmVVTnJuWkNycTR4?=
 =?utf-8?B?cm05dmRHcVZyVE42QitNUEtKU0tGYXlWb2pCTzcwMjRNV2EyTXRqY05zOXY0?=
 =?utf-8?B?VnFYRGF2SkRBMVB0YjE5UDRNTUp0TklyOXhQMnJwenR6QzI5bVNPWlozWUtR?=
 =?utf-8?B?ZC84bmxVOG0xOWplbHJyZjE0dnlOSis5MXAvb1lLaFgzQ21RRWdPZFl6Ymdr?=
 =?utf-8?B?NnhDUTJGeGYxbWdPazNKWDkrbVpRNzFtVk9QMkFCdmFadkR3MjdyalNZVGZy?=
 =?utf-8?B?M2ZMQzBRNUJXczFBQVl3Z2FycEpTUlNBeWVZSzBZRjFkL0ZrcE1vOWdaZjRo?=
 =?utf-8?B?MlBxVjNvMXpVWXE5T3QxN1B1ekwvZzlWb1hKZWVlQ29rWXRId24raDJYQUho?=
 =?utf-8?B?YlZhR09sZEJMZkMzV2tqb01FMXp4azJ0Z0ZNR1EralhaVWZKV3V3eEN0VGNC?=
 =?utf-8?B?d3BjOUpJOHcrWTBMOHFCT0xyakpGM1MyVzhrUDhkRFp3MGNGUWJ1T0RLL2dS?=
 =?utf-8?B?MW9iM0JSSWErZGZjZnhVcm03cVA4dHUybk05cVhLcHJmMTBieHBIdUxJcHVQ?=
 =?utf-8?B?OVNOTXZPK3pydno0TFp1dGRmMTNvSzRwNUphUmx3elJ4NFhIamlKdmYvNm1B?=
 =?utf-8?B?ZVRKSEd2ejBBOVQvRnZxQ3pyZVEyZzl0WnZIb1h2VHBGeitjME03SVJMQTJx?=
 =?utf-8?B?M29MMmo3SUN2RnBIOEE3MWx3eE5xYmJYYUt3RXlZRUN5emZ4MjVMUi9IZm9G?=
 =?utf-8?B?eGxnQ0JZcVFKQVhkMG1wY1pZdy9oTFYrclhGU0d1R2ZRczRDMDNsMVBUbjBw?=
 =?utf-8?B?a2lyYlZBRXl0Z0RUdThickxGeHora1NUbGJ0ZGRFaW5iY1JsVERXL29KdU4v?=
 =?utf-8?B?anZPTHFDbllhZFF4WVBoUER5d1h4RkNVMzVnd1NqbjBseWZMdFRwYU1lZ1J6?=
 =?utf-8?B?TlFGVTNiQUtMZFdGYXNzUlJzaWtPcjl3VFBITHJRMm5PcmZoZzgzN0xLalZG?=
 =?utf-8?B?ZVArY2Z3ZFhZN0VGQXFRalB4SDMxd29SS0x1UG0zR2FvZ0xuWU0xY0p6a2k0?=
 =?utf-8?B?alpuOFgxNGw3OHM5TTFPU1VoemJZUHg4eDV6ZDFRVVFXakdQemxyMHpocnhM?=
 =?utf-8?B?SDVVWW91b0R0dStsM1U4MjkvbG93Z2lvMEJZTUhLUnFlM2ZQYVpESUY4MUoz?=
 =?utf-8?B?QU5ScFNJRUt4RzdPTjNuNkVmNXJUUDVIa3J5ZUNGR1dCN25BYXdUbUJVM1h0?=
 =?utf-8?B?UFdKam05VDNnV01VK2FMK2pyVHNCNEc3U3hBV0VMa09tOTY3QmQwbWVyM3Fi?=
 =?utf-8?B?SjVVQmJ5dnN4YnNwWm1WYXJBK3k5MXorVC9YelhuVVFlaStVd0lQVFp1Qy9T?=
 =?utf-8?B?SFQrYlVFV1FYQUtBMTJkN3VNSlA5UG1LNGloMlZEbHlSWkdsSVVITGpaUyts?=
 =?utf-8?B?NndqYXZtcVFJcm5LenpwY01IUjNDdHlQVVFZWHFXTERhbk9ua3ZocVZzVE1X?=
 =?utf-8?B?VWlRdE5QTlIzU2NrRktkUWJSNDVJWEFXQXNGa0Zlc2xTMTlHTTZCYlhJYlQ0?=
 =?utf-8?B?aE92Si96SmtNSWlVdVA1Q2NNdDkvMTQ0ZERsbStrY0oxV2pHdEFGUWtHYmhD?=
 =?utf-8?B?RUFnQ0FMcGpBaDcyZUU3Snplai9nODVrSkpyaFg2UXlidW5zQ1NBaElBcWdL?=
 =?utf-8?B?RVRwcDN1aCt4MW9INFZCRkhjdVU5aFB4RE5tbHNtQjc4WkY4OW43OWJLWnhX?=
 =?utf-8?B?R0NHUml4NnZURjhubU1TQnQ1VFFQR2JmZTlNVmIwMTlnTWpJb1RIZE1PS0xO?=
 =?utf-8?B?cDBtbTlBbjVqL3E2blVMMnhKb2dmclR5UENOWGZudys1c3ozT0s3dFN6QWNx?=
 =?utf-8?B?eTdyWjNZa2VxOWExNnk5ZW9nNk1wTTBZUGtyUkJuZ2RTWDRZOE9hcUZEbXRY?=
 =?utf-8?B?U0h6eXRGMGs4NFBYdlRZLzFmTFMzelhmNWtJWXFxRmxlMVZINUZoVWpxazlL?=
 =?utf-8?B?Zm5VN1A0ZWUzKzdEZjZhbGsxTTFPU1ZybkNwRHNPckU1SnJDQjE4QlNDNENH?=
 =?utf-8?Q?15cZT+WQuwwJWUYTcW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3629cbd9-00c4-47a0-a765-08df19bda2c8
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:57:18.1968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hqQ+CshyZSvRdUsPOdl7VGZ01f3Cqna2BoaYgWT6SlwLBnVx3+HKrEZwahXvdL4YFXx0+gwN0E58Fobhg0Fkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
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

On 2026-09-23 17:28, Mukul Joshi wrote:
> amdgpu_gem_object_open() maps the BO into the caller's VM early
> (amdgpu_vm_bo_add(), which sets abo->vm_bo) and only later validates and
> attaches an eviction fence for dynamic dma-buf imports in compute VMs via
> amdgpu_amdkfd_bo_validate_and_fence().
>
> When that validate/fence step fails, the function returned the error
> without undoing the VM mapping. Since .open() failed,
> drm_gem_handle_create_tail() aborts the import and drops the last
> reference, freeing the BO while it still has a bo_va attached. This trips
> WARN_ON(abo->vm_bo) in amdgpu_bo_release_notify() and leaks the bo_va:
>
>    amdgpu 0004:04:00.0: validate_and_fence failed: -12
>    WARNING: CPU: 96 PID: 2868883 at amd/amdgpu/amdgpu_object.c:1343
>             amdgpu_bo_release_notify+0x15d/0x180 [amdgpu]
>     ttm_bo_put+0x149/0x350 [amdttm]
>     drm_gem_prime_fd_to_handle+0x132/0x1c0 [drm]
>     drm_ioctl+0x251/0x3d0 [drm]
>
> Roll back the VM mapping on the error path: re-reserve the BO and PD, then
> either delete the freshly added bo_va (also detaching the eviction fence)
> or drop the extra ref_count taken for a pre-existing bo_va. Also clean up
> the bo_va in the out_unlock path when the eviction fence attach itself
> fails right after amdgpu_vm_bo_add(), which had the same leak.

That looks like a lot of complexity for a rollback. Would it be easier 
to move validate_and_fence before mapping the BO? That way, if 
validate_and_fence fails, there is less to roll back.

Regards,
   Felix


>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 53 +++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0d579517c03c..d52bbdc42b31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -237,6 +237,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	struct amdgpu_bo_va *bo_va;
>   	struct mm_struct *mm;
>   	struct drm_exec exec;
> +	bool bo_va_added = false;
>   	int r;
>   
>   	mm = amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
> @@ -264,6 +265,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	bo_va = amdgpu_vm_bo_find(vm, abo);
>   	if (!bo_va) {
>   		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
> +		bo_va_added = true;
>   		r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
>   		if (r)
>   			goto out_unlock;
> @@ -304,9 +306,60 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   		}
>   	}
>   	mutex_unlock(&vm->process_info->lock);
> +	if (r)
> +		goto out_vm_bo_rollback;
> +	return 0;
> +
> +out_vm_bo_rollback:
> +	/*
> +	 * The open failed after we already mapped the BO into this VM. Undo
> +	 * that mapping, otherwise drm_gem_handle_create_tail() aborts the
> +	 * import and frees the BO while it still has a bo_va attached
> +	 * (abo->vm_bo != NULL), tripping WARN_ON(abo->vm_bo) in
> +	 * amdgpu_bo_release_notify() and leaking the bo_va.
> +	 */
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		int r2 = drm_exec_prepare_obj(&exec, &abo->tbo.base, 1);
> +
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r2))
> +			goto out_rollback_unlock;
> +
> +		r2 = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r2))
> +			goto out_rollback_unlock;
> +	}
> +
> +	bo_va = amdgpu_vm_bo_find(vm, abo);
> +	if (bo_va) {
> +		if (bo_va_added) {
> +			if (!amdgpu_vm_is_bo_always_valid(vm, abo))
> +				amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, abo);
> +			amdgpu_vm_bo_del(adev, bo_va);
> +			amdgpu_vm_bo_update_shared(abo);
> +		} else {
> +			--bo_va->ref_count;
> +		}
> +	}
> +
> +out_rollback_unlock:
> +	drm_exec_fini(&exec);
>   	return r;
>   
>   out_unlock:
> +	/*
> +	 * If we already added a bo_va (e.g. the eviction fence attach below
> +	 * failed), remove it while still holding the reservations so the BO is
> +	 * not freed with a dangling abo->vm_bo.
> +	 */
> +	if (bo_va_added) {
> +		bo_va = amdgpu_vm_bo_find(vm, abo);
> +		if (bo_va)
> +			amdgpu_vm_bo_del(adev, bo_va);
> +		amdgpu_vm_bo_update_shared(abo);
> +	}
>   	drm_exec_fini(&exec);
>   	return r;
>   }
