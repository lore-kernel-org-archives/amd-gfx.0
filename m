Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2B7D12663
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 08:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C38B10E229;
	Tue,  5 Nov 2024 08:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M/mmeD4I";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586ED10E229
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 08:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x39J3OfNXTNIKoNf+c5mEoWClAm6JgfC5x6ld6GZ+aIwXsn/IwQvYFl9hpJ7fWYjGXmGvxF+sOGD1mnR7axrXirX5j9dZDT19gw8VQRb/FkQsTZGqcLU/5v0PH4cYIBr3/tFoQ1eiBL4kUwQV81hKy1fYxT9NBWLCzoxeEZhT0UY1/KsM3jCr0TzLlcf8FbKatpKcbC1nyIACKQTpPEIOj+yK8+E/kZQ0NgV6rVzL9rfIPgeNN61G75CNz1WfHzsPAla6fplyXNaUzFUTqYahmcpSqTLG7iQtZzJ/D2MtedW6iFE9CSoC4eou2ktXJTSs2pCZx8gq4auNwvGn0rz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM1ykK1b3+yYjJaYQXuByomG9PvyfSX42ACduO/640A=;
 b=Prnlyx9h8XLXainGqYOnAhJUrMKJzEpgV3ZNCbm/6ktAzvpNjftQtj6gWxazNOdFu+y9JhIx5o8H+fxHIl1FZVCNNbU43XhuH1ReuDDTo0B8vthw6a8jSRmFI+Yxx/vM1iidJv6MCAoo2L7KjRLhCw2GXyA7S5m/FG0ONMmfSwCL/ExtojXjagFGZIqCSKGtHrdXq5Q6WQCuRAzUe+nZ61yaROHuagsprzmBkJHVEs9pZiyFVlvgenKZ67QsiBVGgfPDa+Aj2FYwWY4yBQifx2Y9viZO8V2obkw4V2X1M5khypCa42zSx5n5dI/movHUEIIZt7vz41bPXLRf2vXPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM1ykK1b3+yYjJaYQXuByomG9PvyfSX42ACduO/640A=;
 b=M/mmeD4IkKcpgxj9dic8AIsGspVGgK6leBXg9k9vVUCIhRb5LCfKALKYdSnPaM5AFB8ubeyNeeND+VMK1caXm0jfcZ/H5HbPiR94dE0DIphpZVqp/H/2UQPY/upZ7Bz4REdvlnF6LZSZwYbLP6mMZPY3MN7ZcoxXPhxQDxJMbbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 08:52:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 08:52:10 +0000
Message-ID: <c7c4cac9-66f3-4dc5-939f-e6ae95e13535@amd.com>
Date: Tue, 5 Nov 2024 09:52:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix return random value when multiple threads
 read registers via mes.
To: Chong Li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: emily.deng@amd.com, lincao12@amd.com, dejan.andjelkovic@amd.com,
 zhengyin@amd.com
