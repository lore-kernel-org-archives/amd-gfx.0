Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6728AEA3C5C
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 11:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4BC910E7CD;
	Thu,  9 Apr 2026 11:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X5N+3cSM";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9EB10E7CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 11:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxCJHMeIoHqIP75wTRS7Ng58H1/c31ylFecFgitxZd7Q2vOh2uAfVkRnQvaXUNUNniMW3OSjXv1EeJeIwTaJx+FSSlxgS4ORCqsyMCWLd95cy+8BMt/aD+6OdvrBXby6QCzr+cnw5OpxpVtZ5ClVQeGBv3c80V6f0AqcqRgkRfgx2/QLps6ny/HvXbqfeZJjDRxbO/GlHVT5mz215l0vcKa0yPXVVYeLAxO6R6VxnFSOybTQj3Dux3IOUs9eo70EgkzJmyPtBhQF1rr8hTMdaDSgg5xLapu4Eh6g2wZbDkY1XbLH6faACZbHb9tzxmR5pso2V79ygx0jMzSlj7jETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vqWGticgKjIsYmL+6YIBSN2mwGwbJnl8UmYyTjqyPA=;
 b=eiFYrxr3XqKkcRDIULr2GcsgrjBJvbbNxypCgv9hQBVhiriuVqeo6h2FwaZ0a5g1LlNGo8RgcF7MZOmbyZVkK1Fw0FUvZybSiZli8ihNkef76IYf8VRfjWMZ7wPnU8uNY9z5g3taJjYLCxVnnQhZv/dxwAR02DEwnCjLYXK8k0ESU5jL5jxQMW02S5YigAd3xz+PvSuFYyXJi5knSzLN0nBsufjfpk5Yb+K8sbOWwoFwb9wM47YHKq9627Cqrdw2hbgBmXfxSHnkzmf+aeOJMBc29dKCpJF7HfCsA3+3uRhp5VNij2wPeep/3YVwAA/8aDSFA4dAHvUuYzVLxLiXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vqWGticgKjIsYmL+6YIBSN2mwGwbJnl8UmYyTjqyPA=;
 b=X5N+3cSMcvkxWcoBPc7ZM9zYet0jKs3jjaXFkRlz2La+MD83J/Z6Blof94eZrF8d3J/MGvzWYMZS3brqoDerR14Mx69xdCrEjXq0cYuuqvcUc52NwsOChA8VAki37I+XgbjFeULMSd7ijJJwIr7Su7Fue+ZsY1Z7dClgTocAo+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 11:59:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 11:59:00 +0000
