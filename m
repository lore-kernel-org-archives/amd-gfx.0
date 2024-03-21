Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBB9C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 14:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6013010EAE9;
	Thu, 21 Mar 2024 14:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5IPcYsZU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2265F10EAFA
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 14:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnCIlJDFl5adeju1A9b34EQOfFdZB9bCisVdEDvA08R8WTkUw2+CKsvJn6y2H2jm5mADyd1gbhJNaENCPPjXfno+kOlRzPf8DU57yDxVAdUBuViGmiUfgkZ1XTfhh7NCrtzOFufYJAjYAvi0Haug93mdyG2rQW8Olp7c+xPCGabLLN8wFj3F3JcfwXUPdP8NjjVvAk3RKRaTz3VKx7IXib/GKp0u0WV2rp6HZL8oxjYhQETXztwYz1VYbZ4Y9RfMpHJxqf9uwTskOrlISw2JZqTRlsmsRbyDjDYKACYXJcV9/gNxhG1VGEkHzY7ydqesBROq939sCDVvatfv2x8MlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MTxhm79tMLYZJboi0hnYwruc32oRYKzschjNlFV5Mc=;
 b=E9lyFUkmqeDDER5/fIZD/OEIQ/yzYVEaMxI3Xdena9CJ330KSztC1BwNKqmyJ5tw4opU5VFn7MN7BoKPnxs4FDR8p0BKprVPb97GOP1edXxLs60vsZcoDU30DHK77Kdu+xDJfeWYpyXtmRJxa9dozD0XgG5/oHQ7KpI1NANWk2nOF6L76qjHeqI7G7D5iKoyiN+HDucszVqmRx8JXPoAT6uRk2aPB4rTY5jeLsqN+fQ3iQTmf2hTPEGPSL+Z8TMLu8D1TrvplpIev0B2z2vfDi/kYgvQYUYDhAxYNyjfckK5dFvzaHtsKjFmXGfqTHp1dRd/4q77sDgenYkPVOWzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MTxhm79tMLYZJboi0hnYwruc32oRYKzschjNlFV5Mc=;
 b=5IPcYsZUHP37HkE5Z6MSJLPjeJxXZh5f93Y/5EnVJb2Rrtr9Vid3iqYCqu9Fgr3NCuWzbdj6H6YGiItl1k2j4llVQQnjdUeSfzpYGoZw1Qv6nvPJj04ohQCdbo3Lk7L1rhs41x/XjvS4wNeKKHk+w0mxVtR96CQLB7XO9/Rlbb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Thu, 21 Mar
 2024 14:18:36 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 14:18:36 +0000
Content-Type: multipart/alternative;
 boundary="------------THLZ82b1g8OPx62DpTDloz6n"