References: <20241105024852.30452-1-chongli2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241105024852.30452-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fa9222-1aa5-4d42-e625-08dcfd77228d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c29vZmx0cGpLelE4blhNYkdDWkxJQ1orK0Z0cjRUbmprMkpYQkJ6VVVDdUdM?=
 =?utf-8?B?ZDJ5V3owRTFvbXlvdzJJWVpZZ3ViRytPYVkyUjhyT2pVT05CblBqb2JzYUoy?=
 =?utf-8?B?R2dQYkZidnhlTDFVd0JKdDFHaDlSRk9NU3ZCeUgzZFFLU2l5SngySW9LM3ha?=
 =?utf-8?B?L1F1ZVJDOUh0M3dtakVVV1h0L3lMVUdhK1NNOEdoWUM0N0MwWUtJMTcyU2Vz?=
 =?utf-8?B?a2NmUUg5R1hHWnZqN3I3K2MxMTFvS0NyaENxNFlIWnNJTGZ0Y2NmdlVyUkdH?=
 =?utf-8?B?SFY4RWhLUWhWby8xbWFqdlJnb25VOFpGK21BTHhRVUUyVjNhbzZtQ0NPTnRX?=
 =?utf-8?B?K1llWmZ0T2dXUFhjK1JPNW1MSld1MVF2MzZua2Ztb2k0MzNWcXdFY2txbmxO?=
 =?utf-8?B?R05Ja3l3L3Q3enljZjlnS1BKbzdMbklKT0pPdG4ybTV0RUtEdnRScFZlZFhO?=
 =?utf-8?B?TTl1aUtKejdVejZFbjJGeUMvamszWHMwYkoxeHpyYlM4L1QxN2djT1V4TUtt?=
 =?utf-8?B?djh2MWcwaEdXQ1NyZUVlT3R6dUhXM0xqbE5LRkM3WVJ2U3NXN2Zva0lDWUkx?=
 =?utf-8?B?L3Z0NElFRHNYWjkveDAxZk9zdjVCUVJIOFErZW5VSEh6eFZ5VjFDd1UzR2tO?=
 =?utf-8?B?Y3J4TjQwQVR3R2Q2UldKYjdJUHk5N3E2K3R3STRRelJiQzlETVJScWRBWmNZ?=
 =?utf-8?B?OUlYMGE4MXlHV2xXaUhDQVVnZ0dGOUIydnNrNE5lYURVbndFWngxOWFNM3VE?=
 =?utf-8?B?Ulc0dWRoWTRVS1FFTWc5UmhPNXVIM2phTHVwMnFSOVRwZ1RSQm5Wc1NUdUR0?=
 =?utf-8?B?OUpwNkJWdXE0VGh6N1pCeERNVmJISXFiL3hqRXhZS1JMS0cycnBUZUgyMTly?=
 =?utf-8?B?S3BRSitJSE53ZitIbWFVaGVlL0F5VWpiWWpsWjhuZ1VjU25ONlVPUTZSVmZK?=
 =?utf-8?B?cjF6Y0w2aFFic2VnTFFVL21wTnVDTXpOM1g2cm9RVVBrTXFQdXB4aHp5WHNV?=
 =?utf-8?B?NXZ5Vjc3RklOUGc1WThPR1MyUWlpa2E5Y29mNm1NZU9jOWhhZ1dlbE1jbldH?=
 =?utf-8?B?VHJoczI4OEI3dHlaYm0zMWZ1b2gwdW1ITzM1b2p4S1VFS2wzZHFlL1VjTUJE?=
 =?utf-8?B?ZUp0M1NqVld5VXEzV3VNQUZoSGtlT2VERlQ1TTdOeXpnZHdoYVIzaW1wL0RI?=
 =?utf-8?B?V1dBTk5hdml6RytnWGoyNkNOakFoUDdOdXlYSEZRU05RVGVheko4WjAyUEVx?=
 =?utf-8?B?RFFEb25XU2REVVovREN2T29WZC9zdUs1TUVOdzhEZ1Q2dElMQVNOMFhsaGhC?=
 =?utf-8?B?bkczMkVmWkRuc3ZpMy94cFpESGE2R0IxOSs2ZVJ1aXpidlhKRlU3MnFtMEdw?=
 =?utf-8?B?RmJlQzc1T3JMa25WaklIY29ZQzMwVkdjRW90V0l1bXhqN0R5QWR3THBSTUM1?=
 =?utf-8?B?MzF1aDlncDBscEU3NEhjUGVKTE9TWlFzVW4waW9OK0NhZ3RDODhQV0Rna0Iw?=
 =?utf-8?B?SVpZS1B3ZDUxOEVLd011VnpyNTg5S3lKWldwUkFYT1EwbUhWQ2lLR1lnZW9C?=
 =?utf-8?B?dndnTDhjT3dHWERJODV4eWRka1M4NmFuakhxOVRTUXNnMkR5cGpsa1hsU2hW?=
 =?utf-8?B?VkIrTTdMb3Y1YnFRVGRJcHdocmVuV0kxVUNzaCtBd1M1M0h2dHA5ZXU0bDQ5?=
 =?utf-8?B?ejRtbVdONXJGODZYa2V6aGU0VkNHWHhabVN6RVZKaWx2SlFMREFQWnNvaWtx?=
 =?utf-8?Q?DjJdySApUJi29jOe1c78/Gfb61L0rGjoiWkZoEw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1JGKzRHTDNid0pNd2tzWEtTbXlpMW14c1lZY3pUV3cveXMxalRCQXVRcHlS?=
 =?utf-8?B?NzJqVmFVbDJ4SkZaOTB4OExlL1JuL0w4M2lzTXVjSE95SGRqUTJlUncvVFR6?=
 =?utf-8?B?alZxMGhTUnlreVJ4cjRvUWtVN0ZvclhBcWpPQjF1UjlZYis1SVdBN25SalZK?=
 =?utf-8?B?SXc4K0dCSlUrQ3M3a1Yvc0ZrNHBzOWhBNW9KZmt3MXlTN2FhMnpLWWlOcGRS?=
 =?utf-8?B?QWFKaGlRYnFyYzZsUHdlYnhCcE5DSmRKVGZnTjFrdmo1RmlMbkRVVzZqdnVu?=
 =?utf-8?B?OHBMUmZrWENoSGdVYzZ3WnVocUJHaVBwNUVucDZDTFJ6NVpDSjN5QnVURjBs?=
 =?utf-8?B?Uk1PVTdPQVA5Q25YWmhCVTZBRUZVUU1qdUxncjVSMkZqV0pYTzBDUDJmVlMr?=
 =?utf-8?B?S1E1Yi9qVmd5ajREUmFGTUlnKzFjRDVLTkgwWXl0ai9xd1o5NXVXS2RJK0s3?=
 =?utf-8?B?bFBXelNzM2pROXl2WW1CUTVDV2dtR2ZTUnpwZHEraGtCSXRQS0tCSGNXdVQw?=
 =?utf-8?B?KytQNGFaM1BWUnV3R2ZTQVhqMHBYN2FaTkxUM3lueGhZNjNlRjlLMTg2Mi9Y?=
 =?utf-8?B?enVTU3JDQlpHMlZjNnBDMVVjUFUzczhwMWJQNVpTZHlsREhRaXU4bDFpRXoz?=
 =?utf-8?B?Y1grQlBkaXpGeTBtNllPYmNmeWlLclVaOWU1OGxyT3R0azFFbUdGajlRYjBB?=
 =?utf-8?B?cDRnOUw2R0JFQkpGRFk3K1RpTDRRbEZxRnpYZHpLSDVLVTN5UzZqd1pZR25Z?=
 =?utf-8?B?ZE9iOW5LL2FNa0srZExBRTBNV0hUVXlKOWpNelcyL09GSlNpNHRhT2h2N1Np?=
 =?utf-8?B?eVFqVG44YWpBZUNweEpxbGJaaE5Ramw5aFlpcm1GVDY4WkhSb0swMFd5cWZR?=
 =?utf-8?B?OXBCR3krZmRic1ljM0F6eE5ia2wrQmhHc2NudnhVd1VIaFR3WDUzNVJtUjdp?=
 =?utf-8?B?b1FoY0VBc0pxRFJVQXN5NXhvd004amVQbStmeHRUR0tRbWNTdWlHRWVCOVVn?=
 =?utf-8?B?R2REWUpHWnBHbnNtSEx1ZzM2R09uRkZGT3ZKQXFuRnlldkIreFFZd3FrY1U5?=
 =?utf-8?B?c0JwV2dIbFpYTUkxZjF2WEo1TmRRRkkwRXJPSFV6MzZNczE4d2dCVGJ0eTZh?=
 =?utf-8?B?cWQ4OHhOVTJMMmVxdXFRazZ6aU9BTnR6ZExiUjlMVzU0akxTckc4bm10WkJw?=
 =?utf-8?B?WTBKYXNaczdtdHFlU1BOTXFmWWxoSXV1S2luUmEzU3Z0bHVsQTgveHZpN3h5?=
 =?utf-8?B?NS9JUUF6MktOY1RZUTh1K28rMDkrMy9weVZTK2swRC9qeW5pTVAwZDU2MlM2?=
 =?utf-8?B?VFZ0a1kxZWNtZzl1V3kyZUVLSjdsdERBOTNOemJsS3MwNU9IZGFuNlNiYUVn?=
 =?utf-8?B?c2hGT1IvUlRyVDlMU2dmdTdUbVdoV0ROWDhpZ1Mxc05sS2F6bnpuamtKcFQ2?=
 =?utf-8?B?MytSdXc0eDM2YUJtN3pVNmtkN0F5UXF5akpzVUljQWhRVkh6anp0Tm5GTjV5?=
 =?utf-8?B?Z0pIcGF6Rnc1Nkh6TkNIeCt6emthL2dkcVlUeU1SVm9qb2dGVGNtRUtGUkJ1?=
 =?utf-8?B?bS9vWXBkWEdDSmx0dHk4Q2ZVdTc1K09BcmUvNVdFcHc3WTVNVFByU2FRTFRy?=
 =?utf-8?B?cFNvd1QwMmRqRVNVaEZScUVZRjlrWEF1NnpOem9XaHk4NmIxT2t1MkY0bk9i?=
 =?utf-8?B?NGI2Y2phc29jcnpXK05iaDBld0V1KzRRVGxjU3lBTzJ0VC8xc1MxbHh0azly?=
 =?utf-8?B?N0lyTUdvMDM3Uk9WZG1DSDRhMUFNQW9kV3dlbXRLcnVaQTNVT2R5K3habis5?=
 =?utf-8?B?Tll3TUN4QnphU3dGeS9vVFFjMVo1cmJzdTliQzdqYXNvVlRnUHJkU3NUQi92?=
 =?utf-8?B?QmZnTWFjUmprOFhIRHlyUFl1WmxhUlMyTWhDQklOV2hEcHEwcUJ2WC9lcHZS?=
 =?utf-8?B?N2pieksvTUNqcmUvTUwxZENEdjVrRVVEWFpFR0MraklGV0tIQ0hCT2ZvSHRJ?=
 =?utf-8?B?ZmtGVmtxSmpubE03SmN1Yi9zTzN0N3VGZ3BmbHdIOTVONTA5Y3REa0lTZ0lG?=
 =?utf-8?B?Mi9hYVZHUjVwWUpjalNmOHE4L3VkWlhYa2pZd2VPeTc2NmwzWkM1SzNJWnFp?=
 =?utf-8?Q?YisCVrU3msvljzJ7PxDRYgo8Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fa9222-1aa5-4d42-e625-08dcfd77228d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 08:52:10.4284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEx8RXFVYtPs+S1h9hczFANjuYmPI3vfdiSHco9hLBnOQxAG5sm5/SdslUzOebm4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
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

