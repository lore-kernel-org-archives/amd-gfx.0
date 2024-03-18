Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8E4C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 14:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934E710F171;
	Mon, 18 Mar 2024 14:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AB8KfxKd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0B410F171
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 14:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae+MUge/764u4Adk3Yi8NBo89z+xMJQsHwnfU3t0lmPI5P/ZpBhbDxcCIHmkSyft2NFDNePG47zideCs+VbG8ms0Uw8M0Bte2SvdWewaPtpoYYSfcS0eyyo+48+W7OICG+YkUNJoDitwsULKyCCc80ImiyHcatxHXuU8s6ySsTPymID+39yzZMHjWAkcU+4CV3U00mWUAeeErZMbJ0tJJo+99e9oP+ae7nNlQLWqBSz7gEO4mqDgKmNTfPiSSLiWywK8pkoFoG5nlTiYYaiO1vuef+sZcYzC1Ap1wYlu+r8AdAEdTQzZJPNTod/Ag3gRGOsG23h4VfP7DUDLYzWwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6llqLXnFXoOKdrsvX+31yISt5JulLxpDoewOh6soups=;
 b=Rl8KnbjYiZUl0mU4eeNmn3Eesig1uvZDYNFel2cEZDwLtmmYZ5rkooq+CtD50FK84XJ6i/sPZyCtjLfFQW1lyQ2D+hyvnf+nttrm4upLiuSYnVkxSsqZ2jZLR40q4EqI//kggHSYNNfdiKyjgxzWS4KjKBjyOlUuxrOR5qW4dYuXanIot4oQdLEIOkiWHNYcVbeFBLnVeCDNeCgJZlJJTA5R0wU7rImUDOhNCkiWuyaSH6xAt+XM/iRos9j3jcdzd6RpOMBJN3Hh/AEiPL8ijzLPe7PfiQa3HH9QUsHsu9br6CQC2mpy9kPT0D7nbh6y7rkCAPs5rwIEMJmqaQmDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6llqLXnFXoOKdrsvX+31yISt5JulLxpDoewOh6soups=;
 b=AB8KfxKdyYRiAW3JThMW2YHmIoxlZx9Nkq3H+D9QwptUKchByB1rR1fF+mOjB4w9Pb+OPqgjdsvy5MeFpDlshn8Va89iXCHEhpZZCYIOwbo6WmujHHiTutRlHPObYqFelg4EIYDluLNk9HPY3+zGbTk1rwzRckmr3kwumPJOBaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 14:58:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 14:58:32 +0000
