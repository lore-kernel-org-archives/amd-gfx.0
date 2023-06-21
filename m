Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CF8EB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 08:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3211E10E40E;
	Wed, 21 Jun 2023 08:32:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304EC10E40E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 08:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hADziFCzpT31y3sCjt9Spt9mkHzKV75Mr41dGPhYVlKTIQlUuf7MIMR4Tx7Xhtvx0pTcy/3fqPqYDnWIv+QV+WtMOCjHJta18fq21kLlatxZWlL6wHn+Bb/THOLyYCf17rhRhkzzd+Ai7jS5JmyySLsfvAg0rnvMqW/WxlV7UjfNXSr3KMYO6vqp8daEfh4N5lhiAd4ltq3lgeNqHDWnsBlk97TTO20OwWgdp1oco8gcYV+bh3IiQqTDpDECb0H9Hct2y44Lq7qHgNaxp5vwtxVlE93BkNphedkQPgvwD97ug8FYWZ3Nvao9Ad5Av9asdRdO2snEh9OcZkVYfMzwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTETFGoNrQSbeHq8Q3ClBR2wzSv/pHWxPByKfmrR/8A=;
 b=S0U8W+Ufrd0H6h7QY80N2RKitJpjRWbc/YHitBhG/i06s3WBEpL7gCzr3Vwr9sVZha5/ri34Q0XIb1TgpD1YU4IGsBLFB61tnbDmLzfHE8Lr+uZobt6nNVpGF4Wr2hRf6bHlxMUsZbdLoHmtHB+KgDslPoL3ZbkYkXF0rQk0S4YZ6gcEVhbu8AXiO746PXStppbB7nevRE3YuS+Olp0O6RSvyrb0fO/gSXx3HIXeGl1X6q9nZBY8v9fo32SwFJzvsHiAutF7vr41qCiA1VmQtA8h0Ah48s8mzJidGAUgcLJoyokuYQraqeckntrmUUe23vBDxQGOaMnoAUe8vkXchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTETFGoNrQSbeHq8Q3ClBR2wzSv/pHWxPByKfmrR/8A=;
 b=4QFH6fdMv1WYFQaB2NvK/v4nG0d0osYSuM/rvjEpFqrB9lwut0ig40JUtAAUTdqnVgf03xeuR4i/tAAzI5NHMBaHyaFzd0AAP64Vpmgv9nTB+yzSX7G8Dc1LjOucaEXVlGsaKkkq6p7mwOSaUNuybVHnawJI0CGpuKaYwMJl+g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.39; Wed, 21 Jun
 2023 08:32:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 08:32:19 +0000
