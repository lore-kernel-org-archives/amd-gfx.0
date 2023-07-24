Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2512EC001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 14:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3F110E32E;
	Mon, 24 Jul 2023 14:17:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC9810E32A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 14:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+vGlQzldpHAofaw+4ZPNkx8M9sHk16mMt6PJiG6UP4AhBzL9962rStdc0WIXuCcMoES6l+mLBClG7pN2/RoULTHhYiFz8ErJWoAzthESbeCouWoZvEN2yVu3IzjZA3YlrlEa3wdjNpsp8I8D98xbseRkm5Oq2IEl5yg1p/K/0PdHtiB/4dPJCz4oiPcDnhfh12DT+SFJ7MxPFtTDUIwAa3dtxPLx9HVE2Bo8WottmQSMlSVIqVzfXgD+IGQEYcfJD+9/SC3cuF6N/8PNcJ0I487FqWtqX7f1SfrOPJqv/xYHsifdwUkebU3ND8GoFvwP3rb9UWePTVIGmlDfpSQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juKkqURxyBVYX+OFP+F6NM8TkSjiqEMPVhh5d+5ybm0=;
 b=U8QJYEwsMfnbv/DOhJrvjutbV3gDzjB3pyFebffHTYkXpd0rbXBgffmwLCzufg/IM7jorgeS2kLCWuPpbG9t5rbmvGp+6lnJZNfrvcb4u4qEAZqMY6KNUNSbAvrNdLzQUPI9pXDpRlo0LHusPr9d/7FzLXZcPTXv9RH6ECF4TJxcFF7xnre0z65UUIG++6QALAw1T7Wej4YrMlygVnv7XosdpwQuPqqcW587mc9yUjqlZwtVOp0tpv4TUE08YXEivPOkqQnPqrSp1g3bpfVaLcAnhs4+Nn51LRsC/ZA7JhIymqgSPDJa1MMhw4OmGXR6yKfYBWe6LdZeOw3h9upAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juKkqURxyBVYX+OFP+F6NM8TkSjiqEMPVhh5d+5ybm0=;
 b=XfjyzMQY3V10uQS3micXXwglXCeQw4hyySSD4hWHX5djrzId+q97p2PQF/mgSF6mOhZfNh6YsrutgR/fDjMy11KG2QdZKbd7/54PvGBpNJgx6KtoOswrsvUC7GZPnpYzRjztc1ZqKSs4nLT39NorKUHF5pqjtk9UkJHkwZjG90A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:17:06 +0000
Received: from MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::59c1:2d4e:6bca:30d8]) by MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::59c1:2d4e:6bca:30d8%7]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 14:17:05 +0000
Message-ID: <7c806840-68e6-c6a0-4da7-1425c52995e0@amd.com>
Date: Mon, 24 Jul 2023 10:17:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Add EXT_COHERENCE memory allocation flags
Content-Language: en-CA
To: David Francis <David.Francis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230724141445.2451975-1-David.Francis@amd.com>
 <20230724141445.2451975-2-David.Francis@amd.com>
