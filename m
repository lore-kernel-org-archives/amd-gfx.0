Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BE5C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 13:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC3C112230;
	Fri, 15 Mar 2024 13:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v71s/Z5/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3375112230
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 13:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSPiiuENWuF4ubSD2kvmEdcCc7iDngP8MQK1y87OV/VHiZpAh2KdMBtV4U75pat80IbKGTkJjsX1KVwisIo/sToCyagjIaTNKYR7TJXxXOQUDsoh42lFbU8H4gFosMQ4baSIL/t7JktDMKjfa6mAN//Y+tD+iRAXjrAT3FSdng+yay4d1K5s0L586PyAMGniTrCUmudE1FsqNYUfHDAcjvgfvR0biHG938R8I2rDUgke0UNZXAAIEei0zFZQFD+0qmPhdHNugjLdT9+ehATxI439eyka9ezBKAHlJ35RlGPphftvdvIlZJxBVG5BU6vNZV6qzmgZnSYjk7Y9W/Cd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjnFciTSeFowyZSfT4YjINJzNXlz1ua65XCamCAGVzc=;
 b=kVGRfIz3ArOhdtVij3OB68THw7Q6hUk/gALb9Woo1JZqaC/LhTWHgND4Xi34BHLkKZhNc+jrrJBqPWWehsslGo1vNBwAeYO3j9GbwvNuKtiNSIKhxajWk3Eteaj7QzuTf7EKOX5sxEl02Cps6IQh/XFFywxuyEdzLpClJrHKdOnFCy5bC7In8lTirmxIvJ87k++ZapOj7jdcCtBy2kbLZ8SVqW2aPLCELNCG5wYVrcc7P/IGmU1vsf8euiwN3Rdlj6TU+TlPiuOBnStQnl7gWGrROTVZ3/lrCuy5lgld6Kibm8JqW3aGnr5Q0LVPz9AHQhC2NwGol3ax5oUndQsz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjnFciTSeFowyZSfT4YjINJzNXlz1ua65XCamCAGVzc=;
 b=v71s/Z5/iC9ISbbbq22SOT0ccbwKGkA09LuO8RhMgae6NzBWk5+AoL9pVIJnPN/Ft4es+AvSPZ2kEkhCQ2t/szBUklRL7s610rXPj/SpRksE2RmPqatO9dbZ9Hye+kF0J8u7BVQ4mJhcVfQpbxCNdHvntpw8KKhRy5KtSBDVNKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 15 Mar
 2024 13:51:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 13:51:16 +0000
