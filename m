Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE55C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69D210EDD6;
	Thu, 30 Mar 2023 11:30:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739C710EDD4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJn7xu25oAFAtgcbXC6LSMgT3aG3Bogu9+iHobWEhPLOJfYfBxFUobJK8wXcNww1EWaWEKJx3LFfA9kyqBXqhmPzl3iHNCOpTvVbRbPU6FPXGqtOLiTeZAq5L/cgRWYbjLwAoPHgDuSz+cWyS8sch7qOfDcwtGZ/pZkApTfoXq8upXMx0V3k9MqwK2hM1+C0dB6oQKI313X53yOO1YUor6KixVcpKQvolmaJz/hvi4l2mwQXcPIXLWpYkxNScdjpLnAS4tq1kgAamUKy8AlvvOjWYBs0ELf2nDMAghlvYteCvVp7lw0Yj2sLCvxiDjDsgh9rflYxWVetOsp7OwtPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BjLvDOKziP8yZVR4GPLBp/o8XpScCLniZp330Yzjx8=;
 b=C0sGiaUhkwDJxfs1aNOeNcd5M1St4DSk7vbFapTCjzkk1Z6y637ZXTfbSvQcx91GwFaZ+PGbDsWHgPSXYDHjsbLCSvl2C7T+FdmI0OU1/h0R4WVV9bVzAVpewsPxjzfMpigx1eiIU5tyHYEUq5fnWiMojfGnMyoMuxC268c/yJBEH7Rx9HXoY1zddiYJcqRkxv2982dqaMvteb0Hs2qm//9iQmu0DcM5ttUIcZBwxQFEAwomPNNivixxw4ohU2uzfmMq2lFHhfzU13LA69NTAtXQnc1zSlzqP8Av1YC9GO/fUfJ6DJ/nqY+QJsgPEtYx4SZbG4hRHGdsZNzYv1AYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BjLvDOKziP8yZVR4GPLBp/o8XpScCLniZp330Yzjx8=;
 b=iKPpGh+w2syASTjgaeSAuYcs/ETzlXyczoSMwzmuy+anhG5LR9Z8bNZO0S5rC7FARhEV69JBppSiFytRdsGUcTLO/K9uJWeexdmakpUBK+3gDTFmfIN4/1M0b0BETyy2g2s+Hy5y9A4Lcs8AnwLeOeOp2nq0AMDQ4gj8w3ojB5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Thu, 30 Mar 2023 11:30:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 11:30:31 +0000
