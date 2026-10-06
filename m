Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA805CA5FED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 20:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557B010E025;
	Tue,  6 Oct 2026 20:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1VgKtIhz";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805B910E025
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 20:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+WdnRKMmtBgQsQ4EI/qnNM423FsZq83LnZQDdk5TjajdkB1ZR/Dw2TXT5kjhC4rpOR2I5774hkHxnVo+ZXiG2QirhzG3bnPTwlGjAPDNYG9+1rgCVdvg/sDr80CURLT+uIqsQ/+gx9Rbe0uXsiUKHYBtZDxF6dXGt1aKbqUAGWLnf4+NZjNB4Xw0UrQ2I1l96xOB16+bMczkvtjIDfrXNBRKWZ3tFKBr4mR7ojzU3jCkTzBa1rVMc0Sc2YDxdykMnFi9iagUQ8+MXGs/nhkzBFr1MpDDiVuglT41amDis1h41dH0muKmq7+EQARrvYi/xxYPOMss9pzFkiuJlKI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUa0uRTTH1pSPCbIW/+8QTaQ15EK8kz5qr5bjNP085E=;
 b=tmqAX6k0YPmWoS2CIpPpYdoE4PiUF5psP7lYXuXNWDRrs6F3lRNDRcXpH4ClPa1QgYsKuwyPwQD2GGWuBlKAVddCSvbNFgb5iUQSFN2Pny0PJil34ck93ZGWSPR/Pt83vdAsrwVz8bRXQFN1N7Lmf88sQDAlo+lvkeWu2A0+y1w0ejXTLh9M0LEqT9Pbp9SyqOKhZpZ4otOLGwddcEb+cauUc1IK2VqgvjmFgR+NPLdjiHY/Osrl6kJQ5KVNNs9T+SM1iNs0Ef0iXu6pc8y/XAfXSMxtHmAerW5xMzRJhkHecST08HCLFoFB1u3WhlRLhlaFpEkj1XWFS5bmhy+4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUa0uRTTH1pSPCbIW/+8QTaQ15EK8kz5qr5bjNP085E=;
 b=1VgKtIhzm/wWsLsnbraPFGD/wVcphKZuQJ39uzhm9dtVEyZuHEmxJA5nLlA3+pZCTZDG8aZiK0pdRLXKlBzOQ0cNjkTenWgp+6jBia9vHOiZorho8QMBiECxB2qLCZVFG8EpWR0uTSEkZf5TssBuqE5W7JTCt6IU8xXG30ecuJA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS2PR12MB440961.namprd12.prod.outlook.com
 (2603:10b6:8:405::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 20:39:52 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 20:39:52 +0000
Content-Type: multipart/alternative;
 boundary="------------o1FcVdx3bI9BfE09XlXZKEyg"
Message-ID: <2458421d-2b6b-4b81-b965-5ae6eb67edf6@amd.com>
Date: Tue, 6 Oct 2026 16:39:50 -0400
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_drm/amdkfd=3A_SVM_restore_worker_livelock?=
 =?UTF-8?Q?s_under_memory_reclaim_=E2=80=94_KFD_process_restart_wedges_until?=
 =?UTF-8?Q?_memory_pressure_subsides_=28gfx906=29?=
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <CAKLTOU_Rd4Cm8PQZ4Acu8u49rnGwKcTYonMsBggUASrHhaiMoA@mail.gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CAKLTOU_Rd4Cm8PQZ4Acu8u49rnGwKcTYonMsBggUASrHhaiMoA@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::7) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS2PR12MB440961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6852eab1-ec53-4b02-8f15-08df23e9f904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|11063799006|6133799003|5023799004|8096899003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z6vVmqT/6yrH+27U9G6jrQfF/X26kVL9NI+boI3dQCN5x4xGviAcT+eA8x/f7hI9CWA2rCFpxrouEeA+yzbGtvOqY/yAJWFNLCiOmSKWlb5PrHDLfBq0NALkkbIqbc6f6XgaqNbVVWVB6NZE7kO9gbBEvp8l1ijNzwnU7h9STSLa2PEcDYYDSlnaFR5oBtccCbsmdPJQ74pAEqfxOBa1tE7bHYdk00OTfAIhZ3cber/knmDntkz3UaoTcEcsl9EBCmVGVwtbEg4bYcDAml0sfjO5ix+XvvgmXIl4ySDiEKuiTPNQ5r9kKS0c+vgjk7/061KAfVpq4lkD4kIFm3odW4rPimspYqLAmvTHQ/aa0pg/uOUf79A9X3xvCc2U1U6MEZ0LrRqA0MBZkd5bxjDfpNRfIECJCTjy1IaEcaifBfX70Qn1Y5XfxEwq01K+5J/QXnxZyZJkZEuGd0d6RJCQsP8xU5TIeys8ncqP1Vk/WY68hf118KNZEP5wJJTKdlmx/Sxxcqd54WtiidPpeDC23pxZrOrb4qCW20slijX9+3142f7EbW7MtO/gzdFcDz4lx+czQIvi9QBL84CNHd2Y3WS8pvRsxCdZ4lc03YQzOrJOrpFJYsA3rDjrQl72astl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(5023799004)(8096899003)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkZoV2ZiWjZFNEdPZnpER0FKaWU3OTUvbDRnNXM1ci9nbkJUc1RQM0FNVDlC?=
 =?utf-8?B?S0hYTlg5bStBODRaUG10TUdKanFNd09PVGE1Vk54UXU0T3RLM0UrRTlyMTB5?=
 =?utf-8?B?S3p6cENRb3QwbTZyaElCYUZuRTZ1TmUvWFloRVMreDBCS3NwVGpITnNpRUhY?=
 =?utf-8?B?eTd0aU1rQk9HNGduMVJuRlhWM3NmSTM2UEY1MGVzOTNBeTZ6KzQrWVVBdk56?=
 =?utf-8?B?bzlOTm9zaUI2N2hqSkh4Q2JnVzQ2dDFUS2xjUjBjL3NOVEdiMjd3dXlNN1No?=
 =?utf-8?B?aHV1c05FSURDMWlYQWxJZkk0SmRNVEI3VWpySGZHNTJTVmtnV2dFcFR6akUx?=
 =?utf-8?B?aFpLdDNENzlkRHNvN1N1T01lOHdERllyQWRDbjhIUy9YeVg3RWR2OGQ2Qk1T?=
 =?utf-8?B?OXBGdEdzeEpib2tRVGtkdUw5LzFiZFFwdDhJeEpxczJ2amkwRGF5T3NPc2pB?=
 =?utf-8?B?YkZNVngwdDNJSFYxNkozVGhoL2pPNGtwT2RzR1Uzbmd6c2NxT1J4eEVxYmda?=
 =?utf-8?B?Y2JSUSswbG41UDhaLy9JWlZIcG92azdQS3dGaDJXcDBGQU5oU0VXM1owOU1O?=
 =?utf-8?B?RUZrZ0p5WTRieTJ2NVJRNHZTUXAzMkxnOG8yWXBsVzYzdkR3SE9xQk1STFlS?=
 =?utf-8?B?cmtqTHhPTHlNakRGSGVwRmlrQitNUmI1cUpQdWNJZVRUQm9ac3RqNU01QkNk?=
 =?utf-8?B?eGRrVnlMY3Q2ZjBFaHhTcitoWnlxdW91Qnd0UWNwQkhYTndEUXlUQTF4T1Fz?=
 =?utf-8?B?Y0RIempzTXBaTEZlMTdUc1VRRWRsRG5KT0hkUU5iWFgvTjFUN3JaVVVkQnBN?=
 =?utf-8?B?YzQ3OUk2MldvRFN0STN4S240SkI4bnZPZDB0d2JRZ05yRmpUL1h3cWNNczk0?=
 =?utf-8?B?dHVOSEIvK0NabVJxdGM5dEdPYncwOHhZdnYyRzMwS0NnTU1DdFI4cTZzVDNn?=
 =?utf-8?B?OFZ5QWNvUFI5azl2ajZ2VmZRRTJBUTlwSitVMjZUOVpMZXVENXFNZWRndzBM?=
 =?utf-8?B?S29hRndXWU1yUU9mOGlwQklUbTY3NjY3YXlRYmhzNGNnNllBdVEydDZRS3JB?=
 =?utf-8?B?S1lxNkljdDJUWktEcExQYUdrR1dDU3o0SlJLSENZMDd2L2lIZVZPL0VON09S?=
 =?utf-8?B?cmZCbHhDa3d4Q0UxcSt0bUJ5VitGOXNMWkVWV2szUzFCdllGcHJ1NmovRld2?=
 =?utf-8?B?RThPSDNHZmM5L3RqNjhmZkZ2L2ZVRFN0OUc3ZXRUWGZubTFncVFsU3NGTXhI?=
 =?utf-8?B?eThxNmphWjFGMWlxZGk3b3E3aGNSNEFpSGY0RkxIenpmZDluUG5FRi8yc1dm?=
 =?utf-8?B?Y2RGR3FZbHVaVmVCQjRCY3Q0dXpjN3NsUDc2VDNSaXhkTkJ0bTdhczMyRWd2?=
 =?utf-8?B?VjhEQ08zbW5JajRRN1hMenpyd3FkUk5KTVZOc1VaVG94N1lBMkU2REFVWVBa?=
 =?utf-8?B?RzRjNkx3SzVrUWxVOURkbGxvM3FKblI0S0FjWEZJd0UyNUMwc0FaMUlndlhL?=
 =?utf-8?B?cVRXb2djWDFHOVhiZmhNTHprK2dUTGlwbmU0alV3MHIxTzZsUTV1Yk9pR3A1?=
 =?utf-8?B?L0t6M3Q5UGNWOGxuYzNXZHhjOTBLeXUvcmlGejhRYkZSYmdKWjVVSm1LVFBX?=
 =?utf-8?B?T045Uk1XeWNDT0pVQnVaUUllVGNRbVFJY3JYRE5FT2lucUM2THM2bi84N3hM?=
 =?utf-8?B?amUyWElQVVh2MzA2Z21TT3FNeHlqMU5rbEtCN25ackExWVlFOExFbGtqYnl4?=
 =?utf-8?B?WjJNbHNDTlFSTERObEN2WmNFaHhGalZxVlJmRkJBZExXbXNoRDlhb1lOT3di?=
 =?utf-8?B?a0FNRTNvL25hb1J6bHlwcWhGczBqalRscXlPTDZ4TVlNZFI4Ni9STDBKNlpz?=
 =?utf-8?B?REdFOU55Q3ZPMTBHL2srOTNHZCs3bzFqUnZzekhRbHEvdFd6dDdUbmd5a3Ex?=
 =?utf-8?B?dkVqVzRKWTNySU81eTlzV0x6akdzbk5SWGY4a2MyKzg2aUtUd01ubnlIbk1t?=
 =?utf-8?B?SjVyNFVoa2RTZmlRNHBoK0d0SWF3My9vUmtZUUVjVmF3ZDc2K3hvWE1vOU5I?=
 =?utf-8?B?T2VFWitYblhzaHhtaDRsOFdCeGdTS3dPdi9JNHlCclJTRU01cTRvMWVJYnkx?=
 =?utf-8?B?Z0c5SkZlUW52Vko3ODlLdHU1amJJUDhmV0hDVElGWFpPL2FZa29mWmxnV0JD?=
 =?utf-8?B?elBIc2N3ZFZoeEp2Um5QSC9KblFZaTJtUHpreTMrTENHb0dCU0lCa2FKOXJ3?=
 =?utf-8?B?bzlWRWdSRWlObFRlalZuNW5ESTVpb0ltbmkvYTVpL2hPdHNZMERDUHk0TkJm?=
 =?utf-8?B?c1pObXo1Q0RyYXpJZkJ0M3h2UjltMkxmZmhOTy9acVZCVzFrY1o4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6852eab1-ec53-4b02-8f15-08df23e9f904
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 20:39:52.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI0Uc9R2vbh9tzUb9VUMmnVfRyv+XSwPD8ry4q+AA4jD6s9KY9dpa53fY/+02an6/7nerl2gW2DymknKPb5d5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB440961
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

