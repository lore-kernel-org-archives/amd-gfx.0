Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FA2CD5BB0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 16:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D98310E262;
	Fri, 22 May 2026 16:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="417XZV4x";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348AC10E262
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 16:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUgqynFc1B/gYlv7SEsQQmS8v7NbIs6lRnK4du7tmgDV9N9Ds9KxBFJyOtvvfBky/9Df6StYStBnxXNn/8h0leMJI/unh5mNcSBDIpGvX/1MjHYkQXLhy4CRfSDlIIj8gwQMQ7Y4w6KNVm93sfzM/Tw878gjjK+7qOUIdKHBCmhQDezvrGYDa0KTvDb8rIVuRq72714/0CgA01wjeQyhqSRo8oixBaxcRADwt/uQ4ZGsSOOacUe3DBgi4A2bonqHhSdMFtaus1XbeGADIyqrnwMNO5e+JMZF3vuOOgJ2gcOkyePC7HDysAGWRWPP7vgm5Y9gcqy+R407141vg7uUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBdyNdar/GFAbXjsqg4b0jcTvUGFHHraiz3IK2hq8Ws=;
 b=hdlsSJIIclS+N1VRPp9Z1097SgSGPE5WfEhuFTboAQ+qupPhroKwiiQtS710pNNaVQsPtvjew+6Mu+XdEbJkPJD2OGBNGz427SRtJgzeEi0SQT9YE1UJJ2hBl/ETRrgkQpwUCkp7hmZaV8kmmWGpUp+v3pLXVDV0Ot+i0nBpciMZjIcl3e58mIDM3AiuX2bAFUcIEF+WgDBi1ZInIkyMh4fRz4JkjHyhWahvbLUy8VZqUU6SHPm4Iv5aEVcl9LaoCRq3s0eEkLyEsGFlxYbvTvwYRF/C9wJUP7TWe0C0uPXGGkZu+4qGDjWEzBHL3usgQ4H/1ueCiyxkVA5ok6hZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBdyNdar/GFAbXjsqg4b0jcTvUGFHHraiz3IK2hq8Ws=;
 b=417XZV4x6y3tdl8wbU4OFrGFW3VZkvMVwDpuTi8Om9dZcG9IiKuWShnlMpbFNDY5B/69L9iJWXgTVLscJgkeVcmTbNopnYHvUk0s2M4xRXE09b5s0JrZMMKN4Nfag9qNx+Qg/4wnY+NzkmWKo37qqwqzGJiHKesF4j93FbaKLHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 22 May 2026 16:02:41 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 16:02:40 +0000
