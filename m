Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B04C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 13:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA8660C40
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 13:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDA8660C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866D46E8EB;
	Thu, 11 Nov 2021 13:43:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B636E8EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 13:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK1ewnEiMu4jgNoUlNHIsWStCchLg5cdjXDR1/XsQWEEeeskY45wACNL4lGVzjtdkUaB+visb7ZlJ2T5dS0Z85cvAv0V2CASaLuffUnpf1/6RbaU5osRqJmTR6p1M496NwTk9LGMsl9ybuQwvnpSIjsc3Xc8lLaXTEePg6tuMBvfN5EPoTe6UtD218OIIiCBQFZGZ2dOM2951r4wOS8btZUi/7imCkkhcP2D9ygssHu2N1DPpqpmjd7SSljtBUR21SEY6KpKFk1P3Y3ql7F342vFPhKXvGXVUXOcX3TIy9AuWSCusAHhbictUX3hupa4VdMM6KPg+dpCGMK5YFoYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/TNhIbEnWchLaLmEOFZDMT5P8MT7f4XA4TjTKSiVKY=;
 b=QFH65pJOuvQ/F/DcnK8JNB4A4SE64QNIeGc7alpIgN0I+QuU4kr6g61U+uSlDFJCpSyAwoPrZvnCm2FB8rhrg2h0aV28VBtXiB9AABgeSxxlQzUecSvxN0JIbmVhAfJJ28UF7B5Sk0lBIkte6j+MNhvsCfAgL2mWL1Aoi0aDQvnnx5Ml4DyW77JTs8vvBBgeCv8C4ilnKgtauY2mYctGsQEfqOqRdqi2AyXgkqGPsX8B3GGeyJGsGJTVxCGmpEgEDsD+EvZMtKCNqJkoad9f7YhxrX8v4C6y2fHvXwRGeuvw9WJhHnvgmP7pYyn+hxOUprrXY3OoJ3N1BP40dqdCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/TNhIbEnWchLaLmEOFZDMT5P8MT7f4XA4TjTKSiVKY=;
 b=z9YfaY3pAO9Ro0NgbXEjhfTWKZSB8jx67aq95I/RClh6JGEKW8FVgZXc0mVSj28cV7nkV3rvHmBO1g+VsEqsxYylRwtGwKrgVVHQ4ZC/PAWhqMJ83MMxomvM+fLJ+l9alN7AeHx1EnaRR5ABXC27dYKJRFVLZ/cdfY3f/GjecCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 13:43:43 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 13:43:43 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Update BO memory accounting to rely on
 allocation flag