Message-ID: <cc16724f-a239-4b95-bec5-77d8355c95b1@amd.com>
Date: Fri, 15 Mar 2024 14:51:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240315132511.1103-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240315132511.1103-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d4c6b2-b2f5-484e-4985-08dc44f6fc31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGK8aWtyLoXilJcjMj67eKMcfMSnMkZDgnZWbv9AAYkY9x8SFvRpiIue2cwGLoY7EepxD4ACbvTlHdQ9TxVpkvBBsaoxtoGcmu/1GqLoljSStOOqZRx3Wxwq3Ke28P0ZZT5btSQQRwkHOz0FPy5o09K1Yi4qF521I8qXskXtKTgLiiApA5fwnfyAteWuzc2FTNiM/ndwOEFTc9DJOdtXdXRjXq+ADPGtRFwvY9RdDP7IDujM9qxNs4kZiFmAjxV0KDf5DPw46HhRh4hNxoeEku10Xnpa0zsphPLGVy7M8uE7FHflC2KKbTKKhZkV1iviUj/jsp8GDe5OA2Nk1rqcFCgY5oujw+UaZ2uLkVfSmD/m1Hd+VzTH3vXqVsQa9iWcrhDYQgdxbRdi6nURxi8ClfpEvdTK42BPrY2poiIltBV//towvxPZhW1Layd7W/PbkLA6bb0MOSCmtmtcAUYBtGkSQOKKoryPz5Wq0kdU07bO4cI0BsAZmLvWgvKlhWwIMoUqQ7nz49QEXY0whpbMrv2R31gGpliqk9hukOr6dT6zEfhmUDyafbrbqgL7gnyyeo5WzCC90ao0q4oE7gGt6rLcdaD9chQF//UFbJTKQIzEywEiiIJZ+IBZIKlGCD1C54ITJoIgmWau+VQqY+JSmckvYy5NL1QvpjHXVcLhCPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2R4UTBuQXhRWmtobzgrTnRtUzVFWlcza1l5QXcyeXB5T3U5NGJObDVabHRr?=
 =?utf-8?B?T1Vrbm01cUF6eTBVRWtud29rTlkwUXo0blZIMUpUZ2RjQ3prMS8zejVxUTVa?=
 =?utf-8?B?YlJ2bGU5akRSNGx5MVVGaWtWNlQ1eXFibjdxNmI2TGtnUzJJYnNIak9VVkZT?=
 =?utf-8?B?alFwaEN0REJLVEdraVNTeEV0SjFUbWJIeExMTjZXNXVOQitNWFpOeEw2ZVVu?=
 =?utf-8?B?RUlXYUxDOWkwNXVHdlJGbFQvWTI3c2dyclNNVFZkdU1jVVIzR3VENVpDNWt3?=
 =?utf-8?B?RDV6N0NJZW1GN2VDUjNrMWp2WkdBbzAvLytHUjJ2ZHkvTWtYM29OUzJIV0h2?=
 =?utf-8?B?RzVUc0s1SWZ2ZXFkN1J2QlFDNzFmU240cGN2UDlMNUx6K0Q4MlcrRThEWDlL?=
 =?utf-8?B?NFp4ODUwcktaSWtBWUJaMzJmRDJZZmtWZnNIazVua1pRejZTMUFneTYvZ3Jk?=
 =?utf-8?B?YTY0ZmRsUkxIZC9CSlZneU1OQitzR1dqTndEM3BBRFFPcjhTdThkTk1BVWpQ?=
 =?utf-8?B?VS9udklRQUhIRUV6M3d1dmFZRWpxa245b2M4anhQRkFxYkRqNWNVVnl5MzdY?=
 =?utf-8?B?RlFBbzhEYU94MnU4Q013RjNxdHZMdGdGUzdvNnROQXJRa2NoVFBNcTc5aXZE?=
 =?utf-8?B?WUxHTXRDZGlpa0cxeElhanJnb3dvM2dKWFFzY3BXSUkrVEp0dUZEKzNiUkl4?=
 =?utf-8?B?Skw4TGQyMEFBSHlnK1A3QmlBT3MzdHBoVUJCUk4rcmtuRCtQeEwvV0ZHUmRN?=
 =?utf-8?B?Zjk2VVBMS3AzYlV5RXZGZ0FjeVVHSWJHM2pCUjR4Sk5oOUV5TjZ3WHFhNzVw?=
 =?utf-8?B?cTFnUlBtNjhUTmFxVFR0cUxCL2Y1QjVZQk9SL3UzQm04NGg4VisySm9SMEly?=
 =?utf-8?B?WkpEZ1FtUndHdnJPK2VFTkZhNjdSNm5mVUtyYjBWaGppQlZHaGhOVEdZb2NN?=
 =?utf-8?B?L1pnN3lyNDZPdDdibUNVQmZlS2RCWlhPYWwyd21vL25zQi8vd3duY3l3eG1m?=
 =?utf-8?B?VGVkbXlGak9YOHA1S1BaUkNaeDhZTDVPN2NJZ3F1TURNNzFjR0FOdXQ5bUJS?=
 =?utf-8?B?YmZLUHZNQ2s4RWlkbG1wSW9GWitmVXlMWjc3MGx6M2hXK0huVlgvN0ZrQWpU?=
 =?utf-8?B?cE52b1dUeWI5emllZk5sb3lDUW1EQXpoRHlOVFIxRGVVbmx2Y0N3K1Bta0ta?=
 =?utf-8?B?a2JTUXpQbGY2WkpPNWNSSDhzclNtenJkQmJhTFA2MWh5ZWVENXBqMWxReklB?=
 =?utf-8?B?UEZDMk42cDRWcWFyZEU1alAxTTl2ZDlJaVY2Y0J2dmVyemE0RDE1anRtb3ZI?=
 =?utf-8?B?RUs1Tm90Q29RZE1DOVpwRnZVWGk5SVFoOGhLbk40OTczc1czTlQ4Z2N2OU5E?=
 =?utf-8?B?Zks5eFlqY0dyQWF6d1N3TXZSM1ZGcmdLMzlnTDc0UHd4a3pxL3dsZjhQR1dL?=
 =?utf-8?B?eWc3K0hvdzBVT1ZDeVFyYWlrOXJVL2NYYndGVUc4c3F2WDk4a05mODR3dVVi?=
 =?utf-8?B?dEh6Z2tkQlJGeHh3b2Q5c0k2MHJQWGRPaURqS0JKRDZ5Vm5kTFJhdnoyaUwx?=
 =?utf-8?B?dXphR0R0NTdxOWVkQTVJZlVJRFJMbDQ5aDJjaEk4Mm9ES2w2MVRUZFZLMEEz?=
 =?utf-8?B?OG11djJOaFJJcE9hQVg1RHY2dUxyZU5vSWVlQTlIM0hoTEx0SjhkVXJuZjNR?=
 =?utf-8?B?SEdjbnB3UXlWVzFPdEJNNGVEUkt5cWFMaWxLVXEzZi9Kc1FTVi9VZ2Y5YkZW?=
 =?utf-8?B?dDBUREdrbXBvRGVrTlJEYkUwSlpyeW1scW9LT1pFQnRxeTFlTEVZeS9GNEkz?=
 =?utf-8?B?MWdsMXhQZEcxRzFuVjFXTXpBRjh6TERkVUJVR2VrSjRnL25vYUpXTjRkK1Nx?=
 =?utf-8?B?VVcvMG82MFNHYUZadDVFNUlvY1BJdkgxSFRORUVDRmdhR0dScnVBTlQvc1di?=
 =?utf-8?B?WC9xd1hmQTloVGRlSjR2MEdwOCt4QlpVMVRnbXhOUmVCck1sbEczQjZKY3hK?=
 =?utf-8?B?bkFyVTkzd1pYbCthN0NtU0taRDNaVzF0WStlSmh0aGZHMW9xZkc4NEtUMzlS?=
 =?utf-8?B?cStzdHZtdDJXdzExRG1LVjZnMWJLMEdTS2xydUhva3FTMGFvUnFHcjZIT0hI?=
 =?utf-8?Q?7gm3hfCbkZglMKC3nbhggR9BT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d4c6b2-b2f5-484e-4985-08dc44f6fc31
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 13:51:16.4817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12Ema2GBK12AD7qwBI19mdCVeJXw4qJkK8hXLqO/R/2BA9yiRpJy+BZ9U95keL4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
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