Message-ID: <25488a11-dee0-4397-949f-d166edaf674c@amd.com>
Date: Thu, 9 Apr 2026 13:58:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] drm/amdgpu/userq: caller to take reserv lock for
 amdgpu_userq_buffer_vas_list_cleanup
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260409083355.1326089-1-sunil.khatri@amd.com>
 <20260409083355.1326089-4-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260409083355.1326089-4-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0140.namprd02.prod.outlook.com
 (2603:10b6:208:35::45) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 36007a81-88fe-46aa-f573-08de962f62c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: bbIQOd/gULowjm2rkv4yosIQd8r89sU1tEKv5Go52PaUmYb800YTTS+gjb9AQacUDzUgatMmLY4Jynq/zXvNfpwEVpathpFABjdsSP06uXfvDsSzJN7qIHTrtWJsr1O7R44gYzIW8W2iAYTn0EzFs/2yevZIOaQg4BbeAsVONTwkp0CI89e8KseteIhZr8Y0w6Q99kDaJ/HEEMEcgo6Imri8qpaetHqkaywBE9C6NAg94Q4rZ0VoUELtiELD68P1E0UIoTocux0jR6jTZ6Y6iOMa/AdNrDSMHPm6O9AEnyCbq74qUzqeghUaTq5DeiVvRLWhapc77yk3WDXFJ2GZQou5qMNIyjBml/5rt/hBk1QQwNIzHF9dG2Q6em4grUwONjcX8NW4RgKy2q1cLNvLGUfvkcFDDaNR6rj+PRNth+t5/GeRoxvoNNUmBQELH6W/O5Oow4Uw0aqrqUEovNeoRb5ipKzp3lCPO/XLPHIGSs96BsaWjg7nRyCTpoCVDsyVR7ISGefrFY6uhRcNtK1NfQHhAAQ6dgXugKjM+r9gT/J3LlLfI07Kj8FBqYNdQNa6Jy0MlE9uW0AdvkT1QLTXiSujdGeD557OiF6G5HLgJ8CrnJBNFdYNTWBjJKqcIxIE/pLfg89WXYk1v+KnyaFEmKrij9+3qheUUvPPBtPbRAfn/dmWnmVil7bNFOq3igAaJg7XI9e4nCLov/NwtjIKZp2KQiJdjaluZs/NeY7S8lE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZklWV2p3cEdWZXhvVjQ5ZVR4dHNGWC80Y2ZWb3YwcXFGVUkwOUwxWGlHYlR2?=
 =?utf-8?B?NVVMQ2RDU1h6RzJFeS9QbmZWalNVeUNwdVFnYVdJeDJRd1FxMWlidjQ5R1l5?=
 =?utf-8?B?OEJWSzRNVlFJQ29LeEFVa3ZCU29BS29BV3JWdnA3ZGUvK2UwNmdWZnNTL1d1?=
 =?utf-8?B?NFNnNlJ6bXJhcUQ1c1huTmYvQ29BSENSUVJzQ3J0bUMzRzdJZDM5Mlkyb2JH?=
 =?utf-8?B?OXRuQ0ZEN256d3pVVGRqdlAwWXBwS2xSdWJ3ZmhSV0RUUy9nS2ZxVzVaZ0Y4?=
 =?utf-8?B?aGRiN25SbTNNRm05cjFmak15bWxiM3d4YWtkdXJCc1pPMzduMk1EKyt4LzNq?=
 =?utf-8?B?Y1ZURERFMHZza0F6YnFDeS8zcklwQVdzY3NJZkJGVmlGWEU3TTU3Wmt3Zkhp?=
 =?utf-8?B?aVZjMUJobE1HeGhJc0ozME5oTC9xbFl2OGtGeGVFaUJyeGRDZVZNcmx2SlNC?=
 =?utf-8?B?cFZ6RVlLSVZUQTZROU9RaHU3QXowZjJSQXZTK0tpVGJJdDh0clVFTFVNK3BH?=
 =?utf-8?B?NG5ZOUFxSG9XUGNLblMzOWZwU1pJdWN4REhHQjZwem1DL0t2Z0pjVWViSDBh?=
 =?utf-8?B?K01NWHFIMWtpK0VLSTFSN3NLZ0IvQmh3VmxDanFqcXRuYTA3bDJZWm8xYm5z?=
 =?utf-8?B?MXVNNmlGb3Zmd0hGakpLdjhUUmxOUnlPNHFMTjVPdytNSzl5WHR4WFFISlRy?=
 =?utf-8?B?SkNYV25zTWMrSXFCcjJuSzRpTDZWVExSWmlhSTBzTmhwWVduR2RCQWdPLzBO?=
 =?utf-8?B?OUNoeTBDQ0VKd280T0NrSmtRUjZlT0VoeE8rVGFxc0J0QmZUMlcxTHJHbHo4?=
 =?utf-8?B?d0htazhkSnNIVGtYakJTMFBIaXNLcDNhV3UzNjNPbEp1SHJjRjcwTzVKOFhM?=
 =?utf-8?B?WWd4Tks2ZVNMOUJIV3M0MnZSd3ViSjN6WnZzT0pET1ptaTZ0M21INTF5TjAz?=
 =?utf-8?B?ejJjRDZybklYY3JqUnJaQjlzQi9SYmN1Q3AvUVZyN1lMWHMzZEVucnFaNXBk?=
 =?utf-8?B?eldSVnR3ckx0dEJlNi9sdE1zSk16Y1pWMUNvSDBXMzZFbm11T3hFajEwK09Q?=
 =?utf-8?B?YU5Ndlo4aTU0d2hOeEFnbXVFTkMrd2tuMXh4dHZIN053MHdZVVRmaTBoSmhh?=
 =?utf-8?B?eDV0U3FBZFBvb25qeHUyUkpiaTdDcWdTVkJqNWtVdzlST29IOG5aT1NNQitQ?=
 =?utf-8?B?cmxBWXBMSFZJMkdQWUxWeGo5Mm5KTVVVWnNmcndqSk5qeUM2Q0szdVpWRTlo?=
 =?utf-8?B?V0d0aGtERUtLaEl0TGJ1NEFZdE8wZExTdE95alBWNVkrQUNJYkMyaVlOL1hZ?=
 =?utf-8?B?bURzL0lWOEtHbXl2TmVEUDhZbDFtbVhCQnZhT1hRZnFwbGZCbnhIaGYvakxV?=
 =?utf-8?B?aENLMTZBcXk1T0kxdE1vbTkwbERBWGVGSHhqanVqck1mb0owMHBmWFp5U0pH?=
 =?utf-8?B?bDhBOGlMdHRsL2hQS1FTQUU1ZG5ET3NpMEd0MmdWcHk4bU5vcWpGM3RYOHZs?=
 =?utf-8?B?VU9EMnRyaEdEZnhWZEpweDFBbUFqWXZkLzZLNW5yMVFxb2FLdHdJaGJJZ295?=
 =?utf-8?B?QWZvU2lYR3ZpVlladUg4alVER1BrWHdLdVY1Y1NYTThvS1RrUHZrbnJJOHdj?=
 =?utf-8?B?blZuc2hjcGp5SmVJamMrcWxQaWY1VHRtTTRZbkVjRGNEL3F6MGxYTGpMOEpU?=
 =?utf-8?B?TVBEcTBWZlpRZ0VvV2JwODFsY3hqMlowNkJENEJqNlpJcDA2Q0hxc29LRG1G?=
 =?utf-8?B?c3BnSEhoc0FNcjJ2VUF1YU1lZzBtSEVxdGVmcUh1SjJxbWhBTkhoY0JKaGR2?=
 =?utf-8?B?aCtPRTA3QmxLdk03Z0NHVG9hcHN3NzZBY2pLRFM3OHVBRGlmdVZHTDJ0d1NZ?=
 =?utf-8?B?UnJaODJGWHVmcytIRmNXU3Z3R01jbmQ3amswT1lUMHJPN0dYQ3NOOEZtS2RK?=
 =?utf-8?B?RVBad2I3eHdmZjFoS3R3V1NvN29MRXZGR1lrazZpeGRPc09ZYnlXWUJ4Snpr?=
 =?utf-8?B?ZFVDbk4wQVNzb0ZqSzJOWTlzNVBYTGdLVVlPVG0rYnE4MnNaWXZLWkwvWm5q?=
 =?utf-8?B?ZEFnQ00rd1hRa2xTWVI3a01YVkNSaVB2bW1qbnJLQXNhWllhd08zQjQveWJR?=
 =?utf-8?B?ck1TRmtKYkxhRW9yZ3BrQ29ZOE9xR1RMRk1IOEJOQmhTU2hFOWdla3Y0UUJ5?=
 =?utf-8?B?ZVpvYVhkUEZZTk52ZFk1ZERaWVpHVFc4UWZYanU2bjJOd3hGYTFHK3ZzeXJ5?=
 =?utf-8?B?STlEVUtDU0pscVY4TGwxK0dsY1JKckc0TSs4QUFUZ1QxOVZ0bFZyVEQ5L0d4?=
 =?utf-8?Q?DYtzT5X466ix8H40Dt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36007a81-88fe-46aa-f573-08de962f62c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:58:59.9531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr3RQobmvJoXcXX3dFJ4gdIqomSa1gmG+bOtremYhlDm7RMqJMdA7rVW35f7I/Rs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
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



