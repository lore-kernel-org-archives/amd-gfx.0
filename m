Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8359CA5FC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 21:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B9910E128;
	Wed, 30 Sep 2026 21:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KG82MCJ4";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C333A10E128
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 21:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWj7szgwuGBLAiEpsaeh43j+SR4ZtzDr8ie4lCcOgddFOrgXZgbFsZTnQrfv3+0eLkiHfwmVrvRYpvgTSEJ5B3CuzZJfIykN4LAg2/d9P7yU3EHYYiCtyHhEiCvWRVGXnd+eXej636oZPvJJLlh9BlBJpe8lJKftc6zQ00RDn7+n8m1LSg1G1x71qVJOAAAxzvWJa0kh358CCdNVMTUILy9nPhcVpEt00ocMQT7prSklwiIrKbXG4DqpIVqgU5fCDYnPBxa3sQCxk0LNXQn9ZaIpvRgYNytcgG5MNDYTmYHuBdMJVNJAIClp1KiGrMo14/kB4tOnTEE6aLjSH2xNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYhOpJw7TKj3aWhZR1B6bMqD103bePrEnYUNKsmcVa0=;
 b=nxdi5PzZol3v63SzkhSfzp3Usk6xPUiVs9M87zZy4svU+lvPcbMbEzA4QLvZhPxTZWBtjHUgHIEIh+kqmnt0qZx3FFxjFUNpId2c4L8FEDmKA0Y+zn3KvlmHqxnDLqprkC6A+ysRQy/Hpx1/k/I1eK31QcGBiD4g20RURezsqypckDRInbwC63KrOmGGU+h8qZEhDu0PwYxDIshUeL8vFHcccmziFfanPCyMLjlU+Cf2j/pwcaDtoJ/4fpQ7cpkDbcsF3VN22+j4g+ka/e5uS/faymJjQGKtXAXv23dsZg2S7WK3DjqHceRD6/t3AWkpfLsH+sRD1wr9YTKI77LCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYhOpJw7TKj3aWhZR1B6bMqD103bePrEnYUNKsmcVa0=;
 b=KG82MCJ42R9HdCTd+bUTkZog3Vv4a30DdVYTx1i8kSI3iJGdku5QeUSm1Uaz4ZELThws0kcWu9gWAcy5nxTckQ91s841Va5Jn1HpayaPrEoiIIEgPFTBofRHoBIOeVxvX9iOhMdq5m/KskP7guyWw4qr6Kp+xN65MlJ7c3PsIKE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SN7PR12MB7417.namprd12.prod.outlook.com
 (2603:10b6:806:2a4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 21:03:48 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 21:03:48 +0000
Content-Type: multipart/alternative;
 boundary="------------W6yiXvswjUTIEKO8V67xSxJp"
Message-ID: <e546c00d-6686-4f33-9e17-fee0cf25eaed@amd.com>
Date: Wed, 30 Sep 2026 17:03:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix lost wakeup in interrupt drain on
 debugged process exit
To: Heng Zhou <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Sierra <alex.sierra@amd.com>
Cc: Lijo.Lazar@amd.com, Christian.Koenig@amd.com, Emily.Deng@amd.com,
 Victor.Zhao@amd.com, phasta@kernel.org, Qing.Ma@amd.com,
 HaiJun.Chang@amd.com, Jonathan.Kim@amd.com
References: <20260930134205.469578-1-Heng.Zhou@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260930134205.469578-1-Heng.Zhou@amd.com>
X-ClientProxiedBy: YQZPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 80642220-942f-4380-a9f8-08df1f3652ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|5023799004|6133799003|56012099006|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: 5I6LB2SaJXcJbM6PUbMjLCUktioVWwS+Z6pxKispae4ifFlU5b9qg1j5CMw1p+aCj7/VOJl4r0D/qz5FHNlFnMCFOFOia+eYb7GKhMfYriEWYfZC6+genbxt+063wiX7MKRpGklnofBztIjMLTuX8sv1mZbSJiU+LNJi37rkcmd+NErpY8SB5eb1W7NMFuYMxgD5/qZ1uVycrxHgkqNCybLjn4AUOvW8+dUPLO8kwFPqYL7B+2+HU2dkuKl9AZNJexSQ5JBTg1hcNrmESD3luC1Pr1CurWsm9mByPoo9U/D2DXkwSTmfeWciNq7sohpBS/QD7ynsaK3wfOJ+jAtdJmvnajh8Q/YMq9VoW7tpxkgkHjeedlOKWPXI5Q/1QUBSu92RSb72J5rnWTPtKB1vohb+BX02pXP5s5Hhnggwt6ij2nxkXRxIe/2qzPVwAurMtuCATDQwZR0uNtg6Qyj2lSEzajJ1JO+82WTeJGDFmSV0r/vPCpfF2EXWBwx8CVKvD22fphwWEHgxRO1OknMiHkSXd5Ti89S2W5FMLldt3BW59CxrL3Lh1xgnc1pioCQuNyq8ZnLG0zzVSodAYm2Iz/Q5Qpy0cjHZS1AXqOBPLmw24sqHjNOcHNSlgjMrWz5HOCf7fbSRJfOhj/QdyAahHXh4B06nYZjeIO1Y4cUwaOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck83aUtyTEJ5cEFtTTJxNnFPOU92ZHpPdkNGa3pkdEJnZ3A2Nmt0Q3hyc3Nh?=
 =?utf-8?B?cnUxVm1IdG5KSStsM0dkOGVReFk3Q1I3VXRRZHYyOC9uQ0dvRGl4M05hdFp0?=
 =?utf-8?B?VnBlWUZxekZleVJYb0xKWExzL0NoQ28waFlNZGRDb2o1Q3FBNmxBdTBtMmor?=
 =?utf-8?B?T2xDRmdOanp0Y00wSEoybzJINHlQc3BOcURRVUFWSGJPcnhQWGlNSzNraXps?=
 =?utf-8?B?dmJVSjBLak1TS1d1bFpFNFlJNFUzbmsxQmFvMWN4aUt0bnhOL1RTUlZ5Mnpq?=
 =?utf-8?B?dHRyWHgyK2hucFMyTlpEWTRTcnoxWVVNcTlFSWhiekNWM0tGTE5oTU1uajZJ?=
 =?utf-8?B?YkhXb0VrTENubGNtMi9oczdjd2FuMkZvdlVubVpRU05VQWV4Q3ovL2h6Vnpw?=
 =?utf-8?B?YkZOTmhBb2lGZlpEWkQzSDMxSDluSDJhWWJ6Z0hTcG9VNUVHdFFyWlRwRHND?=
 =?utf-8?B?ZG1HRmNuRDBJU0xXNzh2R3ZjVkovNDN4bTNMUWFPd0V1MkxwNnljTC9iUkZo?=
 =?utf-8?B?ZTZYR0JQa3dNWHRGdWRscm1rdE1GNlFhR1FIK2VaYitGZ1RhSHhaUVkxeExo?=
 =?utf-8?B?TGtnNS9JSVczVGtjNC9Hc3QvWHA5UUlYdkVubXVWWCtVd0M2QmhBMDhBanBa?=
 =?utf-8?B?YzRYZzUxOFY1U2Z2TkJSMGxVSU91UlpxV2FCWnNwd3V5dFp2RHdnTDIrV1Fq?=
 =?utf-8?B?RG1vMTVMUFNqVCsxaDAwbDR5TjhUUFZWL0k2dnZXQ0Y0M1B2TW4wRnhuRjRI?=
 =?utf-8?B?R09CZHhaN0lhYnBwNFJpOGZ0N2hYYWNIR1BEY0hLWnhteEJlVFlYaG1PbGc4?=
 =?utf-8?B?ZmpvM1NqdzBMSXZZdkwwOVVlR1FRK0lZbm12WWxlc202YTd4KzdHQnJKVzQr?=
 =?utf-8?B?T1J4eDVMSU1VcUcvcFBpQzU5REZ3VlNwaXBydU4wMEZxQ1F4SFd3Wm9ZaHFi?=
 =?utf-8?B?aHNHbmhGTTdsRmFRMTZGVFFjQ29rR1pjcHFWMVRITU4yT3lWdlliNmZFM1Aw?=
 =?utf-8?B?V3VhRU96WkFoR0puOXNjM1FWVEsxa2I0QXlTZ09kelNyMi9la2gwVm40R2Uw?=
 =?utf-8?B?ekpuUkg4Q2xjZFF4andOem1ZcEp1UUVCUERUTDlpemJZNDNhS1ZIQ0pDRjNx?=
 =?utf-8?B?WWo1YTgxSHVmR3B4MyszSng5L2E3U2k1UVhqR0g3ZVp4bVFhVDh5Rlo2Nm1J?=
 =?utf-8?B?dCtwZElOTWhTVXFwVms4d0R0Y0lSQWo5aUhoalkrOHp2Tkd3UnlHelc3NVpY?=
 =?utf-8?B?NFV6bTV5QmYwVEUzRUJOaFVlZXU3MkZWR25EQTYvUC9tclBpYm51Y1FPTkd0?=
 =?utf-8?B?QnVBR28yRVY5UUZYcXRDZlQ4ZzFRZlBWZVl1YkdwdmZ2Q0RWcmp2WnM2VURa?=
 =?utf-8?B?UDJzK1MzZ0FFcTM1UDdlbWJ4WkFQTmpCQmJBb1dDRkM3OWk3NE9rVWRzWW92?=
 =?utf-8?B?d1pCVWVWZGduSm85WlA5R0NFUUthZFl0WnN5VHdvdEl6RERGV2ovZHFCVm5l?=
 =?utf-8?B?SXNGRWdZblZTaTNaZnE2bGRUZStLeThJWUVkMXR2ZFJVMlh1OWQ5L0ZkZThZ?=
 =?utf-8?B?Vy9CK0l1azRyVitzR0xBcHFVN1JmVTJaQnBOT3JkUE9CcXNJSmNPZWl2dGlN?=
 =?utf-8?B?UzIrN0dZSyt2RThQZm5KUkpiVFg3eUNhWlVGZ1FaUVF4bTRGNUtsUmVUMlFS?=
 =?utf-8?B?ZnF3MVRqazhSRFBRM09qdmg0RThmQ0JPZjREamN5Tk9OWExiVnJwN3FWWG5X?=
 =?utf-8?B?NEN5YW5aT25uVjI5Z0dsK214QXVxS3ZBVzRUQmNCVi9uSmYvendWQXJsdW8x?=
 =?utf-8?B?b1E2YnVTQm1LdnFYdEdQNzBpcjIvNEJ3MVlRVy9HZ3lJdm5TVmVEeTErc0xq?=
 =?utf-8?B?QWtTZ292UWRueUZkY3M1amNzTEdsYXlpNXNUOVo3bUFmbW02N0QrUHFBWXRU?=
 =?utf-8?B?Wks1N1l0SkJMR1E5Nnhpb0FOU0ZocWV3cWtTZkRwWTlOSVJnS2pwZUhBSC9u?=
 =?utf-8?B?N04xeXlKUjRHS0NvSlh5TEpYNkdwOW1vU3JyK2VwdmF5cmMxV2RJbmd1aXBw?=
 =?utf-8?B?K01KRWQybmN0T1A4c0xmdzg1YUVUcnpiZGhiTHIrZDM5SjhybmlmZjU3STVm?=
 =?utf-8?B?OWJEVGFVVWRUR0xlN3VYL3lnenA1SVhqUm81eUJTLzB4MEFiZTBnb05hWmdK?=
 =?utf-8?B?c1UvT2FNZXFLYW5NQnYxdWloVzhWTnJ3SFVmQW55UDJ2Vko0alQ3V0xMdlVL?=
 =?utf-8?B?bEh5c1pjQmFnU052YnRYQ0tJTVR6VmdVK1hzT2tVckk5WHlSVWt6RkpDTjgy?=
 =?utf-8?Q?sWvmlkGl7onu1nPZoW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80642220-942f-4380-a9f8-08df1f3652ba
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 21:03:48.7879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJHlUnskBq90ZcCmHXqZR9LW46TaGbEbTIK+238palwCQijJhzbRiqc0FD9nWAYj2osm2WolCb7N+kY7DZOYGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
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

--------------W6yiXvswjUTIEKO8V67xSxJp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-30 09:42, Heng Zhou wrote:
> When a debugged process exits, kfd_process_notifier_release_internal()
> first removes it from kfd_processes_table and then calls
> kfd_dbg_trap_disable(), which drains the process interrupts. The drain
> sends a fence through the IH and waits, without a timeout, for
> kfd_process_close_interrupt_drain() to wake it up. That wakeup looks
> the process up by PASID in kfd_processes_table, which no longer holds
> it, so the wakeup is lost and the exiting task sleeps forever. The
> fatal signal has already been consumed in do_exit(), so the
> interruptible wait cannot be broken either.
>
> The wait happens inside the mmu_notifier release callback, i.e. within
> the global mmu_notifier SRCU read-side critical section, so every
> synchronize_srcu() on it stalls as well. Any other process releasing
> its mm then hangs in D state and the system needs a reboot. This is
> seen with rocgdb on MI300X.

I suspect this may have been introduced by this patch by Alex:

commit f34034ce5d2116f397008c63901c9c1946e5d665
Author: Alex Sierra<alex.sierra@amd.com>
Date:   Fri Jul 24 15:53:48 2026 -0500

     drm/amdkfd: disable debug before retiring MES process context on teardown

...

If you can confirm that, please add an appropriate Fixes: tag.


>
> Fix this by:
>
> - Tracking pending drains in a list keyed by PASID instead of looking
>    the process up in kfd_processes_table, so the drain fence always
>    finds its waiter.
> - Bounding the wait with a timeout, since the fence can be lost when
>    the IH ring or the KFD interrupt FIFO overflows, and warning when the
>    drain does not complete.
> - Deferring the drain of an exiting debugged process from the
>    mmu_notifier release path to kfd_process_wq_release(), before the
>    PDDs and their PASIDs are released, so that stale interrupts cannot
>    hit a process that reuses the PASID.
>
> Signed-off-by: Heng Zhou<Heng.Zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |  3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  7 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 89 +++++++++++++++++-------
>   3 files changed, 68 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 0dd1fd448059..2b227d9de492 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -664,7 +664,8 @@ static void kfd_dbg_clean_exception_status(struct kfd_process *target)
>   	for (i = 0; i < target->n_pdds; i++) {
>   		struct kfd_process_device *pdd = target->pdds[i];
>   
> -		kfd_process_drain_interrupts(pdd);
> +		if (!target->irq_drain_deferred)
> +			kfd_process_drain_interrupts(pdd);

The way you're setting and clearing p->irq_drain_deferred seems pretty 
fragile. I'd prefer to just pass this as a parameter to 
kfd_dbg_trap_disable and kfd_dbg_clean_exception_status. Then you also 
don't need two different drain functions.


>   
>   		pdd->exception_status = 0;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2847a5ec5ede..c04c3a03f559 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1030,9 +1030,7 @@ struct kfd_process {
>   	uint64_t exception_enable_mask;
>   	uint64_t exception_status;
>   
> -	/* Used to drain stale interrupts */
> -	wait_queue_head_t wait_irq_drain;
> -	bool irq_drain_is_open;
> +	bool irq_drain_deferred;
>   
>   	/* shared virtual memory registered by this process */
>   	struct svm_range_list svms;
> @@ -1245,7 +1243,8 @@ bool enqueue_ih_ring_entry(struct kfd_node *kfd, const void *ih_ring_entry);
>   bool interrupt_is_wanted(struct kfd_node *dev,
>   				const uint32_t *ih_ring_entry,
>   				uint32_t *patched_ihre, bool *flag);
> -int kfd_process_drain_interrupts(struct kfd_process_device *pdd);
> +void kfd_process_drain_interrupts(struct kfd_process_device *pdd);
> +void kfd_process_drain_deferred_interrupts(struct kfd_process *p);
>   void kfd_process_close_interrupt_drain(unsigned int pasid);
>   
>   /* amdkfd Apertures */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 226f52626e84..b2365c21db9e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -55,6 +55,22 @@ DEFINE_MUTEX(kfd_processes_mutex);
>   
>   DEFINE_SRCU(kfd_processes_srcu);
>   
> +/*
> + * Pending interrupt drains, keyed by PASID. Deliberately not keyed off
> + * kfd_processes_table: a draining process may already have been removed from
> + * it, and the drain fence must still be able to find its waiter.
> + */
> +struct kfd_irq_drain_waiter {
> +	struct list_head list;
> +	u32 pasid;
> +	struct completion done;
> +};
> +
> +static DEFINE_SPINLOCK(kfd_irq_drain_lock);
> +static LIST_HEAD(kfd_irq_drain_list);

If you use an XArray here, you have a more efficient lookup and you also 
get the spin-lock for free. In fact, that xarray already exists in 
amdgpu_ids.c: amdgpu_pasid_xa. It stores a pointer to the fpriv. You can 
get it with amdgpu_pasid_get_fpriv_locked. So you could just add the 
completion to struct amdgpu_fpriv. Maybe the whole IRQ draining logic 
should move to amdgpu_ids.c in that case, and KFD would just invoke it 
with a PASID.

Regards,
   Felix


> +
> +#define KFD_IRQ_DRAIN_TIMEOUT	msecs_to_jiffies(1000)
> +
>   /* For process termination handling */
>   static struct workqueue_struct *kfd_process_wq;
>   
> @@ -1019,8 +1035,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		if (ret)
>   			pr_warn("Failed to create debugfs entry for the kfd_process, ret = %d\n",
>   				ret);
> -
> -		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>   out:
>   	mutex_unlock(&kfd_processes_mutex);
> @@ -1344,6 +1358,8 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	kfd_process_free_outstanding_kfd_bos(p);
>   	svm_range_list_fini(p);
>   
> +	kfd_process_drain_deferred_interrupts(p);
> +
>   	kfd_process_destroy_pdds(p);
>   	dma_fence_put(ef);
>   
> @@ -1420,6 +1436,8 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
>   	 * back on the MES list and, once proc_ctx_bo is freed, MES would fault
>   	 * on the freed process context. Retiring the context last avoids this.
>   	 */
> +	if (p->debug_trap_enabled)
> +		p->irq_drain_deferred = true;
>   	kfd_dbg_trap_disable(p);
>   
>   	if (atomic_read(&p->debugged_process_count) > 0) {
> @@ -2313,17 +2331,16 @@ int kfd_resume_all_processes(void)
>   	return ret;
>   }
>   
> -/* assumes caller holds process lock. */
> -int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
> +void kfd_process_drain_interrupts(struct kfd_process_device *pdd)
>   {
> +	struct kfd_irq_drain_waiter waiter;
>   	uint32_t irq_drain_fence[8];
> +	unsigned long flags;
>   	uint8_t node_id = 0;
> -	int r = 0;
> +	long r;
>   
>   	if (!KFD_IS_SOC15(pdd->dev))
> -		return 0;
> -
> -	pdd->process->irq_drain_is_open = true;
> +		return;
>   
>   	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
>   	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
> @@ -2341,33 +2358,53 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
>   		irq_drain_fence[3] |= node_id << 16;
>   	}
>   
> +	waiter.pasid = pdd->pasid;
> +	init_completion(&waiter.done);
> +
> +	spin_lock_irqsave(&kfd_irq_drain_lock, flags);
> +	list_add(&waiter.list, &kfd_irq_drain_list);
> +	spin_unlock_irqrestore(&kfd_irq_drain_lock, flags);
> +
>   	/* ensure stale irqs scheduled KFD interrupts and send drain fence. */
> -	if (amdgpu_amdkfd_send_close_event_drain_irq(pdd->dev->adev,
> -						     irq_drain_fence)) {
> -		pdd->process->irq_drain_is_open = false;
> -		return 0;
> +	if (!amdgpu_amdkfd_send_close_event_drain_irq(pdd->dev->adev,
> +						      irq_drain_fence)) {
> +		r = wait_for_completion_interruptible_timeout(&waiter.done,
> +							      KFD_IRQ_DRAIN_TIMEOUT);
> +		if (r <= 0)
> +			dev_warn_ratelimited(pdd->dev->adev->dev,
> +					     "irq drain on pasid 0x%x did not complete (%ld)\n",
> +					     waiter.pasid, r);
>   	}
>   
> -	r = wait_event_interruptible(pdd->process->wait_irq_drain,
> -				     !READ_ONCE(pdd->process->irq_drain_is_open));
> -	if (r)
> -		pdd->process->irq_drain_is_open = false;
> -
> -	return r;
> +	spin_lock_irqsave(&kfd_irq_drain_lock, flags);
> +	list_del(&waiter.list);
> +	spin_unlock_irqrestore(&kfd_irq_drain_lock, flags);
>   }
>   
> -void kfd_process_close_interrupt_drain(unsigned int pasid)
> +void kfd_process_drain_deferred_interrupts(struct kfd_process *p)
>   {
> -	struct kfd_process *p;
> -
> -	p = kfd_lookup_process_by_pasid(pasid, NULL);
> +	int i;
>   
> -	if (!p)
> +	if (!p->irq_drain_deferred)
>   		return;
>   
> -	WRITE_ONCE(p->irq_drain_is_open, false);
> -	wake_up_all(&p->wait_irq_drain);
> -	kfd_unref_process(p);
> +	p->irq_drain_deferred = false;
> +
> +	for (i = 0; i < p->n_pdds; i++)
> +		kfd_process_drain_interrupts(p->pdds[i]);
> +}
> +
> +void kfd_process_close_interrupt_drain(unsigned int pasid)
> +{
> +	struct kfd_irq_drain_waiter *waiter;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&kfd_irq_drain_lock, flags);
> +	list_for_each_entry(waiter, &kfd_irq_drain_list, list) {
> +		if (waiter->pasid == pasid)
> +			complete(&waiter->done);
> +	}
> +	spin_unlock_irqrestore(&kfd_irq_drain_lock, flags);
>   }
>   
>   struct send_exception_work_handler_workarea {
--------------W6yiXvswjUTIEKO8V67xSxJp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-09-30 09:42, Heng Zhou wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260930134205.469578-1-Heng.Zhou@amd.com">
      <pre wrap="" class="moz-quote-pre">When a debugged process exits, kfd_process_notifier_release_internal()
first removes it from kfd_processes_table and then calls
kfd_dbg_trap_disable(), which drains the process interrupts. The drain
sends a fence through the IH and waits, without a timeout, for
kfd_process_close_interrupt_drain() to wake it up. That wakeup looks
the process up by PASID in kfd_processes_table, which no longer holds
it, so the wakeup is lost and the exiting task sleeps forever. The
fatal signal has already been consumed in do_exit(), so the
interruptible wait cannot be broken either.

The wait happens inside the mmu_notifier release callback, i.e. within
the global mmu_notifier SRCU read-side critical section, so every
synchronize_srcu() on it stalls as well. Any other process releasing
its mm then hangs in D state and the system needs a reboot. This is
seen with rocgdb on MI300X.</pre>
    </blockquote>
    <p>I suspect this may have been introduced by this patch by Alex:</p>
    <pre>commit f34034ce5d2116f397008c63901c9c1946e5d665
Author: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
Date:   Fri Jul 24 15:53:48 2026 -0500

    drm/amdkfd: disable debug before retiring MES process context on teardown

...
</pre>
    <p>If you can confirm that, please add an appropriate Fixes: tag.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260930134205.469578-1-Heng.Zhou@amd.com">
      <pre wrap="" class="moz-quote-pre">

Fix this by:

- Tracking pending drains in a list keyed by PASID instead of looking
  the process up in kfd_processes_table, so the drain fence always
  finds its waiter.
- Bounding the wait with a timeout, since the fence can be lost when
  the IH ring or the KFD interrupt FIFO overflows, and warning when the
  drain does not complete.
- Deferring the drain of an exiting debugged process from the
  mmu_notifier release path to kfd_process_wq_release(), before the
  PDDs and their PASIDs are released, so that stale interrupts cannot
  hit a process that reuses the PASID.

Signed-off-by: Heng Zhou <a class="moz-txt-link-rfc2396E" href="mailto:Heng.Zhou@amd.com">&lt;Heng.Zhou@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 89 +++++++++++++++++-------
 3 files changed, 68 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 0dd1fd448059..2b227d9de492 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -664,7 +664,8 @@ static void kfd_dbg_clean_exception_status(struct kfd_process *target)
 	for (i = 0; i &lt; target-&gt;n_pdds; i++) {
 		struct kfd_process_device *pdd = target-&gt;pdds[i];
 
-		kfd_process_drain_interrupts(pdd);
+		if (!target-&gt;irq_drain_deferred)
+			kfd_process_drain_interrupts(pdd);</pre>
    </blockquote>
    <p>The way you're setting and clearing p-&gt;irq_drain_deferred
      seems pretty fragile. I'd prefer to just pass this as a parameter
      to kfd_dbg_trap_disable and kfd_dbg_clean_exception_status. Then
      you also don't need two different drain functions.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260930134205.469578-1-Heng.Zhou@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
 		pdd-&gt;exception_status = 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2847a5ec5ede..c04c3a03f559 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1030,9 +1030,7 @@ struct kfd_process {
 	uint64_t exception_enable_mask;
 	uint64_t exception_status;
 
-	/* Used to drain stale interrupts */
-	wait_queue_head_t wait_irq_drain;
-	bool irq_drain_is_open;
+	bool irq_drain_deferred;
 
 	/* shared virtual memory registered by this process */
 	struct svm_range_list svms;
@@ -1245,7 +1243,8 @@ bool enqueue_ih_ring_entry(struct kfd_node *kfd, const void *ih_ring_entry);
 bool interrupt_is_wanted(struct kfd_node *dev,
 				const uint32_t *ih_ring_entry,
 				uint32_t *patched_ihre, bool *flag);
-int kfd_process_drain_interrupts(struct kfd_process_device *pdd);
+void kfd_process_drain_interrupts(struct kfd_process_device *pdd);
+void kfd_process_drain_deferred_interrupts(struct kfd_process *p);
 void kfd_process_close_interrupt_drain(unsigned int pasid);
 
 /* amdkfd Apertures */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 226f52626e84..b2365c21db9e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -55,6 +55,22 @@ DEFINE_MUTEX(kfd_processes_mutex);
 
 DEFINE_SRCU(kfd_processes_srcu);
 
+/*
+ * Pending interrupt drains, keyed by PASID. Deliberately not keyed off
+ * kfd_processes_table: a draining process may already have been removed from
+ * it, and the drain fence must still be able to find its waiter.
+ */
+struct kfd_irq_drain_waiter {
+	struct list_head list;
+	u32 pasid;
+	struct completion done;
+};
+
+static DEFINE_SPINLOCK(kfd_irq_drain_lock);
+static LIST_HEAD(kfd_irq_drain_list);</pre>
    </blockquote>
    <p>If you use an XArray here, you have a more efficient lookup and
      you also get the spin-lock for free. In fact, that xarray already
      exists in amdgpu_ids.c: amdgpu_pasid_xa. It stores a pointer to
      the fpriv. You can get it with amdgpu_pasid_get_fpriv_locked. So
      you could just add the completion to struct amdgpu_fpriv. Maybe
      the whole IRQ draining logic should move to amdgpu_ids.c in that
      case, and KFD would just invoke it with a PASID.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260930134205.469578-1-Heng.Zhou@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+#define KFD_IRQ_DRAIN_TIMEOUT	msecs_to_jiffies(1000)
+
 /* For process termination handling */
 static struct workqueue_struct *kfd_process_wq;
 
@@ -1019,8 +1035,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		if (ret)
 			pr_warn(&quot;Failed to create debugfs entry for the kfd_process, ret = %d\n&quot;,
 				ret);
-
-		init_waitqueue_head(&amp;process-&gt;wait_irq_drain);
 	}
 out:
 	mutex_unlock(&amp;kfd_processes_mutex);
@@ -1344,6 +1358,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 	kfd_process_free_outstanding_kfd_bos(p);
 	svm_range_list_fini(p);
 
+	kfd_process_drain_deferred_interrupts(p);
+
 	kfd_process_destroy_pdds(p);
 	dma_fence_put(ef);
 
@@ -1420,6 +1436,8 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
 	 * back on the MES list and, once proc_ctx_bo is freed, MES would fault
 	 * on the freed process context. Retiring the context last avoids this.
 	 */
+	if (p-&gt;debug_trap_enabled)
+		p-&gt;irq_drain_deferred = true;
 	kfd_dbg_trap_disable(p);
 
 	if (atomic_read(&amp;p-&gt;debugged_process_count) &gt; 0) {
@@ -2313,17 +2331,16 @@ int kfd_resume_all_processes(void)
 	return ret;
 }
 
-/* assumes caller holds process lock. */
-int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
+void kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 {
+	struct kfd_irq_drain_waiter waiter;
 	uint32_t irq_drain_fence[8];
+	unsigned long flags;
 	uint8_t node_id = 0;
-	int r = 0;
+	long r;
 
 	if (!KFD_IS_SOC15(pdd-&gt;dev))
-		return 0;
-
-	pdd-&gt;process-&gt;irq_drain_is_open = true;
+		return;
 
 	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
 	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID &lt;&lt; 8) |
@@ -2341,33 +2358,53 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 		irq_drain_fence[3] |= node_id &lt;&lt; 16;
 	}
 
+	waiter.pasid = pdd-&gt;pasid;
+	init_completion(&amp;waiter.done);
+
+	spin_lock_irqsave(&amp;kfd_irq_drain_lock, flags);
+	list_add(&amp;waiter.list, &amp;kfd_irq_drain_list);
+	spin_unlock_irqrestore(&amp;kfd_irq_drain_lock, flags);
+
 	/* ensure stale irqs scheduled KFD interrupts and send drain fence. */
-	if (amdgpu_amdkfd_send_close_event_drain_irq(pdd-&gt;dev-&gt;adev,
-						     irq_drain_fence)) {
-		pdd-&gt;process-&gt;irq_drain_is_open = false;
-		return 0;
+	if (!amdgpu_amdkfd_send_close_event_drain_irq(pdd-&gt;dev-&gt;adev,
+						      irq_drain_fence)) {
+		r = wait_for_completion_interruptible_timeout(&amp;waiter.done,
+							      KFD_IRQ_DRAIN_TIMEOUT);
+		if (r &lt;= 0)
+			dev_warn_ratelimited(pdd-&gt;dev-&gt;adev-&gt;dev,
+					     &quot;irq drain on pasid 0x%x did not complete (%ld)\n&quot;,
+					     waiter.pasid, r);
 	}
 
-	r = wait_event_interruptible(pdd-&gt;process-&gt;wait_irq_drain,
-				     !READ_ONCE(pdd-&gt;process-&gt;irq_drain_is_open));
-	if (r)
-		pdd-&gt;process-&gt;irq_drain_is_open = false;
-
-	return r;
+	spin_lock_irqsave(&amp;kfd_irq_drain_lock, flags);
+	list_del(&amp;waiter.list);
+	spin_unlock_irqrestore(&amp;kfd_irq_drain_lock, flags);
 }
 
-void kfd_process_close_interrupt_drain(unsigned int pasid)
+void kfd_process_drain_deferred_interrupts(struct kfd_process *p)
 {
-	struct kfd_process *p;
-
-	p = kfd_lookup_process_by_pasid(pasid, NULL);
+	int i;
 
-	if (!p)
+	if (!p-&gt;irq_drain_deferred)
 		return;
 
-	WRITE_ONCE(p-&gt;irq_drain_is_open, false);
-	wake_up_all(&amp;p-&gt;wait_irq_drain);
-	kfd_unref_process(p);
+	p-&gt;irq_drain_deferred = false;
+
+	for (i = 0; i &lt; p-&gt;n_pdds; i++)
+		kfd_process_drain_interrupts(p-&gt;pdds[i]);
+}
+
+void kfd_process_close_interrupt_drain(unsigned int pasid)
+{
+	struct kfd_irq_drain_waiter *waiter;
+	unsigned long flags;
+
+	spin_lock_irqsave(&amp;kfd_irq_drain_lock, flags);
+	list_for_each_entry(waiter, &amp;kfd_irq_drain_list, list) {
+		if (waiter-&gt;pasid == pasid)
+			complete(&amp;waiter-&gt;done);
+	}
+	spin_unlock_irqrestore(&amp;kfd_irq_drain_lock, flags);
 }
 
 struct send_exception_work_handler_workarea {
</pre>
    </blockquote>
  </body>
</html>

--------------W6yiXvswjUTIEKO8V67xSxJp--
