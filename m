Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F8ACA6012
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 07:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A1410E4DF;
	Fri,  9 Oct 2026 07:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z4oR6ZIi";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8C3D10E4DF
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 07:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+1AnaLEznNuaIbvUaycWvD490W/dFPnWCbft5CsmIGNjjtmD4u1BAu9RrVVu1P6diZYKC/ClTeLko32AoEUFzcNlxGgun6Ty3THKhN1WQ5YwWgriKuF0/WFiFwWqpMVpGPgrA6/t02umYG2/P5tCV/l/iXsWpS1Txa4T97UqOQD3mDI/2avpdBVz3dxj9TNg2juELymqxc48mjUXCw6EgFh4APbuZxZcMwG7Ic+tTkouljxnWU5nKc8lfbnnHqrD/ioW3t0zeuQMhrf1VmP1ILFMK2B+m+lmXFTkGiZylowm3DWDhj8417RrasB8Hs0SPHFxT6MmgWRijtj2jg+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPP2ANimd9xaPBPAO2GRG/6exH0gk5kAdHnj+JC9QAw=;
 b=XLX9BY305GKGWReRSkA9OL9TtIK0n7RCye8wMToQRDSiBSxqRD4NJH4JOMJ2zwDcXdo+XUiNHJVggpchzDV8hEYFCWOcfDGTufojwxh5dnUIFxDZB70PG5y8xIbr6hZN4gwUzECzhdl0naDfg31LxjRJ0CUusfLKp4lyt9NxZ8jyxPexSXU+T4dzIImbZx/4BSCWnwKm63vDZ4huPEsL335XxXYTO0ztcZ9x8M+8ThrEjDD+crUzJQ8y2WBX7spN+49fizWqOZ6wA6aJv9JcpVIObG8/gh1U3fG3T5ZJQMCcrjJLGT2Dickn+H0ccwCnU9OrXbFz7DqGGzrH43bQZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPP2ANimd9xaPBPAO2GRG/6exH0gk5kAdHnj+JC9QAw=;
 b=z4oR6ZIi0zBH8xIGShqKhHPEnuwIpsIZxDi6yQ683e+ru8yvjNrHoET2Eamyjk5mI4wER2LVbYR331/2FqEcdz4TaPbpTp6Z30iCxHJieVWvCjGuQa9PdEmFb5ejlSJHx69w3PIv4Rq2ZngJY0gbv1XAZVP+KUAkN76MF3+0GDw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 07:03:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 07:03:15 +0000