Message-ID: <324818a5-5169-4822-9364-033f7bed208a@amd.com>
Date: Fri, 22 May 2026 12:02:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix num_pages calculation in
 amdgpu_ttm_map_buffer() for non-4K page sizes
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Simona Vetter <simona@ffwll.ch>
References: <20260522112838.1311531-1-donettom@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260522112838.1311531-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0090.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::23) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c41bab-ee21-4515-aedd-08deb81b8d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: AkgeyQT7RtTFFpjw5ddEe4KINyjN4q9LB0nIgbn4OUFsAQcAnullpipIgb11Xh4zdModQIavowiEVJK/axUZjAm0int3xgUJl24JcOv5P/T8fqewlUCN30kBSwXZD0sILOSYgESkjbietcuTu03jqkp5Vb2XQ5n2DyG4qoQSAjRrZgrWsULOH5cghMA2qJiU/AIiLHbTzGD7FkN0fxHd23MmtHk5WKQhq2haSco2oQ6PPrEGMB4VvL/+m30emch1xJSUbbdVUyg+UVKF/kFQ6SG74CPH9QtyFmsH/Jf8PtDqePGNM90ii6pkl/J+A5OKzdsyZIcJufVX51FzMr8LdDGmxgVW4Da0gwx8sx2B2aW/XjmpJOc5U9WEIeqeQgP5g91IrG5mP2sCLl2ZsNyK1Q/gIWIQneSKboTrKO3Fxqx/iEKuxkioSY9Wdziq5bSRtmNJ9gqce2aLK2vV2Q+cHCD0Qp8FkNaQ8AP/LyEXR1X/o1FErKdmHu8mUBb/A2NJzCeYKUJSv3EkJmLOu9aGj5qAV7cneWvsYCGecJxh8IB0KNR5WqSVfrWH/cQC7z0i0WU5YT9GJndR5ApU5PUbZmsvdm51dcVmY/aOQD0rbfd2CwsUfVg0yjqS7rxHDylizi97iLwf+GX45NCyAuK/YqLicqO8GVHgt7EunkaN+jBVjf2vkZjmiN1wxmg5W9iz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUlnM1B4MTQvRUgwU3BJa1hYeEU2dmtkbm4vaXJwaC84Q2pjY2Mvc1dRT0NQ?=
 =?utf-8?B?NmtKZk5aWFh1SWpkOU1qNklsZjFLYnVtQVE3K3NFRmMxamRpcElJVmtNdW1O?=
 =?utf-8?B?cTdsMXlEenYyWVVYR3g0VnFCRWo1MGxILzRYWm1YZnRkWHBTczlVY0x5RitL?=
 =?utf-8?B?MG9qaGdaRjZvK3Nubit1K3JzM3ZLR05FZnU0THEreElhTlgvcFNrdVlZMGZE?=
 =?utf-8?B?bkt6TFBSS3hKYllwbXZaRHZDVzdKWEVTL0JUUS95Tk4wRm1jMUw5dllSMVBL?=
 =?utf-8?B?UFJ3cWsxNWVHNmNnVHJwekFCZVh6U21qR2wyeFZVMEE2Y2VLNHVyaDQyOGVN?=
 =?utf-8?B?Y280WGhaTzNPSGNRQVN5cFVUcy9VajZBRG5VMmVjNWRTOHNHbTVpN21wVDFt?=
 =?utf-8?B?blhISnNJMzdPOG5sTjZBeWphZDB5UFlwb0lGQTB3clYydFBKeHpwQ21EV092?=
 =?utf-8?B?U0hnZHdlQVRLS2JqWUlrTStjOGVaOWEvOEdFcERZMTF0bUJ0N3B1bE9CSmd1?=
 =?utf-8?B?QXRJc1E2Mm9JMGlwOFBzSkVSbHVrL0VXNDFrU1EwSmxLbll2bWU1Z1YxdlVU?=
 =?utf-8?B?NXluZVBSaElZalhiN21rK0o5MHNHdk55RHl0dGhqbjRSNHJiYVVtV0tFK2d2?=
 =?utf-8?B?OTBCUlN2L1JheFRUOUtGV2ZqaEFZREpSdFVjS0hWRU02Z3FqVWQ0Y1FkNmxR?=
 =?utf-8?B?LzUyWUlmdEtuYXB6cHZZR1V5Zi9OMGNhY1M5ZlhhVkJEeS9tUG0wK2tmVUV3?=
 =?utf-8?B?Ym5MZ0RaNVlZN0h0UnpnbW5CRkVNMG1KQVBNMjc4UWxGMFlTdkNUV24wN0JR?=
 =?utf-8?B?MDFGa0NXWS9UNmVqZTArVEJGVWtIRHQwUWNZY2JuSFhTaXVGLzR2VjNDSUw4?=
 =?utf-8?B?SjRMRGNiQTZiSjg4RnN5VTE5cU55Vnd0emlyaDR0ekpXL2tlVUYyUnBYSGN0?=
 =?utf-8?B?VTFjQVhRdzJXV2djbkFzQVdKZUZQQjB2QVA1WUUyR3dJdU1TalM0dW9jSEJZ?=
 =?utf-8?B?bFp6TGNCVDhSaDA0UUlobjFXMmU1ZldMOG9nRGVCZ1hMcS9VK1lJT05EdHdx?=
 =?utf-8?B?WU04YUVxYXdXL2FvQ1paKzRMTGRjSDg4dmU3TzNiRFBhRXNFZzRGNW5xalJE?=
 =?utf-8?B?Y0wwN3VmU0N1SGtkMnVwMndJbG9jNlhhTUdiYjFqTGdoaStycFVtbnk4UWFH?=
 =?utf-8?B?ajFKRXhsTUl6cWg4OENtMGNzYVRwRXhoMlJNNjdJazEybE1weGRHWWZ3Nkdx?=
 =?utf-8?B?SFRXbjByREhtQm9hZXlIbXdTaG5nL01XUlpOS2o4bWc2cDFzaW1KUU95aFFH?=
 =?utf-8?B?aHM4RTRubHlycVlnVW43YWxtUUJORUtlUGxkWFpGNTgxSnlTNTlXbkY4QXh1?=
 =?utf-8?B?Zy9hdTZOeEhHRjJXRVdPS1hOYVI2WTVjTldhVTVkaHpJaDZ4TlBoMTB0Rzln?=
 =?utf-8?B?M0gxdmh5SE1OMDlJRWxZUUZITkZuMkU0STVERysrME5paUx2RU85ak9FWmsr?=
 =?utf-8?B?YzE2R09PNlRpRXh2aGhhN3BBTHBlaGFVZmpZZkZwNEpPeDdOZnpBMElFaDJL?=
 =?utf-8?B?Tm1mem9IV3pvdHlHb1Q3Y2VWelc2NEx5UFVVTEFxT3F3QWFoT3dPdnhTS1RL?=
 =?utf-8?B?bm1oWjI2MHI1SHV0Z0dRdlI3ZS9XazluV0JUWkYvcUtJRENsNGpNN2I0aE1G?=
 =?utf-8?B?YXpRSmxWN0pPbUdvSU40UStlYlV3RHROL1MwUHpiS1U5TUsyNTcvaDRWZG44?=
 =?utf-8?B?VGQrOWw2L24zeDNMQTBjQW1TQ014RWJMcDJFVS9DWmZJK1l2c1ZReGFHRkFi?=
 =?utf-8?B?TUlsazZnMFdZaDZQS1hHSFdsZGc2SUJDck04TjJ5ZUJ4SERHdWJyWWJZdnIx?=
 =?utf-8?B?ZGJWWkZ6R0I2WHp6OS8rOUhwZDZOQW9KU24wWStIWHQ5RFlZSnB4K3pYMXJF?=
 =?utf-8?B?WU9YRjBFdHUweE4vQjFLTXExQWdKQjRQMzFZN0xYc0VoQm5WTllMUk8xZlM5?=
 =?utf-8?B?UGdlcTNNYjM0Qzg1WlFENGVrb0VtbjI3K3JvV1hxOGxKWUpQc3pSUyt2bWJh?=
 =?utf-8?B?aEJZU05Vc1ZXTndGL3ZCcXhHRUpIZkxOcHRPOXNUZm5BaWhCOFB5SjB3RVg5?=
 =?utf-8?B?cWxxVENLQ0w1d0lWZ056YU1xNnNCMTRMaTR3cEtnMU9rZlc4YmhyUVRRZXRH?=
 =?utf-8?B?NnFUQjM3WTZKQXZoaFZYcVJUTE9JL1RtY3lBa3lqUkg0QXJWN3NQUm9Hbksz?=
 =?utf-8?B?Rmt2QW56Y1o5eWhmUkZNQm81L3VqN3JkZEQwc29TS0tRd3FaZ0FtQWFtZG0r?=
 =?utf-8?B?NEdGUTMxUTNuMFNTZkJDZzl0d2FWTEFsa2VqT2NiSmdOVHJQcHMxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c41bab-ee21-4515-aedd-08deb81b8d34
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 16:02:40.8395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVTxHrXv5kH0N+ouqwd1FM5mQQ/AV/KU9HOFRXwJWkg47JnX025Z76aGEYdeaZkwD91fLuRd5q6pCY/brvX/gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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


On 2026-05-22 07:28, Donet Tom wrote:
> amdgpu_gart_map_vram_range() expects the number of pages (num_pages) in
> 4K page units. However, in amdgpu_ttm_map_buffer(), the number of pages
> is calculated based on the system page size. On systems with non-4K page
> sizes, this results in an incorrect number of pages being passed to
> amdgpu_gart_map_vram_range().
>
> Fix this by calculating the number of pages correctly before passing it
> to amdgpu_gart_map_vram_range().
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 3d2e00efc741..2904a9400605 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -269,6 +269,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>   		amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags, cpu_addr);
>   	} else {
>   		u64 pa = mm_cur->start + adev->vm_manager.vram_base_offset;
> +		num_pages *= AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>   
>   		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages, flags, cpu_addr);

IMO it would be cleaner to change the definition of 
amdgpu_gart_map_vram_range to use the same page size as amdgpu_gart_map.

Regards,
   Felix


>   	}