Message-ID: <553b7925-e2bf-4865-b42d-b5fa05f4f508@amd.com>
Date: Mon, 18 Mar 2024 15:58:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240318120837.2011-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240318120837.2011-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be3ec07-2e0f-4fe4-d704-08dc475be0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSDW/nIWF1U12V2e95gRr0gPgR6tneq9PoRM+N3+FN0hy4A7P1uHEJ7F098pFkOG84kt0/B45LKbBp1oheIF2kUv5ujTERpwQ60TCzVn0pmUNsIHPmjtmguQkMo8U3taN0Ks1OtLGmxi/pHHkwANKscTRB8QryEyIasq9RIWXgQIifUGRCTcfhmahU9tE7V0ZD0V1v1azOAEjL6s75USreESRUDQnaQn3qmK9qOODNmbLPjwVepMDR0twT1duW/hbgNld8LBbLtQOrtcc0O7jfqHFqknVGzGHywvAEXhknmeP2vyn7zBO6Y55rN4h/TpPNy443KNbo0QHYk37TipLMjjIS33Xs2+5Al83mRwOe0C7SaRKa8WUmKJqm6b59Kgtp1cF3MDEJsdvztr8v63TqsHRocg3xmX6GwX4AOvQwGiWvWAmSr/miTyW9AsKZklVci3iCiFIqp4KUOs9g14veAGrlSf0trmnk1RHFNn03WykdifDEaEfXfcSLnJPZoNiVkBsJYqGziAPhE4BRhh03euOOxcVYbwuYRZsqGv0pS/ah8YTwnhG8xO5Iq7/t4LphaFpwmsYjFhlOhuw13gQgUhMSXhuD85Lravw12BA+uoTijS4UdaJb9QNtcxV909IgVnE5/ggS+gLOAIYOu1lPVcw8y4k6dX7sH7HzOfE5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0RicmtWc2VDalBTTm5DWlpKK2I2VHpuOWo1c3VWS3lPeWJiT3EyckpYVHNP?=
 =?utf-8?B?ekdBWWZSbXlha1hzNmRpdHZ4NXhIYUlpZ1Ntb09oaUw5bTFRL0dvWTlqMkIv?=
 =?utf-8?B?dmFRK1pEZzRQTE5hcENuZkpXR0w5SndGRmVHN3FiTUZVVnRWem9ndUhScGlj?=
 =?utf-8?B?eUpyMlBWd3hFZ0JFNnFQa1IrMUhZZHRWM1NiWWh2akVSeWJ3WmRlTTBIOTVV?=
 =?utf-8?B?c3h4aGh1aDdsYm0zNWJnMkRRdTNVUmUrdWFuYS9rcWZubzcydUpJUVVuYVRC?=
 =?utf-8?B?bkJEWlo5QlFrenIyNzcwdFcrdFFJZEk3OW42UEhJWE91b2J0SDI1R2hFY2l1?=
 =?utf-8?B?UTZHNnljVUh4ZCs5OXN2QWNYejZoQmc5dG5aaEVEbFdnd0h2SktHdEU5RHBI?=
 =?utf-8?B?YklzVmlnc2EyRkRaWG5Cc1FnbWZ0b1N3Q2g2RW4xOFVQeEVPOGY4MzlYSE9o?=
 =?utf-8?B?bmI3b3p5WHUxOTJuc0pobUlhcEpPYnFnYnNFMkY0V0p0MEVQeGt5bWZ3c0FG?=
 =?utf-8?B?SktSTGJUWXpiaDJPUVFzOHdJS0tNRHRsN2dxVGR5WmhSOEpubmMvMXl3cGtt?=
 =?utf-8?B?TldpWGFLcFRJR1Rub0pwdW54eEs3WTEySnhUQ29xOTduSTA2SEkrKzV6SVVY?=
 =?utf-8?B?OXNaeUY1Ym5RM2dsdGlBQmEyeVZkRjVUUHIxaEVVRGFwZ2p3Zkp1VXpReW1s?=
 =?utf-8?B?TnBMeE5KdE9WOUpPd2dsQmNPZDk3YW80Z3ZXM3dlL3dpck9kZDFjNmhFcHcr?=
 =?utf-8?B?S2ZmWnFvQ0lsdDg2MmJOdGZNM09zTkhCOVFuTFR3cWdWM0pra2VxeGsrUUJC?=
 =?utf-8?B?RnFvMDRiRGNNbGs4dmJHUDVnR1lseFlPNjg0b3JpSEE1dFB5MUZ6K2tScGd1?=
 =?utf-8?B?OC9RTXJNWlpyT3RPOXlWMVN3UE5VS3ROUVc5NFM2SnVYbU1YQVQxQXpmYUIr?=
 =?utf-8?B?S3p0L0NWQkdxVVlJUEVicEU1dXpveEEwWFB0dGJnZzRVbFR4YnJKczJNTm9o?=
 =?utf-8?B?K21Jc21oUVZhaWZFdFBNR1JXQXVJVVpKTmVQOUt1N0o4dytHSTBzM0tCYW9w?=
 =?utf-8?B?Snp5ZEFFcXRNeVVROTlrMDFtczcwdzczM2xLUVJJOUlaeVd6bFZhT0pIdE94?=
 =?utf-8?B?V0ZmWWV3dTlXMDFkdkRvZlBGVlpZVE9aUnRrQmhxeWJ3dUdZQU9CaTJwVXFC?=
 =?utf-8?B?UVVyU2V4Rks2ZTFVbWx6M1A4MVFyU1duL3VEVm9KSXV5RkxPd29RUTREcjll?=
 =?utf-8?B?cEoweFdyMjlBeVFXNnJJTGVaaUxtditCT0p5WXBCTml0YjF6MkY3Mjg1REJ1?=
 =?utf-8?B?MjNBbEw1MmdwQjFwNGFHTjZSSnJqaVFILy9kOXpqNHEzSTJYaXRyWWhNRFJo?=
 =?utf-8?B?ZHFmOUdVT3cwem84TmFIcmlZd1pVcGd2L0NObDZnOFNqbTRJYlVHL3BMd0F5?=
 =?utf-8?B?NU9PMDc1ZUhFZXdrSFMvR2QzbXQvaGFPNm5rVXJOTTZKemNUUHNKYk9oZit5?=
 =?utf-8?B?aVdMa3VSaW00NkR0UFIxeWtlcFJDOVdzNmIvNDJqTXNqaUtNdGkrNSsxbU1v?=
 =?utf-8?B?c1Vrb2lvREs1NHNKMHdrN2JpRjhHK0dCNWNvcTNvUTh2VmZURk5JRmM2cFcw?=
 =?utf-8?B?R1BxVjBuNHZ1Y1NSbktwanI0MW81Q2NyUEh4ZWN5WkNMcjJLQ0U4SS9LUmh2?=
 =?utf-8?B?RUNrU2FHQ2xlOWxmWmNyaXdWVi9wWnNXZ3hIeXJPMjdVUEd6eTVCK0FidmVW?=
 =?utf-8?B?Z0puVS95Y29WREl1bTNxQ2o5K3FacDM4MmN3M2p0UCtGWDBCdDh3ek9TeXdu?=
 =?utf-8?B?ZTd6U1QvZE1pcEN4c01ZVFE1aEN4MXo5NGhwL0F0b2ZCSEowNTVKekhUbTVn?=
 =?utf-8?B?N2VPSkJNY3JDVGtjck5XbnhsbWIyMzNmN2NRbDRid1VxeTF1blBQY2pxS3Ja?=
 =?utf-8?B?QU9uZC9SUGJHZEFYamtKanNXQVdpbE4vc1VTL29VTzZ6bUF2dXFZOHJyRDkx?=
 =?utf-8?B?TW0vQ2tXUFNPOWlvTnRnNFdITll0SHlIYnZSSFYvRVBFalJBZ2xsd2cxNExr?=
 =?utf-8?B?VDJUNVhNdlBlTmxuU3hSZ1E0OEVFdDdwRkk4NzB6ekxjb2V1NXMyTlYyRVRk?=
 =?utf-8?Q?fyjhDMfxXIYsTyIifeKshqTNL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be3ec07-2e0f-4fe4-d704-08dc475be0d4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:58:32.1169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBXMrnA8X5FlQOcildxuUJ9KZ71Y6kG9MBBZDz7r3P5kxdO7pWI/xs5IQQ20gU/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
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

