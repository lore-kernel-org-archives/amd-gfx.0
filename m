Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF4606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1C7ngwz1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F1D10EEB6;
	Mon, 23 Nov 2026 14:51:06 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB8410EE96
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 14:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8kGchfB+o7/OqvLNAqD4YK4drCqIQLCKGQ4W2jB0Jw3W2bW+EZJdjtA0RBzK1FNmuzjmht0QOYBmNRV2sCnJpLG5z3/97v+8As1KYdNXv95Kej/32bozt3gndViof6IlwSHeal3mduHfWUF74dtsj0WdOjx3X7wZcYtoEup/KbzwGl55OgWnKGzu6LuvBRQvYuKcnhncG5ADf48zmLFnf/6PMrRu5OPJxL7nX4lGS/XP0tmUQne0WcubqBoqjIF5X5lL0wbniV01whqsOgzn+Hpi5RME3vkLUT+qihx+K+yKNGdqllIR1RP5v9YLuht0AjMCgeotFjgWAY61XeRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIo8793T3ONJvHt7Km1IV+wGopUVBLX+Ju8OXw4JHxo=;
 b=sIyYLCs1qhFoFoVKqIG6WJhtVPrVrrbgoqR5UbzrX3288zbkxrBWVf1UVKIoMUdQdwVgRPqC0S07cWZJ+dqz77GmUNUe+CfEVNY33wn/gvOdGPdtCALym7E2fHMPorg6DQ5eTKr6492Ci6VQGbbgXhrhEFpfEhTCIR4WspGuozYEOhdFWPBjf5eDi3Dtp7ijBd/KK/OFk5WjKSDSIL+g0eOVnYcTKS1lPCX9AfVGHNhIdiXq4Efvq1r2FfHUw8Ngg+ZdJNhKRoz0VXwjeaJChUwSUrc8WziaTb4ImJiItxsy/03t61Ya2uXFPYAXwtRsCNi9jAwcBHMvdLDWio+XCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIo8793T3ONJvHt7Km1IV+wGopUVBLX+Ju8OXw4JHxo=;
 b=1C7ngwz1ifyws7ie/mqwzzxqSoxq1o+eY/+rzD5bEdcWTaxw8C8DYyNvbCkJfpcsCFpM15eGXYewotMKXaE/VWDsItvhwy4XImITcOy4ie6uZkWVMx4YeqRcLsYlbEutzk6thc8AxhGSYdZNOx+xue8v2qPn3I2o2JP/6zqsAr0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 14:50:54 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:50:54 +0000
