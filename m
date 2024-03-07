Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783A5C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 12:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99DC10EBF7;
	Thu,  7 Mar 2024 12:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="huwnmDGc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E8910EBF7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 12:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYJdpWsnCy8prPunp2/H6csUhHHyeL+iY4Wrw31hP2WvVijqzLJg0zSTrnB8b2g1Eczc/1NtOkpACQN8azHmT5e723XWg06Na50o4yhHEmOG0M5wQFQnwem8wOcEPyUyGShULvzazNyUShRQr5QLeY/uCDsi1BUaN0oTFv7m4SG03o0zftIxLQkeWaa9xqa2+W+vNpoD9zQV8ior1PZsKpVcuuYKMe5YfxMELuUrBOGF5SWPuTS/blvjyQhbp6k3WqqEIdLmRo5qyJ+dEThsdJldnCdHuzPLoJxbNdtHr4kA5qkeFl88ig3HUZLPDvRJKOP1Mv1pwnorS34vpgx1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKacIQQ6uvu3i83vImPNTHoCQsgqpcJPEEMm97JHWJE=;
 b=Q0rvmonf06BoRjZ6N/0CTabVRGf/69BTOkZ4R/ir2YbQknpddq14Moq0/f2NbRBRX0HdNtwcVNqY/xpGHf/rNZ65zUg9ozrPT/ulTohOyU4s8FPaQ7jOLvxBB8xugufo0MQNF4HiLVEEtOBLrbkApa0FnfO6mKGHPbvflO0JF4xTXxb0vBSPKezGbLeVq2XGlPFsRnfjjYzlLiuB/Bng4thyqp6eiF/FaP74Hq/HZ2XI/pq5uuPmSGi/YKCXqB0LeZYOVk8EfRtgO9QjI0FfMce3PjegkdTsraZyBE+6qKDm1vzBLYXyrdOgcb4HPuSxYDsm8kVEJOvplPxuTdejwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKacIQQ6uvu3i83vImPNTHoCQsgqpcJPEEMm97JHWJE=;
 b=huwnmDGcLRZ5NIsR3HLKZo9G3SBrrcuj2WWXldLMvSNrZQDy1COgcIpCHo3npDR9vmu5EtOIRf1/2MVWIEKW1J9w5N9kkSfGeRB5MG29CIdnFetjlhA7fNcj6wghPwhD+7gWIO0QPTrc3e6GJTyZmBKuIyRFc4xKS0DuGuRG6Ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 12:45:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 12:45:40 +0000
Message-ID: <918ddcbf-de14-4709-82fb-9456a26855d5@amd.com>
Date: Thu, 7 Mar 2024 13:45:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-free bug
Content-Language: en-US
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Joonkyo Jung
 <joonkyoj@yonsei.ac.kr>, Dokyung Song <dokyungs@yonsei.ac.kr>,
 jisoo.jang@yonsei.ac.kr, yw9865@yonsei.ac.kr
