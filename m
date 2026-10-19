Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F9CCCF2DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1589610E857;
	Mon, 19 Oct 2026 08:24:04 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4045010E876
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1MAQEYYNiR7lig2G8YDCUaF4QAJlpFGzSeY+fG4PCEa3ZTXhkZGYyAXz2wO9f0tPNoOt8NXjk/cUjKPuY32n3gGqAX+KUcbGLwFs4YeeZ4ikUg8xEFWL1ZaEgd/Zfwy5cCFCpq8ooqyhhac7QAuuZ4W9fNDfCZvRMddTnBAZS63PjWsL0UQEedLNmIifujhiQ+fw55uTdXOG7adZKbEFXVmhqvD9at6da9ie8dUxgSjA0XjjTpNWQyiGfmrmyg2MT5Ssj8zgc4QS0EOB3g0sgi3XfX8eMSbafKCJeGYPjDEDvNiU+EnWi0IW+ppwY6rZSUogOZOYyeIeMPeeOOkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9JFlsd6YVlgKQHbCVPyBdxBMd0bsDoq28oYycakm0A=;
 b=OWFCI1jVoikqrlVyUAWsQNn3MALciBMtQAdFiLfStydfBb2s3bxK+pkgx9P8dNRRC+0rZSqOex97WwiuRKGm525Nj6pS6UGSVJos1Ic+43nfyjU0PjUmfUFK5GbnvdofvJz/BLxPwalWIzikURSDBeVf3t812SId7ehalBc9FrTRKMs/quEUQGjUiHCAux4/E2eK++EurRN+x6CiCUZrHvSa9LVLSU+1rVYQwPZkSy7W70OhRiYRlrssbVK3W34K1FmCL4l1vM/0xc51lc1GpDSllG0RDuBLW+HAwZ9WNsqpaIAN2T943ilqwOBAt+uVGauTG9CybEtvxN3ZN8rSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9JFlsd6YVlgKQHbCVPyBdxBMd0bsDoq28oYycakm0A=;
 b=quh4QB29OMo4pQs8+wDHWcVEnBrFJBIq1Q9x7bs4fWr4D8oWOnhZc1lH3kTpBjlxJ29BGnZhpEu+9RPa+aTAtvBVDWliueo5mnV1C7HCqJeGPIWRoaJ0blcUdXScClLn9JDKtzYdfwJ3bFCra20AuID00wvAv2k2xdOo5ais9qg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA3PR12MB482642.namprd12.prod.outlook.com (2603:10b6:208:712::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:23:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:23:55 +0000
Message-ID: <dd0d869d-7a13-4a6a-b046-f8961a82051c@amd.com>
Date: Mon, 19 Oct 2026 10:23:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdkfd: wait for a GPU reset before freeing a BO
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20261016153236.1163913-1-William.Palacek@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261016153236.1163913-1-William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA3PR12MB482642:EE_
X-MS-Office365-Filtering-Correlation-Id: 1812d330-3d01-4c3a-3fdc-08df2dba50ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|5023799004|11063799006|56012099006|261009223027099003|260925021311599003|260925022911599003|260925021911599003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: GGId1NcMTLmoIQ7wPys2t3PAe3mRz9FIjWuqdcawxX9HrPgTkNSpe21UgfRdBTw5KpMsUzhHipSg57jSkkJS+5wLoc+zMPwlwXqnQw64ohgIwJ4gvC2ygITmhNrHYEFlhF1er89y3g+wbxH5tZoh/j2apVqZme0T3smWhfKY7t4n/Bm9/qBbwjfwnUvTIwy/415ZTQS6TYZDh1k21mLNevNHm6xvKGTDMujTR4//kd3ze2rEjQzysZ8y5n0qd+oCcDXM93QlNUneYsq1373vQid9gH1eC1sVwFY6VPEJpgt3d6gAqi5BvDwemS6xvqTlko7jXrQuwXxVb+XMqCk6PXFIkowMYcTtt58x/N8OHdWtnGG7d+LSTNbuKRZbXwuKNT4N7GTzgd4PzViz+BWgEnddTayuPxqHGxB5LHyZRkufqsYXe1tAihEoVlvYsZZrQ6RrvzibtRHOEcXlGpy0nEwWy4h0NlOiFTp+7ao+6vuJwehJUu6j5wpep9Zy57bnWSQ14j6AY60R4C5RWLIAj9xilKUSu0Ml6QQIIC4LcvlVzffiDLeVp9N+uud4VRHCgDUIpo0KPHmXB5u8G79D8DufRSdUBRDQivV3iwdLNgbiu4lNZam/ZrpCykTq+lqs1pdYOSxyjTxkTF6zSZn1l8sxdGyjFHUnU2+J9GN8FEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTVuRHdOS1o3R0o1M3B2UE5EWXJNak1EamhRcVFsM0duNzZPZUlzVlBtQUo0?=
 =?utf-8?B?RkdSSFI0aWRvWXNCTDhySXExcWg0ZE9tampSVFFycERHMXVqdUhiRlI3Mmlt?=
 =?utf-8?B?bXRVZ1FpUG1aU2R4bDAzMSs3K1BxVy9jT0NhK0JBNXpCb09WWHJXRGdhZWRK?=
 =?utf-8?B?Z2FVdzRwNGFmTGtuQlRKdjJ0K3E5aVpDTzZLWWZEcTBGRWtzYTZrRFpFVU1K?=
 =?utf-8?B?VDZIZERHTHJsbXBtd0llMHlMM0o3ek02NmdCaEJ1V2JUdlAwVXdVTUttVlFF?=
 =?utf-8?B?SEVnWU9PZjNDZjNGU2tnOVh6OGNmcGtVaDVhcGY2K1gyUnJUeDczYTd0bDZN?=
 =?utf-8?B?aWRpYTZDOHBJbk13SEd3RnRIM3RpcEJNbkIyTDFnczUycWppUTVLTVhyaGIr?=
 =?utf-8?B?Njh1Q2tUdnorTXJBbXR4RXl6bWJrUlA2TzhFeGcvbXhkMXdudDBwYldrV2JJ?=
 =?utf-8?B?c0NLVE1hSVBwb0laRkRSYXJtdDhydEIvL2dsR0RBbDZ6dUd5UmhQZVVXUlFw?=
 =?utf-8?B?T1BPTlFSRFRvZDh2cFUrVmZPMDZjMU9QRFZWcVJ6djZUaDlxK3J5Z05KalJC?=
 =?utf-8?B?OW9YbTlKSDVyRmFUTXhuRDdLMUlvTXRibFlBWDZCK25KQ1ZXaENhNHpPM3VT?=
 =?utf-8?B?b0VzZFdML21SRjlYMkxWU0xUSkhIdTkvRDZMY1RxMFZJQUFnbkRuWm53WmJQ?=
 =?utf-8?B?WUhOSmVEekZ4YzlmWk1pTzdGeE9nRjk1NzVoNmcrbXMwWlk2d3FtUGNnbStD?=
 =?utf-8?B?ck4yUW5hUXBuRHp0QlVHNVQ4Q0lNMktVczZvUDlGVGY3bTFsMG9sbVNrUmNn?=
 =?utf-8?B?Z2xoOTRSNHBncVlhcWhXSHJjTUlTSVJLMkpLb1M4Q2hKUGg3VzA3cHlYYUt1?=
 =?utf-8?B?RFo1by9wamh2YWc5R3ZjL3RSRlY1T1NNdTFuQngzOHdqb3d4ZlZtWXpIaFVK?=
 =?utf-8?B?V2orMnJOOWJTRnVDMHNaQ0ErU21ubGlNenVOR3d6ejA2WUwzMUhUWTkyZ2Uz?=
 =?utf-8?B?bmUvTXhud0MvbGpnVVN0enlOQW1YTmliL3VYZXpMc2s5bnMxNDlZdkJKWnJ1?=
 =?utf-8?B?NHNLS05hWHVlTzVZZkFUelEwM2RjSnFoTm9mWVhmYUJ2UVBvcElpbXRjZDZ5?=
 =?utf-8?B?ZlZKaWhKdm1BZDRuS09lWDhXWFl4ZUtuUHlqc1F3bjhtdEhkS2FQc05teHUx?=
 =?utf-8?B?bjdIajVraFRHUDQzZDVucG4rREExMjZUODR0Ly9xOFpUR0M5T0hPNEloL0RU?=
 =?utf-8?B?Z3BqeDlLZy9WdXpaS3B1ZmptUmNacVVXUE9WMWw0V3c2WjNRZENRa1JVRWov?=
 =?utf-8?B?bThMWG1YQUhPR3pFSjNtWFBrT3prRmpSZ1lhWFpKZC9sU0VNdHg5aHBxTWwz?=
 =?utf-8?B?bVhGVGZtRjVjRHRMd1ZmZXp1eXZ5bzliK1h0NldySnNweUhscnYrSGZtdE5I?=
 =?utf-8?B?R0swdWRMY0ZhNUtISHMzb2ViRVpCSVVoMnRyemhjVVZnTW9yRnIyNGMwOTli?=
 =?utf-8?B?c1h0T3FCbWdYdktSUFlTMmVFOC9pRjIwc1o1OVRTUUJybDJzYXZHK2dwK0U0?=
 =?utf-8?B?c3MvQm1KbjJwbTlOQUNiZlUwTVdvbjlpczFBMmhSZFpsQi9yanhoV2FnN0dr?=
 =?utf-8?B?TGlOT0RIWmVKazBFcTFGWEtMalRDZjhRY0EyeWJYSjBBbWNpeEF1MFdHZGNN?=
 =?utf-8?B?ZTF2VU03bU5GcUNEcjNCbEM3Yk5kRU5rTFAzcWc3OTdnaXhmNjEwaTNBWkl4?=
 =?utf-8?B?VlZOYU9peEdEbHl6Y05wWkRQSm8rOGpRWGoyU3BRSmV3ZTEyd2dKdVBUdUFl?=
 =?utf-8?B?NTBsdDdCUVNMd1hRNDJjUzNjVmpPY3dmYUdhYTFDR28yT1ZKSEFvMTdJMS8w?=
 =?utf-8?B?eUh3RE9naG41NzM2Q2JTeXplcnl0dzcyamtKUWplU1NCMEl1cVBRMFdyZldi?=
 =?utf-8?B?VVJlRzJBMTZZRjNuRmo3T0FTcTlyM2VqcnJsbGk1NFJmeTVvNkdVRERTSlU2?=
 =?utf-8?B?T1pnWlZyNTYwK1lKUEw2bmQ1Vm1nQjh3bFZUaEwzZE5kWnpuTktxNUxMNVVZ?=
 =?utf-8?B?dG81R0t6bjM1RFZoWFJQcHJlU3R0QmM1VTh0MjBrMWVRN0JkdUhyc0ptMDhl?=
 =?utf-8?B?eUd4ZlY5N0tzeSt1czFva3Vsb3ZuZmNYcGdPM1lHeVB5ZEFlZEJMd2hkOXBn?=
 =?utf-8?B?eFJBUE9hUmhJa1BlWG1MYjZuWnZvSUo1QUFNcFJtY2J6LzE2RGR2SXgwMFYv?=
 =?utf-8?B?Y1dGREZxc2Y3ZVhwUDZrbitFQW9oRTV3aVlMSXF4TGp2aU5Rb1NLNzVzYkpU?=
 =?utf-8?Q?tYhpmNTrBFGaOQKxWw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1812d330-3d01-4c3a-3fdc-08df2dba50ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:23:55.8684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeWpMMs+HfbLcz9b7K59eW86Cx7CGY9dQSHBkqfVRy+lhK6Yl4o/SVciJT/3QMsy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB482642
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

On 10/16/26 17:32, William Palacek wrote:
> When a GPU reset takes the reset domain, KFD eviction cannot unmap
> user queues: execute_queues_cpsch() fails its trylock with -EIO, so
> the queues keep running until the ASIC is reset.

Absolutely clear NAK to that approach here as well, that is just horrible racy.

The root cause is clearly that trylock, this is completely misplaced.

Using trylock is only allowed when the reset executes the operation anyway, e.g. in case of a TLB invalidation.

Regards,
Christian.

> The TLB flush is also
> skipped while the reset is in progress. If the process unmaps and frees
> a BO in that window, its pages are released while a queue can still
> access them through stale translations.
> 
> On MI300X, munmap() then crashes in free_swap_cache() on a small bogus
> page pointer in its mmu_gather batch page:
> 
>   BUG: unable to handle page fault for address: 0000000000002900
>   RIP: 0010:free_swap_cache+0x5/0xb0
>   Call Trace:
>    free_pages_and_swap_cache+0x3a/0x60
>    tlb_batch_pages_flush+0x43/0x80
>    tlb_flush_mmu+0x3d/0x110
>    zap_pte_range+0x80d/0xcd0
>    ...
>    do_vmi_align_munmap+0x3e8/0x5b0
>    do_vmi_munmap+0xdf/0x190
>    __vm_munmap+0xad/0x180
>    __x64_sys_munmap+0x1b/0x30
> 
> In a traced crash the bogus pointer was the read pointer value of an SDMA
> queue the process had just destroyed, at the read pointer's page offset:
> the queue's writeback landed in its freed rptr page after the page was
> reused as the batch page.
> 
> commit f0b4440cdc18 ("drm/amdkfd: Fix mode1 reset crash issue") fixed
> this race on process exit by waiting for the reset to complete before
> freeing the process's BOs. Free through the ioctl has the same race.
> Wait for the reset there too, using the same helper.
> 
> Fixes: 9c33e5fd4fb6 ("drm/amdgpu: fix locking scope when flushing tlb")
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
> Christian, Felix suggested asking you about a lower-level fix. In the
> traces, the TLB flushes during the reset returned right away without
> flushing, because amdgpu_gmc_flush_gpu_tlb_pasid_xccs() returns 0 when
> it can't take the reset domain lock. So callers free memory the queue
> can still access until the ASIC reset. The SVM munmap path goes through
> the same flush. Felix thought a more general solution may be in
> amdgpu_object.c or amdgpu_ttm.c. amdgpu_bo_release_notify() already adds
> the wipe-on-release fence so TTM delays freeing the BO. Could a fence
> that signals when the reset completes hold the pages the same way, or is
> there a better place?
> 
> v5: new approach, replaces "drm/amdkfd: discard interrupts during a GPU
>     reset" (v4) and "drm/amdgpu: preempt KFD queues before taking the
>     reset domain lock" (v1-v3)
>     - v4 did not address the munmap Oops (Felix). Fix the cause instead:
>       BOs freed during a reset while user queues still access them
>     - Reuse kfd_process_wait_gpu_reset_complete() from commit
>       f0b4440cdc18 in the free-memory ioctl; no queue unmap, nothing sent
>       to the GPU during the reset (Christian)
>     - Drop the interrupt discard from v4
> 
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b3ebbee76088..0953d823c345 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1305,6 +1305,9 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>  		goto err_unlock;
>  	}
>  
> +	/* Queues a reset could not stop may still access the buffer */
> +	kfd_process_wait_gpu_reset_complete(p);
> +
>  	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev,
>  				(struct kgd_mem *)mem, pdd->drm_priv, &size);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 7a365fca68e4..25f57dd59bfd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1126,6 +1126,7 @@ void kfd_unref_process(struct kfd_process *p);
>  int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
>  int kfd_process_restore_queues(struct kfd_process *p);
>  void kfd_suspend_all_processes(void);
> +void kfd_process_wait_gpu_reset_complete(struct kfd_process *p);
>  int kfd_resume_all_processes(void);
>  
>  struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index e742ef206abd..7750741444ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1291,7 +1291,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>  /*
>   * If any GPU is ongoing reset, wait for reset complete.
>   */
> -static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
> +void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
>  {
>  	int i;
>  