Am 05.11.24 um 03:48 schrieb Chong Li:
> The currect code use the address "adev->mes.read_val_ptr" to
> store the value read from register via mes.
> So when multiple threads read register,
> multiple threads have to share the one address,
> and overwrite the value each other.
>
> Assign an address by "amdgpu_device_wb_get" to store register value.
> each thread will has an address to store register value.
>
> Signed-off-by: Chong Li <chongli2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
>   2 files changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 83d0f731fb65..d74e3507e155 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -189,17 +189,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   			(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs[i]];
>   	}
>   
> -	r = amdgpu_device_wb_get(adev, &adev->mes.read_val_offs);
> -	if (r) {
> -		dev_err(adev->dev,
> -			"(%d) read_val_offs alloc failed\n", r);
> -		goto error;
> -	}
> -	adev->mes.read_val_gpu_addr =
> -		adev->wb.gpu_addr + (adev->mes.read_val_offs * 4);
> -	adev->mes.read_val_ptr =
> -		(uint32_t *)&adev->wb.wb[adev->mes.read_val_offs];
> -
>   	r = amdgpu_mes_doorbell_init(adev);
>   	if (r)
>   		goto error;
> @@ -220,8 +209,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   			amdgpu_device_wb_free(adev,
>   				      adev->mes.query_status_fence_offs[i]);
>   	}
> -	if (adev->mes.read_val_ptr)
> -		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>   
>   	idr_destroy(&adev->mes.pasid_idr);
>   	idr_destroy(&adev->mes.gang_id_idr);
> @@ -246,8 +233,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>   			amdgpu_device_wb_free(adev,
>   				      adev->mes.query_status_fence_offs[i]);
>   	}
> -	if (adev->mes.read_val_ptr)
> -		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>   
>   	amdgpu_mes_doorbell_free(adev);
>   
> @@ -918,10 +903,19 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
>   {
>   	struct mes_misc_op_input op_input;
>   	int r, val = 0;
> +	uint32_t addr_offset = 0;
> +	uint64_t read_val_gpu_addr = 0;
> +	uint32_t *read_val_ptr = NULL;

Those are unnecessary initialization of local variable. Some automated 
tools will complain about that.

Apart from that looks good to me,
Christian.

>   
> +	if (amdgpu_device_wb_get(adev, &addr_offset)) {
> +		DRM_ERROR("critical bug! too many mes readers\n");
> +		goto error;
> +	}
> +	read_val_gpu_addr = adev->wb.gpu_addr + (addr_offset * 4);
> +	read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];
>   	op_input.op = MES_MISC_OP_READ_REG;
>   	op_input.read_reg.reg_offset = reg;
> -	op_input.read_reg.buffer_addr = adev->mes.read_val_gpu_addr;
> +	op_input.read_reg.buffer_addr = read_val_gpu_addr;
>   
>   	if (!adev->mes.funcs->misc_op) {
>   		DRM_ERROR("mes rreg is not supported!\n");
> @@ -932,9 +926,11 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	if (r)
>   		DRM_ERROR("failed to read reg (0x%x)\n", reg);
>   	else
> -		val = *(adev->mes.read_val_ptr);
> +		val = *(read_val_ptr);
>   
>   error:
> +	if (addr_offset)
> +		amdgpu_device_wb_free(adev, addr_offset);
>   	return val;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 45e3508f0f8e..83f45bb48427 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -119,9 +119,6 @@ struct amdgpu_mes {
>   	uint32_t			query_status_fence_offs[AMDGPU_MAX_MES_PIPES];
>   	uint64_t			query_status_fence_gpu_addr[AMDGPU_MAX_MES_PIPES];
>   	uint64_t			*query_status_fence_ptr[AMDGPU_MAX_MES_PIPES];
> -	uint32_t                        read_val_offs;
> -	uint64_t			read_val_gpu_addr;
> -	uint32_t			*read_val_ptr;
>   
>   	uint32_t			saved_flags;
>   

