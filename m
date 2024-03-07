Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D57C54E49
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 08:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C10113416;
	Thu,  7 Mar 2024 08:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S/jVsK3g";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383FB113416
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 08:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuc8pgRAAfoQX4izUCrjqVR2A3ERi0zU3HYL6TryjK3dpvLQ/oBt91rCahLQzWEZMIPP7OrsgakD/v/R7sNXyYx3k4gOnJJS9bxukewya9bi2+9BIgFLy+knG8CjqcpI7EuYJi0en/xTqUIz6qOzmS3igM+j0zE4/uw4vwIykGJwUdSzpcWc0vY89sWa/3QgPT020m037gKiBB+G4o/ofRDOaZn6CLjXgRwmDFNtXHwQ56bdIO74Px3vwHKzhE1oF0wwGzuPJmDI50sfc4BYqzhW5BtCm/+rwvI9/IYfqEnEmsOB9ULmEt/KFysUU9XOCPf47mr4y0usbfe0ovrndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0iNh4MWIKBHqw74fBZRwNEfmxnSAT+qJ9bhyQMmSRQ=;
 b=L39QxxC69aecZcd0LBKFUW44la9XtA7D8lKcpZnyA58IQ2QSaMecdN6GjdcpFUlOsQRDFKWB7jmO6oN4EAgmtb4H5xkHbb35Wv1+CzHkBdeLQwRIux59eLoRl/OjlTJXQ576apQ2CyvxirMjBsF7bLIlz5puf2jTk8kyKzYyb++Xidu06NXPbKh5LLgjN90VUFBUzg8RFCf/T6JcwzI9GSEagjuA/tFYLyJpCpozWOpdSmbyF23gvg6X+uYkALsEG8iICidfJ817eLqk6ejVPQ3sf521bZyxy8ZLTeSF7l8OPSOB8Zdw3PyGhoXNmCXnrPPeV8QmDWU52I8Hl5FT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0iNh4MWIKBHqw74fBZRwNEfmxnSAT+qJ9bhyQMmSRQ=;
 b=S/jVsK3gkWlBOxGPy8qZE1jNKRZeX0p0xf6Gbr/uiDHAHV18ZDy+sQNw691zmq0XQfaPF3Lc5Vvq0zS3gNLYsZhZ4pVQC1w0FRB/tP6pliSfV48z0szqDMS5RahodG4uYf9XQeD3HB6jOzqJONdKod/qOdpLb8QzKIST9lG8pHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 08:22:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 08:22:24 +0000
Message-ID: <dca6550c-1580-46b6-8835-219f8dbfa4a2@amd.com>
Date: Thu, 7 Mar 2024 09:22:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-free bug
Content-Language: en-US
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Joonkyo Jung <joonkyoj@yonsei.ac.kr>, Dokyung Song <dokyungs@yonsei.ac.kr>,
 jisoo.jang@yonsei.ac.kr, yw9865@yonsei.ac.kr