On 4/9/26 10:33, Sunil Khatri wrote:
> Remove the reservation lock for vm from amdgpu_userq_buffer_vas_list_cleanup
> and caller should make sure it's taken before locking userq_mutex.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 34 ++++++++++++++---------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2408f888c4d9..1b81ce49d408 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -312,25 +312,21 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
>  	struct amdgpu_bo_va_mapping *mapping;
> -	int r;
>  
> -	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> -	if (r)
> -		return r;
> +	/* Caller must hold vm->root.bo reservation */
> +	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>  
>  	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
>  		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
>  		if (!mapping) {
> -			r = -EINVAL;
> -			goto err;
> +			return -EINVAL;
>  		}
>  		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
>  			queue, va_cursor->gpu_addr);
>  		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>  	}
> -err:
> -	amdgpu_bo_unreserve(queue->vm->root.bo);
> -	return r;
> +
> +	return 0;
>  }
>  
>  static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
> @@ -444,8 +440,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  	/* Wait for mode-1 reset to complete */
>  	down_read(&adev->reset_domain->sem);
>  
> -	/* Drop the userq reference. */
> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	uq_funcs->mqd_destroy(queue);
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
> @@ -626,6 +620,9 @@ static int
>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +
>  	int r = 0;
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
> @@ -633,6 +630,14 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	/* Cancel any pending hang detection work and cleanup */
>  	cancel_delayed_work_sync(&queue->hang_detect_work);
>  
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r) {
> +		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
> +		return r;
> +	}
> +	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
>  	mutex_lock(&uq_mgr->userq_mutex);
>  	queue->hang_detect_fence = NULL;
>  	amdgpu_userq_wait_for_last_fence(queue);
> @@ -664,7 +669,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	}
>  	amdgpu_userq_cleanup(queue);
>  	mutex_unlock(&uq_mgr->userq_mutex);
> -
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	return r;
> @@ -856,7 +860,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  clean_fence_driver:
>  	amdgpu_userq_fence_driver_free(queue);
>  clean_mapping:
> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> +	if (!amdgpu_bo_reserve(fpriv->vm.root.bo, false)) {

The second parameter should be true here, and then you actually don't need to check the return value.

Regards,
Christian.

> +		amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> +		amdgpu_bo_unreserve(fpriv->vm.root.bo);
> +	}
> +
>  	kfree(queue);
>  	return r;
>  }

