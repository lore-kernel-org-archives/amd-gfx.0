Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59492C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 03:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9576610F006;
	Fri,  8 Mar 2024 03:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x7Ne3hpj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B11E10F006
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 03:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge8qnL6dKx3bRfaJcnzZk7+jOZZ7r829FbhQu61bCfgvUBP0TEbUZ03AFY7Un5fy4FE5OY7ppSxd+gMgX5MWDubPScYXLeZOliV675Y7MC8012vQ5d17QHF52P2DYH9CqlnGZJjK7b7o2bzhOVMNbSDZtmkgOeENkYnSPOrTUy+XwK7lrd57jTYPtrdl1bgSFe89imMMl+u1PyDEqFdOncvZW4gBfrPRwwozWlZnnXKFwo2N7rOKBcnSmGzh1B7vNPOZrzC0juX+WBMZ4YbMKYe6PR1tB/SfJGxRy4pr/xYuHJwAR/VG08JlwuEQ2uUduHnFUS8Hpe+JUr5ZrSXNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnF1029rWoM/kAeiwO9SznGuHwgoTsgCoYkN+nkTCK4=;
 b=PWwUopExFM8eeMMkp9inLp1tPerjsbela4cbRQDlyfy+R+aMbEuRlnQnJlXZaeIBsXMpW7fsHnoh6wKeFvz0KQOaoli8m42F1U38FL2NW17Qv6XpnXlI3kfnJKiXjphRh0oL1PnpZjXuifSASGzaKa/BEJTF/noRJtykCpha74A3WfqQqEcVHHbGfyLFf0rMU8/jealAXbHorxYVb/pA0+hDu6aF749uQ+MJ/Rg+i3xkd5zyElcLERcKhhYeRLiu/kXz4XpHthUSWvtL25ozrqlyk52G6UeHGglPgn9EHP31vCcicyd47+P0nIQFW4qY9lRlaPfcYBbBW7rKCNa1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnF1029rWoM/kAeiwO9SznGuHwgoTsgCoYkN+nkTCK4=;
 b=x7Ne3hpj1KtAK1ZFjb6XoNLQeJMz2uPkIYjNbTEOeUvviwNUG1+4M0jlb6wu7FJhoPSf4mtxHFWqR00O1WIiqznrRA+8Ix58XsdeuNWe6xl49yN8VDUZZ8JIIGb60sF/SsGAkDsObMRxpWB0WqyeFbg59Q8cjrKt2kZNq5kAFHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 03:45:08 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::ee1b:768b:715f:e5b5]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::ee1b:768b:715f:e5b5%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 03:45:08 +0000
Content-Type: multipart/alternative;
 boundary="------------0GD7g8qI8zKHTtPcD4QH78iX"
Message-ID: <f3cb1403-6822-44b2-95fe-ab5f50ca3736@amd.com>
Date: Thu, 7 Mar 2024 22:45:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Reporting a slab-use-after-free in amdgpu
To: Joonkyo Jung <joonkyoj@yonsei.ac.kr>, Xinhui.Pan@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Cc: Dokyung Song <dokyungs@yonsei.ac.kr>, amd-gfx@lists.freedesktop.org,
 jisoo.jang@yonsei.ac.kr, "yw9865@gmail.com" <yw9865@gmail.com>
