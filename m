Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FA8CA6015
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 21:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5E110E150;
	Thu,  8 Oct 2026 21:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0VZQ1x5y";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B132010E150
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 21:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQqsFCTxcIgO0UG4H3XcpdiX3UhPgiX1PVZjA2zjNW1N4UIgwEo4lsP3esVhZd413swIS+ihsOmnpMxKM1vUDMKgcdTTQ0UAt07Rt1m1JibXGK9UbaeA/FXZQzPPUSjKrIVeabMr65IPJ61iMm31vekcJ8/7JYnON9jlbEGG7mjupXjepZxgyQWPpwJIg5EKZRG2AOIZ+KDzeugSeby1SMOXjfkcvtozBuvXR3NPfJF5/apEUl1iqL2UScLtdwPBn5IKkQ5hd34KrnSKPkOu80KWhf3d8nUDnECFwfCwcQkmHWO4yJ2JBF+CkpodSW9B7+3NqfLASh/LK/HOPqfLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH072A/LvisimmUXTphJDgp4lhlRTelNnNB+9l3GAKg=;
 b=cmO6WUmWsv8dce0HwVZpIG2GT6SqeTt3jVD1/7oRItE+6TBht8VcOGUjlv0VA9IG5IqU9WSeC9Y3cVaXerZ52sG64q/0rXZrOdnZV0Db9W5wvkthWkQ0IXlM8WL6dbtGla22C8e30vKb0iVayl+qlIwPEf4iJ82jYnSM4jHtYj1Ck3qdY7fvLYA4w3GHSHo5m/v24LR2kSZE23cuLd0h4xXTKUqro+hVzpFi2stHllICjfyqT34dk8TMtimHyvv4MoRSeLhbAbzWr7T+hlnSv0GaNlwfokuvLf+QJB4Sr7oXMuFt5atDsREp95hL4XaNNUOGpwOxvCA7QmErEWr3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH072A/LvisimmUXTphJDgp4lhlRTelNnNB+9l3GAKg=;
 b=0VZQ1x5y03sfgD1vONCsiT3CqTFroY0g6dKpkJITW4/dbcTTZryovMVrcIhSe7f6AXnuH+r+wiNQ4e8aWzz4D4gMQhLvCZNcee+8sBap8Iyr7nOMDAw5xflznr5hTavde/OPXL6WK2seotueB+4ncGqncWkvRl8U72z25CoounY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH8PR12MB6795.namprd12.prod.outlook.com
 (2603:10b6:510:1c6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:42:42 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 21:42:42 +0000
Message-ID: <9f7f2076-7306-4f42-87ff-3f51ef5144bd@amd.com>
Date: Thu, 8 Oct 2026 17:42:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Olivier Kaloudoff <kaloudoff@icloud.com>
References: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
 <20261008173350.40455-4-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261008173350.40455-4-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::29) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 88600870-f50c-48ad-58e6-08df258514d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|3023799007|6133799003|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Xq1ikN7qdjke91Iu3qLFjygC86NKtL+X61MeBDZJduV7WBCTCfjurdX1BDCa3YqrcXJXWbKhvL9SyujaH5S3kCWbW56J9TnmHmpL4ROinHvCYvSDS4VojIPke1+0JCHAvr4LFuTjXTndaWYG+vYR6szflt44pzUh79lYFpFy0uK+3WisX5erTU+8xQ4YoWjqcB62eF+ghKedLcrbiDw3r+w7rHxq5OjTEkK9lOo1ZNd3gz1EHJR8fjdWU6WxHnOh4LNV24XdznoWNITi8Ffyh2x5ydFUBzUM0kMuDpSsOHF6GbsQ9caGABg30H/GEvImiGHpP/ihxO9hdw/1zAi1pvP64WB7TmCsE4XhGBLH8hWVSMS475bSLX04HcxAeRLk676xTYZOtVY7QQN3WSUStT+rYtLfpnTogpHVL0F9nt2Bc53CHQ7qss/fOIC/f/YGdMGdflAVCET/oAZjUyB6zcEOq5v2QVuLdGMQvDkVFvofOHyLDGEgIVdlVI4q8Ka1EhVGw/LyUFyUliUN8Q45A5PdImKXN0jePupDc9wrjvaL1FlG81I80SHDBXTlNKcNH6s2xKbXr5gaMJBQ0izENESfL24ltIaKGKoJzM0TWRKxRJzbNBytXcCTRuDkwzZrPVK2nfVXMdx4tTDZ8/iRFn28NCyLPJLqLEJ9PHL49bU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2NwTHdwLzRZK2szWnppMFo1TmlPVFJrTEJXRllxZUthTTRsSWk4NW1LZnFp?=
 =?utf-8?B?S2VieFdhR0huS3VPUWtsOE56cjVvOHdBL2F4MHdvWjhQSjMwV2hxN25IUWEr?=
 =?utf-8?B?M3pHQ2RndFd0N0toUHpEb21uWTV6QURtNkQ1Uk9pTUlZNldjYmxlUjUxNEg3?=
 =?utf-8?B?a3VHOVNIRUZyZzQ4YkZvZUV4VlpYZ3ZQeU95R1VKR2owQ1BFWHpwWmRpQ0hv?=
 =?utf-8?B?UzZHcHVtcVArMkczNTA5SHNWcGxMeUt6b01ES293VHQ5OTJRK0s0MFltTGlm?=
 =?utf-8?B?Um54WHB5VUZHd2V2dEl3Q2I5TmtwNDJSMzQwYThQemRvRXlQRlIzTHoyR0hT?=
 =?utf-8?B?d081aCsyK0VuRC9nWXdLaVB6QlJnOEUyaG9uTVMxZ2FOeHBUZkdneTRyS20y?=
 =?utf-8?B?YmFtMjlTM3RNNGc0ME5tSnY3SW5zdzdlMmYwMkJSaVliMlV4S0NWK1VoeFVk?=
 =?utf-8?B?b005cUlqQzFNZnN4TlJoUGJkMnJEaklENU5FYllsYlZ6VnRBWVRuVG16a2tx?=
 =?utf-8?B?MnU3RFNFUzJsQUJhaGxaOFI2eGM0TC9TMG9lT21sRkI4T3EzWnBNTUw4ZmRx?=
 =?utf-8?B?Tk1OR2hpODNHcmFqME1YSXZFQVczK2NCRWpXMU9GY0JibkIwdDUyS1pkblk1?=
 =?utf-8?B?bTFudm5KZ1NnNjNiUlNMUUQwcDVYeVdMc0UweHg2WEw4VzFXMVhoRDhBY0Fi?=
 =?utf-8?B?VXRGYW56ZVBFNE51MmhZdCt6QVJYWUtPaHFVMmhtU0JNYWMrcmgzRWFqUzF0?=
 =?utf-8?B?OUlERVJ4Q0VGMnRGK0E0cHBqbENrb0NUeEl3UWFCeHVuSlN1N0treS8zSXlK?=
 =?utf-8?B?QXVNOUc1WHRyZ2RJM1NRc21XVzY0V3lRcGVLYkptOU1hVW03elBDei9WRURZ?=
 =?utf-8?B?SEl6UFo3dmZUcXBXSGl0UGlzd21icU5aVktSeitXeXRrTjBOQytJTjhWbDlo?=
 =?utf-8?B?ZFFqMHYycU1DeURKVjlWd2MxUENDUU5JSVlFdUhQeFJkUFZnL2FvQ1o2SHlr?=
 =?utf-8?B?OFF1SHM0K0pyOThBRFhzVXUycUFTV2hiRThORTFVbE9tNGkrRlZoL1NPVDc2?=
 =?utf-8?B?cUtsa2dyMlZuaFlzMEllVHRGK1RwOThLaStmNU4vdFlnc3JEKzYrbHJDQWFL?=
 =?utf-8?B?aklBTzl3d1U5OUZNUmtxcitheVlIZlo1VXg0U01PMnR5NmgzaWJoRldsQnly?=
 =?utf-8?B?YnU3ZUNubmRWUVhLN0k5WktaR0J2K2RqbldrYjJqNnhaR1c2R3lNbjJNVTN5?=
 =?utf-8?B?OU81UEQyNnBKWFV2S0NCSFpucG1kVkhvNmlBdnIrY3ArRkxxVzJ2ZnZPek9B?=
 =?utf-8?B?RUNiTkNGVERnMy9zNnlCcHBxNm90TW1pNTlYUG05VElnbTRQR0VvVjk5a0V0?=
 =?utf-8?B?TGUrRVlRVlE0VGdhV0pnSDVabWdqNUlxQ3UyREJUblVpa3NhR3RCVkVXSTJy?=
 =?utf-8?B?WktVaEp6SVRTUW4rTHQrdkdXQWlvc1J6dzd4N0R1cGgyQjZrRWhDTy9iZDVF?=
 =?utf-8?B?czNyaXFYcHhIMmpqNlRGaC9FN0NsYlBCS2tIeUhWTGQxZm5RT0pMVU85V24x?=
 =?utf-8?B?YkxsYml4ellsRVhaRWtVN0lPUjUrTnRSbUZDWmJkMnlKbUVkSXRlZEZjbG1O?=
 =?utf-8?B?UTNXbkQwYWwrVHhUSUJ3SjkzNjJhK0dYNWFCOURwZUpkSGJDK2RqU0QwZ1FZ?=
 =?utf-8?B?L1Yyeno1c3pnek9uNy9rT2Zka2FEMndKWDVoK3U3bkx0MHRyNTRiaGllcjhT?=
 =?utf-8?B?bHZRYjlkSlIyRCtvUE11c25BM0duUDVWbk00am1sNkh4eUxoczBiY3RYanJ4?=
 =?utf-8?B?SHkzaUdvUk1iZW5hT081citueDl2UHZTL01RYncwNmNDcWdGTTA4c09RbldE?=
 =?utf-8?B?ZDM4OTlKdHplaUpIQzFFRXZ3aTViNU9lcUxvN2JtZGVCUEdjcnpLWXIySEF6?=
 =?utf-8?B?RkV5MjQrb1J5aVBuNXZUR21aakFsUDFVQ1RLS2t0dnQ2T3lOeDdodGxMMVZB?=
 =?utf-8?B?TUNvYzIyMFdIbGNwaTBENzJ0WW8yL0dXNENOZFNJdTJrUHY3ei96ZG9uV1hG?=
 =?utf-8?B?VzZ2QmQ1NlRiZTZ2eVBYU2NCTVlxQzJZU0ovbkVta3lXWW9zQnd6WTZyOVdX?=
 =?utf-8?B?b1pGT1cveVZPRi9MS0paSVE5cXovYlZLeGtOdm9NYVZlNCtJYUs0TVozNHEv?=
 =?utf-8?B?VXpyU1ZacFMrbDdPSXFBaWxMVmxmcExTTkhHS1VlSU0yMW44NUFjQThPbXcy?=
 =?utf-8?B?NEh2V3c5a0sydkZULzJTY3pJa2QralVWRzJZdU93Qk85NWNHeFBMVW1iL0hh?=
 =?utf-8?B?MHRpRkk3dUwrSng3NkxQeXBWaUd4OG8vT0g5dDBDMVQ3SXZRZEhaUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88600870-f50c-48ad-58e6-08df258514d6
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 21:42:42.1728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl7uH8z30r9YgUEmKsuhNHgDljJhb4bye5PX1Usl3ot4dswlNW8JLRsu4xMhHHAtaAl7phqTGjHmSxhKyPT3ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
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