Am 18.03.24 um 13:08 schrieb Shashank Sharma:
> From: Christian Koenig <christian.koenig@amd.com>
>
> The problem is that when (for example) 4k pages are replaced
> with a single 2M page we need to wait for change to be flushed
> out by invalidating the TLB before the PT can be freed.
>
> Solve this by moving the TLB flush into a DMA-fence object which
> can be used to delay the freeing of the PT BOs until it is signaled.
>
> V2: (Shashank)
>      - rebase
>      - set dma_fence_error only in case of error
>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>      - use vm->pasid when f is NULL (Mukul)
>
> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>      - move the misplaced fence_create call to the end (Philip)
>
> V5: - free the f->dependency properly
>
> V6: (Shashank)
>      - light code movement, moved all the clean-up in previous patch
>      - introduce params.needs_flush and its usage in this patch
>      - rebase without TLB HW sequence patch
>
> V7:
>     - Keep the vm->last_update_fence and tlb_cb code until
>       we can fix the HW sequencing (Christian)
>     - Move all the tlb_fence related code in a separate function so that
>       its easier to read and review
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  68 +++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   4 +
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
>   7 files changed, 171 insertions(+), 30 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 4536c8ad0e11..f24f11ac3e92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>   	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>   	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
> -	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
> +	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
> +	amdgpu_ib.o amdgpu_pll.o \
>   	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>   	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
>   	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 81fb3465e197..26f1c3359642 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -885,6 +885,40 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>   	kfree(tlb_cb);
>   }
>   
> +static int
> +amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params, struct dma_fence **fence)
> +{
> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +	struct amdgpu_vm *vm = params->vm;
> +
> +	if (!fence || !*fence)
> +		return 0;
> +
> +	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> +	if (!tlb_cb)
> +		return -ENOMEM;

That won't work like this. The page tables are already updated, so you 
need to have the callback no matter what.

That's why the code previously allocated the tlb_cb structure before 
updating the page tables.

Regards,
Christian.

> +
> +	tlb_cb->vm = vm;
> +	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
> +				    amdgpu_vm_tlb_seq_cb)) {
> +		dma_fence_put(vm->last_tlb_flush);
> +		vm->last_tlb_flush = dma_fence_get(*fence);
> +	} else {
> +		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> +	}
> +
> +	/* Prepare a TLB flush fence to be attached to PTs */
> +	if (!params->unlocked && vm->is_compute_context) {
> +		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
> +
> +		/* Makes sure no PD/PT is freed before the flush */
> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> +				   DMA_RESV_USAGE_BOOKKEEP);
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_vm_update_range - update a range in the vm page table
>    *
> @@ -917,7 +951,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_update_params params;
> -	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_res_cursor cursor;
>   	enum amdgpu_sync_mode sync_mode;
>   	int r, idx;
> @@ -925,12 +958,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
> -	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> -	if (!tlb_cb) {
> -		r = -ENOMEM;
> -		goto error_unlock;
> -	}
> -
>   	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
>   	 * heavy-weight flush TLB unconditionally.
>   	 */
> @@ -948,6 +975,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.immediate = immediate;
>   	params.pages_addr = pages_addr;
>   	params.unlocked = unlocked;
> +	params.needs_flush = flush_tlb;
>   	params.allow_override = allow_override;
>   
>   	/* Implicitly sync to command submissions in the same VM before
> @@ -961,7 +989,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	amdgpu_vm_eviction_lock(vm);
>   	if (vm->evicting) {
>   		r = -EBUSY;
> -		goto error_free;
> +		goto error_unlock;
>   	}
>   
>   	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> @@ -974,7 +1002,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	r = vm->update_funcs->prepare(&params, resv, sync_mode);
>   	if (r)
> -		goto error_free;
> +		goto error_unlock;
>   
>   	amdgpu_res_first(pages_addr ? NULL : res, offset,
>   			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
> @@ -1024,29 +1052,18 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		tmp = start + num_entries;
>   		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>   		if (r)
> -			goto error_free;
> +			goto error_unlock;
>   
>   		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>   		start = tmp;
>   	}
>   
>   	r = vm->update_funcs->commit(&params, fence);
> +	if (r)
> +		goto error_unlock;
>   
> -	if (flush_tlb || params.table_freed) {
> -		tlb_cb->vm = vm;
> -		if (fence && *fence &&
> -		    !dma_fence_add_callback(*fence, &tlb_cb->cb,
> -					   amdgpu_vm_tlb_seq_cb)) {
> -			dma_fence_put(vm->last_tlb_flush);
> -			vm->last_tlb_flush = dma_fence_get(*fence);
> -		} else {
> -			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> -		}
> -		tlb_cb = NULL;
> -	}
> -
> -error_free:
> -	kfree(tlb_cb);
> +	if (params.needs_flush)
> +		r = amdgpu_vm_tlb_flush(&params, fence);
>   
>   error_unlock:
>   	amdgpu_vm_eviction_unlock(vm);
> @@ -2391,6 +2408,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;
> +	vm->tlb_fence_context = dma_fence_context_alloc(1);
>   
>   	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>   				false, &root, xcp_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8efa8422f4f7..b0a4fe683352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -257,9 +257,9 @@ struct amdgpu_vm_update_params {
>   	unsigned int num_dw_left;
>   
>   	/**
> -	 * @table_freed: return true if page table is freed when updating
> +	 * @needs_flush: true whenever we need to invalidate the TLB
>   	 */
> -	bool table_freed;
> +	bool needs_flush;
>   
>   	/**
>   	 * @allow_override: true for memory that is not uncached: allows MTYPE
> @@ -342,6 +342,7 @@ struct amdgpu_vm {
>   	atomic64_t		tlb_seq;
>   	struct dma_fence	*last_tlb_flush;
>   	atomic64_t		kfd_last_flushed_seq;
> +	uint64_t		tlb_fence_context;
>   
>   	/* How many times we had to re-generate the page tables */
>   	uint64_t		generation;
> @@ -611,5 +612,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>   				  uint64_t addr,
>   				  uint32_t status,
>   				  unsigned int vmhub);
> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm,
> +				 struct dma_fence **fence);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 6e31621452de..3895bd7d176a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -108,7 +108,9 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>   static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>   				struct dma_fence **fence)
>   {
> -	/* Flush HDP */
> +	if (p->needs_flush)
> +		atomic64_inc(&p->vm->tlb_seq);
> +
>   	mb();
>   	amdgpu_device_flush_hdp(p->adev, NULL);
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 124389a6bf48..601df0ce8290 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -972,7 +972,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			while (cursor.pfn < frag_start) {
>   				/* Make sure previous mapping is freed */
>   				if (cursor.entry->bo) {
> -					params->table_freed = true;
> +					params->needs_flush = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
>   							      &cursor,
>   							      params->unlocked);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 349416e176a1..66e8a016126b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -126,6 +126,10 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>   
>   	WARN_ON(ib->length_dw == 0);
>   	amdgpu_ring_pad_ib(ring, ib);
> +
> +	if (p->needs_flush)
> +		atomic64_inc(&p->vm->tlb_seq);
> +
>   	WARN_ON(ib->length_dw > p->num_dw_left);
>   	f = amdgpu_job_submit(p->job);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> new file mode 100644
> index 000000000000..51cddfa3f1e8
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <linux/dma-fence.h>
> +#include <linux/workqueue.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_gmc.h"
> +
> +struct amdgpu_tlb_fence {
> +	struct dma_fence	base;
> +	struct amdgpu_device	*adev;
> +	struct dma_fence	*dependency;
> +	struct work_struct	work;
> +	spinlock_t		lock;
> +	uint16_t		pasid;
> +
> +};
> +
> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
> +{
> +	return "amdgpu tlb fence";
> +}
> +
> +static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	return "amdgpu tlb timeline";
> +}
> +
> +static void amdgpu_tlb_fence_work(struct work_struct *work)
> +{
> +	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
> +	int r;
> +
> +	if (f->dependency) {
> +		dma_fence_wait(f->dependency, false);
> +		dma_fence_put(f->dependency);
> +		f->dependency = NULL;
> +	}
> +
> +	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
> +	if (r) {
> +		dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
> +			f->pasid);
> +		dma_fence_set_error(&f->base, r);
> +	}
> +
> +	dma_fence_signal(&f->base);
> +	dma_fence_put(&f->base);
> +}
> +
> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
> +	.use_64bit_seqno = true,
> +	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
> +};
> +
> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +				struct dma_fence **fence)
> +{
> +	struct amdgpu_tlb_fence *f;
> +
> +	f = kmalloc(sizeof(*f), GFP_KERNEL);
> +	if (!f) {
> +		/*
> +		 * We can't fail since the PDEs and PTEs are already updated, so
> +		 * just block for the dependency and execute the TLB flush
> +		 */
> +		if (*fence)
> +			dma_fence_wait(*fence, false);
> +
> +		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
> +		*fence = dma_fence_get_stub();
> +		return;
> +	}
> +
> +	f->adev = adev;
> +	f->dependency = *fence;
> +	f->pasid = vm->pasid;
> +	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
> +	spin_lock_init(&f->lock);
> +
> +	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
> +		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
> +
> +	/* TODO: We probably need a separate wq here */
> +	dma_fence_get(&f->base);
> +	schedule_work(&f->work);
> +
> +	*fence = &f->base;
> +}