Message-ID: <4c4776ea-c53c-a37a-ba4b-3a0be4e7645c@amd.com>
Date: Thu, 30 Mar 2023 13:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230329154753.1261-10-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: d08a3fd9-dc74-4b2b-54af-08db31122b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+mewXUMQldI5itWyf3+dEFq7sHi/Sa8LcSQTQKEgzk3WzkEkJvovwegzdlYD7Zi+bj0RlPSfvJf/QTxJ70CPQLVGC8LC1tevkB2FD96sOSecXkwjdGJ+KXhriZL4hj+gZVkHPt1lbFDmFd5pi6j1r/24E0+FBTBbXyCDXspHeJNKi8kMmqlzidiQQpuM8GckO+9ykKyKES305PwVJIm0LPzKof8lxx+8Ifl6gNQsN/fXqT501jMFLnDR/50mVU4QBAmiGaJbB8AwepcmuOIPjGlwmG6vC43QE/FY6YmB9UhvvK1hjh0fRb1oLkBbfRah6a1HF6+D2kkrihqQA9P3XvKqJ5crvLfhL5QHM8wDcwEFD/ASUkZqBIAwWleEzVt3iLcIFKanUZvnTZ/V1KjXUtBaE6ej28KyLwBSqE4D6mxWUUacrD4ChajWDvHabDb5mbP029UUB3YDt6NTrFO0Kh6P86fbtdRyxtpA1xkoh8koyhYfA3zNANZdx6MkHxR34UCzdACa45zr8q8Y7xoUJY7hDn1BHqfBPrgsMD6g8j/mX5tQa2hRCMb8nBv3BSrlGPrYd6c3Ya+Rx99T1Wc2TPnvT19vmNxLRoe9t5g8NNw6xZyi88pMsU275C42JvDxUMgiCJdMNnqG1723AUDlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36756003)(31696002)(86362001)(2906002)(31686004)(6512007)(6666004)(2616005)(478600001)(6506007)(83380400001)(26005)(6486002)(4326008)(66476007)(66556008)(54906003)(316002)(66946007)(8676002)(41300700001)(186003)(8936002)(5660300002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWlDWnVURWpXM09oZWpFMWlOeWlqaUxaYVExaFlRTzh3TEplU2JSTHN6MW1K?=
 =?utf-8?B?ejNSWTNFK2RQV1dBK1ZJY1NJYWR3cVlCWm1jOHpYdURKbU03c2VVdnFkUStF?=
 =?utf-8?B?SWNrZXNVMCs4bTZUdG05b0NNQnpYWDlEYTZJS1pFYkVJYU1vT2VqWll1STB2?=
 =?utf-8?B?RzNNWC9wTDNqdTFHdjA3MVhuOEM2RlFhTzR3Z1pHc09FcVoyYkpieU5sbC9T?=
 =?utf-8?B?UTVMSTNOZ2tENElKZ3ZMK3FlUnkvODVta1JuMlhLcWQyd0h5RWxNcUkyZzBQ?=
 =?utf-8?B?blVtT0ozQjRNMFVLRjVrTFF5bmJPSkV0RkhTSHFKWk9OVStFZmlNNGZ1dk1D?=
 =?utf-8?B?TGVyeEZTbmRFa2c3QzhQdmxkbzYxTmMxZzN4NGZjdGg5Zktyd201ZTdjSUFS?=
 =?utf-8?B?SEhsTGp6RmgvdjQ1QVBLdjgrMm9OKzFQYjRlNUI5dGpKRFhPRmVZZEpvT2J3?=
 =?utf-8?B?dWdRTlVGMzMwN1FSUmtkOXljVVFpU2EvVFFpUUNVcS9OTW9xNUVTTVhLSFhr?=
 =?utf-8?B?alh1ejZ1My9kdFJUL1RsSEFpNERIbHJGS1UrckthWU1rcEpHY3pQSWs2NG5m?=
 =?utf-8?B?WUxsTUp0TmZRNGcvMTh4YkxNc2hielpYR2tFbTRDRTdqTTZvS0FjcElmd1d6?=
 =?utf-8?B?TTNyUkRoWjd4Ulc4SWJvTURiODB5VVR3TnFSdTBJaWJFOFZIQ1JZbXpxYlBa?=
 =?utf-8?B?UHVMUmN5YU8rU2hZWmNpZ1RFQW9Ka2FOaWlldllVb2NlUjBzU05selBLSFA4?=
 =?utf-8?B?d1pJR2JjeFB2RVJlRXU4UGN4aFVNTyttcTBiNTA4amZXRndsOWxtdG9sQ0k2?=
 =?utf-8?B?Rk1QaHUzVmVURTc4ZXRpbnp0dlFTWXVDNzd4bDZhZ01JV2U2dnZBWFRVNmxV?=
 =?utf-8?B?dWZzYmRud0orR2YzSHhYTnhWU1p0SUZSMzlONG5oZVFVMi84V1ZwemJuTzNi?=
 =?utf-8?B?QU84TG0yc3c2aWxJNFY1alorc3FyU3laWkNZeldtdkRpOVhKMFBWRWlJQVpu?=
 =?utf-8?B?YU55YnNCeHNOWUpYNERpQy96RnQrQlV0elJLUm5UeldTNUVhcloyb0VkcENM?=
 =?utf-8?B?TTNVZjF5Vzd1VHNqRlE3VFhXNXZSVm91dit5eVROVXNLbGtoZml0a0ovaEgx?=
 =?utf-8?B?cmF6b1FVWlh2UVpjQ1lBVWk4Z1VaNjB5RkI4TWFyK1dzd1Naa045Z3gvT1Yx?=
 =?utf-8?B?S2lMdEUwRzNhTUpEL2hhSUFHVEtRQzBpbVZzZ1gva1RsQW8wVmxOMGFkUGRR?=
 =?utf-8?B?UGVBbTJLWnB2emxSUnY4aEt4RWd6eFloblpUT21VS3ZnbUlWNzFxNU9vUENm?=
 =?utf-8?B?OFc0TCtLOElVVU4wYktnbXZtcVBwTnFucUV3N3VHUkVkU2h6eklFYzRaUzdy?=
 =?utf-8?B?TnNjVWVISGVmL1piK0RtMjRxL3k1YnQ5Z2kvMkI3bzFha3VOeDVmaWdrcDlW?=
 =?utf-8?B?ZjJweUtRZThUaTJIS1ZMUFd4eFhMcGpJNXJ6V1BKaDI0R0xCM0pDMkVjVjJh?=
 =?utf-8?B?OFRTWUlwRUpJQjlCOEFLaEUrQWRhZXk3UDRkQVVJRnh3RTFka3F0S3dmdTRD?=
 =?utf-8?B?REp6dURwZHd5T3oxTmU0UXFrNHZBMVkzcDMycHBLdFp2dG1TT2hNTzhqU0Yv?=
 =?utf-8?B?WGczU1NLUytZeGduekxWOTJoRGg3Y3Bxb0RydTNDbGJQaDlFOUxqUTBWdVNB?=
 =?utf-8?B?Z3hVTnlLTGdZcEEvYzZhUkNEQ2RVUitDN2d1enI3R21FdldSRG1mNFlLVVFu?=
 =?utf-8?B?TC9aSzNZOG9wZTJUNk9WeWxWaUtsRXVLTE5QeTAweVlGMnMwQkswc2Q1dGFL?=
 =?utf-8?B?R2RKazlreEFPakk3bElRVGNDY2F0ZjFENmswT0NrWW5kN0RMQldnUEYrYzRs?=
 =?utf-8?B?Zm5QZ3JHcDdzU1RHQkNjYkNrZ2hlUmpjVGZzUmxnMTlYblBMNTVBTEd6ZHdx?=
 =?utf-8?B?VzUwUEZYT0Z5Unp1Vno3ZTNEMCswNGM0WUxJSUx5cTAxOHRPSFhXbEpUY2Q1?=
 =?utf-8?B?UEdMbGsrSFp3UnF2N1JoR0lyVXA0ZzYrQkp3VE40TDNxekQ5NVM1bHJoZjBX?=
 =?utf-8?B?TXRERlpVM2YrQmF1VmtrbDNuU2NUNkpEVTJJbEt1SVdmSnBUS2Y5WVlNeTZp?=
 =?utf-8?Q?xj7s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08a3fd9-dc74-4b2b-54af-08db31122b35
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:30:30.9246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/GOx0QHVQ91LvU55dYcE8LpGZOvDNR5FjPu1RWdS5YCTRW3F5N2Pu3oXTXlh3cq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch:
> - creates a doorbell page for graphics driver usages.
> - removes the adev->doorbell.ptr variable, replaces it with
>    kernel-doorbell-bo's cpu address.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 +++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>   3 files changed, 57 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 6581b78fe438..10a9bb10e974 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>   	/* doorbell mmio */
>   	resource_size_t		base;
>   	resource_size_t		size;
> -	u32 __iomem		*ptr;
> +	u32	__iomem		*ptr;

This one can probably go away if we use the pointer from 
amdgpu_bo_create_kernel().

>   
>   	/* Number of doorbells reserved for amdgpu kernel driver */
>   	u32 num_kernel_doorbells;
> +
> +	/* For kernel doorbell pages */
> +	struct amdgpu_doorbell_obj kernel_doorbells;
>   };
>   
>   /* Reserved doorbells for amdgpu (including multimedia).
> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>   int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>   				struct amdgpu_doorbell_obj *db_obj);
>   
> +/**
> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Creates doorbells for graphics driver
> + *
> + * returns 0 on success, error otherwise.
> + */
> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
> +
>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 8be15b82b545..b46fe8b1378d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Creates doorbells for graphics driver
> + *
> + * returns 0 on success, error otherwise.
> + */
> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
> +{
> +	int r;
> +	struct amdgpu_doorbell_obj *kernel_doorbells = &adev->doorbell.kernel_doorbells;
> +
> +	kernel_doorbells->doorbell_bitmap = bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
> +							  GFP_KERNEL);
> +	if (!kernel_doorbells->doorbell_bitmap) {
> +		DRM_ERROR("Failed to create kernel doorbell bitmap\n");
> +		return -ENOMEM;
> +	}
> +
> +	kernel_doorbells->size = adev->doorbell.num_kernel_doorbells * sizeof(u32);
> +	r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
> +	if (r) {
> +		bitmap_free(kernel_doorbells->doorbell_bitmap);
> +		DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
> +		return r;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * GPU doorbell aperture helpers function.
>    */
> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   		adev->doorbell.base = 0;
>   		adev->doorbell.size = 0;
>   		adev->doorbell.num_kernel_doorbells = 0;
> -		adev->doorbell.ptr = NULL;
>   		return 0;
>   	}
>   
> @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   	if (adev->asic_type >= CHIP_VEGA10)
>   		adev->doorbell.num_kernel_doorbells += 0x400;
>   
> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_kernel_doorbells *
> -				     sizeof(u32));
> -	if (adev->doorbell.ptr == NULL)
> -		return -ENOMEM;
> -
> +	adev->doorbell.ptr = ioremap(adev->doorbell.base, adev->doorbell.size);
>   	return 0;
>   }
>   
> @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>   {
> -	iounmap(adev->doorbell.ptr);
> -	adev->doorbell.ptr = NULL;
> +	bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
> +	amdgpu_doorbell_free_page(adev, &adev->doorbell.kernel_doorbells);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 203d77a20507..75c6852845c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	/* Create a boorbell page for kernel usages */
> +	r = amdgpu_doorbell_create_kernel_doorbells(adev);
> +	if (r) {
> +		DRM_ERROR("Failed to initialize kernel doorbells. \n");
> +		return r;
> +	}
> +
>   	/* Initialize preemptible memory pool */
>   	r = amdgpu_preempt_mgr_init(adev);
>   	if (r) {