Message-ID: <62280d57-3f63-4979-9e4c-f0eca7208b19@amd.com>
Date: Fri, 9 Oct 2026 09:03:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Olivier Kaloudoff <kaloudoff@icloud.com>
References: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
 <20261008173350.40455-4-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008173350.40455-4-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: a60df78a-0727-4abc-374d-08df25d36382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|56012099006|6133799003|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Ti93xX5W4q3MTjvwrRML01zLsv8T+5YZx151iLKgYo66ZymO49c6+8LZexNRN/p1apGuCqhVV8YQVlZx1a9nmG7CJkFUOPohw3GbOHTptsnvAQVEQKYc9iwJfPIUcg+L7+J1TdpzuMYD0YgZ8VdQ0YWqjgQanSG/9wPRDm+OVEPXcF/T/QTnjACittbQyL78yydYQ8cZAKMHZlZnz6fUpfE/qWhOSvD4pY75TC2f6atTLz18h+kSXj1SYf2nmPLK+zG5G2mK/BfvozZYaTrtctuoik5FJr2sT4T+kcAVlskBKjpzUHMSa+BDWd0AGHF/kZ4PLcDgoGw/Yje6kyWGoPKc0DjZX9ksxLHcJp5piCcb9o6fE1/U112O6b3ix62HCIy0A3MGpJukhgvYhToFXAhDfxjgxbHY5HObBeNBF0Onh6b8FpskqhNeygygV6UWR7miouLTBlzNAKY2f8Nyvab8Z3u4u0j7jDjE7uAb9Rx6wB6x655XnF5eN7N1oCYhT+RbCgKaTLB/ZEAgtuchRsakFdzIplIp+oVvu37RWoZrhVHufsDeCZr7H3Z2QT4gC3TJp5n1yNab/6u+5BemUzPlhRZhh61rZYY8cll7R5BjnN2t1cY16sUnpcEtkT6oIkbgK1iPwlPCIiyjsvRlc7AoH1+4fjoSzfl1KbhRUpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(6133799003)(3023799007)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUREWW02WkVuZ3lLcFVJbm0xRnlGenZDbDBhWklOZHNWMmM3ZmMzWWJjUFV2?=
 =?utf-8?B?UTY0QmNlcDhXRFZqQmwvazRkOUE2dlJVRVFUZ1lMeUlLODVIN2ExdG5TaGpo?=
 =?utf-8?B?dHhZVVUremNWV1pTdTNCTTZYeXN6R01mQUQ5Qkx6OHdzT2hRZXd1Q0tDVTJU?=
 =?utf-8?B?WjZjSTlTUjFyN09EbmtPVGFESTZ4RjhZWkV1eXRacWtGekpIc1IrUnhPS3Jr?=
 =?utf-8?B?WFBMNHA4WWFnUU1uWUJmYnB5NkxJRHJPVU9kajFaVk5NWlFsN0lmSTZlemF6?=
 =?utf-8?B?eUJQVUsxbkFHd2txZjZpVlJuZWhnTmpic2E4ajRvbU43dGNpbS9XQ2IvbnVt?=
 =?utf-8?B?VHl4K3ZTaWNlb1lDTzlDb2ZUN1pDS0FCNFZOOWhjWGFXR2RzU2E2OEZwOFcr?=
 =?utf-8?B?Qi9QYjB2cVR2TUtoRm5TcXNPdmMzOEV3enkwNFd4a3A0bnZLMld4RElPR3Vt?=
 =?utf-8?B?VnIyWHN1OUVFbnl0WHN2d0syOGRhZ3ZIK0x3dWxPQzRBRlFGRkhqQnhOTFBN?=
 =?utf-8?B?NktNemw5QVc4bWtHZWlYV2JvQnpvcTVuRmMzQjRZRmlzQmU2cllVQWRBVkxq?=
 =?utf-8?B?V1dkdDFnYVhUaGwwbE5SR2hIVVYwaElqUXFXYmovckJhcmRmVGQrU2VNVm1K?=
 =?utf-8?B?dFd5RlRmc3cyZmlZMHFOMExldGtKYVY1MXNKYnFIKy9Qbmc2aklwZDh4MjBW?=
 =?utf-8?B?MlJ2dVpuRnV0emhvNlduaWFaWi9PbVZSd0JCOEVmZVcxQXRTN3JMdjgrc1V4?=
 =?utf-8?B?TFFjQit5NUlMWEh0bHJHNTU4VmQyMGo2b3Nqekk3WThIQWI2UERRQ0pLNmh1?=
 =?utf-8?B?YW15clJzK1oxN0k4SjhyZ0JUY1VXTkh6dHdHMWt2dFlhL2NGUm00OStKSVlU?=
 =?utf-8?B?NmptQ0cramwwbS9WZk5QbmpCdW9mY3hZMmc4cWcxUW95ZFRsUUdJYnBnYWpO?=
 =?utf-8?B?U0o2cnNpRHprSkNkb1EwRk1KM01KQTJhNmduWUVwUTZFb2NSRlNFVThJV1dS?=
 =?utf-8?B?MVc0OC8yUnFEQkFINUxLWDJ2ek04Zk1PSytrUG5lZ1NnRXc5NzVJR2YwYmUy?=
 =?utf-8?B?dUp3UnF5Q0hnWHlUanIwQXA4RjFxeU1DRmZJb2hpNVZETnZRbDdrODZNdXEy?=
 =?utf-8?B?WVM3VDlxck5RMjdrUUgxV2tBb0Zzdm1sTTYvTzBFdTg2ODBZZE9LZzR1WGZt?=
 =?utf-8?B?VUxGdVZ2ekdwMVZZK05NTDl2ZGxLZFBZbXIxemJyQkNId3AwWGZkOUZjUTBI?=
 =?utf-8?B?ZjM5aTI4ZXJCa00wNmxHK0pXdUZKQlRlKzM1WE1GNVdabHF4ZTAyYXI2SGFn?=
 =?utf-8?B?aW9UMWdRd0Zsb01GNlgwQTRDM3pCa0xBS2lOYXRLZTJnZ25kOVRqNm9BRkhh?=
 =?utf-8?B?VzBXSlNRS3hhd0puTFlDWHRySlFoN1A1TTZnRVdKZm1MQ1d0S21Gc3g4TUNj?=
 =?utf-8?B?cUNsSE1GQU1PY1hwQUNCSkRITmswbmNFMFJ2Q2x4Z0RDcE9ydnZ6eDJZVGJK?=
 =?utf-8?B?dUYwVkgxbEVvTVhvTkM2QVpOT2FZZVQyVHN1em5yYndoZnRqWmszeXRNNWsv?=
 =?utf-8?B?TWZHZmJiZER6U3N3K255SnlocCtDMStNRHczdnhqUldSeW44YkNOK1psUjZJ?=
 =?utf-8?B?YXppc2wya0VaNlUrTGhxVnRtRlhqUHkwTWpxYTRBZGkrNWJtVCtYWGVadDhO?=
 =?utf-8?B?YWkyWnVubmJ0Mk9NUkVxeTIxLzJWTHdTUi9XbEF4YjVKdS9HcThldkRVOExI?=
 =?utf-8?B?akNXbCtMdzU3ZXM1Si9MVjBiSzNJajRqWXBpS2FmempkTmdwZ2kwSCt4OHJm?=
 =?utf-8?B?WmhpT2Z2R1FZc0puSkVUa0pieEZqYm1yZ1djdHd4enhscEFqQnVZVmhoRnp4?=
 =?utf-8?B?VXFLMWIyZU9kOGRyV2xtYlkwTTl4dzVTd1ExTXF4RE9GK2JVYWk1elpZZENu?=
 =?utf-8?B?VGh2dzJBc2pFQ3JOS3ZLSlI1dytiYXkxdXF2ZUVEdXZWODRPM3Rxc0hreG5J?=
 =?utf-8?B?MGlvdURtaVUrWWkyTzRhakJodDRoM05Wa3BoT1ZzMTk2ZDlLaEp3RkFNa3pM?=
 =?utf-8?B?ckJSNGE2eWVYSG9NOWxmNzFIMjAyeXJmWUN2R2s4bEF6NGpHM1UwQUhNeWdp?=
 =?utf-8?B?dlJKQU5rWklOR1kyVUpjRFZPYWZheEl4cHNvZEhST0xFOTdxbmpYS2hTZUFj?=
 =?utf-8?B?QlRCUG96ZXFmZnAzaGxRSy9rQ0h2bzg1ZlRNdW5Bd1pLcEhJcWtPRTZVQ1BE?=
 =?utf-8?B?TkNzSEVYM2FRYjFtSkpnS1M1cU5IVXZtMm9SUWIrR3c5eXNqdzVHWTRFMG11?=
 =?utf-8?Q?VzUsD58B4Jfbp4NRCF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60df78a-0727-4abc-374d-08df25d36382
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 07:03:15.1445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vaMdvhg+2ilBC/NBc9qw3HknrHz4mMqQ8095MRg5CtHwNu0jrhjjCfEALvf5rGW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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

