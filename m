Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFC1C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 06:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF642112564;
	Fri,  8 Mar 2024 06:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m8YVQSmj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABD0112564
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 06:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeNGKVHkwuQRnE/I90wA1WPbrcs4FuapgKp8RX27eJglH5XEiQUuuZkACmMzvllZUbbZKTpzHhG47o0BosO5sReaW89z78KTejKV+M9YMNNZw0zYf3AniRz5EsHCjIqzhOqU/J72nygwGlvYZAZcoQmoYGHyGkGh4FuHaFCnCSF1ssWE3eZM45KSeT+dndclDuPZblOUZeKYWK+tuaRSQaCiPmV1O72SNE8Qy3B3ycbpWHYJ72wsLbv4jborjefmXhbiYPfAmZ/j77JZ4cslvFjHrpbodbx68/q2aUwam4w0FBg8RQHorshCoKuJcbZsVp0KwPYI0RClEkVQ7scbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5TSHoBWwen/Gwnn2x2wu9W5SFcU3EUhIlkxUt6/Jas=;
 b=c29idtQCjmWrbTqzxAoQaq0Lkajx5vKhIEImCSbMnVJFrPWP5OiSZ++t7SFN1ADLjUgVUXB06VfYwEOZ7D1f418DEyQyt4vg+F0+KChLfiDDNrk4ORsz8FeBARWQkfx5QVBtQ/Gm0L1q2DoL6++O+poIna4CkeBrDysLEYbr2E99ovieiWla/Gd9sGb5rx53FkrZHNqKyxXWiz5B9N3cg3RbPSCL0+67KBRSAQoYnbuJyN+D0P3YTSK9+IeFCY15kF1RuIaDKxbQ8dn2WJHyKxOfi3SC75QHuz3mwU+x9+CbNxhCI8MlyXsToe89VpAX79n478viYgZ/I4L2aME6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5TSHoBWwen/Gwnn2x2wu9W5SFcU3EUhIlkxUt6/Jas=;
 b=m8YVQSmjQGthYUT06amrC0aYSc3CENxihYHn5aBIWjYOZoaghEgvRxLZWa/4Y3rWOlyAKOxyEx4pfVkfUe24LylRaKYAOxpri2qyecoRqj2Efb6fuPUEDBE4D0jybpJLJ1ZNDJDyoX2zXzYRTKLVpqJGWCNW7yY78n47Reer5mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Fri, 8 Mar
 2024 06:32:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 06:32:24 +0000