References: <20240307015557.21005-1-vitaly.prosyak@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240307015557.21005-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0198.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a3b39d-cc1e-402f-0b47-08dc3e7fb7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idY+gVz5fMWtxAp+1KOeJatn0mIOEnwcb8dhdBWOtnpLGMTJCnzF0OrbLxaTlxKX4WOqkM2sm21OKkzBgwriWTF/ZKjCBJ9U7Kjq2r8W1RnHFewaCawO5H/sdmkec7fHwVtDErNN4TD7cTCVEpInaZLWYUxwi9+obJRJPK+ZFbFoiWvjvoyIkcQNew+j6rSC/FmoqwwnXT96hCf78yt1r9SMD01g/ZMRzlX+nLTHIyAWQLBcVDp4Y3B6krsnB5sswN9n//YS18kFQmRcENE0nEZ6MtEKiARn/znQeQ1/syjwdANh2UmTykR8r7ztUXJlaOlgF9WDYRciBY8B/EoRkv6pPnhoMdRDh9tbyMABoemVmqJ0mldEE/dai8kqNcIRnMM41tWmpO5FqnSPO+7Vu3RHjHX2uXUIW+sRFR2QXacQwKAfcGgZNNks9wSZIr+T1nAG5t+wOHxM9b/wJjXvvjywhaMaKDLRv/lNc+38RbWumd3k2IG1LvXLWIDlL6g8S5rSyyfR7yE2rKQ5Fr+sEFHkGaJoNsiBVMEC5RI/ReJuns/IuY3smnc2YfqFtxrjMpopg5g6Nu38KhNus4pDhzWzuJ5noj/+DRyh5ug3dixLZcKYL6zzzyTZg9OXvRHQUudlSRNHdFDFI42fXDtm7RE0ppMMsrPTOnYl4CKAr48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjA3NW0rempXdG1BTXBWeVJFc0daL2NEWU0wZHpENnZNejJTS0FxQ1hPbks4?=
 =?utf-8?B?K21jVHVQT1c4cThCOUY2S1lSekNRUEhrVlEzVUhTSWxTQjROajc0Q29paEdZ?=
 =?utf-8?B?cUsxWTU5d2VlR0NmQ3FOb0VuRjJEeW8zNWh5SUZMaVBHOHNGeE5TSmRMMk9o?=
 =?utf-8?B?Tm5VdDFhS0FwamI1clYxaDg0M21Fd2EzbG5JVXYwK3lsbmdsSkdIN2RaTWN5?=
 =?utf-8?B?c0FRTFJheUpZM2ZoY0sxYXA4ejA5aysyS3VRNjFqVFI4MlZwbytqQjlHNi8z?=
 =?utf-8?B?aTFCMnovWUs4cFlRRCtrT2lveWMrSndteWMxU1liMjNKenE3bytKVTUzUGtD?=
 =?utf-8?B?TTNUQW4wN3BUNEpSVnlqWjJISVV4aWdHeGlYNVF3RVBCK2hTK3Z3QkNRREZo?=
 =?utf-8?B?Vk1TSVBjVUsyUWNhcUFYWTlMbDNNeGtyNDlBMlJCNnhvWkxCaUl2R0pWaUJT?=
 =?utf-8?B?QUxmWXJqaVVQNktNNjVHWXdVQ3pCZ1ZQZTdkYkUvdjJXWk9BRHVnWFRtU252?=
 =?utf-8?B?ZWhKN2N6SVE0ZElNUHZQT2tWdkQxTm81QmNDQjhvTldCMVVxaGRjcCtXd3BC?=
 =?utf-8?B?RENwN1VvNmUwR3pmZms0OUdBbzRNOFZ3bGk1MnFHaWZnMDZNRTlZN1RUMThZ?=
 =?utf-8?B?T0N4cElhTFo3OXIrYjR6WkFOd2FYZ0Qrblc4Y2FNTXFnOTk1RmZSRy9FdFVP?=
 =?utf-8?B?MEVCWDZia0wzSUhEaW9WNnFncHV0aXMwYjJtaFk4T0l4TGkwRndWanA5TGMx?=
 =?utf-8?B?OG1UaDRZamxKUFc2end4VTVWUGZ4SllQTk5MNENpVHgrS2ZpUlVZY3oraVlt?=
 =?utf-8?B?ZlUwcFBSdGRreGVWQjZKbW5zWmhsYUp3QkpKY0dTUzgrbG15R21QaEIvUXpO?=
 =?utf-8?B?UnV1ZSs2bzBSalhhekpQNm84MzRJN295OFBEUlF5dmVmdmN0RDlUQ2RUL0pI?=
 =?utf-8?B?Q3BZRi9uUG5RYUZ1cHB4V1gzbzd5K1o2QzNHbGlZdnB5aWRLUVR0Wlk3Y1Yz?=
 =?utf-8?B?ek1JN3FRZWlGdU5HM251RE9IbUlYK2tCc1d0M2FEUkR6bkFFamx2SHh2N2tl?=
 =?utf-8?B?NHU5UDNoNW93UlFkTG0vMG5LUkRvSUU0bUdreG5HNStHb0w2YUs4SU9IODY5?=
 =?utf-8?B?RGlCbmthVCtraEhRaG9YQWhqZUxMUEM1dlZmMmlwYXVPb2dVc05lc2Mza2Fa?=
 =?utf-8?B?ZWZoelpscVhLQmw4OUMvQzZuTnU3S3BKeTFtTjE4R0xpb3RxL0FUbG9VY0pQ?=
 =?utf-8?B?enJxWWx0cWEvd0tmbnNlMTdHa01jaUNOWHdLYmpEd01qVEpDMzQxYVhnSHVL?=
 =?utf-8?B?cFBJMVlHUnIzenBBWjhOT0FFRWNjNzRHQTUwVGtGRUNMTG91K1BOc2NxSEhY?=
 =?utf-8?B?NkVGV09jUFhUbW8yT2NCK29PY2pLdXhwS3JTd2pra2Q4WlRISzdJcDJVRWJU?=
 =?utf-8?B?MWRGR1NrYmtITWh3Z0EwNEZrR0padWovWXJaSFB3Z21tMElFVnV0L0JCNU1v?=
 =?utf-8?B?WWZCOUhTa0RsMU1LYURMUWVaYW1SMHJ5c1czUmR0RkltbVFIWkxSMVRWSU1q?=
 =?utf-8?B?RVAzVzVyeTdSZ1V4NCsreUVuMXB2QTNORm55bGtEdm80Vmp4Z1lpajNDOUJi?=
 =?utf-8?B?K0N1cjN1bnZSdE1JdlVJOGlpNGVleHd4UGNyaG9HUGZaL3czRVRVQjUyMDRi?=
 =?utf-8?B?SWk3V1pXS1ZTRGNKcDAxODlIOW1BQ21OU2lObDRQTmtsM2Z3eFcrakFoZGZY?=
 =?utf-8?B?aFdvcktrb1ZTRzF3MHhRNDNzejAyY0ZhZUw1R2p1WGF4SkdlUFlWNXJRQncz?=
 =?utf-8?B?a1hEN1dhZzE4UDFpSER0QTl4bU1JL3RPanJSTFZ3a0NQN053VFdXN05nMk5G?=
 =?utf-8?B?ZjNTaGt5amFiTlhYYys5dmxBcVhxTmJLUkMrbk5iT3ZFKy9rb2JLZ3ZEZU5K?=
 =?utf-8?B?MW1LVUJGRVlhQmFsZnRCZlg2WUFEeVVMSmZPQzk0Tm1FQ1V1MlFZVS9ua1cx?=
 =?utf-8?B?L09KU040YnJ1TDExWnJQR2hpbW5FVm9ZT1NoWUZ1TVJ4YzVGcnRwc0cvNC9Z?=
 =?utf-8?B?VUU3b2s1dmdLMXB3dE1McFhwUld0aG1nRmptZUw5aTB3V3o5cEZaZEZvR2xv?=
 =?utf-8?Q?Ul6egAVnYChFrcSnAlBDRNJks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a3b39d-cc1e-402f-0b47-08dc3e7fb7d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:22:24.6724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyLTyD9APorONkM3RYEcuLW/0lbX6KPnw1xClRF7OG2mdphr24TNe7BdZPx6W+eb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
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