On 10/8/26 19:33, Olivier Kaloudoff wrote:
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
> index 253365a..14f2273 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -202,7 +202,17 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
>  	int r = 0;
>  
>  	if (mfence) {
> -		r = dma_fence_wait(mfence, false);
> +		/* Bound the wait: on a dying device the fence may never
> +		 * signal.
> +		 */

Fences *must* always signal especially when the device is hot removed.

> +		long ret;
> +
> +		ret = dma_fence_wait_timeout(mfence, false,
> +				AMDGPU_FENCE_JIFFIES_TIMEOUT);
> +		if (!ret)
> +			r = -ETIMEDOUT;
> +		else if (ret < 0)
> +			r = ret;

That change makes no sense at all, a non interruptible wait with AMDGPU_FENCE_JIFFIES_TIMEOUT can never fail.

Regards,
Christian.

>  		dma_fence_put(mfence);
>  		pr_debug("sdma copy memory fence done\n");
>  	}
> @@ -494,6 +504,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  	u64 ttm_res_offset;
>  	struct kfd_node *node;
>  	unsigned long mpages = 0;
> +	int idx;
>  	long r = 0;
>  
>  	if (start_mgr < prange->start || last_mgr > prange->last) {
> @@ -507,6 +518,9 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
>  		return -ENODEV;
>  	}
> +	/* Block unplug while the migration submits jobs and waits on them */
> +	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
> +		return -ENODEV;
>  
>  	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
>  		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
> @@ -521,6 +535,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  					node->xcp ? node->xcp->id : 0);
>  	if (r) {
>  		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
> +		drm_dev_exit(idx);
>  		return -ENOSPC;
>  	}
>  
> @@ -565,6 +580,7 @@ out:
>  					prange->npages * PAGE_SIZE,
>  					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
>  					node->xcp ? node->xcp->id : 0);
> +	drm_dev_exit(idx);
>  	return r < 0 ? r : 0;
>  }
>  
> @@ -821,6 +837,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>  	unsigned long start;
>  	unsigned long end;
>  	unsigned long mpages = 0;
> +	int idx;
>  	long r = 0;
>  
>  	/* this pragne has no any vram page to migrate to sys ram */
> @@ -841,6 +858,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>  		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
>  		return -ENODEV;
>  	}
> +	/* Block unplug while the migration submits jobs and waits on them */
> +	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
> +		return -ENODEV;
>  	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
>  		 prange->svms, prange, start_mgr, last_mgr,
>  		 prange->actual_loc);
> @@ -885,6 +905,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>  		}
>  	}
>  
> +	drm_dev_exit(idx);
>  	return r < 0 ? r : 0;
>  }
>  