Message-ID: <362a4a44-bab7-44db-9557-4bbc2f678fab@amd.com>
Date: Fri, 8 Mar 2024 07:32:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-free bug
Content-Language: en-US
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Joonkyo Jung
 <joonkyoj@yonsei.ac.kr>, Dokyung Song <dokyungs@yonsei.ac.kr>,
 jisoo.jang@yonsei.ac.kr, yw9865@yonsei.ac.kr,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20240307162647.167094-1-vitaly.prosyak@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240307162647.167094-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c966d9d-d8a1-468c-bdab-08dc3f398442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/hND/OS1I2qchN/uiJjoSJutM+Hjun/3izSgi6sDsAsMqko8Q+4AC8bKClk3N4d/QVCZgVY9S60pLKvQ5oC3f3oyd5FkHViM3QVzD24pJpRiTPf8G4S/eqsM37HOA2WoZI3zeckptvMUCxBqKNYjKA0AKCTBrgXeGShZcH5QGXmmoWUd1hOYW8D8iDXZsHdgw+eZpUR/9Ev+CBvZgtYajOZxkZKQNz18kksbAJznBgglKl1sa6z8obw5pfmovgkuq/c4518B7RJmM4kv8hwlXBYIUQzGpqCU44pKKV1u9yP+YpYXi3baKo+SHinTnI5gX1T0NxVd60yPptDdX8yd/5qJVotsfOK61R6KpqwRCHPf3rNKQCCCEZX7CIjfd5JZERx7vn0eqNR4hf8YE6r2DtXgybJnGuyxh6wpVKFwZJNBlBG7NDOvJIcuOyIdenqhNwaDJqmoEbdTU1VrJlWKyb5F9We8uQKm+CDoOd8YnSO78h6Sg+BDBd6g8LebS7oL1sKwN4YaWIC2JliML3DbQ6vfeQIdo6EilDI8Tsg7Z6tiDg715URF8FYJbdD5BcxCLL3VmxvS3oE9hxNr3Li+yBy+4J0Y/HYYnVTmAz0eMrWt9MSCP3MpkeiX5qspCwKmKxYS/Z3p1cA9kHsQeuxacfUPTP8CLZDJFJuy2jV60w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5xVWVwMHpzMnB1V0FOYXdSQkFwei9ibHlmMU1rVlNBTXM0VFBqNXZ5dnJU?=
 =?utf-8?B?MEdwdlpiektzNlFHTFIxMnVXYmdaQTNScSt2emw5dHYvbjVmeHJDQnlnYVJN?=
 =?utf-8?B?WU5OcjhMK0l0b0lsTjlEV3RKaXZMbXo0bWw0Yk1ocGNnM0ZKZmdXdDE4RTJK?=
 =?utf-8?B?bjhNYWxDYUo5R1pmZmpyTjhrTWx4dm1wYU5TdFdFbktCSHpLbnZwSE5jZnZR?=
 =?utf-8?B?cU05K01VY2YxVlROT1RnbEpWajVBU3BKakhUSXhLdmYrVHFPelFHd0U0U3VD?=
 =?utf-8?B?T0tCcDRGd0tlMGZXZXl4REVIeVVnZzVzdDNGRml0ZnBXUHRhdGxvd09uMEgr?=
 =?utf-8?B?Tlg1Z0htWk1MZXcxa0ViSGxEWVBZU2Vnb0lrVUtJZWsrbnJORUNqV0twY1Iz?=
 =?utf-8?B?eDJHUk1XMFhQS2pXc04vUVlZTVBCdXhOZXZWN1BqNytvR0V4dU41QTdGYW5m?=
 =?utf-8?B?bTA2MnhIb28wakZFRTBWRlBMaTVSSC8yVXp6ZjZHSjZJZjVlMnllOVFQMHlJ?=
 =?utf-8?B?YW5pQUJKRmNRVGRNdTdQQWMxYU4rQTJlWGVUV29XUU5QMUlLZ2xvK0FhNnZI?=
 =?utf-8?B?R1I5Rzd1dE12RUo2eUlwUE5Wd25oNk9KSVVudFlQa2FKUmw3a3pqd3M3WlhG?=
 =?utf-8?B?TVhNNHB0SWQ4M0ZHc1FwZzdMRjZvRkwxTmpWcHRpbmxIUXVLeWdKTkhrYldD?=
 =?utf-8?B?dTh6NzRyTVQrUkZEV1dsT1g1ZDhRQ3puY3pOK0xQT0VycjFQVGRJbWNaRXpS?=
 =?utf-8?B?Y24zMkwzd1RQV281UmFOR0NTaDFRYytpRTUvRHo5ZzFiV3NTQlBvemlrNTla?=
 =?utf-8?B?b241TGpWUzV1bWc3aUxSRXBDWWo2NkM0OFpWNWUvTUdHSDcrK2VZNytTK0k0?=
 =?utf-8?B?Q1hVdUV6WTZrcElrcVl1enFxREQxa1JZdE9RZXh5aHhYRzBEaENJaDV2WDdq?=
 =?utf-8?B?V1N4ZUd3OHhuWHhycWtiSUJjVGx4aUhzWDd2WmF3VE4xNXNYRkhlYUROcHNx?=
 =?utf-8?B?ZWJ2aEdYZGFkL1NMUG1VK2lFL0NEY2VSaEoxYkdWZlJpR2JhSmpkazY3dThF?=
 =?utf-8?B?Z1RFRlBVcUdyYWcvd3NPUmttV2hsK1BRTHZUcUxzVkJ0b0ZRSnJtbDBNTDRS?=
 =?utf-8?B?K3lFNWYxMEgvb3FWemVNcW9yQWZZRWh5R2xLek81d1htVnV3WmI2VERqZUtR?=
 =?utf-8?B?Z3NoNk43UGg0YWZsMUx3UkdFSjU0ejA2amxjR09Ob3VwQ1ZPT25jR2FBL1dx?=
 =?utf-8?B?dmFyWW82ckVvSVk0ZkVwRUJCU0l6WXNadG1SaFVxTWtZQVFDNitBYlBhVUlL?=
 =?utf-8?B?aUowVnZ6a2syRllIdGxyK1gyWjRndllMZGtnVVRlMTZ3dWt6NGUzamZ4bCs1?=
 =?utf-8?B?SUZzQkJzdzljeW9ZaWtlZjdubFdFYnFTdVlFTkpVUFdWZThTN2NraFB0ekxJ?=
 =?utf-8?B?OElvVk1kaVl5cjVRdWFlQWlaVGZHOU9WWWJENUVmWW4wWXR4ZjEvUm9HVFR1?=
 =?utf-8?B?WkFNQ2RUOEdTb1dGZFo0SGk4RWdZOW1IcWp6dXczOGpOUjJrdEtwRjk2eDdO?=
 =?utf-8?B?UGEvNlVhK0Z4S0NqWFZQQ2N1cEo4VGF3dFk3WjdvZ2ZwcXlPOHFZWFVqbU56?=
 =?utf-8?B?NHJzLzdBMUN1SnhLTGtua0FKYUtON0t3RjRFc1dkZ3MyNzlpRHBTbGtnOUYz?=
 =?utf-8?B?Y05ud2I3MlhLTk9VSzIwNGNzOXA5Y2NKbnN1NFkrUU40b0EyZTRpbG4rOHBU?=
 =?utf-8?B?TnBIRFZvNC85MXV3V1JyVUp2Q1I4bXBsblpYWUNzY3ptaWg0UGlwTENQdUhm?=
 =?utf-8?B?K25GbzVTaHYyQ2pRVjZBVnRYT0pOR0M0SzdwZjJ0TjFzMDhmQWtNeCs4YXRo?=
 =?utf-8?B?MUp6RlRYdHFqU2lJZ0NNM2paaml4TnJ6UDJMbU9oYmhXUDR6d0Rhelczc0R2?=
 =?utf-8?B?UmZubndDbE9qQXAvbHZicytISk4zQ2xMa3Nzc29zRS9Hbk1zMUYzemcwY1FV?=
 =?utf-8?B?R3N1K1VJS2FBYnZndGZGNmxLNDFKSE5LWVp6OW54UVkwM2dsYUZqQVlmQ0hW?=
 =?utf-8?B?U2tST1lBU3g2NDFYaVNyQ1BwY2RsVTVWVHFTWTV6akVsdzRpVUFTOVRkZWx6?=
 =?utf-8?Q?/6bI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c966d9d-d8a1-468c-bdab-08dc3f398442
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 06:32:24.8289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ko87ucI0zizTGoqVRu9P4mxYyS7NKhMNAwETBqKxayDBHrbPJndcCk6fvJp80EMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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