References: <CAKc8oVUXUHUYQSDYDZ3XqpfwcmOwoxii5+SkyteXoZSPRwshfQ@mail.gmail.com>
 <CAKc8oVU8C-MRVa640603R2Gi7BRZ5P8ZN_uJoruDzR_A8xg71Q@mail.gmail.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <CAKc8oVU8C-MRVa640603R2Gi7BRZ5P8ZN_uJoruDzR_A8xg71Q@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::6) To PH7PR12MB6420.namprd12.prod.outlook.com
 (2603:10b6:510:1fc::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6420:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: beb4d322-66eb-40e6-1d48-08dc3f222662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Z/1N/7nSfx8OUC3ljCBmYqE6UEHFx91rvS4sfS18JZ58mX6qC/XQKPyYrfU8mmtJQ+jO9ZSe9rFAJ2NK0WWXv8gQYEc8PeFfV3b3cWO09KIWg9tIkycy/+ytEHXhnwdHgoPJVK8REzBhLJRQl8XwPaRhm3anfrsJ6fzAWkurneo+TYRNzh14DDVpZNJeKaKTSyu34aHinrh/d9QkUT+ytTcSaeMV4RjlPA166720M4bEgrP5gfqapqHnB0MbvWUNsrfFPB9nlpH92M4a4ozTfOgEid8VdOfmU0rFAREinZOHr+qRTmLZ+cUp3Q1AK4UEcnvhQMAUa/nV4yXgJttDLIY85jtviKYceZay0guwGAe9aXhJhQ+byhSDZPvodVZ6K9rrUuuMWkFuMmHvy7CFuvKX7ntK8LyLpamUfx0kPZK4Y99Cmi13F4flc48oYioygUYFO6jLEwedUlwJ1qZmyV8M2QKXY4cl+420AxHsVeq4t09DjYaBDW28OHNpBf8iV4za/6iBrbDtyaZR6aNrPcAgn0a53M4yXNkYs5pbTQ9WD8S67ESBI06yjCz4p0/OpuX6UNTKecWp0c78ELNFZEsthE8gZ8t9xuBWnoa5DONiJ6t9J8Ey5AJmxxHis6uS6czWA5MxyahpfY2OASlhu0gH1PEm7/uS1D+qZYjPhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1VPd0prc3hGaFZwRkptcVpLRzNKT3JaSUxtT0cwVlkwU0JIay9OZCtMc1Uw?=
 =?utf-8?B?aGNxWWFlSEN3US82NVVnMXd5YlYwVDlGcnU0UEZKeFRYb0pGd3pZUll5MkNm?=
 =?utf-8?B?NG04T0doaGRWaG1OTVNTK1Q1RHhiMmFXb1FUbC9kK2tLYWx5NzRsK3RyMGpV?=
 =?utf-8?B?eHgrZUM1NTdFU1NiMmlHWFM0NHdHNTF5OEVRNkZqWm16V2FONjYzSm1uSXp6?=
 =?utf-8?B?TWYzckpWalMza2tqa1o1emh4clRjblBmS0hLenlkWS9GVm5yOTZ2VUZhL2t6?=
 =?utf-8?B?bVpKNG5jQnMrYitCa2hrUzlkbzNNVHhaaXVtUlpZTVU4Vnh0WnhMajNFbEhm?=
 =?utf-8?B?WEltNEdUNG9zZGJqdTlRVy84dGdxajY5ZFU2dmNYbkJTY2hVcHpYb2hqc0xX?=
 =?utf-8?B?OER5MEFXSUgwZjh2My9qSjQ0bzlkRzJjV1kwYzIvTVg4R29PYStFWlpaVytY?=
 =?utf-8?B?MlpOaGZEU3pCbnNYSlBCWGhycmo2QTN3TWVlNThvZUlzVEdmdzlTTlc5a1hG?=
 =?utf-8?B?d3B0Q2pWeGdRTkpOVFdTcUIzSWtTMDd6Ly96UFZQWkk2aDFJdVA4b2lBNk1E?=
 =?utf-8?B?UGpXRU1XY1h3Y0Jtb3FEb2JiblR5NWRIazJ4MzNGUm5iRE5iOVFkN2g3K0FU?=
 =?utf-8?B?L3MzQ1VOWnpVRVMxeGpWMndPMUZLYmVrVkorQ25VYUt1Z3FZOS96bEMwN0t4?=
 =?utf-8?B?YXA3ZzE3Qm9HcFhjTjZiZU83SEZQK1Jqek5icDdVY1dhV1VOeDh1UHpWKzFq?=
 =?utf-8?B?VmpJelVHb1g4RnRFTVordUVHUHJtOEl3K3B1Q1NSODdDUWxmRjBqQjhnTXhS?=
 =?utf-8?B?dW1xVlhJeTdSRHNJN1Q3U3JUN21TTENVS25DaGNwKzZ3eDdYQkxMS2laOVVE?=
 =?utf-8?B?S3czY25seitnQkxCRS91VndmblNFR3ZJL1Qyb2FqTjY4T2VPRjJQMlRqTmxI?=
 =?utf-8?B?OGlTSjNzcHZ5NW9oWm1EY3N6QStrbU1Bc1hoYVFwSmcwL0ExMzcyOEVsbVJD?=
 =?utf-8?B?ZHV6TjhHMzBJbzRidTdDRW53Y1FmZ05xNVpENzRvd2w2RmszZkx5SGFFdWlM?=
 =?utf-8?B?SjBYbk9TeXBlMmtJSnJrSEQ1Y0tTcVZBYURscmtIdWd5eVRQNkJ6UkI5aVRO?=
 =?utf-8?B?TmwwZ1l3bzNkRlZzUUJCcnQ3Q1ZpdFYzVEFvbXAvL2VNQTVvNXJQTGZld0Nz?=
 =?utf-8?B?czFwbWxCRTJKQzBrTXhLREQwcjlKTk50M25LVmFOeGxwZElXNUpXY00yM2l0?=
 =?utf-8?B?Q21mR0FBeFo5aGlSVjc2QXBqb3lVMFdHcnBjbGV4NVFReFZ6ZGtFc2JyWFBN?=
 =?utf-8?B?YkZtVmdhOTZlb1YvTURLY0JVNmxTZitCME02eWhqekdVT013WklDN0lxQWJi?=
 =?utf-8?B?SElpR09EeWFreE53dGNacVl3MVBOdStzZ2gxQ1d2cjBPcldDbkxwVyt1Q21X?=
 =?utf-8?B?VTZYeTJhNTNlbnBvVHV6RGRLY25UU3AyN2NqaUhZVW5PUkJQOCtyL2Y3aGtI?=
 =?utf-8?B?SXcyM25scC9QS3FHUm8rdnFsOFFTWk9aVm1Sbmw3a3NZOUxOYm5MaFBINTdy?=
 =?utf-8?B?ZjBMdFhWR0M3bENFQXJsemN1YVIxNHdzSmJmRk42d3pCNFgzSzMrMGRrNHFH?=
 =?utf-8?B?cFpLZ2J2RGw3UTJobTJsbWtKcC9SaEpBaDFzejcxTU5yZUpEVzlocHFOU2JX?=
 =?utf-8?B?emJmZW5nbDhWR283K1FjNWhyUEpNSm1zVmt3R1BDdm1ucUgySldFNWNkTGdu?=
 =?utf-8?B?WE42c0xYUVVIaGZUeVYrSUM4dTFrUlVxRUZNUWpMeGNRVi9RemR2TndCZmRs?=
 =?utf-8?B?QTh0c0VQUitRSmdLWlF4YVpCVzM3V3crak0xQmoyd2VIaUNRNndkZFZkU0xT?=
 =?utf-8?B?aEh5amtLT1U0SWdxV2F3cTUveHM0MW5UQVd2RDFrbFZDUkVWVmp3bkJXVnRJ?=
 =?utf-8?B?aWVUcHJDWTBzaFFHWlI3bzFnaThZVmFWaEMwaUZnazRiWS9LQk16Y01rbnl3?=
 =?utf-8?B?OC9jc0dTWGZtcHlJSVRGZEkzT1JBVHZpbmdhb3VSNGxKc1ZuYmtvb2h6Q0Rv?=
 =?utf-8?B?S0xTUmllK2xBbit1dEp5a2RQUWRpNWY0UStZUTArbHBoK3RvWEFkVHpBQnBI?=
 =?utf-8?Q?tfyWEHMG7EetkW57Neeoq2bGe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb4d322-66eb-40e6-1d48-08dc3f222662
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 03:45:08.6521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ol/wevKxVGSgPaqv0127TyBp7bZoJKW4zXfqOBdiwzDv6ZUqCAW3XGreUX0RIbxLXIQqomEvbXsnvYBA30pm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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

--------------0GD7g8qI8zKHTtPcD4QH78iX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joonkyo,
Sorry for the delay.
Yes, sure, I reproduced issue 2 (null-ptr-deref in amdgpu) and I will provide the fix soon.
However, issue No. 3 is no longer reproducible if the recent patch inflight is applied which fixes issue No 1.

Do you see the same behavior?

Thanks in advance, Vitaly

On 2024-03-07 20:18, Joonkyo Jung wrote:
> Hello, 
> thank you for patching the first bug we have sent!
>
> Just a quick touch base with you, to ask if there has been any update on our other two bugs.
> They were each sent with emails titled 
> "Reporting a slab-use-after-free in amdgpu" (this one)
> "Reporting a null-ptr-deref in amdgpu". 
>
> Thank you! 
>
> Best, 
> Joonkyo
>
>
> 2024년 2월 16일 (금) 오후 6:22, Joonkyo Jung <joonkyoj@yonsei.ac.kr>님이 작성:
>
>     Hello,
>
>     We would like to report a slab-use-after-free bug in the AMDGPU DRM driver in the linux kernel v6.8-rc4 that we found with our customized Syzkaller.
>     The bug can be triggered by sending two ioctls to the AMDGPU DRM driver in succession.
>
>     In amdgpu_bo_move, struct ttm_resource *old_mem = bo->resource is assigned.
>     As you can see on the alloc & free stack calls, on the same function amdgpu_bo_move,
>     amdgpu_move_blit in the end frees bo->resource at ttm_bo_move_accel_cleanup with ttm_bo_wait_free_node(bo, man->use_tt).
>     But amdgpu_bo_move continues after that, reaching trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type) at the end, causing the use-after-free bug.
>
>     Steps to reproduce are as below.
>     union drm_amdgpu_gem_create *arg1;
>
>     arg1 = malloc(sizeof(union drm_amdgpu_gem_create));
>     arg1->in.bo_size = 0x8;
>     arg1->in.alignment = 0x0;
>     arg1->in.domains = 0x4;
>     arg1->in.domain_flags = 0x9;
>     ioctl(fd, 0xc0206440, arg1);
>
>     arg1->in.bo_size = 0x7fffffff;
>     arg1->in.alignment = 0x0;
>     arg1->in.domains = 0x4;
>     arg1->in.domain_flags = 0x9;
>     ioctl(fd, 0xc0206440, arg1);
>
>     The KASAN report is as follows:
>     ==================================================================
>     BUG: KASAN: slab-use-after-free in amdgpu_bo_move+0x1479/0x1550
>     Read of size 4 at addr ffff88800f5bee80 by task syz-executor/219
>     Call Trace:
>      <TASK>
>      amdgpu_bo_move+0x1479/0x1550
>      ttm_bo_handle_move_mem+0x4d0/0x700
>      ttm_mem_evict_first+0x945/0x1230
>      ttm_bo_mem_space+0x6c7/0x940
>      ttm_bo_validate+0x286/0x650
>      ttm_bo_init_reserved+0x34c/0x490
>      amdgpu_bo_create+0x94b/0x1610
>      amdgpu_bo_create_user+0xa3/0x130
>      amdgpu_gem_create_ioctl+0x4bc/0xc10
>      drm_ioctl_kernel+0x300/0x410
>      drm_ioctl+0x648/0xb30
>      amdgpu_drm_ioctl+0xc8/0x160
>      </TASK>
>
>     Allocated by task 219:
>      kmalloc_trace+0x211/0x390
>      amdgpu_vram_mgr_new+0x1d6/0xbe0
>      ttm_resource_alloc+0xfd/0x1e0
>      ttm_bo_mem_space+0x255/0x940
>      ttm_bo_validate+0x286/0x650
>      ttm_bo_init_reserved+0x34c/0x490
>      amdgpu_bo_create+0x94b/0x1610
>      amdgpu_bo_create_user+0xa3/0x130
>      amdgpu_gem_create_ioctl+0x4bc/0xc10
>      drm_ioctl_kernel+0x300/0x410
>      drm_ioctl+0x648/0xb30
>      amdgpu_drm_ioctl+0xc8/0x160
>
>     Freed by task 219:
>      kfree+0x111/0x2d0
>      ttm_resource_free+0x17e/0x1e0
>      ttm_bo_move_accel_cleanup+0x77e/0x9b0
>      amdgpu_move_blit+0x3db/0x670
>      amdgpu_bo_move+0xfa2/0x1550
>      ttm_bo_handle_move_mem+0x4d0/0x700
>      ttm_mem_evict_first+0x945/0x1230
>      ttm_bo_mem_space+0x6c7/0x940
>      ttm_bo_validate+0x286/0x650
>      ttm_bo_init_reserved+0x34c/0x490
>      amdgpu_bo_create+0x94b/0x1610
>      amdgpu_bo_create_user+0xa3/0x130
>      amdgpu_gem_create_ioctl+0x4bc/0xc10
>      drm_ioctl_kernel+0x300/0x410
>      drm_ioctl+0x648/0xb30
>      amdgpu_drm_ioctl+0xc8/0x160
>
>     The buggy address belongs to the object at ffff88800f5bee70
>      which belongs to the cache kmalloc-96 of size 96
>     The buggy address is located 16 bytes inside of
>      freed 96-byte region [ffff88800f5bee70, ffff88800f5beed0)
>
>     Should you need any more information, please do not hesitate to contact us.
>
>     Best regards,
>     Joonkyo Jung
>
--------------0GD7g8qI8zKHTtPcD4QH78iX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Joonkyo,<br>
      Sorry for the delay. <br>
      Yes, sure, I reproduced issue 2 (null-ptr-deref in amdgpu) and I
      will provide the fix soon.<br>
      However, issue No. 3 is no longer reproducible if the recent patch
      inflight is applied which fixes issue No 1.</p>
    <p>Do you see the same behavior?<br>
    </p>
    <p>Thanks in advance, Vitaly<br>
    </p>
    <div class="moz-cite-prefix">On 2024-03-07 20:18, Joonkyo Jung
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAKc8oVU8C-MRVa640603R2Gi7BRZ5P8ZN_uJoruDzR_A8xg71Q@mail.gmail.com">
      
      <div>
        <div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Hello,&nbsp;</div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">thank
            you for patching the first bug we have sent!</div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"><br>
          </div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Just
            a quick touch base with you, to ask if there has been any
            update on our other two bugs.</div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">They
            were each sent with emails titled&nbsp;</div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">&quot;Reporting
            a slab-use-after-free in amdgpu&quot; (this one)</div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">&quot;Reporting
            a null-ptr-deref in amdgpu&quot;.&nbsp;</div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"><br>
          </div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Thank
            you!&nbsp;</div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"><br>
          </div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Best,&nbsp;</div>
          <div dir="auto" style="font-family:'-apple-system','helveticaneue';font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Joonkyo</div>
        </div>
        <br>
      </div>
      <div><br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">2024년 2월 16일 (금) 오후 6:22,
            Joonkyo Jung &lt;<a href="mailto:joonkyoj@yonsei.ac.kr" moz-do-not-send="true" class="moz-txt-link-freetext">joonkyoj@yonsei.ac.kr</a>&gt;님이
            작성:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div dir="ltr">Hello,<br>
              <br>
              We would like to report a slab-use-after-free bug in the
              AMDGPU DRM driver in the linux kernel v6.8-rc4 that we
              found with our customized Syzkaller.<br>
              The bug can be triggered by sending two ioctls to the
              AMDGPU DRM driver in succession.<br>
              <br>
              In amdgpu_bo_move, struct ttm_resource *old_mem =
              bo-&gt;resource is assigned.<br>
              As you can see on the alloc &amp; free stack calls, on the
              same function amdgpu_bo_move,<br>
              amdgpu_move_blit in the end frees bo-&gt;resource at
              ttm_bo_move_accel_cleanup with ttm_bo_wait_free_node(bo,
              man-&gt;use_tt).<br>
              But amdgpu_bo_move continues after that, reaching
              trace_amdgpu_bo_move(abo, new_mem-&gt;mem_type,
              old_mem-&gt;mem_type) at the end, causing the
              use-after-free bug.<br>
              <br>
              Steps to reproduce are as below.<br>
              union drm_amdgpu_gem_create *arg1;<br>
              <br>
              arg1 = malloc(sizeof(union drm_amdgpu_gem_create));<br>
              arg1-&gt;in.bo_size = 0x8;<br>
              arg1-&gt;in.alignment = 0x0;<br>
              arg1-&gt;in.domains = 0x4;<br>
              arg1-&gt;in.domain_flags = 0x9;<br>
              ioctl(fd, 0xc0206440, arg1);<br>
              <br>
              arg1-&gt;in.bo_size = 0x7fffffff;<br>
              arg1-&gt;in.alignment = 0x0;<br>
              arg1-&gt;in.domains = 0x4;<br>
              arg1-&gt;in.domain_flags = 0x9;<br>
              ioctl(fd, 0xc0206440, arg1);<br>
              <br>
              The KASAN report is as follows:<br>
