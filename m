Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF54CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 07:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D19710FB5D;
	Wed, 14 Oct 2026 07:09:31 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845B810FB62
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 07:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDkWM1I2YLPBlWXBod37CUrKuZiVNwo7+8ep6OfonQ0q1jQ/+vpkiyFJfBAMJ/4KAmQDxarYNHV52fOGCOPKX5WFOPrgV5NEJp383JGiqnOtq0f+TvJ2D8BuJxgPqLP5xxHmIrCSQ2e0b7R0mcw+iauqowpnt6c60jsdqul1MfTk6TzIPBp5uAWkzfEbG54RS83jeCnwyD3WKbTyiFxjEeiMdoeB8pBiHJrwmK8C3zLiV/f25Uh+vA8DmS7gLgO/5QALDFUX2UqlVUzVn6yiMFR5HHkABU3uggb5nObLb8XEAJZjOwDlsPIdHU/fDlXl8aH5gWFPrFYCzPP9f9oSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOjkjtdgA+dX3cTAJKN7gqXggn6WYSGqy9HyGVtuESo=;
 b=wVM1XxW9skvg+tgj8tOk9MXb/ctrSxGgbmPRpTLcyBBsYcySxsdrM556X8QxIwD2TuG2eQj6mdXZunIqsccLSa0pX1WImgK3WH1vxIv7ha5N0vm26IbiKr9mdBij/jIjwhVQwBzwPEY7+aw55BlqxGpN3mnIvvbVkTKk4i5Wuj2LWxvyXeZczlFLnlX8ko6VEUsT4MM2vqH/0rHyYlM6X/1WErzgai/EuzOm6hkILVftS2L3VhUyCa4p2FUgCc4eO8QtCmBR9PV+rdCZjuSOoT4iBIy+6auedH2QLFqNDvJ5RB07VCKwqKOb+M2Xt29Ab6n12k6eVuTtLbZraTZAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOjkjtdgA+dX3cTAJKN7gqXggn6WYSGqy9HyGVtuESo=;
 b=OQ6B9cenl4bXJBdo3B3oTP++SQCOJ+iwlaD4MzCcZTtEAL22hW1xQhp+Se42daStNKT+Fh060HuiXPAZXDC5pazkz+7SkeveIVYsFAM3obHaK9o2W77u2FpOWlkN4Hx+7hbd98tfkW/vPzddo40quNX+Yqc2af+4T7e76sM9qxY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 07:09:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 07:09:22 +0000