Message-ID: <a794a151-dec5-436e-fd92-c9e49b3c744e@amd.com>
Date: Wed, 21 Jun 2023 10:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 06/12] drm/amdgpu: create kernel doorbell pages
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230620171608.2131-1-shashank.sharma@amd.com>
 <20230620171608.2131-7-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230620171608.2131-7-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 045572aa-f070-4fc6-8885-08db72320696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqILZ468GCL6bxAUtxdKXfVfS8MoKz17Qtt/igKlw5nNnrEgVbrgRanA4BLlf6+wtjzm3C6skEM1C+CsrS5RGrpey/g/Is28OpSLLmxzAMtsc4sJvVyl8zxwmcWFW9ojsJBLQURbCT/edNJlmwkNB0bHDNOmuBE1V9IrVuKQgDLm/ft7iqQNBhrWviTiqG+HzG/+//XWrYQyBiVq0JryBSXgi2tyhdlqB7jb5clfIzAeAYdLCc41VZBM5msZ6fWcFVQDEKS+lE4oF/EDupNrDNcwV25mnTX37NzR6qqNcw41H6J2mz7MMYXmTW6gIhnOYBLee1ElNO5kByLC0WpxX3UH4n4JxD8nqglmLP3RcSALtEEPxtJqTRkRlhY1inJwK7iQSm8bMh35NjDU3KAuGbE4iiPBgV8JXLewiukpOmJgA5mVDB5rtUN1JEmRTOsaFQoQoXMTtV1N5q04Rie5vcxQMHBRpbeRkrv6EWJ3en6/nFspmG49rqQPfUCBzJL+jN5Eb/MCdG8pH4+9/pQLni1hm3miL/EnnG+y5SV/OcoeHr4Ep8ntW43ES/5tEuNSW5XYt+0M5Eh4jTQwE1hzZfOp8nlR6NcpCrsLCLUhHxtc/BmaOt2mcqpxB+1UOUVtTaLj0JjHtnw4SrPKvr5ZaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(38100700002)(6512007)(83380400001)(6506007)(186003)(2616005)(2906002)(5660300002)(41300700001)(8676002)(8936002)(36756003)(6666004)(6486002)(478600001)(4326008)(66476007)(66556008)(66946007)(316002)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THZ0Nkl1YTZySHdNREJLazhYSmF0ZG4wQmRXY2laWXdzTlNuc1NzTTFyUVpF?=
 =?utf-8?B?SytLVWF0ZFZueVJqVm80cWNUMlVmdFhJQ013elMvVEJ5NzFNM01QbEwvYXZX?=
 =?utf-8?B?Y0xxMW5SV01zeDJwTXNDK25MRkNtRVVWeTVWeWdTTkZBNnVhL0p6bDhvZUhZ?=
 =?utf-8?B?SU5PZUEzOXVUODN0em1VZnFjMDV3eitKZEZ2YkZNdkVGV3EvMlgyL2VDbFVL?=
 =?utf-8?B?cUpmN0ZwTGljTGU5clBWR05LT3l6R1JZUDkrclp6c0tFRmU2QlZGeTBNNEVP?=
 =?utf-8?B?OEpqVkYweWx3TmhEbFEzOFhzaHl2RDIxL3pUbnpUU3hZRU81ZUlwL0JNOU5q?=
 =?utf-8?B?M3R3OTVOc1N3eEl5cDJ6L3pwRzB4dDJrVkdCWWdrWnNpbnQzd1dhTjVIMFpF?=
 =?utf-8?B?cFFCbndWVGtQVDk3Z2ltSGJITXRMNlRpTlhYT1AwaTM4Y2xWR1lBNWNDTWha?=
 =?utf-8?B?Tkp4L0xYVk5pb2RsQVhFdFRxNko1VGZlMC9NYm1UL2tYWUplRUl5Mk9YcG5l?=
 =?utf-8?B?ZGtGelplTDk0MGVxVEdlU3N1eHhEV1hVcFd2VmY4TlF6c2xWM25LK3Vob3gv?=
 =?utf-8?B?ejFTQjVzZ2VNN1E0Slg1cjRnWlJ6YURDNkZDMnNVUTBEbkdpdzlUNm9sT1BK?=
 =?utf-8?B?UFM5ZHl6ZDNSbGR0RWJsQjJCOUR4SXNGVFZZSDNmaDduMUJ4S3JzSUV0Q1o2?=
 =?utf-8?B?U2JzRFdHMFdvLzR4RVlyemtPeVl3RnBtZ3VkYzhDbllvVUFNczF0YXR1Z3V3?=
 =?utf-8?B?VDFaSG5pRlJjSGNETHFnSUJuRGM4UTlZenY4UlR3WUJpajk3cWZzOERLaVQ5?=
 =?utf-8?B?UG5Dd2Y1V1ZJd2JCeHRBK2RxZy8yemNBbThxOURqcG1RcXZjYnR1RUM2SHor?=
 =?utf-8?B?ZjA4ZjBQU2ZRd2wrOUlrTUtxZmhYL0VYK2dPOXBOUmIxZThUYlJpYXpTQTAy?=
 =?utf-8?B?L0RISWJsUzc4R1NrbkxEWUR3L3kzY1Vzd05raERBRDBrMzd1akR4dWFEbi9w?=
 =?utf-8?B?aGZ6SEREQVFEeFBSVXE0bTRJVDVRanRQVFFsQlFBZC80b0NRNFUraWQ3L2Z4?=
 =?utf-8?B?czVyQmZEVmVSemxDSXJZR3RxM0c4dEdiMVdoTW9NOG9ScDh0U0F3L1k4NTBs?=
 =?utf-8?B?REZESUlsQ0VNZitJakdvSXdOT1pWeTlkcDJ4R1NKb0FmOVU1cmlXSk92Q2N1?=
 =?utf-8?B?WVRXRWZhZFFoOHFraURKeGltSWJTRkNHTWxWMWVjOUlINXBzT1ladVNzdGQw?=
 =?utf-8?B?UEJDa3NLU1Vlcm43NmZzbSt5bk5UN1hQVGJSK2JOYUY4K05jM3RpdnM1N29G?=
 =?utf-8?B?VEU4akxocE5MVU1NTEtXS3N3VnVJU1dvNWwwdk5sNVBBbkx1MXhLa0RuYTNv?=
 =?utf-8?B?Y2pRVGhBVkNDT3lEOHhrQUczTXFobUF6dUVNY01pU2hsL0h2NmIyVGJrdWxp?=
 =?utf-8?B?Y2h3V3NFUmFhTDV0ZmJJbEZnWk1nZFp1Q2VIRVY3cHV4TzgxWWxxV2UrekQx?=
 =?utf-8?B?STEvOHJpVzVyT1V6a1JiVldQM281cWhIcmxVTGVPNUpBSWRna1NaUzFMU20y?=
 =?utf-8?B?aFAzRXVBUHFmMEVMNmQ0TTJWblQ0SFBQZWlmbWVKWk80SHE2WkxRZlg5MzNW?=
 =?utf-8?B?dDlGY3hUTmMyOHpSRVd1SDIzdWxJblMveFlEK2JSNUxiZnJPZFMyNEVmUGUw?=
 =?utf-8?B?U09LQU9vNGZZMDVIZVJ2c3hwcmh3N1VMK0s5d045YmZ3UFJqd0pwNkpyVkJY?=
 =?utf-8?B?QWk0cnRXL1Y3TUVoeERudFRyN3Jqc2NRcFJHTFJQcklsanRvUWZobmVubTlT?=
 =?utf-8?B?czdNT2ZHWFRaSlRkUzFpSytZRW52QnBTT2U2SVZkWlZuaytreE4vYUErMFdD?=
 =?utf-8?B?Ui9uMU12Wkk0elFzRDRRcCtMS0tNWEh4QTJFSWF5Z00xbEhZcFRnUmlVTm5B?=
 =?utf-8?B?QUxRbE14WE02Vmd3ODloSUZzUTI3N2F2UGdaeVl2YW0zYlRrbHN0azFVOGZI?=
 =?utf-8?B?WkdJdGxPaW5jWGpQVnlRTnVZTzQyWFhqQ013TStJQVlWTTIwbC9aa3plYmVS?=
 =?utf-8?B?NHpLbVRZSis0M3R0T3k1dFU1MWtSV0FQUFVZQzAzN0VCZXhnSkVuc0tRbmFm?=
 =?utf-8?B?R0NlOXNndmlubk1tM0lvYmJHcENjNXBZRERRdWNDMm1aL3dnaG1RV3YrZHVj?=
 =?utf-8?Q?zXrGtCHOyCeAEzgTSGStMPSNfH7ZnQS4h/DRCuVeGkKi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045572aa-f070-4fc6-8885-08db72320696
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 08:32:18.8958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdXKu6OdIeOZKH0lNfHcK+b26R0HjHPV3/tt10/AJNkmWg8L0k6aRyqu1oQvjFH+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.06.23 um 19:16 schrieb Shashank Sharma:
> This patch:
> - creates a doorbell page for graphics driver usages.
> - adds a few new varlables in adev->doorbell structure to
>    keep track of kernel's doorbell-bo.
> - removes the adev->doorbell.ptr variable, replaces it with
>    kernel-doorbell-bo's cpu address.
>
> V2: - Create doorbell BO directly, no wrappe functions (Alex)
>      - no additional doorbell structure (Alex, Christian)
>      - Use doorbell_cpu_ptr, remove ioremap (Christian, Alex)
>      - Allocate one extra page of doorbells for MES (Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  8 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 56 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>   4 files changed, 60 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 783e2b8b086c..002899edb9d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -31,10 +31,15 @@ struct amdgpu_doorbell {
>   	/* doorbell mmio */
>   	resource_size_t		base;
>   	resource_size_t		size;
> -	u32 __iomem		*ptr;
>   
>   	/* Number of doorbells reserved for amdgpu kernel driver */
>   	u32 num_kernel_doorbells;
> +
> +	/* Kernel doorbells */
> +	struct amdgpu_bo *kernel_doorbells;
> +
> +	/* For CPU access of doorbells */
> +	uint32_t *cpu_addr;
>   };
>   
>   /* Reserved doorbells for amdgpu (including multimedia).
> @@ -311,6 +316,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
>    */
>   int amdgpu_doorbell_init(struct amdgpu_device *adev);
>   void amdgpu_doorbell_fini(struct amdgpu_device *adev);
> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
>   
>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index eb113e38f5e9..118f4bed32fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -39,7 +39,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   		return 0;
>   
>   	if (index < adev->doorbell.num_kernel_doorbells)
> -		return readl(adev->doorbell.ptr + index);
> +		return readl(adev->doorbell.cpu_addr + index);
>   
>   	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   	return 0;
> @@ -61,7 +61,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   		return;
>   
>   	if (index < adev->doorbell.num_kernel_doorbells)
> -		writel(v, adev->doorbell.ptr + index);
> +		writel(v, adev->doorbell.cpu_addr + index);
>   	else
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   }
> @@ -81,7 +81,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   		return 0;
>   
>   	if (index < adev->doorbell.num_kernel_doorbells)
> -		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> +		return atomic64_read((atomic64_t *)(adev->doorbell.cpu_addr + index));
>   
>   	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   	return 0;
> @@ -103,11 +103,47 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   		return;
>   
>   	if (index < adev->doorbell.num_kernel_doorbells)
> -		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> +		atomic64_set((atomic64_t *)(adev->doorbell.cpu_addr + index), v);
>   	else
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   }
>   
> +/**
> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Creates doorbells for graphics driver usages.
> + * returns 0 on success, error otherwise.
> + */
> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
> +{
> +	int r;
> +	int size;
> +
> +	/* Reserve first num_kernel_doorbells (page-aligned) for kernel ops */
> +	size = ALIGN(adev->doorbell.num_kernel_doorbells * sizeof(u32), PAGE_SIZE);
> +
> +	/* Allocate an extra page for MES kernel usages (ring test) */
> +	adev->mes.db_start_dw_offset = size / sizeof(u32);
> +	size += PAGE_SIZE;

This is initialized but not used, so I suspect it will temporary break 
the MES test? Or is the MES just implicitly using the correct offset 
somehow?

Apart from that it looks good to me,
Christian.

> +
> +	r = amdgpu_bo_create_kernel(adev,
> +				    size,
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &adev->doorbell.kernel_doorbells,
> +				    NULL,
> +				    (void **)&adev->doorbell.cpu_addr);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
> +		return r;
> +	}
> +
> +	adev->doorbell.num_kernel_doorbells = size / sizeof(u32);
> +	return 0;
> +}
> +
>   /*
>    * GPU doorbell aperture helpers function.
>    */
> @@ -127,7 +163,6 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
>   		adev->doorbell.base = 0;
>   		adev->doorbell.size = 0;
>   		adev->doorbell.num_kernel_doorbells = 0;
> -		adev->doorbell.ptr = NULL;
>   		return 0;
>   	}
>   
> @@ -156,12 +191,6 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
>   	if (adev->asic_type >= CHIP_VEGA10)
>   		adev->doorbell.num_kernel_doorbells += 0x400;
>   
> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_kernel_doorbells *
> -				     sizeof(u32));
> -	if (adev->doorbell.ptr == NULL)
> -		return -ENOMEM;
> -
>   	return 0;
>   }
>   
> @@ -174,6 +203,7 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_doorbell_fini(struct amdgpu_device *adev)
>   {
> -	iounmap(adev->doorbell.ptr);
> -	adev->doorbell.ptr = NULL;
> +	amdgpu_bo_free_kernel(&adev->doorbell.kernel_doorbells,
> +			      NULL,
> +			      (void **)&adev->doorbell.cpu_addr);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 547ec35691fa..a403418d5eac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -128,6 +128,9 @@ struct amdgpu_mes {
>   	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
>   	int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
>   
> +	/* MES doorbells */
> +	uint32_t			db_start_dw_offset;
> +
>   	/* ip specific functions */
>   	const struct amdgpu_mes_funcs   *funcs;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6d1587bbda52..c48e97646541 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1854,6 +1854,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	/* Create a boorbell page for kernel usages */
> +	r = amdgpu_doorbell_create_kernel_doorbells(adev);
> +	if (r) {
> +		DRM_ERROR("Failed to initialize kernel doorbells.\n");
> +		return r;
> +	}
> +
>   	/* Initialize preemptible memory pool */
>   	r = amdgpu_preempt_mgr_init(adev);
>   	if (r) {