To: amd-gfx@lists.freedesktop.org, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20211109061304.13110-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b743f99a-6486-aff2-2664-fa1eff4f7fdc@amd.com>
Date: Thu, 11 Nov 2021 08:43:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211109061304.13110-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 11 Nov 2021 13:43:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e77082da-b128-46a1-4689-08d9a51946b8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5096C9E1EE38B4DACFC6BD4392949@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fn5zLRWot5gP0bI/F12QnlKLS5dtvnnr3vrmYmCW74r3JGruRjnqoep9kyVKIrt7M9BWuKE7BudCWpzJJbCQnV+FX+iHzsaZYncxei7x7PNzRihf8rw0mBwyTk+lPCMmrZLGcbcDvH/5cCEZoDSRgx5xEHufQgUk+vRU/fsec9LH8q0nMz/ecRfWkhDPkRmREkcZ6ccAAoLHy+2gvgqvVCBEJPDnE52ppkd2xLSdU10l87+Ffd52cndh0RaF9Xp6iYKMxt6Aq/6MXcP2z79LSl9OS1WcYhn3GbaNK9VtaZwC6d3Iz7jmVoYoi+f8M8SHnppLH5sJFQBQTcSATE3zWxuwBgq9sH1MiJ0vSvBxKd6bxl0NWidkqkvb5DIaOHE1GMSUBHNJFvjCR67EUzfmQRiFFxl0BEmHD7qydyxGrH6HR/oXr7Oi8rIWOU+kAyzSywntweGVlTUNOcNspzmvpQmrvCHl5AcgsIobmheSeVehu3kwKbmSCO7ux2wwEuPatHkkdVdBdf89zngQR5n4xDQA3g8Tghn1ge1DDwdSfX0vQNEBgiwkWDtgDM4KOz5FwCJ0eNGgdr3dYmd1qbiu3oR6pZCAD4pAEUEVn8NwZVO9EaAob/I3hVyEranSv7m8QPzlchDWIBF7zmt6mxQgn8Z0GI8XJJWXdLCOGf3CC16Xi3G52DNLG8G4D3Qbmx98SpX5xY58zjMmHzm+I/5Tt7dF9K0hDf14UhXLZ2HBn7A2tGfRtg1ETUnxcjN/krYd9HPxArMe632tO9WF+Aj3+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(26005)(186003)(508600001)(83380400001)(5660300002)(8676002)(316002)(38100700002)(2906002)(956004)(16576012)(15650500001)(8936002)(2616005)(44832011)(37006003)(66946007)(66556008)(36756003)(66476007)(31686004)(6862004)(6636002)(6486002)(86362001)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXgrV2RtSVpQb0l5Tkp1Sy8wTFZoUkpuZzM4c3JMekpRMjQ3QURkTWhqV0kx?=
 =?utf-8?B?YzYrM3BJb0xyM1NHY2NjaHR4QXZwMVJTMGZaeklqRDJRYysyUlRHQ1NubGdD?=
 =?utf-8?B?NmpFWi8vZHppdk1Fci9uUVFiTyswTEJBUHhSYWdwOGxVU1d0TUp6NnpwTkVN?=
 =?utf-8?B?N2Vzbi9haW5sSG5iK2RJdGQ2NkhXNFUwN1B3WHdzZ2hrM2UxdjQwWkpFYW9t?=
 =?utf-8?B?ajBhcllIRnAxRFdkK2lNOFF1QndvM3kzYWI3NVZ4TGtLaGxQSkdkcWFTdEVR?=
 =?utf-8?B?RWt1b3ZvaGFsQWpGWnM0UUdIdzVFQis4SHo5Ymh2VTFtVG0yN05rZUNxTUhn?=
 =?utf-8?B?R25KcFlhVkJLSFJnR25aNFFoTk41SUxNTmdabDU1NHdjb3VzcXNTaHFIQjdU?=
 =?utf-8?B?RUxvRlhCSlJUb2hVdDNXdXFhQ2RBcndsSVBZQnZzcjdrMlpGWHJiOGxDdVZs?=
 =?utf-8?B?ek9TV2VBR0FuREtYVzQ0TE90dk9TUnpmT2F1MHFDQVBqS1U5YlNFMDBKVDdn?=
 =?utf-8?B?dit1RVVSRG9qbEVlVlFWdFZlcFVlZkx6RGN0T25VRzM1WEJsTzlRd0NqVnJq?=
 =?utf-8?B?ZXhHU2hXNDNaNjJJelVGUmxIMDFIODVuNWZ0c2RIRWdWU2w3QmpEQlNOSkhC?=
 =?utf-8?B?RXI5NFRrOC9WemNQYStvRXJTZklvSi8wc3VMcVlWK3ZpRVUrTmUwSS9odThD?=
 =?utf-8?B?UnVhc2laakNtNUs4emtXcVdia21pS3FjUEZ5bCt3cXhYeFNDcWdKQTdYNjkx?=
 =?utf-8?B?TVUvclJuaks3T3BxcSt1aGlqQ0pjbGhmR2haNVFTQzNGdkNGNlRzT1Nia2x0?=
 =?utf-8?B?MjBFRlJyYTZzczUxYlE2bEMxMnc2dDlSc1dPdWZmM2JvZTdCblpHN1QyOXZi?=
 =?utf-8?B?Wi82QURabWxYQzBLSEI4NFN3Y2ErVXhsNmJmN0ZmWlVENW5ISDg4dHVjQ1BE?=
 =?utf-8?B?YlE2eG5NL0x4MFhMb1ZmVHRUYk9qK2tKR0FtMnV6OHJLM2FqNzBFeDVHUmFG?=
 =?utf-8?B?U3VnR003Q1NUbDRkL05XRDB1WlhQVWtFeHRtckwzVzR0OG43akVIWnpTV1cr?=
 =?utf-8?B?L1h3VWJkWlRIdVd4eDk0U3l3a0RMUldwZHZsVW5abVBzcW8rV0RlOEVlUXRm?=
 =?utf-8?B?KzhaMXJJeTRiZ0xZSFdaVXJjV1VHRWZEY283Y3cyOU9lcnoyMG83SzFNakl1?=
 =?utf-8?B?Qkx1Q1YwcnRvSTNTZ3FlQ2RneVRuQ3VaZ1FMUzRpdm5HeVBab1U5Y0prYUxE?=
 =?utf-8?B?ckN0MmU1c2JOdkN4UFlWUkZrNmhMdk03ZXQrdEtTeTV3UGlJT0Y1RGlrYnpZ?=
 =?utf-8?B?YnR6aE5lUm05UU9YL2N3OUx0V3N1V2xDcXdBb1lIendmTXF4ODB5Tk5WSHph?=
 =?utf-8?B?M01TQ2d4VnFLOUc2b2pRTDZCdkJxaEZ3aFlWWXVHWmk3RGxLVmVOWXBwK2JG?=
 =?utf-8?B?YzJ0d2xDTnNFak5VQmVTd0xTeHdUK296UytQdGY0djJYTjc2ekVodHd0V2cw?=
 =?utf-8?B?SVYwbFFYc0JDZ25ZTURMbGRNQVpBTThWMkFOcXZTUE55UGZoVis2KzdZcm9K?=
 =?utf-8?B?Kzk3bExBOFlLcXQ0N0xZRGVQL2N5ZCthVEVpb1BqcXE0OGRacUkyNXMzY0lj?=
 =?utf-8?B?ZEtDUCtneDlVaWlmTG5zZDBCMkIxbkpjNXJOelgwZHN5RDBzZ3YvdVlqMjgw?=
 =?utf-8?B?cmhBUVREOHZtMnE1K0NMTDJuRWh5bGNrT0tITjNFeWxBdXoyVTI2QVRidTFH?=
 =?utf-8?B?U05vRENSS2pLU20vNGlNMGtiNlZGMUhLMXJQc0lQWlMzZHlFeTFqR0hJQ0hJ?=
 =?utf-8?B?cGJFQVlBVGpGbS9pYVR4TTROaWxEaXpjQVcwcXFoenpiZXlkd3RFVkVFb2o2?=
 =?utf-8?B?R2FoNk12LzRpTjl0dGl4Qi9uWlZudVJYc2V1MldXT0REWlY0NUY1Qi9tRDF6?=
 =?utf-8?B?RnN3V0p3Z2NhcWlWNDZvcFZjOVh3NHVWajJXb1plL0NlclRXVFFna2lFVUcy?=
 =?utf-8?B?RG5kVll1cHVlUC9SZTVUTFhNT3I2RkltWmpMUnNWaGM3VE9wQVRFd25XUnNj?=
 =?utf-8?B?YmVOZkhyanVvK2pHRndncVhaa1RSbEEyMjBaWVNPMjQ4cnQ0RFBQVHNXVGgv?=
 =?utf-8?B?cXhiMlBkaXZWVVN1bnFTMVF1SSt5YnMrNEdKRkN4bGtETUtyOUFaRXpWUGtX?=
 =?utf-8?Q?S77EvxdFhA/9JkHkMeXRVtE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77082da-b128-46a1-4689-08d9a51946b8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 13:43:43.0147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dl81HyZTGZXeYc6G2JdOo2ZCBK7BSlmC5jCa1gnbc5WUkYuqXfek1f1Hnct3J1sZ+465yxKjQAG2tTdJoaMzpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
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