Message-ID: <13636736-f06e-43c4-b8a2-dd52e93527b4@amd.com>
Date: Wed, 14 Oct 2026 09:09:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, alexander.deucher@amd.com, xiaogang.chen@amd.com
References: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
 <20261013185313.33496-4-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013185313.33496-4-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2dd5db-bba3-4b4a-1097-08df29c21253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|10067099003|22082099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9ee6TVP3SKTzSpVdmeAVYYG3AvxbLQLC9PgnzLQqQpNhKruAfzrqmLquKuRTyKY2BqJO50tG0OfYkj2LOh8x7Kvq74RvM5I0/mRVOrnhFmQ7pOzjakyzRuamVvBSNMlhBz5WnLNZAaGJoX5XsBKVE/Mo615T6mQn15A4azvYwmuuG8fUO/cZWqBaDhtX3BrMyuwpBVa9D8OGguaKvDpHG4Va3YrozHkmUY3eliyl5lHqKUKWZpdCdd/g6356J+edMxkjfG1JAOqgBBw02j3nM2EkBwRyd6gxb0ruKutIIYkw1IyI9Ddhu0RDrrZEo9HuOvvXnceoK5WclJWIQm3PQkKY0ksPqpYQW6MLoSYgzhrMYdmrA9sxw1V9ODmPs8BchxzwsITTm/HUVvHOh7i+GESy3cw+7qZhJtnsNdsqeT7WXf/vl+z88r8s0kl4965f6qZJ8+cV/stx+SscWZEVeBR4TZ9g9nZasINB2BNYOPipToX26aFgW/tKIZu6fLiFzvwns55WrCQjRxP8zAQEnva9IyknMGDtpG186iKEeZFxp4J8aEMtpa79eejQovBVYEKTpMxB86Nm2hIxNwajG6XXvxT9XyTRu1KVQ+Cgi0Vu5KUoZyuW3vueEybNw2osvCqBSi3dPAHr8GZIWfGN+AaBYu9mnAX8x8so7Q9VeQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFE4TWRXUUVXNmI3OEl0eGRJUElmSkNTbS9zWXRCNE9LWUZHaVpqYWhjaFMr?=
 =?utf-8?B?WHdwaENuaWlKN3dnRmpRQzdHMXZwUG9PT1ovLzhJRnNQUC8rZS80NnpTdnQx?=
 =?utf-8?B?cEIyVDArZjZvdmt1K3FRTXl0SXcvRHNnMXJOeTRwSWdNNmdwQU1YbkNZbHpB?=
 =?utf-8?B?YzBzVUg3aHdXVENwK24wclZISDR4c05Ka3I0TUpwRDZGUFBEbXVzbUpucGt5?=
 =?utf-8?B?Z1hrYjN1M3VRNzFCNGRraVhVeTNKSlB1c3pxcUpBMi93VHk2WTBWSE05WWUz?=
 =?utf-8?B?QzlyTVhEWko4MjVTb0JtMGdVTWlJdWlqSG1DbzFsTThmVlNXcjJXSW14clFT?=
 =?utf-8?B?dWRZTThKRjg2R2x4eEIwZnhGOEs1SWMwNXNZU2NudWx5dXRmMFIweFVOUDhM?=
 =?utf-8?B?Qi9iUmo4eEdoMjY3WXB5RUhWODhvUzZiTFNIcnUxbi9WczFzM0FBN0tjczFw?=
 =?utf-8?B?ZXlPaDB4UjNMa1dUcDN5L3hkL2RDQ2J1SGZOMUc3bjdDQ2tEcE1SeEIxOC9W?=
 =?utf-8?B?RkZEUU9PdmE2cGtFMWxrWC92RUYrWE1ETnpQVmt4K1gzeTBQZ0ZQbXJadVlF?=
 =?utf-8?B?QlFBMzNNU3dQaUJLSkFMcWttZEc3ckNyVksyOGVZWjhleTI4eWtqVEZlSHlV?=
 =?utf-8?B?cXFuY0JJWHFUSmNEejBaQ1FuTW9pZmZsTllQWWNRZ04zNy9aV2xXTWI0UGJK?=
 =?utf-8?B?bWVxbjN5MnFmNXpLNkVQMVY5NGFGMUZERUJ1MTN6T1V6WVRwQm5BenU4cDBB?=
 =?utf-8?B?UzhaTEZzcVpZNzFqQnRWRyt2QXR3U1A2b3dxMHA2VnFxYjBOSzNULzBDNHNa?=
 =?utf-8?B?MC92R2k5NzBJNGFzN1RmcHZiQkFBdkZOV21rS1NteVdlYmIzbmlzb1ExaUxO?=
 =?utf-8?B?Tm1USEZLQW41Ym5zKzJnd3JucUdxVFI1cDlIRFhjZ2dJN3NnS0hrTlNkTXlF?=
 =?utf-8?B?c3MzZHEwMDdyeEhPODZFL2xaMG1Yamg4MFJsZktNV3Mxa2RqSXdDVWErRjI5?=
 =?utf-8?B?QVNlbDgxNEFzWVRFMUo3U3pOZ05PeUhTditKcFZiMmNJQXF1WDM2UkFnRW9T?=
 =?utf-8?B?cnlJTzBmVytCMS9kRDl3Yk00Wi9zZTExRkwwYnVXL2p2S05YSmVTZ05GNSti?=
 =?utf-8?B?OUJTTytuM0V2eHFnVlh6UWhQZHIvK3FyZ0UrVldiUys0WFVCQ1V2ZWJqVzgw?=
 =?utf-8?B?M1FVbjVlOWFTeHNvcm8rdndXY0FaZ055NzZhTDg3eEJpdU9vVEkrZHUvc1Zk?=
 =?utf-8?B?bURScGFPaFhheFRHclFNemhuMnpWQ2RMalZmT2x5NkdqcldzREFjMThUNzhU?=
 =?utf-8?B?RU0wK1RQcHBadmFTcXB1dE5BdmRneVlzKzNxb2lXS3ZuZ25zOGNYTXpPZ3NN?=
 =?utf-8?B?SzROSUlWMmZwOEFueDFTMFVZV04xNStIMEV4REx5akZOSUFBbXlzcUxwaFNt?=
 =?utf-8?B?bmM1blZSVzAxSlZ6Rmc2UmZWcEJVZ21ibVJkQnM4SXEyZmhobTV3OC9KMWg2?=
 =?utf-8?B?Q0E4ekRCQlBtdkdYbkJaRHhvdVlBeTh1Tms2NGVYdkdVa1MyVkdBQWZuTlBO?=
 =?utf-8?B?NEx6ZllSUVd6OHZMQUpSdElEWEF4N2xMUEhGbUk1S3lJNUNiL1Q2MFd1WDJH?=
 =?utf-8?B?TTNqbkg1dVMvOUJNVHY5SWdCd25uOWFZN3RPSXZTOGNOWXE1MEZZaUtZWHBJ?=
 =?utf-8?B?ME1uTmZrajJzWXMyVjNQSWNjcFdxbXlQUXhPOGk3YWRTMzBOMC9sdncwZWEw?=
 =?utf-8?B?WlhKYzNnc3ZtWTdOYWFaWEpzUU01eXA5QTdGaWtUaTA1eTN0VDdGdnN3L3Bn?=
 =?utf-8?B?V3c3UEpmN1FwazBpcjEyT0ZZUWZweG1ZL2FmdkRtb0xrdDUyYjROcExMWE13?=
 =?utf-8?B?ZWRnQllVY0tvbXU1aHB1d1lMZmd4ampaN0VYdW5pY3BrRjYzT1dweWJzUXpE?=
 =?utf-8?B?cmxjVy9mNjlKc0tBZWozNFJxS3VjYWJmY1lOZjRvbXFyMEtvWnVHNXU1dUxq?=
 =?utf-8?B?MExaVk16YXRaQ0Y2ek84NHpzeDR4LzJ2T1R6ZVZGK1EwRjRSWGFueEVpanJK?=
 =?utf-8?B?M3lOWllZTUpaZmxhSUU5TzVMRWlrbGs1NFdoTjdkdUthdENNWURuRlZNQVRB?=
 =?utf-8?B?OUlwOFNuTHhXUVlIRVZSemxGZ0RyV1p6THd3ZWNrNllCdUlkM0pFVzdKaHpN?=
 =?utf-8?B?RERNLzV4dkNmZnk4NU5XeE8vVlQ5a2RweUt6UEREWDFjS0JlM2tRVng5K21x?=
 =?utf-8?B?Z3Zvb1hQVnNCY01PaUQ4UXRxeHhyMlNhMkgwOXVDZ0xMaXRIZGJ1UStaa1ZL?=
 =?utf-8?Q?iRAJQ0pdu2NG87txoY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2dd5db-bba3-4b4a-1097-08df29c21253
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:09:22.0829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwNcQy3AWFyKlwn+A5eRyfO5hXEdnNvq6VSBxf3LJERj8idnoP3PyjNh6hBEGhre
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188
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