--------------o1FcVdx3bI9BfE09XlXZKEyg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Olivier,

There are a few relatively recent patches that improve eviction and 
migration behaviour in the KFD SVM code. Can you check if those make a 
difference for you?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=25f0b322ffb5ba1d61175ad6b0c53bf0bcf3d301
https://gitlab.freedesktop.org/agd5f/linux/-/commit/46109de0748dd647c8dd628eb875e05364cbb720
https://gitlab.freedesktop.org/agd5f/linux/-/commit/ec4d432bea941f0788cd0e583e861e2346fb1f21

Regards,
   Felix

On 2026-09-28 08:03, Olivier Kaloudoff wrote:
>
> 	
> You don't often get email from olivier.kaloudoff@gmail.com. Learn why 
> this is important <https://aka.ms/LearnAboutSenderIdentification>
> 	
>
> == Summary ==
>
> Restarting a KFD application reliably wedges the next instance during
> initial GPU memory allocations whenever the system is under memory
> pressure. The root cause is an invalidation-storm livelock in the SVM
> eviction/restore path:
>
>     kswapd / kcompactd reclaim or migrate a page inside the process's
>     SVM-registered address space
>       -> mmu interval notifier -> svm_range_cpu_invalidate_pagetables
>       -> svm_range_evict: prange->invalid++, svms->evicted_ranges++,
>          quiesce_mm(), schedule svm_range_restore_work
>       -> svm_range_restore_work takes mmap write lock, walks the range
>          list, re-faults pages via hmm_vma_fault and remaps them to the
>          GPU
>       -> those pages are reclaim candidates again immediately; the next
>          invalidation lands mid-pass -> per-range cmpxchg on
>          prange->invalid fails -> goto out_reschedule aborts the whole
>          pass
>       -> evicted_ranges never drains to 0 -> kgd2kfd_resume_mm() never
>          runs -> KFD queues stay quiesced forever
>
> Because svm_range_evict() increments both counters on EVERY invalidate
> callback (even for ranges already marked invalid) and restore_work
> aborts the ENTIRE pass on the first re-dirtied range, convergence
> requires a perfectly quiet window that does not exist under sustained
> reclaim. Observed on the wedged system: ~900 invalidations/sec
> (svm_range_cpu_invalidate_pagetables, counted via ftrace), per-range
> "inv" counters in the tens of thousands (max seen: 32769), and the
> userspace process spinning in the HSA runtime waiting for a queue
> signal that never arrives — or blocked in D state in
> svm_range_list_lock_and_flush_work.
>
> Two secondary bugs compound this:
>
>   (a) svm_range_restore_work holds mmap_write_lock for the whole pass;
>       concurrent mm walkers (incl. reclaim-side access_remote_vm) stall
>       behind it — Emily Deng's Feb-2025 mmap_write_downgrade fix
>       addresses the lock-ordering part and is confirmed missing in the
>       tested kernels.
>
>   (b) A !vma range returns -EFAULT and reschedules forever instead of
>       unmapping the stale GPU mapping — Philip Yang's Oct-2025 fix;
>       also missing in the tested kernels. On teardown/restart (dead
>       VMAs pending restore) this alone can pin the worker.
>
> == Environment ==
>
>   GPU:        AMD Radeon Instinct MI50 32GB, gfx906, 0000:05:00.0
>               (Vega 20, PCIe, attached via Thunderbolt 3 eGPU enclosure)
>   Host:       AMD Strix Halo (Ryzen AI Max+ 395), 28GB RAM, Proxmox VE 9
>   Kernels:    6.17.13-13-pve, 7.0.12-1-pve, 7.2.6-k726 — all affected
>   Cmdline:    amdgpu.dc=0 modprobe.blacklist=amdxdna apparmor=0
>   Userspace:  llama.cpp llama-server (HIP/ROCm), hsakmt; ~19GB model
>               mmap'd into the SVM-registered address space
>   Taint:      512 (unsigned module; none in the KFD path)
>
> == Trigger: memory pressure ==
>
> The wedge is deterministically controlled by reclaim pressure on the
> KFD process's SVM-registered pages:
>
>   * Docker swarm (~95 services) up, ~8-12GB available:
>     restart -> invalidation storm, never healthy (health endpoint
>     stays 503; process spins in userspace or D-state in the alloc
>     ioctl; storm continues even after SIGSTOPping the process —
>     17,488 invalidates in 20s with userspace frozen; it is
>     kernel-driven).
>
>   * Same machine, swarm scaled to 0, ~24GB available:
>     restart -> health=200, clean load, real inference OK.
>
>   * Same machine, swarm up, llama-server started with --mlock
>     (model pages unevictable):
>     restart under pressure -> health=200, ftrace count of
>     svm_range_cpu_invalidate_pagetables = 0. The storm cannot start
>     when reclaim cannot touch the pages.
>
>   * ftrace stack traces of svm_range_cpu_invalidate_pagetables during
>     the storm: kcompactd -> compact_zone -> migrate_pages ->
>     try_to_migrate -> __mmu_notifier_invalidate_range_start, and
>     kswapd -> shrink_folio_list -> try_to_unmap -> same path
>     (via __rmap_walk_file — the mmap'd GGUF file pages).
>
> == Reproduction ==
>
>   1. Boot with the MI50 bound to amdgpu/KFD.
>   2. Start a KFD app that mmap's ~19GB of file-backed model data into
>      its SVM-registered address space (llama-server -ngl 99).
>   3. Create sustained memory pressure (busy service stack, or
>      anonymous churn so kswapd keeps scanning).
>   4. systemctl restart. The new instance wedges during VRAM/SVM
>      setup; dmesg (with dyndbg) shows svm_range_restore_work
>      rescheduling indefinitely.
>
> == Observed stacks (kernel 7.2.6) ==
>
>   Userspace process (llama-server, D state):
>
>       __flush_work+0x2c4/0x3c0
>       flush_work+0x1c/0x30
>       svm_range_list_lock_and_flush_work+0x2f/0x100 [amdgpu]
>       kfd_ioctl_alloc_memory_of_gpu+0x7c/0x3a0 [amdgpu]
>
>   Concurrent kworker (D state, same boot):
>
>       __flush_work+0x2c4/0x3c0
>       flush_work+0x1c/0x30
>       svm_range_list_lock_and_flush_work+0x2f/0x100 [amdgpu]
>       svm_range_restore_work+0x75/0x3a0 [amdgpu]
>       process_one_work+0x1a9/0x390
>
>   With dyndbg enabled the log fills with:
>       kfd kfd: [pid N] restore svm ranges
>       ... restoring svms ... inv 74 / inv 52 / ... / inv 32769
>       kfd kfd: [pid N] reschedule to restore svm ranges
>   (~900 lines/sec; journald flooding itself degrades the machine.)
>
> == Tested fix ==
>
> A patch against 7.2.6 combining the two missing upstream fixes plus a
> restore-pass convergence fix (attached:
> 0001-amdkfd-svm-restore-convergence.patch):
>
>   1. Backport Emily Deng's mmap_write_downgrade() in
>      svm_range_restore_work (Feb 2025).
>   2. Backport Philip Yang's !vma -> svm_range_unmap_from_gpus handling
>      (Oct 2025), adapted to this tree's amdgpu_hmm_range_* API; this
>      also fixes a latent units bug: the old !VM_READ path compared
>      byte-address start/end against page-index prange->start/last, so
>      the unmap never fired.
>   3. Convergence fix (new): in svm_range_restore_work, do not abort the
>      pass on the first range that fails or is re-dirtied mid-restore.
>      Restore each dirty range independently; if a range is
>      re-invalidated during its own restore or fails to map, mark
>      need_retry and continue with the remaining ranges. Reschedule one
>      more pass only if anything is still dirty, and still take the
>      evicted_ranges snapshot consistency check before resuming queues.
>      Each pass now makes monotonic per-range progress instead of
>      requiring an all-clean sweep.
>
> == Results ==
>
>   Patched amdgpu.ko on 7.2.6-k726, swarm fully up (original failing
>   conditions, swap enabled, default vm tunables), llama WITHOUT mlock:
>
>     restart round 1: invalidations = 668  -> health=200 @ 176s
>     restart round 2: invalidations = 898  -> health=200 @ 102s
>     restart round 3: invalidations = 2146 -> health=200 @ 125s
>
>   vs unpatched: identical conditions produced a non-converging storm
>   (inv counts into the tens of thousands, max 32769 observed on one
>   range) and the process never became healthy.
>
>   Inference verified working after each healthy restart.
>
>   Sustained-pressure follow-up (patch 1 installed, cgroup
>   MemoryHigh=6G on the service during model reload — continuous
>   direct reclaim of the process's own pages):
>
>     invalidations > 156,000 and still climbing when killed
>     health=503 persisted >15 min, RSS pinned ~13GB
>     storm CONTINUED after releasing the cgroup squeeze —
>       restore_work's own refaults kept feeding it
>
>   Conclusion: patch 1 fixes convergence under bursty invalidation
>   but not the reclaim->invalidate->restore->refault feedback loop
>   under sustained reclaim. Restored pages remain reclaim candidates,
>   so a clean pass can never complete while pressure continues.
>
> == Second fix: make registered ranges unevictable (patch 2) ==
>
> On non-xnack hardware the GPU cannot fault CPU pages back in, so
> every resident page inside a registered SVM interval must stay
> resident while the interval exists; reclaiming one is always futile
> — restore_work just faults it straight back in. The bug is not that
> restore retries; it is that the VM may take pages the GPU mapping
> fundamentally requires.
>
> Two failed mechanisms before the working one:
>
>   - Pinning folios at dma_map time (refcount + PG_mlocked mark):
>     insufficient — a folio only becomes unreclaimable once it is
>     moved to the unevictable LRU list, and the primitives that move
>     an already-LRU folio (mlock_folio, __mlock_folio, lruvec helpers)
>     are not exported to modules. Flagged-but-evictable folios were
>     still scanned, still unmapped, still stormed (253k+ observed).
>
>   - VM_LOCKED alone on covering VMAs: try_to_unmap_one() does bail
>     on VM_LOCKED before the PTE clear and lazily mlocks the folio —
>     but mmu_notifier_invalidate_range_start() fires at the TOP of
>     try_to_unmap, before the rmap walk discovers the flag. Every
>     reclaim attempt on a not-yet-locked folio still costs one
>     invalidation. Bounded per page, but under sustained pressure the
>     load only crawled (RSS growth ~1GB/5min, inv into six figures).
>
> Working approach (attached: 0002-amdkfd-nonxnack-lock.patch):
>
>   In svm_range_add_notifier_locked() — the single funnel where every
>   registered interval is inserted — when !p->xnack_enabled:
>
>     1. Set VM_LOCKED on all VMAs covering the registered range
>        (vma_start_write + vm_flags_set; callers already hold
>        mmap_write_lock for mmu_interval_notifier_insert_locked).
>     2. Prefault the range with batched get_user_pages_remote(FOLL_GET
>        then put_page): pages faulted into a VM_LOCKED vma are placed
>        on the unevictable LRU by the normal fault path
>        (lru_cache_add_inactive_or_unevictable), so reclaim never
>        selects them and the notifier never fires.
>
>   This is exactly what userspace mlock() does (VM_LOCKED + prefault),
>   applied at registration to the ranges the GPU may touch — matching
>   the --mlock measurement (0 invalidations, immune restart).
>
> == Results with patch 2 ==
>
>   Same environment (full swarm, swap enabled, no --mlock):
>
>     cold boot load under swarm pressure: inv = 4   -> health=200
>     restart under live swarm churn, round 1: +694  -> health=200 @102s
>     restart under live swarm churn, round 2: +83   -> health=200 @102s
>     restart after repeated cycles:         ~3.3k   -> health=200 @195s
>
>   Residual invalidations are one-time lazy-lock transitions on pages
>   resident before their VMA was locked plus non-reclaim notifier
>   events — bounded, not self-sustaining. The storm no longer feeds
>   on itself: releasing memory pressure once stopped the counter
>   dead instead of the storm continuing.
>
>   Note: with a hard cgroup cap below the model footprint
>   (MemoryHigh=6G vs ~19G needed), locked+prefaulted pages are
>   correctly unevictable but the workload cannot fit — expected, and
>   identical to userspace --mlock under the same cap.
>
>   Deployment gotcha worth noting: on this host amdgpu.ko ships in
>   the initramfs and loads at ~3s, so /lib/modules replacement alone
>   did nothing until update-initramfs -u was run.
>
> == What was ruled out ==
>
>   - HSA_XNACK=0 does not avoid it (gfx906 has no xnack anyway).
>   - Not alloc-size specific (8GB context reproduces too).
>   - Not the custom kernel: identical on stock 6.17.13-13-pve,
>     7.0.12-1-pve.
>   - Not the model file specifically: --no-mmap still storms (any
>     file-backed pages inside the SVM-registered mm are enough).
>   - Not a swap-only issue: storm persists with swap disabled while
>     other reclaim pressure exists; kcompactd page migration alone
>     suffices.
>   - kfdtest memory/queue tests pass while a healthy client holds the
>     device.
>
> == Logs ==
>
>   SysRq-w dumps, blocked stacks, dyndbg excerpts, ftrace stack samples
>   and counters available on request.
>
> == Notes for maintainers ==
>
>   - MI50 is behind Thunderbolt (hotplug PCI topology). If restore
>     scheduling interacts with hotplug eviction paths this box may
>     expose a wider timing window than fixed-PCIe systems. Happy to
>     test patches — reproduction takes ~5 minutes.
>   - The convergence change (3) is a proposal; it preserves the
>     "queues resume only when clean" guarantee via the existing
>     evicted_ranges consistency check, but review of the
>     retry-vs-resume ordering is welcome.
--------------o1FcVdx3bI9BfE09XlXZKEyg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">Hi Olivier,</div>
    <div class=3D"moz-cite-prefix"><br>
    </div>
    <div class=3D"moz-cite-prefix">There are a few relatively recent
      patches that improve eviction and migration behaviour in the KFD
      SVM code. Can you check if those make a difference for you?</div>
    <div class=3D"moz-cite-prefix"><br>
    </div>
    <div class=3D"moz-cite-prefix"><a class=3D"moz-txt-link-freetext" href=
=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D25f0b322ffb5ba1d61175ad6b0c53bf0bcf3d301">https://git.kernel.org/p=
ub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D25f0b322ffb5ba1d611=
75ad6b0c53bf0bcf3d301</a></div>
    <div class=3D"moz-cite-prefix"><a class=3D"moz-txt-link-freetext" href=
=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commit/46109de0748dd647c8d=
d628eb875e05364cbb720">https://gitlab.freedesktop.org/agd5f/linux/-/commit/=
46109de0748dd647c8dd628eb875e05364cbb720</a></div>
    <div class=3D"moz-cite-prefix"><a class=3D"moz-txt-link-freetext" href=
=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commit/ec4d432bea941f0788c=
d0e583e861e2346fb1f21">https://gitlab.freedesktop.org/agd5f/linux/-/commit/=
ec4d432bea941f0788cd0e583e861e2346fb1f21</a></div>
    <div class=3D"moz-cite-prefix"><br>
    </div>
    <div class=3D"moz-cite-prefix">Regards,<br>
      &nbsp; Felix</div>
    <div class=3D"moz-cite-prefix"><br>
    </div>
    <div class=3D"moz-cite-prefix">On 2026-09-28 08:03, Olivier Kaloudoff
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CAKLTOU_Rd4Cm8PQZ4Acu8u49rnGwKcTY=
onMsBggUASrHhaiMoA@mail.gmail.com">
     =20
      <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" width=3D"100%=
" style=3D" aspect-ratio: revert !important; background: revert !important;=
 block-size: revert !important; border: revert !important; bottom: revert !=
important; color: revert !important; color-scheme: revert !important; conte=
nt-visibility: revert !important; cursor: revert !important; direction: rev=
ert !important; display: revert !important; font-size: revert !important; h=
eight: revert !important; hyphens: revert !important; letter-spacing: rever=
t !important; line-height: revert !important; margin: revert !important; op=
acity: revert !important; order: revert !important; outline: revert !import=
ant; overflow: revert !important; padding: revert !important; position: rev=
ert !important; resize: revert !important; rotate: revert !important; scale=
: revert !important; tab-size: revert !important; table-layout: revert !imp=
ortant; text-align: revert !important; text-indent: revert !important; text=
-orientation: revert !important; text-overflow: revert !important; text-sha=
dow: revert !important; text-transform: revert !important; text-wrap: rever=
t !important; top: revert !important; transition: revert !important; user-s=
elect: revert !important; vertical-align: revert !important; visibility: re=
vert !important; white-space: revert !important; width: revert !important; =
word-break: revert !important; word-spacing: revert !important; writing-mod=
e: revert !important; zoom: revert !important; cellpadding: 0 !important; b=
order: 0 !important; cellspacing: 0 !important; display: table !important; =
width: 100% !important; table-layout: fixed !important; border-collapse: se=
perate !important; float: none !important; border-spacing: 0px 0px !importa=
nt; " align=3D"left">
        <tbody style=3D" aspect-ratio: revert !important; background: rever=
t !important; block-size: revert !important; border: revert !important; bot=
tom: revert !important; color: revert !important; color-scheme: revert !imp=
ortant; content-visibility: revert !important; cursor: revert !important; d=
irection: revert !important; display: revert !important; font-size: revert =
!important; height: revert !important; hyphens: revert !important; letter-s=
pacing: revert !important; line-height: revert !important; margin: revert !=
important; opacity: revert !important; order: revert !important; outline: r=
evert !important; overflow: revert !important; padding: revert !important; =
position: revert !important; resize: revert !important; rotate: revert !imp=
ortant; scale: revert !important; tab-size: revert !important; table-layout=
: revert !important; text-align: revert !important; text-indent: revert !im=
portant; text-orientation: revert !important; text-overflow: revert !import=
ant; text-shadow: revert !important; text-transform: revert !important; tex=
t-wrap: revert !important; top: revert !important; transition: revert !impo=
rtant; user-select: revert !important; vertical-align: revert !important; v=
isibility: revert !important; white-space: revert !important; width: revert=
 !important; word-break: revert !important; word-spacing: revert !important=
; writing-mode: revert !important; zoom: revert !important; display: block =
!important; ">
          <tr style=3D" aspect-ratio: revert !important; background: revert=
 !important; block-size: revert !important; border: revert !important; bott=
om: revert !important; color: revert !important; color-scheme: revert !impo=
rtant; content-visibility: revert !important; cursor: revert !important; di=
rection: revert !important; display: revert !important; font-size: revert !=
important; height: revert !important; hyphens: revert !important; letter-sp=
acing: revert !important; line-height: revert !important; margin: revert !i=
mportant; opacity: revert !important; order: revert !important; outline: re=
vert !important; overflow: revert !important; padding: revert !important; p=
osition: revert !important; resize: revert !important; rotate: revert !impo=
rtant; scale: revert !important; tab-size: revert !important; table-layout:=
 revert !important; text-align: revert !important; text-indent: revert !imp=
ortant; text-orientation: revert !important; text-overflow: revert !importa=
nt; text-shadow: revert !important; text-transform: revert !important; text=
-wrap: revert !important; top: revert !important; transition: revert !impor=
tant; user-select: revert !important; vertical-align: revert !important; vi=
sibility: revert !important; white-space: revert !important; width: revert =
!important; word-break: revert !important; word-spacing: revert !important;=
 writing-mode: revert !important; zoom: revert !important; ">
            <td valign=3D"middle" width=3D"1px" cellpadding=3D"7px 2px 7px =
2px" style=3D" aspect-ratio: revert !important; background: revert !importa=
nt; block-size: revert !important; border: revert !important; bottom: rever=
t !important; color: revert !important; color-scheme: revert !important; co=
ntent-visibility: revert !important; cursor: revert !important; direction: =
revert !important; display: revert !important; font-size: revert !important=
; height: revert !important; hyphens: revert !important; letter-spacing: re=
vert !important; line-height: revert !important; margin: revert !important;=
 opacity: revert !important; order: revert !important; outline: revert !imp=
ortant; overflow: revert !important; padding: revert !important; position: =
revert !important; resize: revert !important; rotate: revert !important; sc=
ale: revert !important; tab-size: revert !important; table-layout: revert !=
important; text-align: revert !important; text-indent: revert !important; t=
ext-orientation: revert !important; text-overflow: revert !important; text-=
shadow: revert !important; text-transform: revert !important; text-wrap: re=
vert !important; top: revert !important; transition: revert !important; use=
r-select: revert !important; vertical-align: revert !important; visibility:=
 revert !important; white-space: revert !important; width: revert !importan=
t; word-break: revert !important; word-spacing: revert !important; writing-=
mode: revert !important; zoom: revert !important; padding: 7px 2px 7px 2px =
!important; background-color: #A6A6A6 !important; valign: middle !important=
; width: 0px !important; "><br>
            </td>
            <td valign=3D"middle" width=3D"100%" cellpadding=3D"7px 5px 7px=
 15px" style=3D"aspect-ratio: revert !important; background-position: rever=
t !important; background-repeat: revert !important; background-attachment: =
revert !important; background-image: revert !important; background-size: re=
vert !important; background-origin: revert !important; background-clip: rev=
ert !important; block-size: revert !important; border: revert !important; b=
ottom: revert !important; color-scheme: revert !important; content-visibili=
ty: revert !important; cursor: revert !important; direction: revert !import=
ant; display: revert !important; height: revert !important; hyphens: revert=
 !important; letter-spacing: revert !important; line-height: revert !import=
ant; margin: revert !important; opacity: revert !important; order: revert !=
important; outline: revert !important; overflow: revert !important; positio=
n: revert !important; resize: revert !important; rotate: revert !important;=
 scale: revert !important; tab-size: revert !important; table-layout: rever=
t !important; text-indent: revert !important; text-orientation: revert !imp=
ortant; text-overflow: revert !important; text-shadow: revert !important; t=
ext-transform: revert !important; text-wrap: revert !important; top: revert=
 !important; transition: revert !important; user-select: revert !important;=
 vertical-align: revert !important; visibility: revert !important; white-sp=
ace: revert !important; word-break: revert !important; word-spacing: revert=
 !important; writing-mode: revert !important; zoom: revert !important; widt=
h: 100% !important; padding: 7px 5px 7px 15px !important; font-family: wf_s=
egoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif !important; f=
ont-size: 12px !important; font-weight: normal !important; text-align: left=
 !important; overflow-wrap: break-word !important;">
              <div style=3D" aspect-ratio: revert !important; background: r=
evert !important; block-size: revert !important; border: revert !important;=
 bottom: revert !important; color: revert !important; color-scheme: revert =
!important; content-visibility: revert !important; cursor: revert !importan=
t; direction: revert !important; display: revert !important; font-size: rev=
ert !important; height: revert !important; hyphens: revert !important; lett=
er-spacing: revert !important; line-height: revert !important; margin: reve=
rt !important; opacity: revert !important; order: revert !important; outlin=
e: revert !important; overflow: revert !important; padding: revert !importa=
nt; position: revert !important; resize: revert !important; rotate: revert =
!important; scale: revert !important; tab-size: revert !important; table-la=
yout: revert !important; text-align: revert !important; text-indent: revert=
 !important; text-orientation: revert !important; text-overflow: revert !im=
portant; text-shadow: revert !important; text-transform: revert !important;=
 text-wrap: revert !important; top: revert !important; transition: revert !=
important; user-select: revert !important; vertical-align: revert !importan=
t; visibility: revert !important; white-space: revert !important; width: re=
vert !important; word-break: revert !important; word-spacing: revert !impor=
tant; writing-mode: revert !important; zoom: revert !important; ">
                You don't often get email from
                <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:olivie=
r.kaloudoff@gmail.com">olivier.kaloudoff@gmail.com</a>. <a href=3D"https://=
aka.ms/LearnAboutSenderIdentification" style=3D"background: revert !importa=
nt;color: revert !important;content-visibility: revert !important;direction=
: revert !important;display: revert !important;font-size: revert !important=
;opacity: revert !important;rotate: revert !important;scale: revert !import=
ant;visibility: revert !important;" moz-do-not-send=3D"true">
                  Learn why this is important</a> </div>
            </td>
            <td valign=3D"middle" align=3D"left" width=3D"75px" cellpadding=
=3D"7px 5px 7px 5px" style=3D"aspect-ratio: revert !important; background-p=
osition: revert !important; background-repeat: revert !important; backgroun=
d-attachment: revert !important; background-image: revert !important; backg=
round-size: revert !important; background-origin: revert !important; backgr=
ound-clip: revert !important; block-size: revert !important; border: revert=
 !important; bottom: revert !important; color-scheme: revert !important; co=
ntent-visibility: revert !important; cursor: revert !important; direction: =
revert !important; display: revert !important; height: revert !important; h=
yphens: revert !important; letter-spacing: revert !important; line-height: =
revert !important; margin: revert !important; opacity: revert !important; o=
rder: revert !important; outline: revert !important; overflow: revert !impo=
rtant; position: revert !important; resize: revert !important; rotate: reve=
rt !important; scale: revert !important; tab-size: revert !important; table=
-layout: revert !important; text-indent: revert !important; text-orientatio=
n: revert !important; text-overflow: revert !important; text-shadow: revert=
 !important; text-transform: revert !important; text-wrap: revert !importan=
t; top: revert !important; transition: revert !important; user-select: reve=
rt !important; vertical-align: revert !important; visibility: revert !impor=
tant; white-space: revert !important; word-break: revert !important; word-s=
pacing: revert !important; writing-mode: revert !important; zoom: revert !i=
mportant; width: 75px !important; padding: 7px 5px !important; font-family:=
 wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif !importa=
nt; font-size: 12px !important; font-weight: normal !important; text-align:=
 left !important; overflow-wrap: break-word !important;"><br>
            </td>
          </tr>
        </tbody>
      </table>
      <div>
        <div dir=3D"ltr">=3D=3D Summary =3D=3D<br>
          <br>
          Restarting a KFD application reliably wedges the next instance
          during<br>
          initial GPU memory allocations whenever the system is under
          memory<br>
          pressure. The root cause is an invalidation-storm livelock in
          the SVM<br>
          eviction/restore path:<br>
          <br>
          &nbsp; &nbsp; kswapd / kcompactd reclaim or migrate a page inside=
 the
          process's<br>
          &nbsp; &nbsp; SVM-registered address space<br>
          &nbsp; &nbsp; &nbsp; -&gt; mmu interval notifier -&gt;
          svm_range_cpu_invalidate_pagetables<br>
          &nbsp; &nbsp; &nbsp; -&gt; svm_range_evict: prange-&gt;invalid++,
          svms-&gt;evicted_ranges++,<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;quiesce_mm(), schedule svm_rang=
e_restore_work<br>
          &nbsp; &nbsp; &nbsp; -&gt; svm_range_restore_work takes mmap writ=
e lock,
          walks the range<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;list, re-faults pages via hmm_v=
ma_fault and remaps
          them to the<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;GPU<br>
          &nbsp; &nbsp; &nbsp; -&gt; those pages are reclaim candidates aga=
in
          immediately; the next<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;invalidation lands mid-pass -&g=
t; per-range cmpxchg
          on<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;prange-&gt;invalid fails -&gt; =
goto out_reschedule
          aborts the whole<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pass<br>
          &nbsp; &nbsp; &nbsp; -&gt; evicted_ranges never drains to 0 -&gt;
          kgd2kfd_resume_mm() never<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;runs -&gt; KFD queues stay quie=
sced forever<br>
          <br>
          Because svm_range_evict() increments both counters on EVERY
          invalidate<br>
          callback (even for ranges already marked invalid) and
          restore_work<br>
          aborts the ENTIRE pass on the first re-dirtied range,
          convergence<br>
          requires a perfectly quiet window that does not exist under
          sustained<br>
          reclaim. Observed on the wedged system: ~900 invalidations/sec<br=
>
          (svm_range_cpu_invalidate_pagetables, counted via ftrace),
          per-range<br>
          &quot;inv&quot; counters in the tens of thousands (max seen: 3276=
9), and
          the<br>
          userspace process spinning in the HSA runtime waiting for a
          queue<br>
          signal that never arrives =E2=80=94 or blocked in D state in<br>
          svm_range_list_lock_and_flush_work.<br>
          <br>
          Two secondary bugs compound this:<br>
          <br>
          &nbsp; (a) svm_range_restore_work holds mmap_write_lock for the
          whole pass;<br>
          &nbsp; &nbsp; &nbsp; concurrent mm walkers (incl. reclaim-side
          access_remote_vm) stall<br>
          &nbsp; &nbsp; &nbsp; behind it =E2=80=94 Emily Deng's Feb-2025 mm=
ap_write_downgrade
          fix<br>
          &nbsp; &nbsp; &nbsp; addresses the lock-ordering part and is conf=
irmed
          missing in the<br>
          &nbsp; &nbsp; &nbsp; tested kernels.<br>
          <br>
          &nbsp; (b) A !vma range returns -EFAULT and reschedules forever
          instead of<br>
          &nbsp; &nbsp; &nbsp; unmapping the stale GPU mapping =E2=80=94 Ph=
ilip Yang's Oct-2025
          fix;<br>
          &nbsp; &nbsp; &nbsp; also missing in the tested kernels. On teard=
own/restart
          (dead<br>
          &nbsp; &nbsp; &nbsp; VMAs pending restore) this alone can pin the=
 worker.<br>
          <br>
          =3D=3D Environment =3D=3D<br>
          <br>
          &nbsp; GPU: &nbsp; &nbsp; &nbsp; &nbsp;AMD Radeon Instinct MI50 3=
2GB, gfx906,
          0000:05:00.0<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (Vega 20, PCIe, =
attached via Thunderbolt 3 eGPU
          enclosure)<br>
          &nbsp; Host: &nbsp; &nbsp; &nbsp; AMD Strix Halo (Ryzen AI Max+ 3=
95), 28GB RAM,
          Proxmox VE 9<br>
          &nbsp; Kernels: &nbsp; &nbsp;6.17.13-13-pve, 7.0.12-1-pve, 7.2.6-=
k726 =E2=80=94 all
          affected<br>
          &nbsp; Cmdline: &nbsp; &nbsp;amdgpu.dc=3D0 modprobe.blacklist=3Da=
mdxdna
          apparmor=3D0<br>
          &nbsp; Userspace: &nbsp;llama.cpp llama-server (HIP/ROCm), hsakmt=
; ~19GB
          model<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; mmap'd into the =
SVM-registered address space<br>
          &nbsp; Taint: &nbsp; &nbsp; &nbsp;512 (unsigned module; none in t=
he KFD path)<br>
          <br>
          =3D=3D Trigger: memory pressure =3D=3D<br>
          <br>
          The wedge is deterministically controlled by reclaim pressure
          on the<br>
          KFD process's SVM-registered pages:<br>
          <br>
          &nbsp; * Docker swarm (~95 services) up, ~8-12GB available:<br>
          &nbsp; &nbsp; restart -&gt; invalidation storm, never healthy (he=
alth
          endpoint<br>
          &nbsp; &nbsp; stays 503; process spins in userspace or D-state in=
 the
          alloc<br>
          &nbsp; &nbsp; ioctl; storm continues even after SIGSTOPping the p=
rocess
          =E2=80=94<br>
          &nbsp; &nbsp; 17,488 invalidates in 20s with userspace frozen; it=
 is<br>
          &nbsp; &nbsp; kernel-driven).<br>
          <br>
          &nbsp; * Same machine, swarm scaled to 0, ~24GB available:<br>
          &nbsp; &nbsp; restart -&gt; health=3D200, clean load, real infere=
nce OK.<br>
          <br>
          &nbsp; * Same machine, swarm up, llama-server started with --mloc=
k<br>
          &nbsp; &nbsp; (model pages unevictable):<br>
          &nbsp; &nbsp; restart under pressure -&gt; health=3D200, ftrace c=
ount of<br>
          &nbsp; &nbsp; svm_range_cpu_invalidate_pagetables =3D 0. The stor=
m cannot
          start<br>
          &nbsp; &nbsp; when reclaim cannot touch the pages.<br>
          <br>
          &nbsp; * ftrace stack traces of svm_range_cpu_invalidate_pagetabl=
es
          during<br>
          &nbsp; &nbsp; the storm: kcompactd -&gt; compact_zone -&gt;
          migrate_pages -&gt;<br>
          &nbsp; &nbsp; try_to_migrate -&gt;
          __mmu_notifier_invalidate_range_start, and<br>
          &nbsp; &nbsp; kswapd -&gt; shrink_folio_list -&gt; try_to_unmap -=
&gt;
          same path<br>
          &nbsp; &nbsp; (via __rmap_walk_file =E2=80=94 the mmap'd GGUF fil=
e pages).<br>
          <br>
          =3D=3D Reproduction =3D=3D<br>
          <br>
          &nbsp; 1. Boot with the MI50 bound to amdgpu/KFD.<br>
          &nbsp; 2. Start a KFD app that mmap's ~19GB of file-backed model
          data into<br>
          &nbsp; &nbsp; &nbsp;its SVM-registered address space (llama-serve=
r -ngl 99).<br>
          &nbsp; 3. Create sustained memory pressure (busy service stack, o=
r<br>
          &nbsp; &nbsp; &nbsp;anonymous churn so kswapd keeps scanning).<br=
>
          &nbsp; 4. systemctl restart. The new instance wedges during
          VRAM/SVM<br>
          &nbsp; &nbsp; &nbsp;setup; dmesg (with dyndbg) shows svm_range_re=
store_work<br>
          &nbsp; &nbsp; &nbsp;rescheduling indefinitely.<br>
          <br>
          =3D=3D Observed stacks (kernel 7.2.6) =3D=3D<br>
          <br>
          &nbsp; Userspace process (llama-server, D state):<br>
          <br>
          &nbsp; &nbsp; &nbsp; __flush_work+0x2c4/0x3c0<br>
          &nbsp; &nbsp; &nbsp; flush_work+0x1c/0x30<br>
          &nbsp; &nbsp; &nbsp; svm_range_list_lock_and_flush_work+0x2f/0x10=
0 [amdgpu]<br>
          &nbsp; &nbsp; &nbsp; kfd_ioctl_alloc_memory_of_gpu+0x7c/0x3a0 [am=
dgpu]<br>
          <br>
          &nbsp; Concurrent kworker (D state, same boot):<br>
          <br>
          &nbsp; &nbsp; &nbsp; __flush_work+0x2c4/0x3c0<br>
          &nbsp; &nbsp; &nbsp; flush_work+0x1c/0x30<br>
          &nbsp; &nbsp; &nbsp; svm_range_list_lock_and_flush_work+0x2f/0x10=
0 [amdgpu]<br>
          &nbsp; &nbsp; &nbsp; svm_range_restore_work+0x75/0x3a0 [amdgpu]<b=
r>
          &nbsp; &nbsp; &nbsp; process_one_work+0x1a9/0x390<br>
          <br>
          &nbsp; With dyndbg enabled the log fills with:<br>
          &nbsp; &nbsp; &nbsp; kfd kfd: [pid N] restore svm ranges<br>
          &nbsp; &nbsp; &nbsp; ... restoring svms ... inv 74 / inv 52 / ...=
 / inv 32769<br>
          &nbsp; &nbsp; &nbsp; kfd kfd: [pid N] reschedule to restore svm r=
anges<br>
          &nbsp; (~900 lines/sec; journald flooding itself degrades the
          machine.)<br>
          <br>
          =3D=3D Tested fix =3D=3D<br>
          <br>
          A patch against 7.2.6 combining the two missing upstream fixes
          plus a<br>
          restore-pass convergence fix (attached:<br>
          0001-amdkfd-svm-restore-convergence.patch):<br>
          <br>
          &nbsp; 1. Backport Emily Deng's mmap_write_downgrade() in<br>
          &nbsp; &nbsp; &nbsp;svm_range_restore_work (Feb 2025).<br>
          &nbsp; 2. Backport Philip Yang's !vma -&gt;
          svm_range_unmap_from_gpus handling<br>
          &nbsp; &nbsp; &nbsp;(Oct 2025), adapted to this tree's amdgpu_hmm=
_range_*
          API; this<br>
          &nbsp; &nbsp; &nbsp;also fixes a latent units bug: the old !VM_RE=
AD path
          compared<br>
          &nbsp; &nbsp; &nbsp;byte-address start/end against page-index
          prange-&gt;start/last, so<br>
          &nbsp; &nbsp; &nbsp;the unmap never fired.<br>
          &nbsp; 3. Convergence fix (new): in svm_range_restore_work, do no=
t
          abort the<br>
          &nbsp; &nbsp; &nbsp;pass on the first range that fails or is re-d=
irtied
          mid-restore.<br>
          &nbsp; &nbsp; &nbsp;Restore each dirty range independently; if a =
range is<br>
          &nbsp; &nbsp; &nbsp;re-invalidated during its own restore or fail=
s to map,
          mark<br>
          &nbsp; &nbsp; &nbsp;need_retry and continue with the remaining ra=
nges.
          Reschedule one<br>
          &nbsp; &nbsp; &nbsp;more pass only if anything is still dirty, an=
d still take
          the<br>
          &nbsp; &nbsp; &nbsp;evicted_ranges snapshot consistency check bef=
ore resuming
          queues.<br>
          &nbsp; &nbsp; &nbsp;Each pass now makes monotonic per-range progr=
ess instead
          of<br>
          &nbsp; &nbsp; &nbsp;requiring an all-clean sweep.<br>
          <br>
          =3D=3D Results =3D=3D<br>
          <br>
          &nbsp; Patched amdgpu.ko on 7.2.6-k726, swarm fully up (original
          failing<br>
          &nbsp; conditions, swap enabled, default vm tunables), llama
          WITHOUT mlock:<br>
          <br>
          &nbsp; &nbsp; restart round 1: invalidations =3D 668 &nbsp;-&gt; =
health=3D200 @
          176s<br>
          &nbsp; &nbsp; restart round 2: invalidations =3D 898 &nbsp;-&gt; =
health=3D200 @
          102s<br>
          &nbsp; &nbsp; restart round 3: invalidations =3D 2146 -&gt; healt=
h=3D200 @
          125s<br>
          <br>
          &nbsp; vs unpatched: identical conditions produced a non-convergi=
ng
          storm<br>
          &nbsp; (inv counts into the tens of thousands, max 32769 observed
          on one<br>
          &nbsp; range) and the process never became healthy.<br>
          <br>
          &nbsp; Inference verified working after each healthy restart.<br>
          <br>
          &nbsp; Sustained-pressure follow-up (patch 1 installed, cgroup<br=
>
          &nbsp; MemoryHigh=3D6G on the service during model reload =E2=80=
=94
          continuous<br>
          &nbsp; direct reclaim of the process's own pages):<br>
          <br>
          &nbsp; &nbsp; invalidations &gt; 156,000 and still climbing when =
killed<br>
          &nbsp; &nbsp; health=3D503 persisted &gt;15 min, RSS pinned ~13GB=
<br>
          &nbsp; &nbsp; storm CONTINUED after releasing the cgroup squeeze =
=E2=80=94<br>
          &nbsp; &nbsp; &nbsp; restore_work's own refaults kept feeding it<=
br>
          <br>
          &nbsp; Conclusion: patch 1 fixes convergence under bursty
          invalidation<br>
          &nbsp; but not the reclaim-&gt;invalidate-&gt;restore-&gt;refault
          feedback loop<br>
          &nbsp; under sustained reclaim. Restored pages remain reclaim
          candidates,<br>
          &nbsp; so a clean pass can never complete while pressure continue=
s.<br>
          <br>
          =3D=3D Second fix: make registered ranges unevictable (patch 2) =
=3D=3D<br>
          <br>
          On non-xnack hardware the GPU cannot fault CPU pages back in,
          so<br>
          every resident page inside a registered SVM interval must stay<br=
>
          resident while the interval exists; reclaiming one is always
          futile<br>
          =E2=80=94 restore_work just faults it straight back in. The bug i=
s not
          that<br>
          restore retries; it is that the VM may take pages the GPU
          mapping<br>
          fundamentally requires.<br>
          <br>
          Two failed mechanisms before the working one:<br>
          <br>
          &nbsp; - Pinning folios at dma_map time (refcount + PG_mlocked
          mark):<br>
          &nbsp; &nbsp; insufficient =E2=80=94 a folio only becomes unrecla=
imable once it
          is<br>
          &nbsp; &nbsp; moved to the unevictable LRU list, and the primitiv=
es that
          move<br>
          &nbsp; &nbsp; an already-LRU folio (mlock_folio, __mlock_folio, l=
ruvec
          helpers)<br>
          &nbsp; &nbsp; are not exported to modules. Flagged-but-evictable =
folios
          were<br>
          &nbsp; &nbsp; still scanned, still unmapped, still stormed (253k+
          observed).<br>
          <br>
          &nbsp; - VM_LOCKED alone on covering VMAs: try_to_unmap_one() doe=
s
          bail<br>
          &nbsp; &nbsp; on VM_LOCKED before the PTE clear and lazily mlocks=
 the
          folio =E2=80=94<br>
          &nbsp; &nbsp; but mmu_notifier_invalidate_range_start() fires at =
the TOP
          of<br>
          &nbsp; &nbsp; try_to_unmap, before the rmap walk discovers the fl=
ag.
          Every<br>
          &nbsp; &nbsp; reclaim attempt on a not-yet-locked folio still cos=
ts one<br>
          &nbsp; &nbsp; invalidation. Bounded per page, but under sustained
          pressure the<br>
          &nbsp; &nbsp; load only crawled (RSS growth ~1GB/5min, inv into s=
ix
          figures).<br>
          <br>
          Working approach (attached: 0002-amdkfd-nonxnack-lock.patch):<br>
          <br>
          &nbsp; In svm_range_add_notifier_locked() =E2=80=94 the single fu=
nnel where
          every<br>
          &nbsp; registered interval is inserted =E2=80=94 when !p-&gt;xnac=
k_enabled:<br>
          <br>
          &nbsp; &nbsp; 1. Set VM_LOCKED on all VMAs covering the registere=
d range<br>
          &nbsp; &nbsp; &nbsp; &nbsp;(vma_start_write + vm_flags_set; calle=
rs already hold<br>
          &nbsp; &nbsp; &nbsp; &nbsp;mmap_write_lock for
          mmu_interval_notifier_insert_locked).<br>
          &nbsp; &nbsp; 2. Prefault the range with batched
          get_user_pages_remote(FOLL_GET<br>
          &nbsp; &nbsp; &nbsp; &nbsp;then put_page): pages faulted into a V=
M_LOCKED vma are
          placed<br>
          &nbsp; &nbsp; &nbsp; &nbsp;on the unevictable LRU by the normal f=
ault path<br>
          &nbsp; &nbsp; &nbsp; &nbsp;(lru_cache_add_inactive_or_unevictable=
), so reclaim
          never<br>
          &nbsp; &nbsp; &nbsp; &nbsp;selects them and the notifier never fi=
res.<br>
          <br>
          &nbsp; This is exactly what userspace mlock() does (VM_LOCKED +
          prefault),<br>
          &nbsp; applied at registration to the ranges the GPU may touch =
=E2=80=94
          matching<br>
          &nbsp; the --mlock measurement (0 invalidations, immune restart).=
<br>
          <br>
          =3D=3D Results with patch 2 =3D=3D<br>
          <br>
          &nbsp; Same environment (full swarm, swap enabled, no --mlock):<b=
r>
          <br>
          &nbsp; &nbsp; cold boot load under swarm pressure: inv =3D 4 &nbs=
p; -&gt;
          health=3D200<br>
          &nbsp; &nbsp; restart under live swarm churn, round 1: +694 &nbsp=
;-&gt;
          health=3D200 @102s<br>
          &nbsp; &nbsp; restart under live swarm churn, round 2: +83 &nbsp;=
 -&gt;
          health=3D200 @102s<br>
          &nbsp; &nbsp; restart after repeated cycles: &nbsp; &nbsp; &nbsp;=
 &nbsp; ~3.3k &nbsp; -&gt;
          health=3D200 @195s<br>
          <br>
          &nbsp; Residual invalidations are one-time lazy-lock transitions =
on
          pages<br>
          &nbsp; resident before their VMA was locked plus non-reclaim
          notifier<br>
          &nbsp; events =E2=80=94 bounded, not self-sustaining. The storm n=
o longer
          feeds<br>
          &nbsp; on itself: releasing memory pressure once stopped the
          counter<br>
          &nbsp; dead instead of the storm continuing.<br>
          <br>
          &nbsp; Note: with a hard cgroup cap below the model footprint<br>
          &nbsp; (MemoryHigh=3D6G vs ~19G needed), locked+prefaulted pages =
are<br>
          &nbsp; correctly unevictable but the workload cannot fit =E2=80=
=94
          expected, and<br>
          &nbsp; identical to userspace --mlock under the same cap.<br>
          <br>
          &nbsp; Deployment gotcha worth noting: on this host amdgpu.ko shi=
ps
          in<br>
          &nbsp; the initramfs and loads at ~3s, so /lib/modules replacemen=
t
          alone<br>
          &nbsp; did nothing until update-initramfs -u was run.<br>
          <br>
          =3D=3D What was ruled out =3D=3D<br>
          <br>
          &nbsp; - HSA_XNACK=3D0 does not avoid it (gfx906 has no xnack
          anyway).<br>
          &nbsp; - Not alloc-size specific (8GB context reproduces too).<br=
>
          &nbsp; - Not the custom kernel: identical on stock 6.17.13-13-pve=
,<br>
          &nbsp; &nbsp; 7.0.12-1-pve.<br>
          &nbsp; - Not the model file specifically: --no-mmap still storms
          (any<br>
          &nbsp; &nbsp; file-backed pages inside the SVM-registered mm are
          enough).<br>
          &nbsp; - Not a swap-only issue: storm persists with swap disabled
          while<br>
          &nbsp; &nbsp; other reclaim pressure exists; kcompactd page migra=
tion
          alone<br>
          &nbsp; &nbsp; suffices.<br>
          &nbsp; - kfdtest memory/queue tests pass while a healthy client
          holds the<br>
          &nbsp; &nbsp; device.<br>
          <br>
          =3D=3D Logs =3D=3D<br>
          <br>
          &nbsp; SysRq-w dumps, blocked stacks, dyndbg excerpts, ftrace sta=
ck
          samples<br>
          &nbsp; and counters available on request.<br>
          <br>
          =3D=3D Notes for maintainers =3D=3D<br>
          <br>
          &nbsp; - MI50 is behind Thunderbolt (hotplug PCI topology). If
          restore<br>
          &nbsp; &nbsp; scheduling interacts with hotplug eviction paths th=
is box
          may<br>
          &nbsp; &nbsp; expose a wider timing window than fixed-PCIe system=
s.
          Happy to<br>
          &nbsp; &nbsp; test patches =E2=80=94 reproduction takes ~5 minute=
s.<br>
          &nbsp; - The convergence change (3) is a proposal; it preserves t=
he<br>
          &nbsp; &nbsp; &quot;queues resume only when clean&quot; guarantee=
 via the existing<br>
          &nbsp; &nbsp; evicted_ranges consistency check, but review of the=
<br>
          &nbsp; &nbsp; retry-vs-resume ordering is welcome.<br>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------o1FcVdx3bI9BfE09XlXZKEyg--