From: David Francis <David.Francis@amd.com>
In-Reply-To: <20230724141445.2451975-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::6) To MN2PR12MB2909.namprd12.prod.outlook.com
 (2603:10b6:208:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2909:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 6380d309-62fe-41e1-405e-08db8c50a855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rYkuCUEcKskMKxPIo90XG8zL5IeagezqUge30OhuJAukH0xcvALKGKASHRdhnwvcGbeGzeZWaGT/uDoMFLV1xFgrr4qtfcNvDn9H/tJNtkkSRYymE3uqU9viop81/6tcKGsLYBqGopncxxEZy1Ia5Sxatv+52Hw8K/ceofXTFYKm1pKmamgs04iNcbX5GvAsyLfKUbAnOTX0HcEG7NbMgC+4R+Trp/OJf0Tn9Og8gf3V7rtSK9lwb4fi787scvMYHPgQ+nn9RoBXT9B0OUzqMQq/QD15RnhhUUrgVtmBw23XhIn6q5+7SqFI5VE1S1kbs7bMcIWOb6fu+KNYkYUHj5qO0ATkX2iCof2CGTjrDLSwAqbp5YE4sQ1yHzZS9G0HtfLLd3QSgKPuW48XgVEtHb72NUTQL6LUp3/VcqpB1arwi/1j5jG6fujQ+BA6YKuzFtnpe3S3mrOiKr0A2BYw6lyTDSJg5aigyGAPsr184A1pM9p/4kmsarFRaMjKSLS/euP86ZsEN+c6chCxYoFSUqHOC+4SOFyE6FqymTvqNHD0X3gc5aWBNgr57my7IlDPc5cCiSh7isGRdJLAwrXCuPDHVD/krmiuItmmeqZBqviE860VPt0W3TLJ2FK3q4NirBTEITYNBWQGQsFj5uUow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2909.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(966005)(6512007)(6486002)(6666004)(478600001)(110136005)(186003)(2616005)(6506007)(2906002)(41300700001)(66556008)(5660300002)(316002)(8936002)(8676002)(66946007)(66476007)(38100700002)(36756003)(31696002)(86362001)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZLWWUzcXNieEdZenpmNnJJSGVQRncwcVZ0RGg5U2tRdmtLREVmS1ZjMnJh?=
 =?utf-8?B?RE9CaTF1dVltMFh4VWl0c2ZLL0pEL0wvcUVjdlFDNXlRU1FJenpMTFJQSmUz?=
 =?utf-8?B?d2xyMFFoZXFJdzI2cXg2MWcyUWZlVi91R0FJSWQwK0xDT3EzWExPMmNFRHVo?=
 =?utf-8?B?clJxUHFxS3M0QUxGQzFPY2FtZUxlUE9ReVF0OGJCVmNkOHFzbWZNU1RzTW9Z?=
 =?utf-8?B?VDZBZit0Uzd1TGNJeEVLQ0FxRVYxa1A1MWFBV0RqUUFWa1hDQ3dxOENZdFlR?=
 =?utf-8?B?K2NHWVdlRFIyNlltTVFYTWQyYy9Xb0phRFg1eFA3WWxSQzNZYTlONEdTSmRx?=
 =?utf-8?B?WG1UNitVOEl6aTluNlRkNTJUeHJRTWk0OEdiVi9RR0ovanJ2WWtQcXlaODJw?=
 =?utf-8?B?aHJvam9ZM3Jna2NBMmNPTFU2NG4zUnBOaytFbmhXZ1lkNU8reHZic202aEFq?=
 =?utf-8?B?NnQ4cXo0UTJNL0UyZ2h1bU1zSnN5SXFVdktUdWZOaWFvUkd0OTN5YVRWQWxS?=
 =?utf-8?B?QWd2b2YyVHZHSlZOTjY4SldjdlF0Z1ZrU0huUG41NTB0TFZIVFFGZGRHT0VR?=
 =?utf-8?B?TWRrS1hWUEc1Q0JJYlJJeVliNHh2bXNoREV3NUI1QW15bVZvTUNmQ1NvQy9u?=
 =?utf-8?B?K1crMjVXcUI2dldSai9hNG1lSXhkTjA3NnBQOUMvWHJiMERpWUdjQ3pJRkQw?=
 =?utf-8?B?Y1I1Z1RDcGdMZEUweklxSXR5bUNGWk5Yblo2MDIxbDlxMXlrL3FueEM2NTVs?=
 =?utf-8?B?aWVkeFNJaWNFMG94NmQyb2tLR1JQRVVMZFB3ZnNHZVBxdEhNWnV2bFE0cTcv?=
 =?utf-8?B?ZFBzQUFZSGhXRGtGRjZXT0kzZXJ2M3JOZm94bTAvRGlJSDdYeHZWRlJjbWl5?=
 =?utf-8?B?RitSRTFFQzR1cXVOUVlFMDE5dUVUbVViTC9ZdGVvR3hYTy8wN25EbDl0NkRv?=
 =?utf-8?B?ZnA2S2ZXT2VDM2xjSWd4dmZaRjZ5Syt5L3NQc044b05yN1lDc2JtdWJUUk93?=
 =?utf-8?B?UDVRcFRzRWRybmZCL0JUcWdsTlFhWGcva3JmTWFqVUs2RW1BUllJYlluS05C?=
 =?utf-8?B?QTRkcHRjU0VnY1dHSlFxT0Z3VjZqY0Y4NXo3dHErTzloTG9MS090bEFaZ0VE?=
 =?utf-8?B?MlY4dFR2aVRMME9OWkNZNFQ4eEVuVnVtUFJ6Wi9KbldPT2dXSG9yeWlzMSty?=
 =?utf-8?B?aGh3L3RJVjh0bCtRcmwyU24xWEhiVmR0emwyam5JYUlaZ1lkREpkMnRxQVVY?=
 =?utf-8?B?cFRZU29hODdxRTRKWlRGZkRQNHZ4UGFZSVFJNm5DYzZXUnM2YzM3cmFObTlN?=
 =?utf-8?B?VkVaTjkwTDQ4VWJFbStJM29Zamg0Rkl3TUV2L3o1MjZoRThGUFdwRk9vMVpx?=
 =?utf-8?B?a0psWDhIa09nZGRnWHAxRzZjR215dXdqdldEdWppbXlYRG9RSHZmWEtyQlpa?=
 =?utf-8?B?dE5UK3UxSmxLeFJTWGpCYUlOVDRzTm4rNXdIaXlseWV4RnVjdVppbjVnOTli?=
 =?utf-8?B?ZUJ5eldVUDRaOW5EMGJUWkhhNmlwcjZvOFpLVEpxVkR2NERxUmVzRUV3NkxN?=
 =?utf-8?B?QWJhRm1RZThRK0Nvc002M1JnTnVhL1M1d2pmODhqREFzWmlmeG42R1hmOVEy?=
 =?utf-8?B?K1o5WERyVFF1R1VMUkR2UFJWM1ZmWjNaeTRPYXYzR3M4dnFyUHRQY3d5TDBp?=
 =?utf-8?B?MkNSdTBlbHNYbXdXYjA4V1VPNVpaaFdBbkRZNlRuckJuWWZJZ1NMSmw2YXpW?=
 =?utf-8?B?ZFNydXA0V2pWcStaczJKaWZIVGUvd3VDNkNFTE05RDFwajV1MjFVVDhFdVpu?=
 =?utf-8?B?bGtJWUtvODZjUkVPUzRQMElDSkpJN3ZqQndwaFVVZWZGTFoxQjd2cTZPNjd0?=
 =?utf-8?B?S0ZsdldTWmZSSTdpTXFEeGxwT3g0TE82WW80a3l6dGp5UXppY0ZDYkJYRTg3?=
 =?utf-8?B?c2JsVVZGTXAvOCtZMFJLKzVjYW1uTStjUFl2aGp4MmNBcFBrWGVtVU45R3NV?=
 =?utf-8?B?WVBadVZkamRXUENaZkhQazV1aVBBK1VwVStNcTBxK01zM3NubCtFbmgwNjZS?=
 =?utf-8?B?ekwxMk9CN2Y1WS9HS2YxUlIxS3d1NG5jeUZSR0NXY3RLbG5hRUtrQllGN2pE?=
 =?utf-8?B?OFNEMXkyVmZYYmhZQTh5bkZ6bzBaYnhweDNGYk0vL0dZSlQzZmp4SFJoZ2Zm?=
 =?utf-8?Q?u4PWW69oIoWBFzPGHM6U+xrmnz4t5H8Tp5Yq7nXI8d/q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6380d309-62fe-41e1-405e-08db8c50a855
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:17:05.6174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKQpsC+iMEkLN1kDvkff/pbj6gbggAUUbjglq6eXoeh4u2cNMD3WVRUa41g0kiB6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

Cover letter got lost, here it is:

This is in support of a RCCL change that requires specific
coherence behaviour.

Corresponding Thunk patch is at
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/pull/88

> These flags (for GEM and SVM allocations) allocate
> memory that allows for system-scope atomic semantics.
>
> On GFX943 these flags cause caches to be avoided on
> non-local memory.
>
> On all other ASICs they are identical in functionality to the
> equivalent COHERENT flags.
>
> Signed-off-by: David Francis<David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  5 ++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 10 +++++++++-
>   include/uapi/drm/amdgpu_drm.h                    |  7 +++++++
>   include/uapi/linux/kfd_ioctl.h                   |  3 +++
>   7 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 9e18fe5eb190..67634e9f6466 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1790,6 +1790,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   
>   	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
>   		alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE)
> +		alloc_flags |= AMDGPU_GEM_CREATE_EXT_COHERENCE;
>   	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
>   		alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 1c07459e2bd2..6a6f6068bea0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -631,6 +631,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
>   	}
>   
>   	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			       AMDGPU_GEM_CREATE_EXT_COHERENCE |
>   			       AMDGPU_GEM_CREATE_UNCACHED))
>   		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>   			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index a6ee0220db56..ff330c7c0232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -540,6 +540,7 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
>   	}
>   
>   	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			       AMDGPU_GEM_CREATE_EXT_COHERENCE |
>   			       AMDGPU_GEM_CREATE_UNCACHED))
>   		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>   			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 8447fcada8bb..17cf19c868e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1180,7 +1180,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
> -	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> +	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_EXT_COHERENCE);
> +	bool ext_coherence = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENCE;
>   	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
>   	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
>   	unsigned int mtype_local, mtype;
> @@ -1248,6 +1249,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   		snoop = true;
>   		if (uncached) {
>   			mtype = MTYPE_UC;
> +		} else if (ext_coherence) {
> +			mtype = is_local ? MTYPE_CC : MTYPE_UC;
>   		} else if (adev->flags & AMD_IS_APU) {
>   			mtype = is_local ? mtype_local : MTYPE_NC;
>   		} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 909f1ef8927d..acb87b2fe8df 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1157,7 +1157,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   	uint32_t mapping_flags = 0;
>   	uint64_t pte_flags;
>   	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
> -	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
> +	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENCE);
> +	bool ext_coherence = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENCE;
>   	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
>   	unsigned int mtype_local;
>   
> @@ -1205,6 +1206,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   		snoop = true;
>   		if (uncached) {
>   			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +		} else if (ext_coherence) {
> +			/* local HBM region close to partition */
> +			if (bo_node->adev == node->adev &&
> +			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
> +				mapping_flags |= AMDGPU_VM_MTYPE_CC;
> +			else
> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>   		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			/* local HBM region close to partition */
>   			if (bo_node->adev == node->adev &&
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 3b98635bdfa8..7dbee3e3d9d1 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -173,6 +173,13 @@ extern "C" {
>    * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
>    */
>   #define AMDGPU_GEM_CREATE_UNCACHED		(1 << 14)
> +/* Flag that BO should be coherent across devices when using device-level
> + * atomics. May depend on GPU instructions to flush caches explicitly.
> + *
> + * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
> + * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
> + */
> +#define AMDGPU_GEM_CREATE_EXT_COHERENCE		(1 << 15)
>   
>   /* hybrid specific */
>   /* Flag that the memory should be in SPARSE resource */
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index e467ac678ba9..7a4041ee5951 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -416,6 +416,7 @@ struct kfd_ioctl_acquire_vm_args {
>   #define KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM	(1 << 27)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
> +#define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE	(1 << 24)
>   
>   /* Allocate memory for later SVM (shared virtual memory) mapping.
>    *
> @@ -777,6 +778,8 @@ struct kfd_ioctl_cross_memory_copy_deprecated_args {
>   #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
>   /* Keep GPU memory mapping always valid as if XNACK is disable */
>   #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
> +/* Fine grained coherency between all devices using device-scope atomics */
> +#define KFD_IOCTL_SVM_FLAG_EXT_COHERENCE       0x00000080
>   
>   /**
>    * kfd_ioctl_svm_op - SVM ioctl operations
> -- 2.34.1