Am 15.03.24 um 14:25 schrieb Shashank Sharma:
> From: Christian Koenig <christian.koenig@amd.com>
>
> The problem is that when (for example) 4k pages are replaced
> with a single 2M page we need to wait for change to be flushed
> out by invalidating the TLB before the PT can be freed.
>
> Solve this by moving the TLB flush into a DMA-fence object which
> can be used to delay the freeing of the PT BOs until it is signaled.
> Also remove existing TLB flush cb and vm->last_tlb_flush fence and
> replace it with new method of flushing tlb.
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
> V5: - free the f->dependency properly (Christian)
>
> V6: (Shashank)
>      - added some cleanup from the HW seq patch in this patch.
>      - introduce params.needs_flush and its usage in this patch.
>      - remove vm->last_tlb_flush and tlb_cb.
>      - rebase without TLB HW seq patch.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Christian KÃ¶nig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  77 ++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  26 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   4 +
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
>   7 files changed, 141 insertions(+), 87 deletions(-)
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
> index 81fb3465e197..3b64623f32ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -111,21 +111,6 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>   
> -/**
> - * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
> - */
> -struct amdgpu_vm_tlb_seq_struct {
> -	/**
> -	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
> -	 */
> -	struct amdgpu_vm *vm;
> -
> -	/**
> -	 * @cb: callback
> -	 */
> -	struct dma_fence_cb cb;
> -};
> -
>   /**
>    * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>    *
> @@ -868,23 +853,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -/**
> - * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
> - * @fence: unused
> - * @cb: the callback structure
> - *
> - * Increments the tlb sequence to make sure that future CS execute a VM flush.
> - */
> -static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
> -				 struct dma_fence_cb *cb)
> -{
> -	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> -
> -	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
> -	atomic64_inc(&tlb_cb->vm->tlb_seq);
> -	kfree(tlb_cb);
> -}
> -
>   /**
>    * amdgpu_vm_update_range - update a range in the vm page table
>    *
> @@ -917,7 +885,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_update_params params;
> -	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_res_cursor cursor;
>   	enum amdgpu_sync_mode sync_mode;
>   	int r, idx;
> @@ -925,12 +892,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
> @@ -948,6 +909,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.immediate = immediate;
>   	params.pages_addr = pages_addr;
>   	params.unlocked = unlocked;
> +	params.needs_flush = flush_tlb;
>   	params.allow_override = allow_override;
>   
>   	/* Implicitly sync to command submissions in the same VM before
> @@ -961,7 +923,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	amdgpu_vm_eviction_lock(vm);
>   	if (vm->evicting) {
>   		r = -EBUSY;
> -		goto error_free;
> +		goto error_unlock;
>   	}
>   
>   	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> @@ -974,7 +936,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	r = vm->update_funcs->prepare(&params, resv, sync_mode);
>   	if (r)
> -		goto error_free;
> +		goto error_unlock;
>   
>   	amdgpu_res_first(pages_addr ? NULL : res, offset,
>   			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
> @@ -1024,7 +986,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		tmp = start + num_entries;
>   		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>   		if (r)
> -			goto error_free;
> +			goto error_unlock;
>   
>   		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>   		start = tmp;
> @@ -1032,21 +994,14 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	r = vm->update_funcs->commit(&params, fence);
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

Removing that here will completely break gfx.

You need to keep that logic around as well.

Regards,
Christian.

> +	/* Prepare a TLB flush fence to be attached to PTs */
> +	if (!unlocked && params.needs_flush && vm->is_compute_context) {
> +		amdgpu_vm_tlb_fence_create(adev, vm, fence);
>   
> -error_free:
> -	kfree(tlb_cb);
> +		/* Makes sure no PD/PT is freed before the flush */
> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> +				   DMA_RESV_USAGE_BOOKKEEP);
> +	}
>   
>   error_unlock:
>   	amdgpu_vm_eviction_unlock(vm);
> @@ -2386,11 +2341,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	vm->last_update = dma_fence_get_stub();
>   	vm->last_unlocked = dma_fence_get_stub();
> -	vm->last_tlb_flush = dma_fence_get_stub();
>   	vm->generation = 0;
>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;
> +	vm->tlb_fence_context = dma_fence_context_alloc(1);
>   
>   	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>   				false, &root, xcp_id);
> @@ -2429,10 +2384,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	amdgpu_bo_unref(&root_bo);
>   
>   error_free_delayed:
> -	dma_fence_put(vm->last_tlb_flush);
>   	dma_fence_put(vm->last_unlocked);
>   	amdgpu_vm_fini_entities(vm);
> -
>   	return r;
>   }
>   
> @@ -2530,7 +2483,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	struct amdgpu_bo_va_mapping *mapping, *tmp;
>   	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
>   	struct amdgpu_bo *root;
> -	unsigned long flags;
>   	int i;
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
> @@ -2543,11 +2495,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	amdgpu_vm_set_pasid(adev, vm, 0);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
> -	dma_fence_wait(vm->last_tlb_flush, false);
> -	/* Make sure that all fence callbacks have completed */
> -	spin_lock_irqsave(vm->last_tlb_flush->lock, flags);
> -	spin_unlock_irqrestore(vm->last_tlb_flush->lock, flags);
> -	dma_fence_put(vm->last_tlb_flush);
>   
>   	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>   		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8efa8422f4f7..ba92f431f4e0 100644
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
> @@ -338,10 +338,10 @@ struct amdgpu_vm {
>   	struct drm_sched_entity	immediate;
>   	struct drm_sched_entity	delayed;
>   
> -	/* Last finished delayed update */
> +	/* Sequence number indicating necessary TLB flush */
>   	atomic64_t		tlb_seq;
> -	struct dma_fence	*last_tlb_flush;
>   	atomic64_t		kfd_last_flushed_seq;
> +	uint64_t		tlb_fence_context;
>   
>   	/* How many times we had to re-generate the page tables */
>   	uint64_t		generation;
> @@ -562,21 +562,6 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>    */
>   static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>   {
> -	unsigned long flags;
> -	spinlock_t *lock;
> -
> -	/*
> -	 * Workaround to stop racing between the fence signaling and handling
> -	 * the cb. The lock is static after initially setting it up, just make
> -	 * sure that the dma_fence structure isn't freed up.
> -	 */
> -	rcu_read_lock();
> -	lock = vm->last_tlb_flush->lock;
> -	rcu_read_unlock();
> -
> -	spin_lock_irqsave(lock, flags);
> -	spin_unlock_irqrestore(lock, flags);
> -
>   	return atomic64_read(&vm->tlb_seq);
>   }
>   
> @@ -611,5 +596,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
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

