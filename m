Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CF606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TCV0okuu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5704310EBD0;
	Tue, 20 Oct 2026 14:20:26 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6D610EBD0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 14:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+t7wYpgPKywo3W8rtVV8PlK1NRshLdJREBKwfyOxx0bgBc+5UyINjRMszSpJ+TEeMwDzhZGfDRinLmreLGJC5LUyirdabcgK1I8o3hHqwLTa0qp7LIU7U2cDEv/zhjtanmhWnFnxm2Ozwquw3EOf6XcHsJ5iwN56/eVnZyG5PyYt/Vf2cYAR5nn+5Py+0h2B/TPz/jq0nq1sY+E4SFkdaFHkALZAS3InmKI0vz0CoQCv1F6iBQR97s9/oxILzanbPqQ8D7i+vcHlwKNXR21SPkV16AN6ivXsvjzc3WMaCo96J9/aufcaudPBuJ3PtETztaZdSN+iXHDkVHv1bXL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4+8Y+qu+a0ML9QItN3As6FKCxuXMplhzRMnnqB4qs8=;
 b=cYPO1jqT6/XVV1ZVi/tP6OoALPp8qe8WOg2BdHR+4IWAVbtiu7QwemILgKYQpLsaOBGGGlcZSmVUqwGqckk8RlI89myltZKJaATwb4NARFO22zJOOzJxJGAuDbZofo7/DiS/G67Ec6xpNohOYQu9hqoLFeFmIbJaIjttlpwA8fjzJW9XIhcx6HudWTIsG/M9CmAjDb6um076ssRcy0g71upqcsnedIC/WJgWNvmoZ7SQ3yu+4DAzGxTsKbXgdxIip2nBUg0qgBkTfY1DfKaFF6JVNrZmwabzM75s8+HRoJk8L0dSyQ/a4FJo9fzKb2eN+Hyfw2TUhBSdf3zN5hcY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4+8Y+qu+a0ML9QItN3As6FKCxuXMplhzRMnnqB4qs8=;
 b=TCV0okuubcNkB8L1ljIGJTX/wM8rwFpFSkLAGgJmD7OCa3IrRstezS+qZxk1QfsPSDsaOS/c8G5FBl0Ct9OMhq2v39v/drTdCqtTEqf+J1m0Yy1orn8t/hCIfOAUir4RGcL39OSq4rHEebwy4OLgLFb/UWigseCUSktCnSOIwxo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:20:11 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:20:11 +0000
Content-Type: multipart/alternative;
 boundary="------------Gqioo7RoAoydvgSDCvWSkrZ7"