References: <20240307120150.49715-1-vitaly.prosyak@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240307120150.49715-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1514b4c7-0993-48fc-f413-08dc3ea47ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Urnuy+UlhiXnHoiJ80vYbxrf6EiLLhWmA2z6d+Ss/e4GhWoCRA8p5sNKDa/TNaGfXwEgFE8IKl9v1yUWCY7abLZ/xF/WNYTZokJO6FePaP2QQI1u8i5HGEnfSG43IWB0MCOGeoQLznKeVkNgVjLZll9TbEodi3SBj6okmid57Gu8ZHT7PxcuneadGCnHvKNVUv/Qh2//KUwJ6STbkOz0uCmRYxhyrbMIL546DtNfEywpcMaxisCXIuuk8xF1dfHxixJYDoTUPk8V8oddatONlYAlO/2UzC/QQwZ4PCtzWRYJQ4SU0/HOlv+w//a2HFlbi6A5dYY0rLNzc/+h3qtlEqKDHPTyODZ4sD/fuHeev8jFmhvbXzqH6h4lFJy6pZtB2xijLjbnWW+EpimGrUu3MoDxcS5sZjKc82SUsjo3zmUjMzcgx/oLM+36SzzFR4dNtvYWw0RPZDr+G203iCenTfVk1n7JjyYny5fkoSPXBnTUPVpoWc6nwgYekCJAty32Wz9jA51060JBdjimLroOx35nLrsgqc2LwBRqNasLdaObRPB47Qt/Afum3/fCON7RJubosDbDpA+slxac2V44ixfZoitUi/fcdL/1k6v1+QJ2IFM9OIS0wAHGIfVExxAH8PoqjMF3PQ1s6bRTgW/ujhaW1pepKVgZPmh/hay4KDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXVrS3Bubkl3RTFDSGdnUlo4TzcyL3hNbnMzWVBPNmpaRDJXaE5IL0h5VUZy?=
 =?utf-8?B?enNRYUFIZDRVeVFUK2dBVTlGTFJ6VUZCQWRDdnhZcjBGNzVRTmFIMWRNWTdH?=
 =?utf-8?B?enZwUzNDNXMrNk9sUWRWWWs3M2dUaGZGOVRxY0xDMXQrOU56UUNWd3V4RXh6?=
 =?utf-8?B?UWhEVm9uZkdweFYrdktlQldGOEhReXpNTHNNbWgwaDk0bU80YmVua1VGYlJx?=
 =?utf-8?B?dDdNeWRYZms1NmxSL1dNdVJxeWlVdnlQUEtyTHVjeWFub0x2OGlFM1ZJWklI?=
 =?utf-8?B?M3hBV29NdGJNQWx3b05WNDVPSjkyMXpHak1nOHA0Z1BjWHBrTTlVcCtaNExv?=
 =?utf-8?B?bzRMM0ZtZ2VlK0hpOFhWNDVXazJZTkR1QnNYUUd0ellqb0NiZUdTRU9Cb3Y4?=
 =?utf-8?B?em4yS0VvaE9EWXZadHdYbHZudnFEZ1dralVmdTBOdXN0THp6RDQ2M203UHJi?=
 =?utf-8?B?QU1OOWJsUElOSXNwUk54TTdUb3pFSkpWa2svc1U1ZFcwVkFFeFVoOFZKK1pp?=
 =?utf-8?B?S2hHVkdFMkduV2k0am02QUtaaDdjdHlPeFQ2MzNjNDBWZ1lNblRpL3pzMXRI?=
 =?utf-8?B?REJwQzZ1WEpRTEdiWjlJNUsrc0ZUdlIvYldXVm9UVFZoT2pwVDBOYjZJbDBY?=
 =?utf-8?B?QjA4M3pyOXgzZStlZTBNZkdPRUFnZFo1TE9IRnpTT0ZMR3hvUG04RmZCRU9o?=
 =?utf-8?B?RUJjdXdCRHB3TlVTZ3ZTcCt0MDhIb1R1cUNldmVwcENBdXdIYWVCNlRIbDgx?=
 =?utf-8?B?b1ZBY29UTklsOXNZT0RhWGw3N09PWEN4VVhudzBYQ1hCZ0NVeHdNemVFSGJl?=
 =?utf-8?B?d2N5aGViVExjRkhQWWZoeDBVMytxMS81ZHFCVXUxWHg3ZEdMVHduNk1vUzdJ?=
 =?utf-8?B?UkZnRUdGTDUwUCtsUEtqblBPRElOd3I3WFhXZFc1dVBSZnNBajROUUlGQnpq?=
 =?utf-8?B?SndJTDZoR0RuVkQ4WGQ2Ulk5VW5wYmxndG9jS2RRZ1JDNjJPamxDWXFNM1l6?=
 =?utf-8?B?UDErZ21qUkJGQ2wzbHlQSU9WTkk2cVlJaitQUTRoUjV5dHlrYTR6N0NOUG1N?=
 =?utf-8?B?S1piUUhrNFkyV1dFL0ZIbmVlNkpnZGtWTStMaDBJbGN6M3lVN3hVaVBJeHhU?=
 =?utf-8?B?eVFGaHFSSEQ0anpKU293TGF3SGtYL0hMN3ZZUGtmdms0THg4SVlQSFNPYXhp?=
 =?utf-8?B?R0hUczlBMFYwYXQvSmx5NXdrM242TnJTaVJDM2JXVndzZDBBb3o2Z0VzY0hh?=
 =?utf-8?B?TWJnQkRFdHUzQ1M0Wm1lemt0Y3VVMWlvcHJlOUNjMERsTGNRSTZnYy9tUUs3?=
 =?utf-8?B?eUJFcEFscndlRVViNWlIcVYyZzZFTW9WM0NDbHE0RHU1UnJCbjdpUzcrUytL?=
 =?utf-8?B?T2ovMERMRGVabkNNYXJzZnh2akdhLzE2ZzE0K01xa3hIcnhJeVhOUm40R2RH?=
 =?utf-8?B?bUQyMFduVVlwajRJUEp5MTFJRHJsZnViVjZaZVU2SHpCZnBQYnZOazlkTHVy?=
 =?utf-8?B?SW9IMDBpc29JZWowd1Q4TS9vWSs1WFdvV2NCNEV0MWovS0p4bmI3dkVDaFJm?=
 =?utf-8?B?cWkwZzdaaXpFMHlnYTlVNG13N1JDcTQyZGFSaVdHZUUvQklMWk43U3QzZUYy?=
 =?utf-8?B?cFNLMUhSN0dOd0MyNmJMaEVXV0lLcGF0WVlMdHVWdFB6MGhTL25VVlRVak9G?=
 =?utf-8?B?S2l4L3ZCK0NsdDB3ME9KNUk1VmdFUnBmYkVJWG11RGZ4WjhRV0RHNGZISWFX?=
 =?utf-8?B?L2RxTFRhVk9vakVpUi9udjlsY1lYdW1yRFVaNEhqQlFJWjg4RG5jSFJhQjZL?=
 =?utf-8?B?NVZqdjRRSW5WekxMTG0rUkcyQmdaOGlyVWJJR24rMmdIV0kzSWlHOXZSbGlR?=
 =?utf-8?B?ejRkWSt0Z1pQZnVZZUREV0gvajJHakF4S2d5aXdUc25YVlduaG43ZFVKRUhI?=
 =?utf-8?B?M0FORFJ6aVN1ZlFESnMycmNhYnNDa3NsemRBbElrTGNoKzhFRG84ekNZaXBZ?=
 =?utf-8?B?Z3F0dzF0RU5Xei91djBrL3R0RHRjM0FEWWs5R292Ung1UzJZY243K2tBZTVx?=
 =?utf-8?B?eXh1ZTRrM2JVL2JWbmVCNFVSbUtBZlpxSTBwQVl6MEpjQWZXT0tsY0ZRc0VE?=
 =?utf-8?Q?SL2dO7yauf4TE5DIHEek9AKXb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1514b4c7-0993-48fc-f413-08dc3ea47ee9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:45:40.5882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N2/6bFJcJ9Br95txxNsdTL3odjr1TZNblHh9vWQyFKiIRR/6AY+lh3EZYgvdtdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
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