On 2026-10-08 13:33, Olivier Kaloudoff wrote:
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
> Verified on MI50 behind Thunderbolt: the workload takes SIGBUS,
> coredump completes, kfd_processes_count drains in ~7s, pciehp
> removal finishes, and the device re-enumerates cleanly on slot
> re-power. Previously the same repro wedged the host.
>
> Cc: Xiaogang Chen <xiaogang.chen@amd.com>
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> ---
> Changes in v5:
> - dropped drm_dev_is_unplugged()/pci_dev_is_disconnected() checks;
>    drm_dev_enter()/exit() alone is sufficient (Felix Kuehling)
>
> Changes in v4:
> - use AMDGPU_FENCE_JIFFIES_TIMEOUT instead of an open-coded 10s
>    (Felix Kuehling)
> - guard migration sections with drm_dev_enter()/exit() instead of
>    racing flag checks (Felix Kuehling)
> - keep pci_dev_is_disconnected() early-out for the dead-link window
> - moved svm_range_restore_work() change to patch 2
>
> Changes in v3:
> - new
> ---
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 253365a..14f2273 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -202,7 +202,17 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
>   	int r = 0;
>   
>   	if (mfence) {
> -		r = dma_fence_wait(mfence, false);
> +		/* Bound the wait: on a dying device the fence may never
> +		 * signal.
> +		 */
> +		long ret;
> +
> +		ret = dma_fence_wait_timeout(mfence, false,
> +				AMDGPU_FENCE_JIFFIES_TIMEOUT);
> +		if (!ret)
> +			r = -ETIMEDOUT;
> +		else if (ret < 0)
> +			r = ret;

You're adding more failure cases here.  But the callers of this function 
currently don't check for errors. We'll need to fix that. If the copy 
times out or fails otherwise, we should not pretend that the migration 
succeeded. It doesn't matter in the GPU-unplug and process termination 
case you're working on, but it could result in silent data corruption in 
other cases where we hit a timeout maybe because the DMA engine just 
takes too long for some reason.

We'll need to put all the migration pages and clear the migrate->dst 
array before calling migrate_vma_finalize.

Also pass the error code back to the caller.

Regards,
   Felix


>   		dma_fence_put(mfence);
>   		pr_debug("sdma copy memory fence done\n");
>   	}
> @@ -494,6 +504,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	u64 ttm_res_offset;
>   	struct kfd_node *node;
>   	unsigned long mpages = 0;
> +	int idx;
>   	long r = 0;
>   
>   	if (start_mgr < prange->start || last_mgr > prange->last) {
> @@ -507,6 +518,9 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
>   		return -ENODEV;
>   	}
> +	/* Block unplug while the migration submits jobs and waits on them */
> +	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
> +		return -ENODEV;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
>   		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
> @@ -521,6 +535,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   					node->xcp ? node->xcp->id : 0);
>   	if (r) {
>   		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
> +		drm_dev_exit(idx);
>   		return -ENOSPC;
>   	}
>   
> @@ -565,6 +580,7 @@ out:
>   					prange->npages * PAGE_SIZE,
>   					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
>   					node->xcp ? node->xcp->id : 0);
> +	drm_dev_exit(idx);
>   	return r < 0 ? r : 0;
>   }
>   
> @@ -821,6 +837,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	unsigned long start;
>   	unsigned long end;
>   	unsigned long mpages = 0;
> +	int idx;
>   	long r = 0;
>   
>   	/* this pragne has no any vram page to migrate to sys ram */
> @@ -841,6 +858,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
>   		return -ENODEV;
>   	}
> +	/* Block unplug while the migration submits jobs and waits on them */
> +	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
> +		return -ENODEV;
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
>   		 prange->svms, prange, start_mgr, last_mgr,
>   		 prange->actual_loc);
> @@ -885,6 +905,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   		}
>   	}
>   
> +	drm_dev_exit(idx);
>   	return r < 0 ? r : 0;
>   }
>   