Message-ID: <d2139a86-8e3d-3afe-6635-587001d99b2f@amd.com>
Date: Thu, 21 Mar 2024 15:18:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <7caeb5ca-4164-4d4d-bfd9-147abcbf105d@amd.com>
 <20240318144412.2051-1-shashank.sharma@amd.com>
 <cc76d0a2-90e3-420e-9521-f64a75863c25@amd.com>
 <9c9e9efe-56bb-d7dd-3b73-7d3150a7c215@amd.com>
 <c85e5897-66cf-46b8-aa8f-c208c4a6c68a@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <c85e5897-66cf-46b8-aa8f-c208c4a6c68a@amd.com>
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6af62c-ec45-4180-523d-08dc49b1cc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3yGkN4CAi/PGymrMwcPI6KSrP1VP0GdxUPzYvenvs4tNrJNfxS0XPo0PQqMGp+dUq77L53Uz9xSt8fNaiz3ToXOJ0kMmTVf0iMS0Xd8LIig6om34Fm6yPgaSi4MdmsyUBJr3gdGcs73GeVJpxiCAHxPeeont3kjfRvexQ3JXB0zUjf/6cif4xUPGB7l6D2to1c6FQFPUWnpKCMREQVxZ9tO8ha3+B7eqCHjL0lgmQXvw+MYiQH3hhbRNXl3P1qxuu3snwym2lmRYJ8W1BX/on/CaeBNitgUR1BUuQCEZmWFDsQLThZEMX6++gQ3wovXUtXjU6NKXaOEiTkoIUEhn52EOds/+o3R+bfvyTFBJuvpFWNoRX4sMmzH3AVEKGAUmO/VfcjdQ9hOgX94338qhoj9UYQgAEGcAxBNwylC7WCfjIv4dbmzk97nQ5RDG9Z0cVYWZjhfT2tTCv7OZjWtM5NixT6l8xgtJjTq64hiUezBtyy9iZosEmdN4yTd91Pj/NXBNHjcUVVaBlZovf2nj5aqaR5/tXUgD215bKXaYrsR+ljTA5nmih4BkWO98v/Gtm8wrdvr6Zp5CIVnbkJjjzNLh0xhICdMhQMoSonKZR16nOJFep2+MxRrARoEIqmLvqmyydh/pxH0LEkElhfVP0NyuH3qz24WBrMCh7c2tsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUR1ZGczcy84QjdFT2ltVnBxdlR4ditwcms0a2RiSDBCQ3pacG93M2xMT2Vu?=
 =?utf-8?B?dEZ4OTFwcHB3VlJaZFlOc2MxTFdOdkdEcnAwU0N0dnJjQ3o5TmVDZ0FYejV4?=
 =?utf-8?B?WDRIY0JtV1huRExwMzhLMXlIRmYyQzdPNCthT2dNem8yMzF0SHI1TkQ5bjJs?=
 =?utf-8?B?T0JDa3VQdkpMTTNpOVBvTjRMTmhTRytaK3FZUUNYb0c5M2FWRVhxNTNPdENT?=
 =?utf-8?B?NDg5b2EySUJnN054SnBYaDNrTE9TQXRRU0kzY2pXNCtwak9jbEJTS2MzR3BW?=
 =?utf-8?B?ODR4aWFuS3cyUEZtd3p0UjBrS3lXT29kN2JEZXJkL1Q3MC9laEhYcjdEeEJm?=
 =?utf-8?B?bmhjTm5xRGtielAvVDBOY0JGR3pHY09QSjFNak00eEg1V1U3ZnF4Z2I1T05m?=
 =?utf-8?B?VTNLMVc5US9NL2R2aHhHKzRaSCtDeStnQ29rbjN6dCtYMHd4akFoZjJsbXR6?=
 =?utf-8?B?TXROVnZJTzFodkNNb3BmWHZ4blBHOUNxUkt2d0VxWnk0WmlWMXBxUFFZMkhx?=
 =?utf-8?B?U1k1SnRrb3poZlQ2VFpYY2puaDRpQktiWVZGUmt4MDgrcVB0cSs2MFF6TmdP?=
 =?utf-8?B?L2N3YVZTeG5wamVqei8xdmVyTXRXb2FCUHRDd2xwdGxVTkJTNVRBaytYNm5k?=
 =?utf-8?B?dW5ueENTR0h5UTJLY2kzK2liNDdkdUwvdG1YZlVJNzBFS0ROakxxd1F6anRp?=
 =?utf-8?B?SXFwQzRiK2FFUFZ4OTdNZE1nUFZtaHE2VDhVNUo1Y1cwYUd2ZnA5b2hMbEZP?=
 =?utf-8?B?Zk5rcG9yRjdTU1V5Z3FsWFdBTGhMemRNTllFZHdMNVo4WHdHSjNwbzE1d0kv?=
 =?utf-8?B?aGJwV0JLc2dKQmhmelRBZkRPR2NNQmwxQnY1R0F5QVNhLzhRZTdQL2xIVXdF?=
 =?utf-8?B?bTl0S09lb29PRXV3UlpBWDZrd2xaNm02ZlI2VVRBRDA1aStPZVA5Nm83bnFw?=
 =?utf-8?B?Mm9LRVZSS1p0YVNpTmRvckp5R01pc281UUMzUVBjcVY1UVU2TWtEOWw4UVp0?=
 =?utf-8?B?SHR5ZTN0bFJHKzVnSWhEUzg4OEUvTzUvdk52eFYrRlZjWnV1dnJ4dlFlRVpk?=
 =?utf-8?B?Z3pGVEpLVnRLQWt2VVdHS0t5VjFPdGVyMy9HVko1ZStGTHRMUlpkSGZaOVN0?=
 =?utf-8?B?ZGlkNU1rRG5NcW50ZVVvRmNmWlI1LzMwY2FhUlVaUW44aUFpamFyM2RKZmVr?=
 =?utf-8?B?cytnaWZyNmlFcjdSNlhNNzFETGk3THd0OVdKVS9ZMDNubkFMRjFVK2hjTzhn?=
 =?utf-8?B?MEQ5MTJDMnVvOVhpVVNjWXF0a2s2c0p5aTBKYkhFVFUxc0RXL1pHUlFxcEdD?=
 =?utf-8?B?ZVYwNzRYVXBVa3F2MDBaZFNUbDkwdDYzWXlZL2ZnVlV0Mk5QeGhvNUZSb2tO?=
 =?utf-8?B?UmFiOGUrUTZYMGxqZ0xMWXZ6MFNZem5GdmJzdDVITGNqTXo4SjM1czZHVkhF?=
 =?utf-8?B?YkRrN0dXbjdtWjJVcXJLcHoyazhtWGIzTG9FUEk2RldMeHFNczF3N3pCZmtu?=
 =?utf-8?B?dWNpNU1nckp1aW5XeWFFVDdZU3RHcjZVcDJxNUJlNW93a05ZTy9aQWJqM2N4?=
 =?utf-8?B?aE9oM2xURXdsTUk0dHdGdVk0VFMvcS9VOXlyMFpuZW8zOStjR3paVkFrYkdT?=
 =?utf-8?B?dHVRQ1BWQ21rQ1drN2dhcmZQdVV5ZWR2ZnRoTVpFTE5oSWQrR29IWGpETU9O?=
 =?utf-8?B?SWtvWDNKL2YrR1FKcWdOQ1gvZytKeVFtVlBrc1VTVWsyWHp1anhXek8wUkVw?=
 =?utf-8?B?Z0xRc09hU09odmxxMEZxWWFuclc1MlBwOTBwZVVXL1gxTFhRR1YxeFVBMHpM?=
 =?utf-8?B?RnFwUW5NcXVCT3hNc3RoQW1MZTA5RnNiWkFHNzQ4dFc3Y0lGNTdYQnV2Slo2?=
 =?utf-8?B?cFRJRG1JYVV0Y09PcjVFM0FaZnRHenNzR2VWWlR3aEoyOG9LZHhpL245VlhC?=
 =?utf-8?B?cEhiWURSSXQ5Uk9WNmxwQ1JKLzlLeEw4MXQ2ZnJsa0hqd0poeGdERHJ2UEpu?=
 =?utf-8?B?eFVVaGRBUEJSNG1VZ3ZYdGdNY2pvTzY1SGlwWXM3Q0trMVM0V2dsZG9VWTIw?=
 =?utf-8?B?NWpUL0Z3Y0Z3YVp0M0ZXVHlqTE1OVXFEVmNSb0hhckVhclZPTjlOb3lKclFn?=
 =?utf-8?Q?WJKe4mM0mVOKDu1800ZU+zQjQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6af62c-ec45-4180-523d-08dc49b1cc16
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 14:18:36.4867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vP9bM+C3ASy80ww9Rh2IFPBNWXTJCdmY2j3O8cg6bNKNg0BDoasb9bljWI4ZNDsPblXqmRQaBuG9YtC68WP7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
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

