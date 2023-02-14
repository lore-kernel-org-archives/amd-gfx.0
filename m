Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F65C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 18:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002BF10E266;
	Tue, 14 Feb 2023 18:35:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C6710E266
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 18:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFgocPlCjmrXKI8dElZcgIRHMRl4trdmiPBt+kdP34mIl2+DugKcSI013qhrfrzc1sE7fgkcnuYIIHM/h61E0sQuUaXi5XVI4hB+xM4LQR1ZUzh4FjI/0NcWdm7nNTwzIcyiJeA9HKdx6o91SeyUMV5etTlwqLdbO5lAImIoHsawMJAa3IAC5QIqIfPxjqWHjOJFHem7qP+gErivsCf1NuYLRRDmtdqDP9xCDAA6PjNGeVL5XjYfnNJ+SIruXiW5DIPRFiN3juGpmDXmaZ/z+5gxmPRmgkIZyxEpjen4tD4t29cxAs0QY/dLUdqNWz8BY79LR5bmx2OogNHvp+uB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBgRO8zcv1y0boigahFkwY1Fz8SUrH0xB2R5+qTXLmg=;
 b=bQXbd/LHJ1h1bJW4GJWfcFjJFF8b08KLiGBfTBfzPB15H6RFk17Vjcm1qXfga0t/6J+DCLgeraZ7VkfL0tqCEwCo9J48D4muHFahMD6Lxi2WhSXxvszPucJHZZ+k3OBxvQqR/w4ZHq3iqZHx4G051No+PMVlmebc/7wUtTa1Pz3vjHXHBWVcZh3b25de3fMd+QqHSSEhBTuPIs0xGCis6c5YmUr196+1msd5EfkafQUj+6nlxoGxjlcZkQS2Nu2Cx4jLnXzKtfARoPFLKy8XM5qdhv7sQuRHRGy3xoDjRw4DDVUygwl57Z/0gcIWqL3at93mcL+aB3JKaR0NCoMYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBgRO8zcv1y0boigahFkwY1Fz8SUrH0xB2R5+qTXLmg=;
 b=4wIrqm3XKQUSy10wFef14FgTBJLCryPQMFbMVJX2f+APTtw0HImm8XRWoFgFV7mQrUvb7Py8DSIB8eBGSmE7/fACxZfcKRoSxcXJBw62iiBxW5DJHEMWvSsPWqLxaE1tffQzt3wxBY3th3uLMqSx7pIeUN2bMK6VHnTXqPXU9pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 18:35:15 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 18:35:15 +0000