==================================================================<br>
              BUG: KASAN: slab-use-after-free in
              amdgpu_bo_move+0x1479/0x1550<br>
              Read of size 4 at addr ffff88800f5bee80 by task
              syz-executor/219<br>
              Call Trace:<br>
              &nbsp;&lt;TASK&gt;<br>
              &nbsp;amdgpu_bo_move+0x1479/0x1550<br>
              &nbsp;ttm_bo_handle_move_mem+0x4d0/0x700<br>
              &nbsp;ttm_mem_evict_first+0x945/0x1230<br>
              &nbsp;ttm_bo_mem_space+0x6c7/0x940<br>
              &nbsp;ttm_bo_validate+0x286/0x650<br>
              &nbsp;ttm_bo_init_reserved+0x34c/0x490<br>
              &nbsp;amdgpu_bo_create+0x94b/0x1610<br>
              &nbsp;amdgpu_bo_create_user+0xa3/0x130<br>
              &nbsp;amdgpu_gem_create_ioctl+0x4bc/0xc10<br>
              &nbsp;drm_ioctl_kernel+0x300/0x410<br>
              &nbsp;drm_ioctl+0x648/0xb30<br>
              &nbsp;amdgpu_drm_ioctl+0xc8/0x160<br>
              &nbsp;&lt;/TASK&gt;<br>
              <br>
              Allocated by task 219:<br>
              &nbsp;kmalloc_trace+0x211/0x390<br>
              &nbsp;amdgpu_vram_mgr_new+0x1d6/0xbe0<br>
              &nbsp;ttm_resource_alloc+0xfd/0x1e0<br>
              &nbsp;ttm_bo_mem_space+0x255/0x940<br>
              &nbsp;ttm_bo_validate+0x286/0x650<br>
              &nbsp;ttm_bo_init_reserved+0x34c/0x490<br>
              &nbsp;amdgpu_bo_create+0x94b/0x1610<br>
              &nbsp;amdgpu_bo_create_user+0xa3/0x130<br>
              &nbsp;amdgpu_gem_create_ioctl+0x4bc/0xc10<br>
              &nbsp;drm_ioctl_kernel+0x300/0x410<br>
              &nbsp;drm_ioctl+0x648/0xb30<br>
              &nbsp;amdgpu_drm_ioctl+0xc8/0x160<br>
              <br>
              Freed by task 219:<br>
              &nbsp;kfree+0x111/0x2d0<br>
              &nbsp;ttm_resource_free+0x17e/0x1e0<br>
              &nbsp;ttm_bo_move_accel_cleanup+0x77e/0x9b0<br>
              &nbsp;amdgpu_move_blit+0x3db/0x670<br>
              &nbsp;amdgpu_bo_move+0xfa2/0x1550<br>
              &nbsp;ttm_bo_handle_move_mem+0x4d0/0x700<br>
              &nbsp;ttm_mem_evict_first+0x945/0x1230<br>
              &nbsp;ttm_bo_mem_space+0x6c7/0x940<br>
              &nbsp;ttm_bo_validate+0x286/0x650<br>
              &nbsp;ttm_bo_init_reserved+0x34c/0x490<br>
              &nbsp;amdgpu_bo_create+0x94b/0x1610<br>
              &nbsp;amdgpu_bo_create_user+0xa3/0x130<br>
              &nbsp;amdgpu_gem_create_ioctl+0x4bc/0xc10<br>
              &nbsp;drm_ioctl_kernel+0x300/0x410<br>
              &nbsp;drm_ioctl+0x648/0xb30<br>
              &nbsp;amdgpu_drm_ioctl+0xc8/0x160<br>
              <br>
              The buggy address belongs to the object at
              ffff88800f5bee70<br>
              &nbsp;which belongs to the cache kmalloc-96 of size 96<br>
              The buggy address is located 16 bytes inside of<br>
              &nbsp;freed 96-byte region [ffff88800f5bee70, ffff88800f5beed0)<br>
              <br>
              Should you need any more information, please do not
              hesitate to contact us.<br>
              <br>
              Best regards,<br>
              Joonkyo Jung<br>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------0GD7g8qI8zKHTtPcD4QH78iX--