Message-ID: <edbb95b8-e3c9-42f9-afb0-2525438d8789@amd.com>
Date: Tue, 20 Oct 2026 10:20:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdkfd: wait for a GPU reset before freeing a BO
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Kent.Russell@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20261016153236.1163913-1-William.Palacek@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261016153236.1163913-1-William.Palacek@amd.com>
X-ClientProxiedBy: YT4PR01CA0434.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::6) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfbc32b-4d79-4bd4-d0fd-08df2eb54040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|10067099003|18002099003|22082099003|8096899003|11063799006|5023799004|260925021311599003|260925021911599003|260925022911599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1V8f1JnDkjo5dLeIjLu2VxYLpgNQISnY0Skuda4ZoteakSztJAa0HFNWlRB7zZQwhK3KDoQ/mSObMxOqMqWrsOPZqwscNAOm4iNjBSjqDIBBUzon7ZsuXE3JX1tqw8jJZEvflQ2eVyOha0AcVp8NKh/JHtP/+PZfmr1jEF2A2GeUdsnuC/YgCjolKPozhW74GpESVPCpZgmGxUrISmTNPxmIoMFe19tNppsNsuT6btXZn6leGiU5DVnA8OW7B2eOkwRmK8HZSEqeH8rCVEP7G1N7mOy+eSoaGwCsRkDfOZ8PwpZC0BVuCksx0+TWb60tL0ZcNMuc6p1ByI4rfyOvsFcPT4ejQPo3JCbs+JPpPntRkCEjB1bOYItexkdGVAgpvzmxkZqU0FsRpeARt1T5AcWRK4BgAuX13aO/oyBgcMaJP4k0pA02IjDxd0R+mehxwsar1yNRhx2RmvjBei98byUSyYFiBqGFMnjfNufBpq71DtlP0tpzjy8EYVrxkr957TbTbEEtxlK9pBjQ4LM9dpd+29NZM36GrhK6xiQy22eF7cQW5sF7DG6dLM/RO4mXx0DV2G/6lo20aL5oD6uWM0Uihbfnkt2CR1/ygzXdu0Ha8Raa9rJegA+TorAwBvnzACsnH1nn8oXhxuoWuzrp7HnH8UeDOc55bysVFxxdEzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(8096899003)(11063799006)(5023799004)(260925021311599003)(260925021911599003)(260925022911599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjBkcEpnZTdTKzNHL0VJWS9TQ3p6Sy9rdnUxZCt5OSswRGRLSHNRS2lUQUNM?=
 =?utf-8?B?OEQxeTlTbGhoMjNSQVNxbmVDM1NyRnl5UE9ZU1dLa1B5bC9WSHV0NzFyS0RF?=
 =?utf-8?B?THdqTVdWSnpET1hYbUswcVJnTWFRS2IwOHZRTmZWK2lZU053S3FnRWlOU3Ex?=
 =?utf-8?B?dlZBam56WkNib01uUzQ1cW1TVEJvcWdjTzBXeGJaUTNhY0VKdFN4WmJ4QVhC?=
 =?utf-8?B?aGNVL0N0bExUdFdoZjZMYWlxc29PenYyTFp4SUFmcXh1eXI3QUZCOGxxYk5T?=
 =?utf-8?B?MEJyOCtrRFpJTXM0MGd3M0podE5UaWZBQnovSTI4T0RYTW1lMzJBRXBLOVZy?=
 =?utf-8?B?TWJ5bzMyMVVqVnpXNkdUeEFDcWFnMmpuajZSMFFtRzVYZEN0bHh0bGc0Mno3?=
 =?utf-8?B?YnB0VG02MHdhdnYvWndFY2dSeGZVNmNxWXh5eVNVV2s3WDhsYTZQZXhzTyty?=
 =?utf-8?B?Q08rWjdjVWtTRTJtT1J0eC9mWVNqb0ZjMEk3bUt1NzB0bnNXVlNjRGlYU1F3?=
 =?utf-8?B?a1hFajIrQnk2bEIxNjJQaGtQWVpUdWxxQXFZNm9MQzAveEZGTWNidE0zdzdI?=
 =?utf-8?B?cUhYUk1jOWRFWmttOVh4Y21iaFVkSE81RUJCZkxFV3dPM25rNFczVE1DZUlT?=
 =?utf-8?B?dGFRZ0ZHd1lFM2NtYStkcEpHYXFyN3IzN0o3TUNOZXZ5VkxFVGJxUXlyRThF?=
 =?utf-8?B?Z0pISlV6ZWxrcWJHNXpSTmdNZ21jd0lzaWZ5TXBLT0xaZkxRN0hyYTZIWUt4?=
 =?utf-8?B?Y2ZsMkZscVkwcmxIOVV4UWdZNnBMajVqbkVodlVvTjZpSVRLWXNlNHlWajJk?=
 =?utf-8?B?YVNFamk1TmZiYW5tVGxXdWw5enMvNnBvOFRNc0lKQmc0bmo1eElJc3hyL0ho?=
 =?utf-8?B?eEd6eHVRbnAxeFFZaFlPNVRjdFVOODdQWmRIY3A2QWZMTm4rS2l3cW9NZ3Ix?=
 =?utf-8?B?Y2cxelZ1TnJ0cm52b3hLMlhhbmpyeFl2QUtZWTBzTnVwQlBqQ0dsTUxJM0Yw?=
 =?utf-8?B?WFR4WUNBejZjRGNSUnFudTU4RHREaXhqNW0zZjQzZkdIMXpMc0lselVtaE90?=
 =?utf-8?B?eTRveXUvSEExZUpkTGMyeEFFWE94L2ZPMDJOSFo0REFHNEs2V1lMSU1EeG5D?=
 =?utf-8?B?UGRkOXcxc2lUNHA2dUw4MHR1azBRZ1dYN3NublcybWxuejNIS1hPNGhaeFc2?=
 =?utf-8?B?NEdzNWlvOGNSNnVrTWdNWlB0T3kwUHA5bnJSYW1WQVdVRUdIY0VkazYxeDR3?=
 =?utf-8?B?ZUNFeno1TjBJRUdLTEJuem5VTHpvVEIvc2JLMVJFVUVLcjdzZkZIK1FERzla?=
 =?utf-8?B?VVhacFpGa1NTeUdmNGJITVREc2liNlpneUtTK012S1piQnZYS0JiOWx6eUlR?=
 =?utf-8?B?RGRlM2lPeGZDa0J3QjRQczdQVDlTYWEyb3I2SGJxbzVlN2l1Nzdqc3ZEWE1q?=
 =?utf-8?B?SjZISlNXTzhnN1V4MGhBQlJlWjZ1UlFzTHFWYVpSaXBDaHRKd2Fua1JsRmsw?=
 =?utf-8?B?WHRxaWtsSmt5MXBTMXVpbksvRG45SmY4dWNqelV2ZTgra2ZYbE9sWW5nTWc5?=
 =?utf-8?B?aEQ4RUZGeUs2SDdvY096dm5TNzZXTFVuSTVyakgvaWwvckMranJuVEI1bW9P?=
 =?utf-8?B?dEJSUUp0dzZwM3dtRUxsYlloaWJNb0Q2SGx3OU9GRmZGY1N3UHQwcVMveEpH?=
 =?utf-8?B?eEhxNTN6b0VJMkwwR1YxcC93Zktpb0FTNDN4SzR0aWNacXFOdEw5WUlKbWRS?=
 =?utf-8?B?QXU2UFZIMjJHY1pvSFpBVjlKczdlMmtMMnJnYTBCSnN0TzArTWJNRklHWk1Q?=
 =?utf-8?B?M0VhalBEbmFMR2ZobDlRY2Zpd2hrSDJwRHNhOHdUcWw5OVAyV3BpcVFhdFFl?=
 =?utf-8?B?aWsycUJpT014VU9COTNEVURGTGt0ME1neGJodFU3YnB6S2xpTlR3dFE2Z0c2?=
 =?utf-8?B?UDh1SVRGajg3N3pPN1c3bXR1T2trUmhLalR3dFQyS1lObHVkdTlwZkFKdHRt?=
 =?utf-8?B?eVZYVHJma3JiUEFjWTZsTUdqN3k4ODB2SXZPYzkyUU5DWjJYdjFUM2phU3Zq?=
 =?utf-8?B?ZUhEZVpUUC9nQ1B5Y2ZTb1R5MTBuTVJCS2NCMDdlOEdaanNIK0txMGZiZldE?=
 =?utf-8?B?NUVRRHMvcElxcjlKWWdQbHBZTzNlMFIzT3QwTVFaYTUxT1RMTFM0elljYWV0?=
 =?utf-8?B?SUIyWHpraVB2bW5CalJZVjEwcHVUVDkyb1VSVmJwMzlFRk1QUzQ3eVRQOC8y?=
 =?utf-8?B?SkR3b2gvSGdIWEdsR21LWkE0cG5GSjlXYWJiQ1UzR0x3VGpvR3ZtSjZPZE9G?=
 =?utf-8?Q?Vp+pCJF8xiAUF6dhCd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfbc32b-4d79-4bd4-d0fd-08df2eb54040
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:20:11.3770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BM2oGV5UxeKj7h8VvGcS4WyE2uvs0kaE5OXREMS9pcRIKE7DtpWajD26ZWxxqwwF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Gqioo7RoAoydvgSDCvWSkrZ7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-10-16 11:32, William Palacek wrote:
> When a GPU reset takes the reset domain, KFD eviction cannot unmap
> user queues: execute_queues_cpsch() fails its trylock with -EIO, so
> the queues keep running until the ASIC is reset. The TLB flush is also
> skipped while the reset is in progress. If the process unmaps and frees
> a BO in that window, its pages are released while a queue can still
> access them through stale translations.
>
> On MI300X, munmap() then crashes in free_swap_cache() on a small bogus
> page pointer in its mmu_gather batch page:
>
>    BUG: unable to handle page fault for address: 0000000000002900
>    RIP: 0010:free_swap_cache+0x5/0xb0
>    Call Trace:
>     free_pages_and_swap_cache+0x3a/0x60
>     tlb_batch_pages_flush+0x43/0x80
>     tlb_flush_mmu+0x3d/0x110
>     zap_pte_range+0x80d/0xcd0
>     ...
>     do_vmi_align_munmap+0x3e8/0x5b0
>     do_vmi_munmap+0xdf/0x190
>     __vm_munmap+0xad/0x180
>     __x64_sys_munmap+0x1b/0x30
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
On GPU reset, kgd2kfd_pre_reset() sends a reset event to all processes 
and ROCr then aborts the process. This is unfortunately racy: the 
process can still be calling ioctls into KFD while the GPU reset is in 
progress. The expectation is that the process stops issuing ioctls and 
exits, after which kfd_process_wq_release() cleans up the remaining 
system/VRAM memory, queues and so on.

Waiting for the GPU reset to complete inside the ioctl is not an option. 
Once the thread blocks in the kernel on something like 
flush_workqueue(), the wait is uninterruptible, so the pending 
abort/exit cannot be delivered and the thread sits in D state until the 
reset finishes. That defeats the whole point of aborting the process.

kgd2kfd_suspend_process() in the pre-reset path also sets the kfd_locked 
flag, which is used to prevent a new KFD process from opening the KFD 
node while a GPU reset is in progress.

So I think we could check kfd_locked and return -EBUSY from the KFD 
ioctls. The application retries, eventually gets aborted, and the KFD 
cleanup worker frees the resources once the GPU reset has completed.

Regards,
Philip
>
> Fixes: 9c33e5fd4fb6 ("drm/amdgpu: fix locking scope when flushing tlb")
> Signed-off-by: William Palacek<William.Palacek@amd.com>
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
>      reset" (v4) and "drm/amdgpu: preempt KFD queues before taking the
>      reset domain lock" (v1-v3)
>      - v4 did not address the munmap Oops (Felix). Fix the cause instead:
>        BOs freed during a reset while user queues still access them
>      - Reuse kfd_process_wait_gpu_reset_complete() from commit
>        f0b4440cdc18 in the free-memory ioctl; no queue unmap, nothing sent
>        to the GPU during the reset (Christian)
>      - Drop the interrupt discard from v4
>
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
>   3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b3ebbee76088..0953d823c345 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1305,6 +1305,9 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>   		goto err_unlock;
>   	}
>   
> +	/* Queues a reset could not stop may still access the buffer */
> +	kfd_process_wait_gpu_reset_complete(p);
> +
>   	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev,
>   				(struct kgd_mem *)mem, pdd->drm_priv, &size);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 7a365fca68e4..25f57dd59bfd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1126,6 +1126,7 @@ void kfd_unref_process(struct kfd_process *p);
>   int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
>   int kfd_process_restore_queues(struct kfd_process *p);
>   void kfd_suspend_all_processes(void);
> +void kfd_process_wait_gpu_reset_complete(struct kfd_process *p);
>   int kfd_resume_all_processes(void);
>   
>   struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index e742ef206abd..7750741444ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1291,7 +1291,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   /*
>    * If any GPU is ongoing reset, wait for reset complete.
>    */
> -static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
> +void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
>   {
>   	int i;
>   

--------------Gqioo7RoAoydvgSDCvWSkrZ7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-16 11:32, William Palacek
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261016153236.1163913-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">When a GPU reset takes the reset domain, KFD eviction cannot unmap
user queues: execute_queues_cpsch() fails its trylock with -EIO, so
the queues keep running until the ASIC is reset. The TLB flush is also
skipped while the reset is in progress. If the process unmaps and frees
a BO in that window, its pages are released while a queue can still
access them through stale translations.

On MI300X, munmap() then crashes in free_swap_cache() on a small bogus
page pointer in its mmu_gather batch page:

  BUG: unable to handle page fault for address: 0000000000002900
  RIP: 0010:free_swap_cache+0x5/0xb0
  Call Trace:
   free_pages_and_swap_cache+0x3a/0x60
   tlb_batch_pages_flush+0x43/0x80
   tlb_flush_mmu+0x3d/0x110
   zap_pte_range+0x80d/0xcd0
   ...
   do_vmi_align_munmap+0x3e8/0x5b0
   do_vmi_munmap+0xdf/0x190
   __vm_munmap+0xad/0x180
   __x64_sys_munmap+0x1b/0x30

In a traced crash the bogus pointer was the read pointer value of an SDMA
queue the process had just destroyed, at the read pointer's page offset:
the queue's writeback landed in its freed rptr page after the page was
reused as the batch page.

commit f0b4440cdc18 (&quot;drm/amdkfd: Fix mode1 reset crash issue&quot;) fixed
this race on process exit by waiting for the reset to complete before
freeing the process's BOs. Free through the ioctl has the same race.
Wait for the reset there too, using the same helper.</pre>
    </blockquote>
    On GPU reset, kgd2kfd_pre_reset() sends a reset event to all
    processes and ROCr then aborts the process. This is unfortunately
    racy: the process can still be calling ioctls into KFD while the GPU
    reset is in progress. The expectation is that the process stops
    issuing ioctls and exits, after which kfd_process_wq_release()
    cleans up the remaining system/VRAM memory, queues and so on.<br>
    <br>
    Waiting for the GPU reset to complete inside the ioctl is not an
    option. Once the thread blocks in the kernel on something like
    flush_workqueue(), the wait is uninterruptible, so the pending
    abort/exit cannot be delivered and the thread sits in D state until
    the reset finishes. That defeats the whole point of aborting the
    process.<br>
    <br>
    kgd2kfd_suspend_process() in the pre-reset path also sets the
    kfd_locked flag, which is used to prevent a new KFD process from
    opening the KFD node while a GPU reset is in progress.<br>
    <br>
    So I think we could check kfd_locked and return -EBUSY from the KFD
    ioctls. The application retries, eventually gets aborted, and the
    KFD cleanup worker frees the resources once the GPU reset has
    completed.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20261016153236.1163913-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">

Fixes: 9c33e5fd4fb6 (&quot;drm/amdgpu: fix locking scope when flushing tlb&quot;)
Signed-off-by: William Palacek <a class="moz-txt-link-rfc2396E" href="mailto:William.Palacek@amd.com">&lt;William.Palacek@amd.com&gt;</a>
---
Christian, Felix suggested asking you about a lower-level fix. In the
traces, the TLB flushes during the reset returned right away without
flushing, because amdgpu_gmc_flush_gpu_tlb_pasid_xccs() returns 0 when
it can't take the reset domain lock. So callers free memory the queue
can still access until the ASIC reset. The SVM munmap path goes through
the same flush. Felix thought a more general solution may be in
amdgpu_object.c or amdgpu_ttm.c. amdgpu_bo_release_notify() already adds
the wipe-on-release fence so TTM delays freeing the BO. Could a fence
that signals when the reset completes hold the pages the same way, or is
there a better place?

v5: new approach, replaces &quot;drm/amdkfd: discard interrupts during a GPU
    reset&quot; (v4) and &quot;drm/amdgpu: preempt KFD queues before taking the
    reset domain lock&quot; (v1-v3)
    - v4 did not address the munmap Oops (Felix). Fix the cause instead:
      BOs freed during a reset while user queues still access them
    - Reuse kfd_process_wait_gpu_reset_complete() from commit
      f0b4440cdc18 in the free-memory ioctl; no queue unmap, nothing sent
      to the GPU during the reset (Christian)
    - Drop the interrupt discard from v4

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b3ebbee76088..0953d823c345 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1305,6 +1305,9 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		goto err_unlock;
 	}
 
+	/* Queues a reset could not stop may still access the buffer */
+	kfd_process_wait_gpu_reset_complete(p);
+
 	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd-&gt;dev-&gt;adev,
 				(struct kgd_mem *)mem, pdd-&gt;drm_priv, &amp;size);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7a365fca68e4..25f57dd59bfd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1126,6 +1126,7 @@ void kfd_unref_process(struct kfd_process *p);
 int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
 int kfd_process_restore_queues(struct kfd_process *p);
 void kfd_suspend_all_processes(void);
+void kfd_process_wait_gpu_reset_complete(struct kfd_process *p);
 int kfd_resume_all_processes(void);
 
 struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e742ef206abd..7750741444ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1291,7 +1291,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 /*
  * If any GPU is ongoing reset, wait for reset complete.
  */
-static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
+void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
 {
 	int i;
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------Gqioo7RoAoydvgSDCvWSkrZ7--