Message-ID: <4d5dee60-537d-745d-9bc9-1246f50427fe@amd.com>
Date: Tue, 14 Feb 2023 19:35:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 7/8] drm/amdgpu: create doorbell kernel object
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-8-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230214161510.2153-8-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: ba845a05-4729-4313-9de4-08db0eba36c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoyA8730c1fdxh4xPDodb+/P5ja2fDs/iwC4fP7eM5fgopVhyZwYrEDdxRDmkrtwEv5iMCycdWA0sDtnwFPLia64h12LgRF4wuKHW9fDduBxezz0ryxV5mHIj7lrMS6ger27w9Isuc58u9rNGfO/TlrFRWfFY5eXSeRhwqkqIxvguhv4OUXTH6gD8XFG4O2Ey8BdVcJ4knLuaBzKRBvHJTWti3V4f7BNYzIcKVM/SA6EgTU+O82L2lW2ZOjZxDQNklsVLnVwuijCEsPnHlAJu9ll+ZmTI8v9S8rMUfl0xJQGEC+JGNlc8VikGR4CAV1V9eL36oG/yYz+Z2PC3qzwCaPuxNqHA2O/zNoBetubQ5v7pZvUKFCbBdTzA/M83Uq+kYPlBvO/WRuCNy9jb7yuZ+LHS/0pFYl8tl7Rb9RaN4386500n993MWHRY7kNw6C0aJ/tgTpKkha6Npd4ZsG6c5eNnBqdxsZc8BAxAmNHg6q4qM0f65Ap98AFo6RFCi+cyL+io3WMlFr5nOwFB5/OWUeW2Szybrnm1QOvG+M4Mp+8cru72D+/zgDjYixL79ls4Fg5LJK3YwpVc7i/4jkwBNxLU/Pwzg4OV7NjdYVJG/lh6qrN1qil2BsvTkJjpIyidAKzT5jbPtNrDM7LPWqn3oO449YIs0k7F3KguJrY6lS4LqRyO27jfiCBvV2Fhwhr5hkOeFLGjfJw0OfPvh5rpP02+D1sKwxOA9gkUF5T5Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199018)(31686004)(4326008)(66476007)(66946007)(66556008)(8676002)(5660300002)(8936002)(41300700001)(38100700002)(6666004)(36756003)(2616005)(6512007)(186003)(6506007)(478600001)(6486002)(86362001)(31696002)(83380400001)(316002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRadjhZblVvMndxZ2ZnMUFpSkNXVCtqeU5QVmNGTTRMZk84aUU3TmJHazBZ?=
 =?utf-8?B?dFhuQzdGRlMyT2daNnREakxIdWtYcGh6RmZhWGRGQzBNVHd6d0Y4L2hPWE1t?=
 =?utf-8?B?RnI2UzNEbk1kVXlLc2tvQjBpN2xYOWRjbVdIdGlkNVd3VjFTbVoyUG9SUmlI?=
 =?utf-8?B?Z2ovRmdLN3k2OTFoTFgxQUp5ZC9JWVd1RFdRd3IzNWpqTTI2Z0JMTDhLbzFs?=
 =?utf-8?B?SHNwOG5HNkdyUlFaMnNwb2JNVDEzOXB0YitialFOd2VYSk5nZXVCVjJadEdk?=
 =?utf-8?B?ZEFYZEtKMjAxN1Z4TTl2czAvOVV4eHowc09lWFhsaTdNNG5tdGdBUk1MbnVq?=
 =?utf-8?B?bzlkL0hsTGxPN0dUb25LVTQ3SGtaREtyWjhqM05VVmZzZElZQ3lMZlhva1BP?=
 =?utf-8?B?REtGQ1VqVkFIUGM4TnZib3pKYzJFek4zUG9kaGlmcnVVbU9sWFR0WTgxWnFh?=
 =?utf-8?B?UU5ZdkJJMG9BRE96Wk4vR0Nya1dCNnc2N3gzZUMvQnhOb3ZEOWNiZHlycmV1?=
 =?utf-8?B?THA3clh0a0hKYUVGazgzTGdERzlaK3B4bGFYYWJ2WWUwZ09wMVRlbkpXNGk5?=
 =?utf-8?B?R2hxc3FXUWJDTEo4QkUzODdUQlh4NXh1VWxqSHFpZnhIbnE0RmExdHBPUEdS?=
 =?utf-8?B?bGR1VzBTUDliVGtiazJNMWNmMVQ4OVVGTmpZNW9XdWpTQkVMYUtVUGZCbERi?=
 =?utf-8?B?Nys5bG1Gc0Zqd1BPQ3R3RkMyTytnUy9mbmZBN0xWeURPQUZ1MUtFemlWUGNn?=
 =?utf-8?B?NFpRZkhnOEIxRjdhWFhPWnVVdnorVElueXNNRWF0RVZVOVgxdDVKeXh2OWor?=
 =?utf-8?B?T0tvekp0R1Yvc01QaktxdU9KRTJtOVB4WDBER3lhQy95S3hDRWtVbHhtRitn?=
 =?utf-8?B?QWRLSTBJbnExS0g3cjB0MERjRU9rajVNOTdxdGp6QW9tKytXYWhXSEEyR01v?=
 =?utf-8?B?VHNhU3BTb0FaVC9wTVVmVTYrTDNNK1ZZNHFwTkdDV2IxcUEwVVNIeFJRUjN6?=
 =?utf-8?B?SjBxUHd6Sy83QVVROUtnTFZaS1VMeWxwVTkrU3o1TUZuMU9jaHNMQmdwUzNy?=
 =?utf-8?B?a01Pb0NyVXhEK1lsa2ZMSGE0cXZSSDg3UHpCY1pFUDVJK0dWYjFnWW1WM0ZL?=
 =?utf-8?B?OHppY1MvZFVRNXNZSFNwbGg3NnJNNVAyU2tVNE56MzRYOEhCc2ExMm9lSTJD?=
 =?utf-8?B?Y0w3VFVPMERlVW52TjhWSDY0cnJKM0N2aE5kRGRDQ0FsME40UVhRNTcrcEJ6?=
 =?utf-8?B?REpwYXRDZzRPRWthYlkyOUhFUHlFb2p4c1kxaTNSNUNkMUIwZm9UQzZjcUFT?=
 =?utf-8?B?YkVVNzZjMDluc0loRzZ3dzl3VmZHMkk2azJ0ZkxHQ01OUkpXVVlqUkgxalZh?=
 =?utf-8?B?clI5UitpTUNqa3poK1E0b1hiVDBkNFpFeVpGQWU1VDlYZzU5UVQyTzM1ejhp?=
 =?utf-8?B?a1hqVStrU1pOV25DN1Q5MndUMHJUOVZIZE1NdzNLVGpiSE9ha3NVRWlSTFgr?=
 =?utf-8?B?UDhpMEdBUVhoa1l1V3VGZW9RYi9ZbzZ5MGtGSzJ1SytaVTZBME5EYmNZNTRx?=
 =?utf-8?B?d2JQbE11ZlZUblV3NTg3cHUzZnlxV1VFbVZtc0NycG9FUHMvZkcwNW8raFMr?=
 =?utf-8?B?Y3JzV3Z6NWVoSFEvaG5LblN5MTdMQjJqUjdCa1ZnRVJaYXBLZExuOXpYaFhp?=
 =?utf-8?B?WFM5cHJXL01JaXFzalNNdkx2UjQwUEE0MVo2bXZVbFdKbWFUOVkrYjdMcHJM?=
 =?utf-8?B?YS85WTgrSjhDeFZITFVTdzA4ZnhMY0xoVFpWUmh3SU1jM3Fnc1dxNDVoZldM?=
 =?utf-8?B?cTg4MVg1NFA2WndKMXN2aTFuZDdtMnlyUjFqN0lxUFdPQkRqV0FPUkJiV1BD?=
 =?utf-8?B?UGNFb0FoaWtKVVVaenZmTkhJV3l1bU1KNUwyaXkyZHd2WXBkRUM1alNnYkpo?=
 =?utf-8?B?cmRYSkZCcjdCVjhWYnhuMWk2VXp6M2NTaGVmOHR5V213VHNDOWxsK1NXZTYz?=
 =?utf-8?B?K2ErMUtnVTRlUUs1QjNFenZrUGJDclNxSCtqR1R3aWxhK2Z1Y2JaeXBTOXdV?=
 =?utf-8?B?TjJXM3paSTRXT1hycWxxbG1IWmp5T0JZb3V2bzdPTTNZckI1M0x1WUROenM4?=
 =?utf-8?B?S2Y0Z05Ua3dSWnZ0enZuMTBRaGx6dmFCLzBjV1ZKZ2xnTGl4MUhyamRkV05J?=
 =?utf-8?Q?EW5FBTuCh81SHhrgEoVKWtvO98YR7MYX3WulZsSJ/19V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba845a05-4729-4313-9de4-08db0eba36c3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:35:15.1677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oI1i0met8se9Ld5CVenZUFTk+0KD+hKavWkHz+lAjhAFuNfMwQCjjncknqQ9PzGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 17:15 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch does the following:
> - Initializes TTM range management for domain DOORBELL.
> - Introduces a kernel bo for doorbell management in form of mman.doorbell_kernel_bo.
>    This bo holds the kernel doorbell space now.
> - Removes ioremapping of doorbell-kernel memory, as its not required now.
>
> V2:
> - Addressed review comments from Christian:
>      - do not use kernel_create_at(0), use kernel_create() instead.
>      - do not use ttm_resource_manager, use range_manager instead.
>      - do not ioremap doorbell, TTM will do that.
> - Split one big patch into 2
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  7 +++++++
>   2 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e9dc24191fc8..086e83c17c0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1879,12 +1879,32 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.doorbell_aper_size);
> +	if (r) {
> +		DRM_ERROR("Failed initializing oa heap.\n");
> +		return r;
> +	}
> +
>   	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>   				AMDGPU_GEM_DOMAIN_GTT,
>   				&adev->mman.sdma_access_bo, NULL,
>   				&adev->mman.sdma_access_ptr))
>   		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
>   
> +	/* Create a doorbell BO for kernel usages */
> +	r = amdgpu_bo_create_kernel(adev,
> +				    adev->mman.doorbell_kernel_bo_size,
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &adev->mman.doorbell_kernel_bo,
> +				    &adev->mman.doorbell_gpu_addr,
> +				    (void **)&adev->mman.doorbell_cpu_addr);
> +
> +	if (r) {
> +		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
> +		return r;
> +	}
> +