Message-ID: <1d9b2289-e6c2-46b1-b1d0-8da1ea7e9110@amd.com>
Date: Mon, 23 Nov 2026 09:50:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: fix kfd drm_file race condition for dmabuf
To: amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20261109155855.20471-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20261109155855.20471-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::13) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: a202e73a-368e-4a8c-ec29-08df49712d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|10067099003|56012099006|11063799006|261102123227099003|261102130727099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 5Rl9ZSZWCfsh7GHdRT0o4HMEtfPFtmQDkg4IMh65pvRs3euogQILKPq0NVoo17ZfQIpI0lDj0pVGrxPmBI9VC3yJNVKq5OtnPYrV9y5NTBZyKE6vNPVhW2Pg2SCRT583vZ3giGHkhoWl8mfu4oBGvpjAfAEe1VlPoJmLt9rZG3+9s+JrRPDBTKJiJ9XrYxMsJpuGQVueLjYjKjDZZewemQFJ6cTLGxQwSmN7DGF+H77nL/HY7rpmxr7Jc7ah0KLO8Y0lx01ZA0qFsmsMFMP6xYFCrHWE6p5VMry0v3IA7iaWC0lHX43Lc8cUOjA4tyYGrC/FrLT6wAi3H7IFsVUZnKfofFG4T6jke4z8qkakGwC+FqwA/VAIVgH2r62aMaQ31ILFeYBpbJRxlgEHI+PJjPKsEl7xNL/D/fMkTvvdukphblgAlSMopOieZ6q+vENozz8fU9MN0CToEscw3ajQs0PYJWYnNn+D/5kCvCMrBLIib5gl+AEhbS3zxc17sWlUM5NlXJvjBlERT6OE21cJAV5dHLZw+TBwr0fNhLIGC62bHNAzaGfpU8ZryMni+NQrs+Ip3BSlgYinGPuBR2m9YaaDyyAAKSLrnDvUnCXAjQFOobBdYYLB9u2pziv6wAaAn4giFzdwAJFFv8JiMxySNl8+G9sSbCwbRjTz5Dg6Jac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261102130727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3Vsbkt2T1hjbHdFSGlSK3E0V1VJR3QwcVcvMFQ2WHc0a1paWnpINjh3bmlR?=
 =?utf-8?B?SitrdnZRbG00Rlk5VkR6YTZNN3FmRnlsOXpqMTNYM1BqbENOK1hEQ3pDbWdG?=
 =?utf-8?B?V0FLNEZLcDZYWEdLQUlRa3ZzaXM0ODBUNi9jczhDZEErYzVFVVZtMVNWM2Y0?=
 =?utf-8?B?Mm84SkxHc2lqcGZRMEkvd0lsa3JuTi9LV1lsVzFhLzJsWlMyV0hBS2k4YnhI?=
 =?utf-8?B?UFNRSm82SzJiem9kL1Jlakl6a1dsUXk5QW5tSFhqRnVSNVZraFA3UXIvbmt2?=
 =?utf-8?B?a0Q0bDV3WG5FQ2c0Wmx6MHlZU1J0MzVmazVsQmhZd0FsTjhJWkpCZjJnQmdR?=
 =?utf-8?B?eVBueGhzTklCd0Ezd3FMcDE2RUlGM3dXdFJiZ0IySkFLV3NqOVhKOVlvTzV4?=
 =?utf-8?B?UVBGeVFXc3JYQVFEWElEODhvRWNQMk1JTlFvK1pKMnkrQkJYQTNZSUR0SVR5?=
 =?utf-8?B?bWg3VGFIZVB4bk9qbXJ5ZWNwVjRwL3lnTm51dkJ4U3BsZVlOb0o4ZXZTN1ow?=
 =?utf-8?B?V004THpoYjN3U2RVeG13bzFKaDVWdHFiQnV5SUVCMStpTEMyc2pqTnVXRzY4?=
 =?utf-8?B?enRqUlhXMlBGa3dXZ0I1THArYnZYa1ZMODBhZElkcDZQcUdsTlBRbnFJNjNH?=
 =?utf-8?B?ZWE0T2pLRWhRZmwwTnoreUp4SURTcTdadXFuMnhlZjVJZnBUWDhtMERaUVRr?=
 =?utf-8?B?ZGVvVEpwREhPRXdZUHE1V3BZN0ZaMHZSWkg0SndrU2xqRUJKT2ZiSzVsa2ky?=
 =?utf-8?B?UVRLWmw4MGxneEo5RGFaV2ZRdUFhemFxejJKaGdxSFJOM3lUUS9yejlISldy?=
 =?utf-8?B?MzNSM3lTeCtEVVkwcUNDQW5BaUxrY2ZLb2FFM2poWDFDcVB2dDVCZENOcitO?=
 =?utf-8?B?T3Bub3BaUmlyS085MUdWWU9Hc25LTVdjYmxUWDkzN3BidGdEc3lrUmN4bFVP?=
 =?utf-8?B?WFhUdDJSemtjMXl3QWsxdjRXTTRTcWxDWmgwUlR3MnlUZ2hFdEppTElzRU1T?=
 =?utf-8?B?ZmE2cWtJREhvVVRzc01MaVJJYWxnRDZDenFhL2dGT0w3QnVCRjZqYXp2dVlw?=
 =?utf-8?B?QWZlTW91eHNTaDRYRmsreFlGUFZTenBaWmxHUURzSHh0NHphWDIrdlpPWXRi?=
 =?utf-8?B?akZIVFI4eFBES0d1d0hxOTFIdVVGM3VxY2c1RWVtZzZYZHdCYWkwOHY0bHpU?=
 =?utf-8?B?czVTdzBiN2dnZmEyRmxyU01iVTl0bWhxcGpyVTkvVnZtcXVFczlvY2lZVnhT?=
 =?utf-8?B?dzlYd3pOMk02eGxYYzFFZFJnL0lTcW1rclFMdTB6RWFnTHVLeS9BRFZrbkM2?=
 =?utf-8?B?ejVKbXV3OTc5UHYwcTd6Tkx5SlFjckZvUkt2bld2T00xZmcvaDBZMzA2OFA2?=
 =?utf-8?B?STNvR1lTMm5TcExrRFhuSVFyV0RMb2pHMmlGZWlWc3F5bDc3aEtKNVMyV3cy?=
 =?utf-8?B?eUNnbmV5NDYwTlpnNStTa0VUZjJGaWZzY3NNamJ1dm9USkxhZnJnUU1jWjMy?=
 =?utf-8?B?QUJuQzZJSWp5dmpaelFXN21yaS9zRXZmRXpTTk1STXVVWXlRTlRpd0l6emFK?=
 =?utf-8?B?cUpTK2lYVDdHQ1BXcVVxdmhWcTd2QzhNK3ZRbnJwTWxIbFhXbmxUNGpsWFRr?=
 =?utf-8?B?RFNLVXFKMjNqOS9vTlJiekhlenI1WEd0cFNuOFUySGFHR2c5NjZPS2ZGc0t1?=
 =?utf-8?B?M0RXampxOTcvRDQ3LzNIaVBFaE5Gd2N1UFFHZ0JucGl2MTI0QlBwdHg5ZlYy?=
 =?utf-8?B?QzI3ZHM2cEl0aW1EN1FYcnVJQS9TNkxjS0QyL1JCMldjUWhjUTdXR1pvT2xp?=
 =?utf-8?B?dTBaZGhRVUQ1aXE3Qkw4NTBsVmJxRDhtVnN5UnRoRW1jV1ZqT2Y3d05DQTU1?=
 =?utf-8?B?dzdjVGtJUUV2RWM4dFYyWG1iZU50MG9aek1yVmRmNWtocU5qK2NQNXdUbXI3?=
 =?utf-8?B?YTdRUVBzMGZlcFBpZzJRUk9IaWJodlJoZWQ1Q1JPTy9POGFMc2MvaDdrUmxJ?=
 =?utf-8?B?d3FETDFtcTltN1lDa3BaVVpXVldIdTJjd0E3ZkE5bEE2ellVbXZZNUhnMjVU?=
 =?utf-8?B?eExZN3RoaWpPSEFOOEttWTR5eU9CZy9Ob1JSTnJucnRWTW5sSGVNUTFhbEhp?=
 =?utf-8?B?MjU2Z01idmQ5SkQwTWsvNUFzRFJJdkptVGZaUnZFdmtnZXYrUFNJaGIzYUNN?=
 =?utf-8?B?SlN2RXN0Y1RGZjQ3SGtuM0lWL1p2ZlZ1WXhoZkJQL1dlNGMrRE5jTDhVWjll?=
 =?utf-8?B?Z2VjSSt0RXhtdEM5MkNkZHZ5cTJrUHZ6R1Z1dWU3SDlYNFI1V2VDWFBmYjdW?=
 =?utf-8?Q?iJ5Pw+GB2fIS17PIzC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a202e73a-368e-4a8c-ec29-08df49712d0a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:50:54.7134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOA9XJcF8DRQlbg53MgYtP9pKvnwyAkAPRQGz2xMLS8Y+cOCildFL2kHwNwpK94vhoZsXMG+iszBIXGrbZQVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping .

On 2026-11-09 10:58, Eric Huang wrote:
> Every KFD GEM-handle operation (create/delete/lookup, PRIME
> handle<->dmabuf/fd conversion) is currently performed against
> adev->kfd.client.file, a single struct drm_file created once per GPU
> at probe time and shared by every process doing KFD memory ops on
> that device. DRM's GEM-handle machinery (per-file handle_count, PRIME
> dmabuf cache, idr) assumes one drm_file per process, so funneling all
> processes through one shared drm_file breaks that isolation:
>
>   - AMDKFD_IOC_IMPORT_DMABUF creates a GEM handle for the importer that
>     does not survive the exporter's FREE_MEMORY_OF_GPU, since handle
>     lifetime is tracked against the shared drm_file rather than per
>     owner. The importer's BO can be torn down from under it.
>
>   - Concurrent handle churn in the single shared idr/PRIME cache causes
>     AMDKFD_IOC_EXPORT_DMABUF (hipIpcGetMemHandle) to intermittently fail
>     on a buffer the process just allocated, under multi-process IPC
>     pressure on the same GPU.
>
> Each kfd_process_device already carries a genuine per-process,
> per-device drm_file in pdd->drm_priv, established via
> AMDKFD_IOC_ACQUIRE_VM and guaranteed non-NULL at every call site that
> matters (kfd_bind_process_to_device() refuses to proceed otherwise).
> Use that instead of the device-wide shared client file for all GEM
> handle operations.
>
> Most of the affected functions already receive drm_priv as a
> parameter and can use it directly. kfd_mem_export_dmabuf() does not,
> and is called both for genuine cross-process export and for
> same-process peer/XGMI GPU mapping, where the in-scope drm_priv
> belongs to the peer device rather than the device that originally
> created the GEM handle. To keep it correct in both cases, cache the
> owning drm_priv on struct kgd_mem at allocation/import time, mirroring
> how gem_handle itself is already stored once per kgd_mem and never
> reassigned.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  8 ++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 ++++++++++-------
>   2 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 74dc307e5140..3c2734c9a3f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -95,6 +95,14 @@ struct kgd_mem {
>   	struct amdgpu_sync sync;
>   
>   	uint32_t gem_handle;
> +	/* Owning per-process drm_file for gem_handle (the allocating pdd for
> +	 * native BOs, the importing pdd for imported BOs). Set once at
> +	 * alloc/import time; used instead of the device-wide
> +	 * adev->kfd.client.file so GEM handle lifetime is scoped to the
> +	 * correct per-process drm_file rather than one shared across all
> +	 * processes on the device.
> +	 */
> +	void *drm_priv;
>   	bool aql_queue;
>   	bool is_imported;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f060b206c255..eab1eac831f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -833,7 +833,8 @@ static int kfd_mem_export_dmabuf(struct kgd_mem *mem)
>   		struct dma_buf *dmabuf;
>   
>   		bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
> -		dmabuf = drm_gem_prime_handle_to_dmabuf(&bo_adev->ddev, bo_adev->kfd.client.file,
> +		dmabuf = drm_gem_prime_handle_to_dmabuf(&bo_adev->ddev,
> +					       (struct drm_file *)mem->drm_priv,
>   					       mem->gem_handle,
>   			mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
>   					       DRM_RDWR : 0);
> @@ -1857,7 +1858,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   		pr_debug("Failed to allow vma node access. ret %d\n", ret);
>   		goto err_node_allow;
>   	}
> -	ret = drm_gem_handle_create(adev->kfd.client.file, gobj, &(*mem)->gem_handle);
> +	ret = drm_gem_handle_create((struct drm_file *)drm_priv, gobj, &(*mem)->gem_handle);
>   	if (ret)
>   		goto err_gem_handle_create;
>   	bo = gem_to_amdgpu_bo(gobj);
> @@ -1874,6 +1875,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	(*mem)->domain = domain;
>   	(*mem)->mapped_to_gpu_memory = 0;
>   	(*mem)->process_info = avm->process_info;
> +	(*mem)->drm_priv = drm_priv;
>   
>   	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
>   
> @@ -1911,7 +1913,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   err_pin_bo:
>   err_validate_bo:
>   	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
> -	drm_gem_handle_delete(adev->kfd.client.file, (*mem)->gem_handle);
> +	drm_gem_handle_delete((struct drm_file *)drm_priv, (*mem)->gem_handle);
>   err_gem_handle_create:
>   	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>   err_node_allow:
> @@ -2027,7 +2029,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   
>   	/* Free the BO*/
>   	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> -	drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
> +	drm_gem_handle_delete((struct drm_file *)mem->drm_priv, mem->gem_handle);
>   	if (mem->dmabuf) {
>   		dma_buf_put(mem->dmabuf);
>   		mem->dmabuf = NULL;
> @@ -2463,6 +2465,7 @@ static int import_obj_create(struct amdgpu_device *adev,
>   	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
>   	amdgpu_sync_create(&(*mem)->sync);
>   	(*mem)->is_imported = true;
> +	(*mem)->drm_priv = drm_priv;
>   
>   	mutex_lock(&avm->process_info->lock);
>   	if (avm->process_info->eviction_fence &&
> @@ -2495,11 +2498,11 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
>   	uint32_t handle;
>   	int ret;
>   
> -	ret = drm_gem_prime_fd_to_handle(&adev->ddev, adev->kfd.client.file, fd,
> +	ret = drm_gem_prime_fd_to_handle(&adev->ddev, (struct drm_file *)drm_priv, fd,
>   					 &handle);
>   	if (ret)
>   		return ret;
> -	obj = drm_gem_object_lookup(adev->kfd.client.file, handle);
> +	obj = drm_gem_object_lookup((struct drm_file *)drm_priv, handle);
>   	if (!obj) {
>   		ret = -EINVAL;
>   		goto err_release_handle;
> @@ -2517,7 +2520,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
>   err_put_obj:
>   	drm_gem_object_put(obj);
>   err_release_handle:
> -	drm_gem_handle_delete(adev->kfd.client.file, handle);
> +	drm_gem_handle_delete((struct drm_file *)drm_priv, handle);
>   	return ret;
>   }
>   