Am 07.03.24 um 02:55 schrieb vitaly.prosyak@amd.com:
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
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
> Cc: Dokyung Song <dokyungs@yonsei.ac.kr>
> Cc: <jisoo.jang@yonsei.ac.kr>
> Cc: <yw9865@yonsei.ac.kr>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 9 ++++++++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index bf8e6653341f..d5bc302b3bb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1068,6 +1068,12 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   	if (ret) {
>   		pr_err("%s: Failed to register MMU notifier: %d\n",
>   		       __func__, ret);
> +		if (ret == -EOVERFLOW || ret == -EINVAL)
> +			/*
> +			 * To avoid call mmu_interval_notifier_remove with
> +			 * RB_EMPTY_NODE(&interval_sub->interval_tree.rb)
> +			 */
> +			bo->notifier.mm = NULL;
>   		goto out;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6bbab141eaae..644a9cfd7758 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -453,8 +453,15 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   		goto release_object;
>   
>   	r = amdgpu_hmm_register(bo, args->addr);
> -	if (r)
> +	if (r) {
> +		if (r == -EOVERFLOW || r == -EINVAL)
> +			/*
> +			 * To avoid call mmu_interval_notifier_remove with
> +			 * RB_EMPTY_NODE(&interval_sub->interval_tree.rb)
> +			 */
> +			bo->notifier.mm = NULL;
>   		goto release_object;
> +	}

We should probably move this handling directly into the 
amdgpu_hmm_register() function since it is amdgpu_hmm_unregister() which 
depends on it.

And every error should probably reset the mm variable in the notfier, 
nut just -EOVERFLOW and -EINVAL. Apart from that nice catch.

Christian.

>   
>   	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>   		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,

