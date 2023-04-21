Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8823C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 19:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368C310E06D;
	Fri, 21 Apr 2023 19:58:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E853010EEE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 19:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T54clA1064fEbNFy+uYjifIDvRBZErBmETmBDBLugF08t1aC1bVZ+a4rVZr2AUI/Zx+vWP/LPvOulDYKcY4VhpbcDE6yXfpxTFmgMxF+8vEBikLTkxa6g3qxbBQ4L6g97FI/DASKeU/wSaM+tnHaJduR5oyvtWfCckF4fpmTaHmblBYzgz7HYrYqAAHhhpUSALYrkCCd2TDtFqn5pJNPw7vc9LMn8ACCbvug3mIxf2lTyX3DxR5jKTkp+pnKAczfjEEFTYhYYAm83db11a0jt8sjKyqrMX6bmU7+PM2Y0bszqfG9vMTPh50IHRr9IRZ6uRvNAD15JpFg339tkrpeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfcWykqEVyXA3mzdb3oW3WDdLxlmZWf1LNGoqxExKsg=;
 b=b5gYkat3gaXP0Sr3gQBCwrSZQMCUGcaHEBJFHf3qtQZ04X5U0j7bP9StkC5hrr2xgT3KP2egGX290e8C8NYh5VJzRBhiWIxdF72RXROrWWsvJht//5tL5jv7BPG+X1VJ5Z5gXX/92yoAeLVvpCPH8TaZnny5LcLQOJa2e8re+sqxdWs9gKUxvZSnxOnQXvYsqWEefSw0ytZ+18Jfod1gvlr36/S8Ib3tX4ri6wpa7MjdhDGSo/iHEHy+Iod+UjdHiviLCthxJvs6LqB1fzTi+EC/jajleZkdnL40MARFjgdoaroTRGIlizRcExubvxamEIFWOX7Jt0UwZp2xljf/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfcWykqEVyXA3mzdb3oW3WDdLxlmZWf1LNGoqxExKsg=;
 b=vkSpWCqkUY+Xkobp8oVAap2hYs0jFVXRgUboPfvvqA+aWdbFS2qAodG4s2cZYbDJsZ3Qfzuj4s6H2dyDDUMwA9xDWbQLNMSTlNutZgFqxLSpes8jIE9kSJJ4FqOdG2Fr6MYWWEgz2hUvSqhCYtV4LIMw0t1wZk2y/KyV8hKW99w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5044.namprd12.prod.outlook.com (2603:10b6:610:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 19:58:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 19:58:16 +0000
Message-ID: <2808cded-f913-58fa-a026-6887445ef37f@amd.com>
Date: Fri, 21 Apr 2023 15:58:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-9-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230412162537.1357-9-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::46) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 942c3f6f-3d3e-4be3-b3a7-08db42a2becd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTqLRv4/HY3KHYHjSeRYWWLaBEbvyHnqG5n1phK89zJZizbqtv50C84Vda6HAUyGMLVd+J7IOrObFDCJJWPkTN+MqXonGR6g/o0oj8TMkq5iiTc45vwDuKc09eGnOB6UXsss+SNvZU2J9FF5I7irfUQmRWTxxJFQx8hjB2nogI+d+wfEjSN62EwUsQ5O+SVi0gG2UnSaP3Pqx1Z8SXjf2BnHvmhPydXvN+EVoaKhZ1dXS1/GHhF0sNu4SZCenLvFOI40ofZK/ezZG8kbv9nbyqi1CQ/ANS3+OLP8nQcwOH8o+txVoD0rDe+gX+RWoHs/y3HG6A681iIkmHfzy1DgLQoTl6VGrH851o+Ln3kY82m/EfqKNPOtHdACMFCKpWNp1WRtjgslXNZ4s1KoBTS282z34/Tr7y5f9t8zF6APQis5QFziutlJ0ezzPs0M57JlSIsk4BAToJxbfjZEtpEUHRSnYCDEL7/11JA4MPsiCQEQsTr7Lt0GIk49rnDYPH8TPgtwmJGkjMJWmKsEm4pKZrwTB47ICLC6oBdNVqKmxmAs/uT9gddRRWmRoTuBRnuFANNDX2LXNACjVvl0rXBudt5sUZZ0BDohrh2wuxYVfUPqZWOucnCYJtC4u+S55vJrbyfpanQKudMAMAQZKaoRLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(4326008)(38100700002)(8936002)(8676002)(41300700001)(66556008)(316002)(66476007)(66946007)(2906002)(5660300002)(44832011)(186003)(53546011)(6512007)(26005)(36756003)(6506007)(83380400001)(31686004)(2616005)(54906003)(86362001)(31696002)(6486002)(6666004)(36916002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWNWY0FMTjlHRjhablp0N044VTlRVHVjckx6ekowd3l2bnJlRUl4RnVBNkRh?=
 =?utf-8?B?eHlqNjZTMTN1cUFrcENZL0tsNWlhSWNwcUdGVWlRQjF4TG9KQWVPeTJWbGRz?=
 =?utf-8?B?RE4zWDR0TDd0OS9QemJxNGR3RVZieStZa2hZeENleUVZRzZUd2VNejUvSDhO?=
 =?utf-8?B?aFlFTFhFTGlBOGFTVkRwS3NUTzNGL1NmNFBnQ2UyVXZybHJ1ZW1ZWXR2emhk?=
 =?utf-8?B?UlV4SDQ1cW4xdzNjcURlNDh6NFdQVXZtcGNwNnVVRDNTalFQOHd6QzJub2Mx?=
 =?utf-8?B?RGlySmJUYkNyRENQcVdzNElzS3ltZ1lmSXpKMkw1cjMwL2k2OHArKzJwREVp?=
 =?utf-8?B?a1dVa0ZmbmZHdFJ1RWdqeTJ3dE1EZlo4K2hKTkQwSjlVRWRVbkh0ZUVDbEMx?=
 =?utf-8?B?ZUltSXVmQzFJV3lnRmwyMGZLL24vMmpVdndJelgzYnM1Q0xrZ1ZObUxxRW9r?=
 =?utf-8?B?VFpnSHNEQ1BFaVR4VjMrR2pDTnlGSnFVeWdFMU5qcjV2TS9ZSERrZTdHd1o0?=
 =?utf-8?B?Zzhka1BKa0pseXZ5b2pEbno1VFJ2bWxyTERvOHRERjRreDQ5S2JMOE92WnY4?=
 =?utf-8?B?M0tQb0hWb0UzYVVHaWthdWQrenRUMXdzOUpNWmhObXdaWVhYMXlQbVVzSThO?=
 =?utf-8?B?M29kNnJQTkV2TzlVaXluc3pwQk1taTcrdjdlcUsxdlhVaXhnSzhVNkhVSEtJ?=
 =?utf-8?B?L1dQUUNUa2lYbHFJNnVEdktxR011T3BMR0JiZ2ZFSjFEVmVWMm9VditDaTdU?=
 =?utf-8?B?ZXp0L2JoV0dxZGxPb255a3IycTZrREU0eDJpMFVyaFUvMkhUUVVTVVJVdXpS?=
 =?utf-8?B?YXh0NktRODBHWUdJdEFOcFF6Y3FjcjdUdXJMWi9VVGVtc1M3eXZmV2dDa0VT?=
 =?utf-8?B?aEpFSllLcTdkWFd2R0Ntb1BLK3lJbExkOEdLaEpFblFhQmE5bkhHbVBsTUtU?=
 =?utf-8?B?MEFGRms5MVlmc1pJRTRhSjQ0RllKZ1MvL0t0MmlORVdFMjZqQW5ycWVpVE1p?=
 =?utf-8?B?ZWMzMXNLSWkzSGo3MjFCL2VmdXh4NXJIZFZTa3YwZEluSE1DRGRScDhqWnNu?=
 =?utf-8?B?QWlBNFFxeUtnZUJjVGFvYS9SaGtkeXRlZTdMZU1UU0RpSFgrRzh3MVhiMVo4?=
 =?utf-8?B?OFI5OWxOM1d4WGZ5d2VtRFZNY3hPWWVWVzZaeW1WTm00NXFNRHVUWUpPOTVx?=
 =?utf-8?B?SUN6Rm5yL3ZrTGl5Y3pGQld6clZObDNNdjJJODdVVXMxdjhIbWcvVFk0dENP?=
 =?utf-8?B?ckxMUzlLN211c1Q1OXRXeFcyZklkT2t0bTdhZHdpNC8zaHY2THlCY1VnK3F4?=
 =?utf-8?B?UW9hKzZYcm9EajFaTFpNRDMvcytJQ0xvajh1TE5nWjNBM1VEbGMwcTJscFVI?=
 =?utf-8?B?bUN1QmRtT3IrTjIwbmZUWFRUY1dBTnA2Rk9BRkRFRnRRNTVabS9Db0xrdEFV?=
 =?utf-8?B?SCt3dmt3Zm1adWJzMHFEK0FKMUxVc2JDaWNNVnVWU3NjK09iNWxPd1hHUWxX?=
 =?utf-8?B?VmwzbVBYZnhScEZQRDUyRlQwQWNtUTJyeWozNk92S0Y5MHhTcGkyWitRZW5a?=
 =?utf-8?B?ajVjd24wS3E4bzRTWlZLNHFxbWhVVm5DOE9sTTB2TzRabjJjdVV0d2w0QVhi?=
 =?utf-8?B?YmhjeTJVdmpMMG9iemFOelVmR2xKcTY3M2RxRzNWUDhOYXpkN0xjTXNFdVlP?=
 =?utf-8?B?bkRqUUNNaElMemtpUGZUemgwVUZ4Qm51V1gxRnJUUmVkM2duZDk3ckZzcG56?=
 =?utf-8?B?T0xsNjVJZUg5NGhIbUpKRGZzcy9XM2pMaWRxUUljbkJaY3FmOVhITjUxamVT?=
 =?utf-8?B?K3VUbGxjSnY0cXcxR01wRU11TEVBMkVYSVlkcU1FazRwVnVDZXRyZEM3elFx?=
 =?utf-8?B?anJINmVaU2tFRjUzd01GN05YSUV4TmdyYU5NU2VpMUE2NVp6RkJ6ejBHbUFD?=
 =?utf-8?B?Q3MydkwvSEtWZ0E0MUtCRHlVdTZEZWxLOGo0dlp5YmdXYkQ4WkRRc296T1Uy?=
 =?utf-8?B?eTg4dFZDSjZiZ3I3V2t2b0FIVkJwSE5NZ0xFeXF6d04wamQ1a0JEcEdNczBl?=
 =?utf-8?B?aDkrWnpqQkwxSnEzUkcxRzBJVHk4S2U4dXZtTFdlMXhiOG5GU1ByMEgwSHl4?=
 =?utf-8?Q?itguyBSa3MrYTjaf46PPCdbln?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942c3f6f-3d3e-4be3-b3a7-08db42a2becd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 19:58:15.8176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbbpFxgKJQOTRIX/9bDbZ2Mp4il/TOET/TaKJRuKOPQRvk1r3PO5HeEwKQVTnwR8TeZFeJdCti2o8QVMw91AEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5044
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-04-12 12:25, Shashank Sharma wrote:
> This patch:
> - adds a doorbell bo in kfd device structure.
> - creates doorbell page for kfd kernel usages.
> - updates the get_kernel_doorbell and free_kernel_doorbell functions
>    accordingly
>
> V2: Do not use wrapper API, use direct amdgpu_create_kernel(Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   |   2 -
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 110 ++++++----------------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |   6 ++
>   3 files changed, 36 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b8936340742b..49e3c4e021af 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -435,8 +435,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   	atomic_set(&kfd->compute_profile, 0);
>   
>   	mutex_init(&kfd->doorbell_mutex);
> -	memset(&kfd->doorbell_available_index, 0,
> -		sizeof(kfd->doorbell_available_index));
>   
>   	atomic_set(&kfd->sram_ecc_flag, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index cd4e61bf0493..82b4a56b0afc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -61,81 +61,39 @@ size_t kfd_doorbell_process_slice(struct kfd_dev *kfd)
>   /* Doorbell calculations for device init. */
>   int kfd_doorbell_init(struct kfd_dev *kfd)
>   {
> -	size_t doorbell_start_offset;
> -	size_t doorbell_aperture_size;
> -	size_t doorbell_process_limit;
> +	int r;
> +	int size = PAGE_SIZE;

On GPUs with 64-bit doorbells, ROCm uses two pages of doorbells per 
process. In hindsight that's probably overkill and we could live with a 
single doorbell page per process in terms of the number of doorbells 
needed. But this is not easy to change due to the way that doorbells are 
routed to SDMA engines, at least on Arcturus and later MI GPUs that have 
lots of SDMA engines and queues. We need enough doorbells in each 
process's doorbell slice to reach all SDMA queues. On Arcturus that's up 
to 64 queues. The way the routing is set up, only 32 doorbells per page 
are routed to various SDMA engines, so we need two pages.

Changing the doorbell routing is not trivial due to SRIOV support, where 
the routing is programmed by the hypervisor driver. The hypervisor 
driver and all guest drivers (Windows and Linux) have to agree on the 
routing. Changing it breaks the ABI between hypervisor and guest drivers.

Regards,
   Felix


>   
> -	/*
> -	 * With MES enabled, just set the doorbell base as it is needed
> -	 * to calculate doorbell physical address.
> -	 */
> -	if (kfd->shared_resources.enable_mes) {
> -		kfd->doorbell_base =
> -			kfd->shared_resources.doorbell_physical_address;
> -		return 0;
> -	}
> -
> -	/*
> -	 * We start with calculations in bytes because the input data might
> -	 * only be byte-aligned.
> -	 * Only after we have done the rounding can we assume any alignment.
> -	 */
> -
> -	doorbell_start_offset =
> -			roundup(kfd->shared_resources.doorbell_start_offset,
> -					kfd_doorbell_process_slice(kfd));
> -
> -	doorbell_aperture_size =
> -			rounddown(kfd->shared_resources.doorbell_aperture_size,
> -					kfd_doorbell_process_slice(kfd));
> -
> -	if (doorbell_aperture_size > doorbell_start_offset)
> -		doorbell_process_limit =
> -			(doorbell_aperture_size - doorbell_start_offset) /
> -						kfd_doorbell_process_slice(kfd);
> -	else
> -		return -ENOSPC;
> -
> -	if (!kfd->max_doorbell_slices ||
> -	    doorbell_process_limit < kfd->max_doorbell_slices)
> -		kfd->max_doorbell_slices = doorbell_process_limit;
> -
> -	kfd->doorbell_base = kfd->shared_resources.doorbell_physical_address +
> -				doorbell_start_offset;
> -
> -	kfd->doorbell_base_dw_offset = doorbell_start_offset / sizeof(u32);
> -
> -	kfd->doorbell_kernel_ptr = ioremap(kfd->doorbell_base,
> -					   kfd_doorbell_process_slice(kfd));
> -
> -	if (!kfd->doorbell_kernel_ptr)
> +	/* Bitmap to dynamically allocate doorbells from kernel page */
> +	kfd->doorbell_bitmap = bitmap_zalloc(size / sizeof(u32), GFP_KERNEL);
> +	if (!kfd->doorbell_bitmap) {
> +		DRM_ERROR("Failed to allocate kernel doorbell bitmap\n");
>   		return -ENOMEM;
> +	}
>   
> -	pr_debug("Doorbell initialization:\n");
> -	pr_debug("doorbell base           == 0x%08lX\n",
> -			(uintptr_t)kfd->doorbell_base);
> -
> -	pr_debug("doorbell_base_dw_offset      == 0x%08lX\n",
> -			kfd->doorbell_base_dw_offset);
> -
> -	pr_debug("doorbell_process_limit  == 0x%08lX\n",
> -			doorbell_process_limit);
> -
> -	pr_debug("doorbell_kernel_offset  == 0x%08lX\n",
> -			(uintptr_t)kfd->doorbell_base);
> -
> -	pr_debug("doorbell aperture size  == 0x%08lX\n",
> -			kfd->shared_resources.doorbell_aperture_size);
> -
> -	pr_debug("doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
> +	/* Alloc a doorbell page for KFD kernel usages */
> +	r = amdgpu_bo_create_kernel(kfd->adev,
> +				    size,
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &kfd->doorbells,
> +				    NULL,
> +				    (void **)&kfd->doorbell_kernel_ptr);
> +	if (r) {
> +		pr_err("failed to allocate kernel doorbells\n");
> +		bitmap_free(kfd->doorbell_bitmap);
> +		return r;
> +	}
>   
> +	pr_debug("Doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
>   	return 0;
>   }
>   
>   void kfd_doorbell_fini(struct kfd_dev *kfd)
>   {
> -	if (kfd->doorbell_kernel_ptr)
> -		iounmap(kfd->doorbell_kernel_ptr);
> +	bitmap_free(kfd->doorbell_bitmap);
> +	amdgpu_bo_free_kernel(&kfd->doorbells, NULL,
> +			     (void **)&kfd->doorbell_kernel_ptr);
>   }
>   
>   int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
> @@ -188,22 +146,15 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>   	u32 inx;
>   
>   	mutex_lock(&kfd->doorbell_mutex);
> -	inx = find_first_zero_bit(kfd->doorbell_available_index,
> -					KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
> +	inx = find_first_zero_bit(kfd->doorbell_bitmap, PAGE_SIZE / sizeof(u32));
>   
> -	__set_bit(inx, kfd->doorbell_available_index);
> +	__set_bit(inx, kfd->doorbell_bitmap);
>   	mutex_unlock(&kfd->doorbell_mutex);
>   
>   	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
>   		return NULL;
>   
> -	inx *= kfd->device_info.doorbell_size / sizeof(u32);
> -
> -	/*
> -	 * Calculating the kernel doorbell offset using the first
> -	 * doorbell page.
> -	 */
> -	*doorbell_off = kfd->doorbell_base_dw_offset + inx;
> +	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kfd->doorbells, inx);
>   
>   	pr_debug("Get kernel queue doorbell\n"
>   			"     doorbell offset   == 0x%08X\n"
> @@ -217,11 +168,10 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
>   {
>   	unsigned int inx;
>   
> -	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
> -		* sizeof(u32) / kfd->device_info.doorbell_size;
> +	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
>   
>   	mutex_lock(&kfd->doorbell_mutex);
> -	__clear_bit(inx, kfd->doorbell_available_index);
> +	__clear_bit(inx, kfd->doorbell_bitmap);
>   	mutex_unlock(&kfd->doorbell_mutex);
>   }
>   
> @@ -280,7 +230,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>   	if (!pdd->doorbell_index) {
>   		int r = kfd_alloc_process_doorbells(pdd->dev,
>   						    &pdd->doorbell_index);
> -		if (r)
> +		if (r < 0)
>   			return 0;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 552c3ac85a13..0b199eb6dc88 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -346,6 +346,12 @@ struct kfd_dev {
>   
>   	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>   	struct dev_pagemap pgmap;
> +
> +	/* Kernel doorbells for KFD device */
> +	struct amdgpu_bo *doorbells;
> +
> +	/* bitmap for dynamic doorbell allocation from this object */
> +	unsigned long *doorbell_bitmap;
>   };
>   
>   enum kfd_mempool {