Am 07.03.24 um 13:01 schrieb vitaly.prosyak@amd.com:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> The bug can be triggered by sending a single amdgpu_gem_userptr_ioctl
> to the AMDGPU DRM driver on any ASICs with an invalid address and size.
> The bug was reported by Joonkyo Jung <joonkyoj@yonsei.ac.kr>.
> For example the following code:
>
> static void Syzkaller1(int fd)
> {
> 	struct drm_amdgpu_gem_userptr arg;
> 	int ret;
>
> 	arg.addr = 0xffffffffffff0000;
> 	arg.size = 0x80000000; /*2 Gb*/
> 	arg.flags = 0x7;
> 	ret = drmIoctl(fd, 0xc1186451/*amdgpu_gem_userptr_ioctl*/, &arg);
> }
>
> Due to the address and size are not valid there is a failure in
> amdgpu_hmm_register->mmu_interval_notifier_insert->__mmu_interval_notifier_insert->
> check_shl_overflow, but we even the amdgpu_hmm_register failure we still call
> amdgpu_hmm_unregister into  amdgpu_gem_object_free which causes access to a bad address.
> The following stack is below when the issue is reproduced when Kazan is enabled:
>
> [  +0.000014] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
> [  +0.000009] RIP: 0010:mmu_interval_notifier_remove+0x327/0x340
> [  +0.000017] Code: ff ff 49 89 44 24 08 48 b8 00 01 00 00 00 00 ad de 4c 89 f7 49 89 47 40 48 83 c0 22 49 89 47 48 e8 ce d1 2d 01 e9 32 ff ff ff <0f> 0b e9 16 ff ff ff 4c 89 ef e8 fa 14 b3 ff e9 36 ff ff ff e8 80
> [  +0.000014] RSP: 0018:ffffc90002657988 EFLAGS: 00010246
> [  +0.000013] RAX: 0000000000000000 RBX: 1ffff920004caf35 RCX: ffffffff8160565b
> [  +0.000011] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8881a9f78260
> [  +0.000010] RBP: ffffc90002657a70 R08: 0000000000000001 R09: fffff520004caf25
> [  +0.000010] R10: 0000000000000003 R11: ffffffff8161d1d6 R12: ffff88810e988c00
> [  +0.000010] R13: ffff888126fb5a00 R14: ffff88810e988c0c R15: ffff8881a9f78260
> [  +0.000011] FS:  00007ff9ec848540(0000) GS:ffff8883cc880000(0000) knlGS:0000000000000000
> [  +0.000012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000010] CR2: 000055b3f7e14328 CR3: 00000001b5770000 CR4: 0000000000350ef0
> [  +0.000010] Call Trace:
> [  +0.000006]  <TASK>
> [  +0.000007]  ? show_regs+0x6a/0x80
> [  +0.000018]  ? __warn+0xa5/0x1b0
> [  +0.000019]  ? mmu_interval_notifier_remove+0x327/0x340
> [  +0.000018]  ? report_bug+0x24a/0x290
> [  +0.000022]  ? handle_bug+0x46/0x90
> [  +0.000015]  ? exc_invalid_op+0x19/0x50
> [  +0.000016]  ? asm_exc_invalid_op+0x1b/0x20
> [  +0.000017]  ? kasan_save_stack+0x26/0x50
> [  +0.000017]  ? mmu_interval_notifier_remove+0x23b/0x340
> [  +0.000019]  ? mmu_interval_notifier_remove+0x327/0x340
> [  +0.000019]  ? mmu_interval_notifier_remove+0x23b/0x340
> [  +0.000020]  ? __pfx_mmu_interval_notifier_remove+0x10/0x10
> [  +0.000017]  ? kasan_save_alloc_info+0x1e/0x30
> [  +0.000018]  ? srso_return_thunk+0x5/0x5f
> [  +0.000014]  ? __kasan_kmalloc+0xb1/0xc0
> [  +0.000018]  ? srso_return_thunk+0x5/0x5f
> [  +0.000013]  ? __kasan_check_read+0x11/0x20
> [  +0.000020]  amdgpu_hmm_unregister+0x34/0x50 [amdgpu]
> [  +0.004695]  amdgpu_gem_object_free+0x66/0xa0 [amdgpu]
> [  +0.004534]  ? __pfx_amdgpu_gem_object_free+0x10/0x10 [amdgpu]
> [  +0.004291]  ? do_syscall_64+0x5f/0xe0
> [  +0.000023]  ? srso_return_thunk+0x5/0x5f
> [  +0.000017]  drm_gem_object_free+0x3b/0x50 [drm]
> [  +0.000489]  amdgpu_gem_userptr_ioctl+0x306/0x500 [amdgpu]
> [  +0.004295]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
> [  +0.004270]  ? srso_return_thunk+0x5/0x5f
> [  +0.000014]  ? __this_cpu_preempt_check+0x13/0x20
> [  +0.000015]  ? srso_return_thunk+0x5/0x5f
> [  +0.000013]  ? sysvec_apic_timer_interrupt+0x57/0xc0
> [  +0.000020]  ? srso_return_thunk+0x5/0x5f
> [  +0.000014]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [  +0.000022]  ? drm_ioctl_kernel+0x17b/0x1f0 [drm]
> [  +0.000496]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
> [  +0.004272]  ? drm_ioctl_kernel+0x190/0x1f0 [drm]
> [  +0.000492]  drm_ioctl_kernel+0x140/0x1f0 [drm]
> [  +0.000497]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
> [  +0.004297]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
> [  +0.000489]  ? srso_return_thunk+0x5/0x5f
> [  +0.000011]  ? __kasan_check_write+0x14/0x20
> [  +0.000016]  drm_ioctl+0x3da/0x730 [drm]
> [  +0.000475]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
> [  +0.004293]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
> [  +0.000506]  ? __pfx_rpm_resume+0x10/0x10
> [  +0.000016]  ? srso_return_thunk+0x5/0x5f
> [  +0.000011]  ? __kasan_check_write+0x14/0x20
> [  +0.000010]  ? srso_return_thunk+0x5/0x5f
> [  +0.000011]  ? _raw_spin_lock_irqsave+0x99/0x100
> [  +0.000015]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  +0.000014]  ? srso_return_thunk+0x5/0x5f
> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
> [  +0.000011]  ? srso_return_thunk+0x5/0x5f
> [  +0.000011]  ? preempt_count_sub+0x18/0xc0
> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
> [  +0.000010]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [  +0.000019]  amdgpu_drm_ioctl+0x7e/0xe0 [amdgpu]
> [  +0.004272]  __x64_sys_ioctl+0xcd/0x110
> [  +0.000020]  do_syscall_64+0x5f/0xe0
> [  +0.000021]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [  +0.000015] RIP: 0033:0x7ff9ed31a94f
> [  +0.000012] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
> [  +0.000013] RSP: 002b:00007fff25f66790 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  +0.000016] RAX: ffffffffffffffda RBX: 000055b3f7e133e0 RCX: 00007ff9ed31a94f
> [  +0.000012] RDX: 000055b3f7e133e0 RSI: 00000000c1186451 RDI: 0000000000000003
> [  +0.000010] RBP: 00000000c1186451 R08: 0000000000000000 R09: 0000000000000000
> [  +0.000009] R10: 0000000000000008 R11: 0000000000000246 R12: 00007fff25f66ca8
> [  +0.000009] R13: 0000000000000003 R14: 000055b3f7021ba8 R15: 00007ff9ed7af040
> [  +0.000024]  </TASK>
> [  +0.000007] ---[ end trace 0000000000000000 ]---
>
> v2: Consolidate any error handling into amdgpu_hmm_register
>      which applied to kfd_bo also. (Christian)
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
> Cc: Dokyung Song <dokyungs@yonsei.ac.kr>
> Cc: <jisoo.jang@yonsei.ac.kr>
> Cc: <yw9865@yonsei.ac.kr>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>:
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 55b65fc04b65..f1618a65f9b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -129,13 +129,23 @@ static const struct mmu_interval_notifier_ops amdgpu_hmm_hsa_ops = {
>    */
>   int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
>   {
> +	int r;
> +
>   	if (bo->kfd_bo)
> -		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
> +		r = mmu_interval_notifier_insert(&bo->notifier, current->mm,
>   						    addr, amdgpu_bo_size(bo),
>   						    &amdgpu_hmm_hsa_ops);

Since we don't return any more we now need an "else" here I think.

> -	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
> +	r = mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
>   					    amdgpu_bo_size(bo),
>   					    &amdgpu_hmm_gfx_ops);
> +	if (r)
> +		/*
> +		 * To avoid call mmu_interval_notifier_remove with
> +		 * RB_EMPTY_NODE(&interval_sub->interval_tree.rb)
> +		 */
> +		bo->notifier.mm = NULL;

I think that needs some other information, especially 
amdgpu_hmm_unregister need to be mentioned.

Something like "Make sure amdgpu_hmm_unregister() doesn't call 
mmu_interval_notifier_remove() when the notifier isn't properly 
initialized.".

Regards,
Christian.

> +
> +	return r;
>   }
>   
>   /**