I would even move this before the SDMA VRAM buffer since the later is 
only nice to have while the doorbell is mandatory to have.

>   	return 0;
>   }
>   
> @@ -1908,6 +1928,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   				      NULL, NULL);
>   	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>   					&adev->mman.sdma_access_ptr);
> +	amdgpu_bo_free_kernel(&adev->mman.doorbell_kernel_bo,
> +			      NULL, (void **)&adev->mman.doorbell_cpu_addr);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
>   	amdgpu_ttm_drv_reserve_vram_fini(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 9cf5d8419965..50748ff1dd3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -97,6 +97,13 @@ struct amdgpu_mman {
>   	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>   	struct amdgpu_bo	*sdma_access_bo;
>   	void			*sdma_access_ptr;
> +
> +	/* doorbells reserved for the kernel driver */
> +	u32			num_kernel_doorbells;	/* Number of doorbells actually reserved for kernel */
> +	uint64_t		doorbell_kernel_bo_size;

That looks like duplicated information. We should only keep either the 
number of kernel doorbells or the kernel doorbell bo size around, not both.

And BTW please no comment after structure members.

Christian.

> +	uint64_t		doorbell_gpu_addr;
> +	struct amdgpu_bo	*doorbell_kernel_bo;
> +	u32			*doorbell_cpu_addr;
>   };
>   
>   struct amdgpu_copy_mem {