On 10/13/26 20:53, Olivier Kaloudoff wrote:
> On surprise removal the killed process's own exit path can fault on
> its SVM managed ranges: SIGBUS -> coredump -> get_dump_page() ->
> __get_user_pages() -> do_swap_page() -> svm_migrate_to_ram(). Without
> protection, svm_migrate_vram_to_ram() submits an SDMA copy job to an
> already-killed drm_sched entity (observed as
> "drm_sched_rq_add_entity: Trying to push to a killed entity" plus
> refcount_t saturation warnings), then svm_migrate_copy_done() waits
> uninterruptibly on a job fence that can never signal. The task dies
> in D state holding svms->lock, which wedges svm_range_restore_work()
> on the rwsem writer side, so kfd_processes_count never drains and the
> pciehp removal thread wedges for good.
> 
> Guard the hardware-accessing migration sections with
> drm_dev_enter()/drm_dev_exit() so unplug cannot proceed while a
> migration submits jobs and waits on them, and bound the job fence
> wait in svm_migrate_copy_done() with AMDGPU_FENCE_JIFFIES_TIMEOUT so
> a fence that can never signal does not stall the critical section
> (or the faulting task) indefinitely.
> 
> Handle the new failure case properly: if the copy times out or fails,
> release the migration pages and clear migrate->dst before
> migrate_vma_finalize() so a failed copy cannot complete as a
> successful migration, and propagate the error to the caller. The
> cleanup is shared with the copy functions' existing error paths via
> new svm_migrate_vram_pages_put() / svm_migrate_ram_pages_put()
> helpers.
> 
> Verified on MI50 behind Thunderbolt: the workload takes SIGBUS,
> coredump completes, kfd_processes_count drains in ~9s, pciehp
> removal finishes, and the device re-enumerates cleanly on slot
> re-power. Previously the same repro wedged the host.
> 
> Cc: Xiaogang Chen <xiaogang.chen@amd.com>
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> ---
> Changes in v6:
> - check svm_migrate_copy_done() return in both callers: on failure
>   release dst pages, clear migrate->dst before finalize, propagate
>   the error (Felix Kuehling)
> - drop the dead ret < 0 branch; a non-interruptible wait can only
>   return 0 on timeout (Christian König)
> 
> Changes in v5:
> - dropped drm_dev_is_unplugged()/pci_dev_is_disconnected() checks;
>   drm_dev_enter()/exit() alone is sufficient (Felix Kuehling)
> 
> Changes in v4:
> - use AMDGPU_FENCE_JIFFIES_TIMEOUT instead of an open-coded 10s
>   (Felix Kuehling)
> - guard migration sections with drm_dev_enter()/exit() instead of
>   racing flag checks (Felix Kuehling)
> - keep pci_dev_is_disconnected() early-out for the dead-link window
> - moved svm_range_restore_work() change to patch 2
> 
> Changes in v3:
> - new
> ---
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 8b96e1f..40e993a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -204,7 +204,12 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
>  	int r = 0;
>  
>  	if (mfence) {
> -		r = dma_fence_wait(mfence, false);
> +		/* Bound the wait: on a dying device the fence may never
> +		 * signal.
> +		 */
> +		if (!dma_fence_wait_timeout(mfence, false,
> +					    AMDGPU_FENCE_JIFFIES_TIMEOUT))
> +			r = -ETIMEDOUT;

Ok, once more: Clear NAK to that!

This is just nonsense. DMA fences on a removed device *must* signal immediately.

If you want to know if the device is removed you don't even need to take a look at the return code of dma_fence_wait() here but rather at what dma_fence_error() returns.

Regards,
Christian.


>  		dma_fence_put(mfence);
>  		pr_debug("sdma copy memory fence done\n");
>  	}
> @@ -239,6 +244,24 @@ svm_migrate_put_vram_page(struct amdgpu_device *adev, unsigned long addr)
>  	put_page(page);
>  }
>  
> +/* Release VRAM dst pages of a failed migration and clear migrate->dst
> + * so migrate_vma_finalize() leaves the source pages unmigrated.
> + */
> +static void
> +svm_migrate_vram_pages_put(struct amdgpu_device *adev,
> +			   struct migrate_vma *migrate, u64 *dst, u64 npages)
> +{
> +	u64 i;
> +
> +	for (i = 0; i < npages; i++) {
> +		if (!dst[i])
> +			continue;
> +		svm_migrate_put_vram_page(adev, dst[i]);
> +		dst[i] = 0;
> +		migrate->dst[i] = 0;
> +	}
> +}
> +
>  static unsigned long
>  svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
>  {
> @@ -359,13 +382,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>  out_free_vram_pages:
>  	if (r) {
>  		pr_debug("failed %d to copy memory to vram\n", r);
> -		for (i = 0; i < npages && mpages; i++) {
> -			if (!dst[i])
> -				continue;
> -			svm_migrate_put_vram_page(adev, dst[i]);
> -			migrate->dst[i] = 0;
> -			mpages--;
> -		}
> +		svm_migrate_vram_pages_put(adev, migrate, dst, npages);
>  	}
>  
>  #ifdef DEBUG_FORCE_MIXED_DOMAINS
> @@ -441,7 +458,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>  	unsigned long mpages = 0;
>  	dma_addr_t *scratch;
>  	void *buf;
> -	int r = -ENOMEM;
> +	int ret, r = -ENOMEM;
>  
>  	/* Avoid unnecessary migrations and MMU notifiers if all the data is
>  	 * already resident in VRAM.
> @@ -493,7 +510,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>  	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
>  	migrate_vma_pages(&migrate);
>  
> -	svm_migrate_copy_done(adev, mfence);
> +	ret = svm_migrate_copy_done(adev, mfence);
> +	if (ret) {
> +		svm_migrate_vram_pages_put(adev, &migrate,
> +					   (u64 *)(scratch + npages), npages);
> +		if (!r)
> +			r = ret;
> +	}
>  	migrate_vma_finalize(&migrate);
>  
>  	mpages = svm_migrate_successful_pages(&migrate);
> @@ -542,6 +565,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  	u64 ttm_res_offset;
>  	struct kfd_node *node;
>  	unsigned long mpages = 0;
> +	int idx;
>  	long r = 0;
>  
>  	if (start_mgr < prange->start || last_mgr > prange->last) {
> @@ -555,6 +579,9 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
>  		return -ENODEV;
>  	}
> +	/* Block unplug while the migration submits jobs and waits on them */
> +	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
> +		return -ENODEV;
>  
>  	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
>  		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
> @@ -569,6 +596,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  					node->xcp ? node->xcp->id : 0);
>  	if (r) {
>  		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
> +		drm_dev_exit(idx);
>  		return -ENOSPC;
>  	}
>  
> @@ -613,6 +641,7 @@ out:
>  					prange->npages * PAGE_SIZE,
>  					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
>  					node->xcp ? node->xcp->id : 0);
> +	drm_dev_exit(idx);
>  	return r < 0 ? r : 0;
>  }
>  
> @@ -627,6 +656,32 @@ static void svm_migrate_folio_free(struct folio *folio)
>  	}
>  }
>  
> +/* Release system RAM dst pages of a failed migration and clear
> + * migrate->dst so migrate_vma_finalize() leaves them unmigrated.
> + */
> +static void
> +svm_migrate_ram_pages_put(struct device *dev, struct migrate_vma *migrate,
> +			  dma_addr_t *dst, u64 npages)
> +{
> +	u64 i;
> +
> +	for (i = 0; i < npages; i++) {
> +		struct page *dpage;
> +
> +		if (dst[i]) {
> +			dma_unmap_page(dev, dst[i], PAGE_SIZE,
> +				       DMA_BIDIRECTIONAL);
> +			dst[i] = 0;
> +		}
> +		dpage = migrate_pfn_to_page(migrate->dst[i]);
> +		if (!dpage)
> +			continue;
> +		unlock_page(dpage);
> +		put_page(dpage);
> +		migrate->dst[i] = 0;
> +	}
> +}
> +
>  static int
>  svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  			struct migrate_vma *migrate, struct dma_fence **mfence,
> @@ -717,22 +772,7 @@ out_oom:
>  		}
>  
>  		/* release previous allocated sys pages and unmap dma address */
> -		while (i--) {
> -
> -			if (dst[i]) {
> -				dma_unmap_page(dev, dst[i], PAGE_SIZE,
> -					       DMA_BIDIRECTIONAL);
> -				dst[i] = 0;
> -			}
> -
> -			dpage = migrate_pfn_to_page(migrate->dst[i]);
> -			if (!dpage)
> -				continue;
> -
> -			unlock_page(dpage);
> -			put_page(dpage);
> -			migrate->dst[i] = 0;
> -		}
> +		svm_migrate_ram_pages_put(dev, migrate, dst, npages);
>  	}
>  
>  	return r;
> @@ -770,7 +810,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>  	struct migrate_vma migrate = { 0 };
>  	dma_addr_t *scratch;
>  	void *buf;
> -	int r = -ENOMEM;
> +	int ret, r = -ENOMEM;
>  
>  	memset(&migrate, 0, sizeof(migrate));
>  	migrate.vma = vma;
> @@ -821,11 +861,17 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>  				    scratch, npages);
>  	migrate_vma_pages(&migrate);
>  
> +	ret = svm_migrate_copy_done(adev, mfence);
> +	if (ret) {
> +		svm_migrate_ram_pages_put(adev->dev, &migrate, scratch, npages);
> +		if (!r)
> +			r = ret;
> +	}
> +
>  	mpages = svm_migrate_successful_pages(&migrate);
>  	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>  		 mpages, cpages, migrate.npages);
>  
> -	svm_migrate_copy_done(adev, mfence);
>  	migrate_vma_finalize(&migrate);
>  
>  	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> @@ -869,6 +915,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>  	unsigned long start;
>  	unsigned long end;
>  	unsigned long mpages = 0;
> +	int idx;
>  	long r = 0;
>  
>  	/* this pragne has no any vram page to migrate to sys ram */
> @@ -889,6 +936,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>  		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
>  		return -ENODEV;
>  	}
> +	/* Block unplug while the migration submits jobs and waits on them */
> +	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
> +		return -ENODEV;
>  	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
>  		 prange->svms, prange, start_mgr, last_mgr,
>  		 prange->actual_loc);
> @@ -933,6 +983,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>  		}
>  	}
>  
> +	drm_dev_exit(idx);
>  	return r < 0 ? r : 0;
>  }
>  