Am 2021-11-09 um 1:13 a.m. schrieb Ramesh Errabolu:
> Accounting system to track amount of available memory (system, TTM
> and VRAM of a device) relies on BO's domain. The change is to rely
> instead on allocation flag indicating BO type - VRAM, GTT, USERPTR,
> MMIO or DOORBELL
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

The code changes look good. Comments about comments inline ...


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  16 +++
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 101 +++++++++++-------
>  2 files changed, 79 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 5f658823a637..8d31a742cd80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -307,7 +307,23 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
>  void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>  void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>  				struct amdgpu_vm *vm);
> +
> +/**
> + * @amdgpu_amdkfd_release_notify() - Invoked when GEM object reference count
> + * reaches ZERO. Increases available memory by size of buffer including any
> + * reserved for control structures

"Increases available memory size ..." is an implementation detail that
doesn't matter to the callers of this function. It should not be part of
the interface definition. The interface description should be more
general, maybe:

* amdgpu_amdkfd_release_notify() - Notify KFD when GEM object is released
*
* Allows KFD to release its resources associated with the GEM object.
* ...


> + *
> + * @note: This api must be invoked on BOs that have been allocated via
> + * KFD interface amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu()
> + */
>  void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
> +
> +/**
> + * @amdgpu_amdkfd_reserve_system_mem - Decrease system memory that is
> + * available by an amount specified by input parameter

This is misleading. This function doesn't change availability of system
memory in general because it doesn't allocate any memory. You'll need to
be more specific:

* amdgpu_amdkfd_reserve_system_mem() - Decrease system memory limit for KFD applications


> + *
> + * @size: Size of buffer in bytes

What buffer?


> + */
>  void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>  #else
>  static inline
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 94fccf0b47ad..08675f89bfb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -120,8 +120,22 @@ static size_t amdgpu_amdkfd_acc_size(uint64_t size)
>  		PAGE_ALIGN(size);
>  }
>  
> +/**
> + * @amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
> + * of buffer including any reserved for control structures
> + *
> + * @adev: Device to which allocated BO belongs to
> + * @size: Size of buffer, in bytes, encapsulated by B0. This should be
> + * equivalent to amdgpu_bo_size(BO)
> + * @alloc_flag: Flag used in allocating a BO as noted above
> + *
> + * @note: This api must be invoked on BOs that have been allocated via
> + * KFD interface amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu()

Who needs to call it? Your statement sounds like callers of
amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu must call this function as well.
This is very misleading because this function is already called from
amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu.


> + *
> + * Return: returns -ENOMEM in case of error, ZERO otherwise
> + */
>  static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
> -		uint64_t size, u32 domain, bool sg)
> +		uint64_t size, u32 alloc_flag)
>  {
>  	uint64_t reserved_for_pt =
>  		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> @@ -131,20 +145,24 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>  	acc_size = amdgpu_amdkfd_acc_size(size);
>  
>  	vram_needed = 0;
> -	if (domain == AMDGPU_GEM_DOMAIN_GTT) {
> -		/* TTM GTT memory */
> +	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>  		system_mem_needed = acc_size + size;
>  		ttm_mem_needed = acc_size + size;
> -	} else if (domain == AMDGPU_GEM_DOMAIN_CPU && !sg) {
> -		/* Userptr */
> +	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> +		system_mem_needed = acc_size;
> +		ttm_mem_needed = acc_size;
> +		vram_needed = size;
> +	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>  		system_mem_needed = acc_size + size;
>  		ttm_mem_needed = acc_size;
> -	} else {
> -		/* VRAM and SG */
> +	} else if (alloc_flag &
> +		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>  		system_mem_needed = acc_size;
>  		ttm_mem_needed = acc_size;
> -		if (domain == AMDGPU_GEM_DOMAIN_VRAM)
> -			vram_needed = size;
> +	} else {
> +		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
> +		return -ENOMEM;
>  	}
>  
>  	spin_lock(&kfd_mem_limit.mem_limit_lock);
> @@ -160,64 +178,71 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>  	    (adev->kfd.vram_used + vram_needed >
>  	     adev->gmc.real_vram_size - reserved_for_pt)) {
>  		ret = -ENOMEM;
> -	} else {
> -		kfd_mem_limit.system_mem_used += system_mem_needed;
> -		kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
> -		adev->kfd.vram_used += vram_needed;
> +		goto release;
>  	}
>  
> +	/* Update memory accounting by decreasing available system
> +	 * memory, TTM memory and GPU memory as computed above
> +	 */
> +	adev->kfd.vram_used += vram_needed;
> +	kfd_mem_limit.system_mem_used += system_mem_needed;
> +	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
> +
> +release:
>  	spin_unlock(&kfd_mem_limit.mem_limit_lock);
>  	return ret;
>  }
>  
>  static void unreserve_mem_limit(struct amdgpu_device *adev,
> -		uint64_t size, u32 domain, bool sg)
> +		uint64_t size, u32 alloc_flag)
>  {
>  	size_t acc_size;
>  
>  	acc_size = amdgpu_amdkfd_acc_size(size);
>  
>  	spin_lock(&kfd_mem_limit.mem_limit_lock);
> -	if (domain == AMDGPU_GEM_DOMAIN_GTT) {
> +
> +	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>  		kfd_mem_limit.system_mem_used -= (acc_size + size);
>  		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
> -	} else if (domain == AMDGPU_GEM_DOMAIN_CPU && !sg) {
> +	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> +		kfd_mem_limit.system_mem_used -= acc_size;
> +		kfd_mem_limit.ttm_mem_used -= acc_size;
> +		adev->kfd.vram_used -= size;
> +	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>  		kfd_mem_limit.system_mem_used -= (acc_size + size);
>  		kfd_mem_limit.ttm_mem_used -= acc_size;
> -	} else {
> +	} else if (alloc_flag &
> +		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>  		kfd_mem_limit.system_mem_used -= acc_size;
>  		kfd_mem_limit.ttm_mem_used -= acc_size;
> -		if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
> -			adev->kfd.vram_used -= size;
> -			WARN_ONCE(adev->kfd.vram_used < 0,
> -				  "kfd VRAM memory accounting unbalanced");
> -		}
> +	} else {
> +		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
> +		goto release;
>  	}
> -	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
> -		  "kfd system memory accounting unbalanced");
> +
> +	/* Alert user if memory accounting is not per expectation */