Am 07.03.24 um 17:26 schrieb vitaly.prosyak@amd.com:
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
> v3: Improve syntax and comment (Christian)
>      Add CONFIG_MMU_NOTIFIER since field notifier does not present on
>      some configirations (Vitaly)
>      The build failures are reported by Ivan Lipski.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
> Cc: Dokyung Song <dokyungs@yonsei.ac.kr>
> Cc: <jisoo.jang@yonsei.ac.kr>
> Cc: <yw9865@yonsei.ac.kr>
> Cc: Ivan Lipski <ivan.lipski@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 55b65fc04b65..154db2cf44d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -129,13 +129,27 @@ static const struct mmu_interval_notifier_ops amdgpu_hmm_hsa_ops = {
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
> -	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
> -					    amdgpu_bo_size(bo),
> -					    &amdgpu_hmm_gfx_ops);
> +	else
> +		r = mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
> +							amdgpu_bo_size(bo),
> +							&amdgpu_hmm_gfx_ops);
> +#ifdef CONFIG_MMU_NOTIFIER

You can drop that ifdef, CONFIG_MMU_NOTIFIER is a prerequisite that the 
files is compiled in the first place. See CONFIG_DRM_AMDGPU_USERPTR and 
CONFIG_HMM_MIRROR.

With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Regards,
Christian.

> +	if (r)
> +		/*
> +		 * Make sure amdgpu_hmm_unregister() doesn't call
> +		 * mmu_interval_notifier_remove() when the notifier isn't properly
> +		 * initialized.
> +		 */
> +		bo->notifier.mm = NULL;
> +#endif
> +
> +	return r;
>   }
>   
>   /**