--------------THLZ82b1g8OPx62DpTDloz6n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18/03/2024 16:24, Christian König wrote:
> Am 18.03.24 um 16:22 schrieb Sharma, Shashank:
>>
>> On 18/03/2024 16:01, Christian König wrote:
>>> Am 18.03.24 um 15:44 schrieb Shashank Sharma:
>>>> The idea behind this patch is to delay the freeing of PT entry objects
>>>> until the TLB flush is done.
>>>>
>>>> This patch:
>>>> - Adds a tlb_flush_waitlist in amdgpu_vm_update_params which will 
>>>> keep the
>>>>    objects that need to be freed after tlb_flush.
>>>> - Adds PT entries in this list in amdgpu_vm_ptes_update after finding
>>>>    the PT entry.
>>>> - Changes functionality of amdgpu_vm_pt_free_dfs from (df_search + 
>>>> free)
>>>>    to simply freeing of the BOs, also renames it to
>>>>    amdgpu_vm_pt_free_list to reflect this same.
>>>> - Exports function amdgpu_vm_pt_free_list to be called directly.
>>>> - Calls amdgpu_vm_pt_free_list directly from amdgpu_vm_update_range.
>>>>
>>>> V2: rebase
>>>> V4: Addressed review comments from Christian
>>>>      - add only locked PTEs entries in TLB flush waitlist.
>>>>      - do not create a separate function for list flush.
>>>>      - do not create a new lock for TLB flush.
>>>>      - there is no need to wait on tlb_flush_fence exclusively.
>>>>
>>>> V5: Addressed review comments from Christian
>>>>      - change the amdgpu_vm_pt_free_dfs's functionality to simple 
>>>> freeing
>>>>        of the objects and rename it.
>>>>      - add all the PTE objects in params->tlb_flush_waitlist
>>>>      - let amdgpu_vm_pt_free_root handle the freeing of BOs 
>>>> independently
>>>>      - call amdgpu_vm_pt_free_list directly
>>>>
>>>> V6: Rebase
>>>> V7: Rebase
>>>> V8: Added a NULL check to fix this backtrace issue:
>>>> [  415.351447] BUG: kernel NULL pointer dereference, address: 
>>>> 0000000000000008
>>>> [  415.359245] #PF: supervisor write access in kernel mode
>>>> [  415.365081] #PF: error_code(0x0002) - not-present page
>>>> [  415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0
>>>> [  415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI
>>>> [  415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e Tainted: 
>>>> G           OE 5.18.2-mi300-build-140423-ubuntu-22.04+ #24
>>>> [  415.394437] Hardware name: AMD Corporation Sh51p/Sh51p, BIOS 
>>>> RMO1001AS 02/21/2024
>>>> [  415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10 [amdgpu]
>>>> [  415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85 db 
>>>> 74 42 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18 48 8d 
>>>> 75 b0 4c 89 ff <48
>>>>> 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c 89 63
>>>> [  415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287
>>>> [  415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8 RCX: 
>>>> 0000000000000000
>>>> [  415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30 RDI: 
>>>> ffff888161f80000
>>>> [  415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000 R09: 
>>>> ffffc9000401fa00
>>>> [  415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000 R12: 
>>>> ffffc9000401fb20
>>>> [  415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0 R15: 
>>>> ffff888161f80000
>>>> [  415.476312] FS:  00007f132ff89840(0000) 
>>>> GS:ffff889f87c00000(0000) knlGS:0000000000000000
>>>> [  415.485350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  415.491767] CR2: 0000000000000008 CR3: 0000000161d46003 CR4: 
>>>> 0000000000770ef0
>>>> [  415.499738] PKRU: 55555554
>>>> [  415.502750] Call Trace:
>>>> [  415.505482]  <TASK>
>>>> [  415.507825]  amdgpu_vm_update_range+0x32a/0x880 [amdgpu]
>>>> [  415.513869]  amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]
>>>> [  415.519814] 
>>>> amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 [amdgpu]
>>>> [  415.527729]  kfd_ioctl_unmap_memory_from_gpu+0xed/0x340 [amdgpu]
>>>> [  415.534551]  kfd_ioctl+0x3b6/0x510 [amdgpu]
>>>>
>>>> Cc: Christian König <Christian.Koenig@amd.com>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>>>> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 58 
>>>> +++++++++++++----------
>>>>   3 files changed, 45 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 26f1c3359642..eaa402f99fe0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm,
>>>>       params.unlocked = unlocked;
>>>>       params.needs_flush = flush_tlb;
>>>>       params.allow_override = allow_override;
>>>> +    INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>>>>         /* Implicitly sync to command submissions in the same VM 
>>>> before
>>>>        * unmapping. Sync to moving fences before mapping.
>>>> @@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct 
>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>       if (r)
>>>>           goto error_unlock;
>>>>   -    if (params.needs_flush)
>>>> +    if (params.needs_flush) {
>>>>           r = amdgpu_vm_tlb_flush(&params, fence);
>>>> +        amdgpu_vm_pt_free_list(adev, &params);
>>>
>>> This is completed independent of the VM flush and should always be 
>>> called.
>>>
>>>> +    }
>>>>     error_unlock:
>>>>       amdgpu_vm_eviction_unlock(vm);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index b0a4fe683352..54d7da396de0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {
>>>>        * to be overridden for NUMA local memory.
>>>>        */
>>>>       bool allow_override;
>>>> +
>>>> +    /**
>>>> +     * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
>>>> +     */
>>>> +    struct list_head tlb_flush_waitlist;
>>>>   };
>>>>     struct amdgpu_vm_update_funcs {
>>>> @@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct 
>>>> amdgpu_vm_update_params *params,
>>>>                 uint64_t start, uint64_t end,
>>>>                 uint64_t dst, uint64_t flags);
>>>>   void amdgpu_vm_pt_free_work(struct work_struct *work);
>>>> +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>>> +                struct amdgpu_vm_update_params *params);
>>>>     #if defined(CONFIG_DEBUG_FS)
>>>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>>>> seq_file *m);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> index 601df0ce8290..9231edfb427e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> @@ -622,40 +622,30 @@ void amdgpu_vm_pt_free_work(struct 
>>>> work_struct *work)
>>>>   }
>>>>     /**
>>>> - * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>>> + * amdgpu_vm_pt_free_list - free PD/PT levels
>>>>    *
>>>>    * @adev: amdgpu device structure
>>>> - * @vm: amdgpu vm structure
>>>> - * @start: optional cursor where to start freeing PDs/PTs
>>>> - * @unlocked: vm resv unlock status
>>>> + * @params: see amdgpu_vm_update_params definition
>>>>    *
>>>> - * Free the page directory or page table level and all sub levels.
>>>> + * Free the page directory objects saved in the flush list
>>>>    */
>>>> -static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>>> -                  struct amdgpu_vm *vm,
>>>> -                  struct amdgpu_vm_pt_cursor *start,
>>>> -                  bool unlocked)
>>>> +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>>> +                struct amdgpu_vm_update_params *params)
>>>>   {
>>>> -    struct amdgpu_vm_pt_cursor cursor;
>>>> -    struct amdgpu_vm_bo_base *entry;
>>>> +    struct amdgpu_vm_bo_base *entry, *next;
>>>> +    struct amdgpu_vm *vm = params->vm;
>>>> +    bool unlocked = params->unlocked;
>>>>         if (unlocked) {
>>>>           spin_lock(&vm->status_lock);
>>>> -        for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, 
>>>> entry)
>>>> -            list_move(&entry->vm_status, &vm->pt_freed);
>>>> -
>>>> -        if (start)
>>>> -            list_move(&start->entry->vm_status, &vm->pt_freed);
>>>> +        list_splice_init(&vm->pt_freed, &params->tlb_flush_waitlist);
>>>>           spin_unlock(&vm->status_lock);
>>>>           schedule_work(&vm->pt_free_work);
>>>>           return;
>>>>       }
>>>>   -    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>>> +    list_for_each_entry_safe(entry, next, 
>>>> &params->tlb_flush_waitlist, vm_status)
>>>>           amdgpu_vm_pt_free(entry);
>>>> -
>>>> -    if (start)
>>>> -        amdgpu_vm_pt_free(start->entry);
>>>>   }
>>>>     /**
>>>> @@ -667,7 +657,13 @@ static void amdgpu_vm_pt_free_dfs(struct 
>>>> amdgpu_device *adev,
>>>>    */
>>>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>>>> amdgpu_vm *vm)
>>>>   {
>>>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>>> +    struct amdgpu_vm_pt_cursor cursor;
>>>> +    struct amdgpu_vm_bo_base *entry;
>>>> +
>>>> +    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry) {
>>>> +        if (entry)
>>>
>>> Entry can't be NULL here I think.
>> Yeah, makes sense, if there is a GPU process, it will have at-least 
>> one page table entry.
>
> The problem is rather that entry is either the root entry or a child 
> element within the array of entries.
>
> So entry can never be NULL, only entry->bo can be NULL if there is no 
> PD/PT allocated for this slot.

It looks like it can be NULL, Rajneesh has just shared a backtrace from 
the testing, which shows a NULL here:

[Mar21 06:55] BUG: unable to handle page fault for address: ffffc9002d637aa0
[  +0.007689] #PF: supervisor write access in kernel mode
[  +0.005833] #PF: error_code(0x0002) - not-present page
[  +0.005732] PGD 100000067 P4D 100000067 PUD 1001ec067 PMD 4882af067 PTE 0
[  +0.007579] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  +0.004861] CPU: 52 PID: 8146 Comm: kworker/52:2 Tainted: G           
OE     5.18.2-mi300-build-140423-ubuntu-22.04+ #24
[  +0.012135] Hardware name: AMD Corporation Sh54p/Sh54p, BIOS WPP4311S 
03/11/2024
[  +0.008254] Workqueue: events delayed_fput
[  +0.004573] RIP: 0010:amdgpu_vm_pt_free+0x66/0xe0 [amdgpu]
[  +0.006270] Code: 01 74 6e 48 c7 45 e8 00 00 00 00 31 f6 48 83 c7 58 
e8 0e ea 3b ff 48 8b 03 48 8d 78 38 e8 f2 9b 90 c0 48 8b 43 20 48 8b 53 
18 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 43 18 48
[  +0.020954] RSP: 0018:ffffc9002e117c08 EFLAGS: 00010246
[  +0.005830] RAX: ffff8884867bda20 RBX: ffff8884867bd9a8 RCX: 
0000000000000000
[  +0.007961] RDX: ffffc9002d637a98 RSI: ffff888482845458 RDI: 
ffffffffc155916e
[  +0.007958] RBP: ffffc9002e117c20 R08: 0000000000000000 R09: 
0000000000000001
[  +0.007961] R10: ffff888482843000 R11: 0000000141eed000 R12: 
ffff8884867bd9a8
[  +0.007959] R13: ffff888471d68098 R14: ffff888471d68098 R15: 
00000000c1dab300
[  +0.007960] FS:  0000000000000000(0000) GS:ffff88e1cf700000(0000) 
knlGS:0000000000000000
[  +0.009027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.006409] CR2: ffffc9002d637aa0 CR3: 0000000006410006 CR4: 
0000000000770ee0
[  +0.007961] PKRU: 55555554
[  +0.003016] Call Trace:
[  +0.002726]  <TASK>
[  +0.002340]  amdgpu_vm_pt_free_root+0x60/0xa0 [amdgpu]
[  +0.005843]  amdgpu_vm_fini+0x2cb/0x5d0 [amdgpu]
[  +0.005248]  ? amdgpu_ctx_mgr_entity_fini+0x53/0x1c0 [amdgpu]
[  +0.006520]  amdgpu_driver_postclose_kms+0x191/0x2d0 [amdgpu]
[  +0.006520]  drm_file_free.part.0+0x1e5/0x260 [drm]

I might have to add a follow-up patch here.

- Shashank

>
> Regards,
> Christian.
>
>>>
>>>> +            amdgpu_vm_pt_free(entry);
>>>> +    }
>>>>   }
>>>>     /**
>>>> @@ -972,10 +968,24 @@ int amdgpu_vm_ptes_update(struct 
>>>> amdgpu_vm_update_params *params,
>>>>               while (cursor.pfn < frag_start) {
>>>>                   /* Make sure previous mapping is freed */
>>>>                   if (cursor.entry->bo) {
>>>> +                    struct amdgpu_vm_pt_cursor seek;
>>>> +                    struct amdgpu_vm_bo_base *entry;
>>>> +
>>>>                       params->needs_flush = true;
>>>> -                    amdgpu_vm_pt_free_dfs(adev, params->vm,
>>>> -                                  &cursor,
>>>> -                                  params->unlocked);
>>>> + spin_lock(&params->vm->status_lock);
>>>> +                    for_each_amdgpu_vm_pt_dfs_safe(adev, 
>>>> params->vm, &cursor,
>>>> +                                       seek, entry) {
>>>> +                        if (!entry || !entry->bo)
>>>> +                            continue;
>>>> +
>>>> +                        list_move(&entry->vm_status,
>>>> + &params->tlb_flush_waitlist);
>>>> +                    }
>>>> +
>>>> +                    /* enter start node now */
>>>> + list_move(&cursor.entry->vm_status,
>>>> + &params->tlb_flush_waitlist);
>>>> + spin_unlock(&params->vm->status_lock);
>>>
>>> I would put this into a separate function maybe.
>>
>> Noted,
>>
>> - Shashank
>>
>>>
>>> Apart from those nit-picks looks good to me.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>                   }
>>>>                   amdgpu_vm_pt_next(adev, &cursor);
>>>>               }
>>>
>
--------------THLZ82b1g8OPx62DpTDloz6n
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 18/03/2024 16:24, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c85e5897-66cf-46b8-aa8f-c208c4a6c68a@amd.com">Am
      18.03.24 um 16:22 schrieb Sharma, Shashank:
      <br>
      <blockquote type="cite">
        <br>
        On 18/03/2024 16:01, Christian König wrote:
        <br>
        <blockquote type="cite">Am 18.03.24 um 15:44 schrieb Shashank
          Sharma:
          <br>
          <blockquote type="cite">The idea behind this patch is to delay
            the freeing of PT entry objects
            <br>
            until the TLB flush is done.
            <br>
            <br>
            This patch:
            <br>
            - Adds a tlb_flush_waitlist in amdgpu_vm_update_params which
            will keep the
            <br>
            &nbsp;&nbsp; objects that need to be freed after tlb_flush.
            <br>
            - Adds PT entries in this list in amdgpu_vm_ptes_update
            after finding
            <br>
            &nbsp;&nbsp; the PT entry.
            <br>
            - Changes functionality of amdgpu_vm_pt_free_dfs from
            (df_search + free)
            <br>
            &nbsp;&nbsp; to simply freeing of the BOs, also renames it to
            <br>
            &nbsp;&nbsp; amdgpu_vm_pt_free_list to reflect this same.
            <br>
            - Exports function amdgpu_vm_pt_free_list to be called
            directly.
            <br>
            - Calls amdgpu_vm_pt_free_list directly from
            amdgpu_vm_update_range.
            <br>
            <br>
            V2: rebase
            <br>
            V4: Addressed review comments from Christian
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; - add only locked PTEs entries in TLB flush waitlist.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; - do not create a separate function for list flush.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; - do not create a new lock for TLB flush.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; - there is no need to wait on tlb_flush_fence
            exclusively.
            <br>
            <br>
            V5: Addressed review comments from Christian
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; - change the amdgpu_vm_pt_free_dfs's functionality to
            simple freeing
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of the objects and rename it.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; - add all the PTE objects in
            params-&gt;tlb_flush_waitlist
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; - let amdgpu_vm_pt_free_root handle the freeing of BOs
            independently
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; - call amdgpu_vm_pt_free_list directly
            <br>
            <br>
            V6: Rebase
            <br>
            V7: Rebase
            <br>
            V8: Added a NULL check to fix this backtrace issue:
            <br>
            [&nbsp; 415.351447] BUG: kernel NULL pointer dereference,
            address: 0000000000000008
            <br>
            [&nbsp; 415.359245] #PF: supervisor write access in kernel mode
            <br>
            [&nbsp; 415.365081] #PF: error_code(0x0002) - not-present page
            <br>
            [&nbsp; 415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD
            0
            <br>
            [&nbsp; 415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI
            <br>
            [&nbsp; 415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e
            Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE
            5.18.2-mi300-build-140423-ubuntu-22.04+ #24
            <br>
            [&nbsp; 415.394437] Hardware name: AMD Corporation Sh51p/Sh51p,
            BIOS RMO1001AS 02/21/2024
            <br>
            [&nbsp; 415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10
            [amdgpu]
            <br>
            [&nbsp; 415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48
            85 db 74 42 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d
            43 18 48 8d 75 b0 4c 89 ff &lt;48
            <br>
            <blockquote type="cite">89 51 08 48 89 0a 49 8b 56 30 48 89
              42 08 48 89 53 18 4c 89 63
              <br>
            </blockquote>
            [&nbsp; 415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287
            <br>
            [&nbsp; 415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8
            RCX: 0000000000000000
            <br>
            [&nbsp; 415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30
            RDI: ffff888161f80000
            <br>
            [&nbsp; 415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000
            R09: ffffc9000401fa00
            <br>
            [&nbsp; 415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000
            R12: ffffc9000401fb20
            <br>
            [&nbsp; 415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0
            R15: ffff888161f80000
            <br>
            [&nbsp; 415.476312] FS:&nbsp; 00007f132ff89840(0000)
            GS:ffff889f87c00000(0000) knlGS:0000000000000000
            <br>
            [&nbsp; 415.485350] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0:
            0000000080050033
            <br>
            [&nbsp; 415.491767] CR2: 0000000000000008 CR3: 0000000161d46003
            CR4: 0000000000770ef0
            <br>
            [&nbsp; 415.499738] PKRU: 55555554
            <br>
            [&nbsp; 415.502750] Call Trace:
            <br>
            [&nbsp; 415.505482]&nbsp; &lt;TASK&gt;
            <br>
            [&nbsp; 415.507825]&nbsp; amdgpu_vm_update_range+0x32a/0x880 [amdgpu]
            <br>
            [&nbsp; 415.513869]&nbsp; amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]
            <br>
            [&nbsp; 415.519814]
            amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250
            [amdgpu]
            <br>
            [&nbsp; 415.527729]&nbsp; kfd_ioctl_unmap_memory_from_gpu+0xed/0x340
            [amdgpu]
            <br>
            [&nbsp; 415.534551]&nbsp; kfd_ioctl+0x3b6/0x510 [amdgpu]
            <br>
            <br>
            Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
            <br>
            Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
            <br>
            Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
            <br>
            Cc: Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
            <br>
            Acked-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
            <br>
            Acked-by: Rajneesh Bhardwaj
            <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
            <br>
            Tested-by: Rajneesh Bhardwaj
            <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
            <br>
            Signed-off-by: Shashank Sharma
            <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp; |&nbsp; 5 +-
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp; |&nbsp; 7 +++
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 58
            +++++++++++++----------
            <br>
            &nbsp; 3 files changed, 45 insertions(+), 25 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            index 26f1c3359642..eaa402f99fe0 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            @@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.unlocked = unlocked;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.needs_flush = flush_tlb;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.allow_override = allow_override;
            <br>
            +&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;params.tlb_flush_waitlist);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Implicitly sync to command submissions in the
            same VM before
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * unmapping. Sync to moving fences before mapping.
            <br>
            @@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; if (params.needs_flush)
            <br>
            +&nbsp;&nbsp;&nbsp; if (params.needs_flush) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_tlb_flush(&amp;params, fence);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free_list(adev, &amp;params);
            <br>
          </blockquote>
          <br>
          This is completed independent of the VM flush and should
          always be called.
          <br>
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp; error_unlock:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_eviction_unlock(vm);
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            index b0a4fe683352..54d7da396de0 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            @@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to be overridden for NUMA local memory.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool allow_override;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /**
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * @tlb_flush_waitlist: temporary storage for BOs until
            tlb_flush
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; struct list_head tlb_flush_waitlist;
            <br>
            &nbsp; };
            <br>
            &nbsp; &nbsp; struct amdgpu_vm_update_funcs {
            <br>
            @@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct
            amdgpu_vm_update_params *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t end,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags);
            <br>
            &nbsp; void amdgpu_vm_pt_free_work(struct work_struct *work);
            <br>
            +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params *params);
            <br>
            &nbsp; &nbsp; #if defined(CONFIG_DEBUG_FS)
            <br>
            &nbsp; void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm,
            struct seq_file *m);
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            index 601df0ce8290..9231edfb427e 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            @@ -622,40 +622,30 @@ void amdgpu_vm_pt_free_work(struct
            work_struct *work)
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            - * amdgpu_vm_pt_free_dfs - free PD/PT levels
            <br>
            + * amdgpu_vm_pt_free_list - free PD/PT levels
            <br>
            &nbsp;&nbsp; *
            <br>
            &nbsp;&nbsp; * @adev: amdgpu device structure
            <br>
            - * @vm: amdgpu vm structure
            <br>
            - * @start: optional cursor where to start freeing PDs/PTs
            <br>
            - * @unlocked: vm resv unlock status
            <br>
            + * @params: see amdgpu_vm_update_params definition
            <br>
            &nbsp;&nbsp; *
            <br>
            - * Free the page directory or page table level and all sub
            levels.
            <br>
            + * Free the page directory objects saved in the flush list
            <br>
            &nbsp;&nbsp; */
            <br>
            -static void amdgpu_vm_pt_free_dfs(struct amdgpu_device
            *adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor *start,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unlocked)
            <br>
            +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params *params)
            <br>
            &nbsp; {
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor cursor;
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry, *next;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = params-&gt;vm;
            <br>
            +&nbsp;&nbsp;&nbsp; bool unlocked = params-&gt;unlocked;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlocked) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start,
            cursor, entry)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_move(&amp;entry-&gt;vm_status,
            &amp;vm-&gt;pt_freed);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (start)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_move(&amp;start-&gt;entry-&gt;vm_status,
            &amp;vm-&gt;pt_freed);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_splice_init(&amp;vm-&gt;pt_freed,
            &amp;params-&gt;tlb_flush_waitlist);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_work(&amp;vm-&gt;pt_free_work);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start,
            cursor, entry)
            <br>
            +&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next,
            &amp;params-&gt;tlb_flush_waitlist, vm_status)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; if (start)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(start-&gt;entry);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            @@ -667,7 +657,13 @@ static void
            amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp; */
            <br>
            &nbsp; void amdgpu_vm_pt_free_root(struct amdgpu_device *adev,
            struct amdgpu_vm *vm)
            <br>
            &nbsp; {
            <br>
            -&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor cursor;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor,
            entry) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entry)
            <br>
          </blockquote>
          <br>
          Entry can't be NULL here I think.
          <br>
        </blockquote>
        Yeah, makes sense, if there is a GPU process, it will have
        at-least one page table entry.
        <br>
      </blockquote>
      <br>
      The problem is rather that entry is either the root entry or a
      child element within the array of entries.
      <br>
      <br>
      So entry can never be NULL, only entry-&gt;bo can be NULL if there
      is no PD/PT allocated for this slot.
      <br>
    </blockquote>
    <p>It looks like it can be NULL, Rajneesh has just shared a
      backtrace from the testing, which shows a NULL here: <br>
    </p>
    <p><span><span class="ui-provider a b c d e f g h i j k l m n o p q
          r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">[Mar21
          06:55] BUG: unable to handle page fault for address:
          ffffc9002d637aa0<br>
          [&nbsp; +0.007689] #PF: supervisor write access in kernel mode<br>
          [&nbsp; +0.005833] #PF: error_code(0x0002) - not-present page<br>
          [&nbsp; +0.005732] PGD 100000067 P4D 100000067 PUD 1001ec067 PMD
          4882af067 PTE 0<br>
          [&nbsp; +0.007579] Oops: 0002 [#1] PREEMPT SMP NOPTI<br>
          [&nbsp; +0.004861] CPU: 52 PID: 8146 Comm: kworker/52:2 Tainted:
          G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.18.2-mi300-build-140423-ubuntu-22.04+ #24<br>
          [&nbsp; +0.012135] Hardware name: AMD Corporation Sh54p/Sh54p, BIOS
          WPP4311S 03/11/2024<br>
          [&nbsp; +0.008254] Workqueue: events delayed_fput<br>
          [&nbsp; +0.004573] RIP: 0010:amdgpu_vm_pt_free+0x66/0xe0 [amdgpu]<br>
          [&nbsp; +0.006270] Code: 01 74 6e 48 c7 45 e8 00 00 00 00 31 f6 48
          83 c7 58 e8 0e ea 3b ff 48 8b 03 48 8d 78 38 e8 f2 9b 90 c0 48
          8b 43 20 48 8b 53 18 &lt;48&gt; 89 42 08 48 89 10 48 b8 00 01
          00 00 00 00 ad de 48 89 43 18 48<br>
          [&nbsp; +0.020954] RSP: 0018:ffffc9002e117c08 EFLAGS: 00010246<br>
          [&nbsp; +0.005830] RAX: ffff8884867bda20 RBX: ffff8884867bd9a8 RCX:
          0000000000000000<br>
          [&nbsp; +0.007961] RDX: ffffc9002d637a98 RSI: ffff888482845458 RDI:
          ffffffffc155916e<br>
          [&nbsp; +0.007958] RBP: ffffc9002e117c20 R08: 0000000000000000 R09:
          0000000000000001<br>
          [&nbsp; +0.007961] R10: ffff888482843000 R11: 0000000141eed000 R12:
          ffff8884867bd9a8<br>
          [&nbsp; +0.007959] R13: ffff888471d68098 R14: ffff888471d68098 R15:
          00000000c1dab300<br>
          [&nbsp; +0.007960] FS:&nbsp; 0000000000000000(0000)
          GS:ffff88e1cf700000(0000) knlGS:0000000000000000<br>
          [&nbsp; +0.009027] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0:
          0000000080050033<br>
          [&nbsp; +0.006409] CR2: ffffc9002d637aa0 CR3: 0000000006410006 CR4:
          0000000000770ee0<br>
          [&nbsp; +0.007961] PKRU: 55555554<br>
          [&nbsp; +0.003016] Call Trace:<br>
          [&nbsp; +0.002726]&nbsp; &lt;TASK&gt;<br>
          [&nbsp; +0.002340]&nbsp; amdgpu_vm_pt_free_root+0x60/0xa0 [amdgpu]<br>
          [&nbsp; +0.005843]&nbsp; amdgpu_vm_fini+0x2cb/0x5d0 [amdgpu]<br>
          [&nbsp; +0.005248]&nbsp; ? amdgpu_ctx_mgr_entity_fini+0x53/0x1c0
          [amdgpu]<br>
          [&nbsp; +0.006520]&nbsp; amdgpu_driver_postclose_kms+0x191/0x2d0
          [amdgpu]<br>
          [&nbsp; +0.006520]&nbsp; drm_file_free.part.0+0x1e5/0x260 [drm]</span></span></p>
    <p>I might have to add a follow-up patch here. <br>
    </p>
    <p>- Shashank<br>
    </p>
    <blockquote type="cite" cite="mid:c85e5897-66cf-46b8-aa8f-c208c4a6c68a@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            @@ -972,10 +968,24 @@ int amdgpu_vm_ptes_update(struct
            amdgpu_vm_update_params *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.pfn &lt; frag_start) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Make sure previous mapping is freed */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cursor.entry-&gt;bo) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor seek;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params-&gt;needs_flush = true;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free_dfs(adev,
            params-&gt;vm,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;cursor,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params-&gt;unlocked);
            <br>
            + spin_lock(&amp;params-&gt;vm-&gt;status_lock);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_amdgpu_vm_pt_dfs_safe(adev,
            params-&gt;vm, &amp;cursor,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seek, entry) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!entry || !entry-&gt;bo)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_move(&amp;entry-&gt;vm_status,
            <br>
            + &amp;params-&gt;tlb_flush_waitlist);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enter start node now */
            <br>
            + list_move(&amp;cursor.entry-&gt;vm_status,
            <br>
            + &amp;params-&gt;tlb_flush_waitlist);
            <br>
            + spin_unlock(&amp;params-&gt;vm-&gt;status_lock);
            <br>
          </blockquote>
          <br>
          I would put this into a separate function maybe.
          <br>
        </blockquote>
        <br>
        Noted,
        <br>
        <br>
        - Shashank
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Apart from those nit-picks looks good to me.
          <br>
          <br>
          Regards,
          <br>
          Christian.
          <br>
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_next(adev, &amp;cursor);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------THLZ82b1g8OPx62DpTDloz6n--