This comment is obvious and unnecessary, and also not even correct.
These WARN messages are not for the user because the user did not cause
them and can do nothing to avoid them. These messages point out bugs
elsewhere in the driver. So they are for engineers.

Regards,
  Felix


> +	WARN_ONCE(adev->kfd.vram_used < 0,
> +		  "KFD VRAM memory accounting unbalanced");
>  	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
> -		  "kfd TTM memory accounting unbalanced");
> +		  "KFD TTM memory accounting unbalanced");
> +	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
> +		  "KFD system memory accounting unbalanced");
>  
> +release:
>  	spin_unlock(&kfd_mem_limit.mem_limit_lock);
>  }
>  
>  void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -	u32 domain = bo->preferred_domains;
> -	bool sg = (bo->preferred_domains == AMDGPU_GEM_DOMAIN_CPU);
> -
> -	if (bo->flags & AMDGPU_AMDKFD_CREATE_USERPTR_BO) {
> -		domain = AMDGPU_GEM_DOMAIN_CPU;
> -		sg = false;
> -	}
> -
> -	unreserve_mem_limit(adev, amdgpu_bo_size(bo), domain, sg);
> +	u32 alloc_flags = bo->kfd_bo->alloc_flags;
> +	u64 size = amdgpu_bo_size(bo);
>  
> -	kfree(bo->kfd_bo);
> +	unreserve_mem_limit(adev, size, alloc_flags);
>  }
>  
> -
>  /* amdgpu_amdkfd_remove_eviction_fence - Removes eviction fence from BO's
>   *  reservation object.
>   *
> @@ -1452,7 +1477,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  
>  	amdgpu_sync_create(&(*mem)->sync);
>  
> -	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, alloc_domain, !!sg);
> +	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
>  	if (ret) {
>  		pr_debug("Insufficient memory\n");
>  		goto err_reserve_limit;
> @@ -1508,7 +1533,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  	/* Don't unreserve system mem limit twice */
>  	goto err_reserve_limit;
>  err_bo_create:
> -	unreserve_mem_limit(adev, size, alloc_domain, !!sg);
> +	unreserve_mem_limit(adev, size, flags);
>  err_reserve_limit:
>  	mutex_destroy(&(*mem)->lock);
>  	kfree(*mem);
