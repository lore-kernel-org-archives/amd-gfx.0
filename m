Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78F606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YxI2tyqw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E192710F2D7;
	Tue,  3 Nov 2026 01:40:31 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F1310E75C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 01:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shc4Jboe7kuf+/M72K/Tzr2mw57YbSvK6gnRG3YWz4cAs6JuoLfHjwWPU1h6KmeD8Jdl5uQviXQbvx4xYffiLQX5lZonO2rYkltHDo0YRmoWL3/fRfrshnxwLDItehjBZz1kWE8h4vl+ieiWsZJcZe8kY2LkZGDwhyhKsXKZO5RwC/Sk31xAuY9DAWYOO8mpb4hgc5UFay0Yin63D4LTERrlU3QVP71HniDy0C2IvVsFKaMuN5/9FakkPpHOUtxH8zYT2YlnJdbeZemi6NpEWFF5fjcHjVB5JfG6XiBJDfgLDFQZOHe3In3RLj1ggFEDc/m6h9+fh/enqWXEX2BVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM2hzqXED9UyftSGgAG/sxS591KBUtTGur5ls/VU50A=;
 b=KOhzD52Dfhz7KK/jzAmEks2kvjTA4fyVbfOIeR+NOjFMDStpYUJ5gw+6hmHuL1VYOl1K914+y2n0SMtlwFZeyRpGr2czA1mKeLScpXTTeoMwR3KRNx4c3Z20ic5tphGQE2YyL6QV/0Vlcl4fs3V9+xHXgZkNheJpZ3HVgAwEQEde3nYRMkVA66EQ7IcJ9GqHXvNcWPFVEh0Jzg7xWoun3e5qiYGQXfQdiZlPcaD/84WonMjW9lXOMYsAlHUIseAQBX/wZe15lvGFKFihm2SgO9rN4AIhECieSiCr3A0FhuJj8H7iQ3bhdG4KEPM7rBJz0pabuYJz5NLDXwjqds0+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM2hzqXED9UyftSGgAG/sxS591KBUtTGur5ls/VU50A=;
 b=YxI2tyqwN6CsRmsdfGGLEKpmlFCBjqPUJ50mhKYaP660A9AhQ0LYEUexQ+4XE3o8PUPagWH3T+Bl34w8+MK+T6i6jze6S7Uz5lUzTvb4lz0IiQpf5d7LX8JQyuON7OFpeC3Tp2JRIsl+AvRmqOwv6uLoYTHsMJC/prFUsAkudS4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB504406.namprd12.prod.outlook.com
 (2603:10b6:610:34b::7) by PH0PR12MB7932.namprd12.prod.outlook.com
 (2603:10b6:510:280::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Tue, 3 Nov
 2026 01:39:59 +0000
Received: from CH3PR12MB504406.namprd12.prod.outlook.com
 ([fe80::570c:1c4d:5cd:97f7]) by CH3PR12MB504406.namprd12.prod.outlook.com
 ([fe80::570c:1c4d:5cd:97f7%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 01:39:59 +0000
Message-ID: <d65508ed-9bfa-4508-9794-32a292f18f74@amd.com>
Date: Tue, 3 Nov 2026 09:39:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amdgpu: No need of mutiple hung_queue_db_array
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20261027075017.121456-1-amber.lin@amd.com>
 <20261027075017.121456-3-amber.lin@amd.com>
Content-Language: en-US
From: "Lin, Amber" <amber.lin@amd.com>
In-Reply-To: <20261027075017.121456-3-amber.lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To CH3PR12MB504406.namprd12.prod.outlook.com
 (2603:10b6:610:34b::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB504406:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: cea052ce-4b69-43e2-e5e9-08df394b5ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|261026121527099003|261022105027099003|11063799006|4143699003|5023799004|261021121427099003|261026140227099003|261021123027099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: tu4lMqZ3MwmX1SkD4BnbUMgCrGqiUtwpHunA9kAjhPUaqeF8an6Atg1fbuz2pp+2WPzyMyAhuC4qDurzdREpuhnGwgLnp3AzQLTzM0xPmc7avVFxNKFGdQVLycAt+6tb3bTjZErG7foSFoZ+FTQsLIMJ4WiPoJykcMyIpG82GRgYBSuqPUru+H1TPDkOa90VS9y8aBIBBMAyFiEUMBrYrtPKTPM1SfYknuxU4ifjn+/zxV6km9SrWxcCYl3n1wAjz0knTRY0jYeEH5eD0+O5Fls/8fFYOh9V/ynO09GhNzscbwuuJz0g12qb+YinGYT6MkObcE4jKmZLSRvacoHORv5gXBfcvpqb99I1UMshsC+BtYBtkcGP2kzTyUcv6eg0yn8CejlnJJopoTy6hIyUz9Q3S2E/Bc4iPCpymp4H9qU0ejstM7PCmw9h4+gMzD9qPKflKDXs+WE00+cWFtc9U/WmYTfC5YGf7HcxuUyN+bUNg7mDYwOp3JjV5wqBv/cAVA3Del++X66VYXyDCzmwhz+BGnpX6XYOXqQsCg19IzuTfVUmVSilPE33nX/NgQsH81qdlo76JygbNiJS2y5rFtVDpfxyH+1CgShzl2ytT9g/KoIRd3fRd9JMLWyfIifQSpJc9rsSeL0havQA+CA0LhQIFIJPXFjcDhrGHSryMSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB504406.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(261026121527099003)(261022105027099003)(11063799006)(4143699003)(5023799004)(261021121427099003)(261026140227099003)(261021123027099003)(261028144727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtHc2pUUFpjRFNzQUpDc0hzdWZZMVY0dEFtaS9wYVBQNHdyV2kwU202M2VF?=
 =?utf-8?B?ekJjRG9sWHE2N0FHM1RVMG5lSXFMbnE2OVY2SkJ0YlpQVFRKdnRQZjJhTDNX?=
 =?utf-8?B?ZCtlaUx4cFNpM3JocVNjY0hiaGFlY0lLWWpNL3ErNk5GMHVqcGhYczBqWmdU?=
 =?utf-8?B?V0RqWDBzd1Nqb0lHMHI3eTQxbUtwTEwxNUtvS0JhNURKKzdCdUpKQjVhaHBV?=
 =?utf-8?B?eFJ5KzdLY2NsNEp0cXFmSlBQK2RqK1Fja2tWaFF1dmozeFZudGk1bFNiUC9D?=
 =?utf-8?B?OVNSRWtOTk9hK21Ob0s2NWp6ZWIvWWc1RisxMXFJM1dCeWV2b1F2VWhMdlZF?=
 =?utf-8?B?K1paQzdwVkYxYmE4UnUvdTd2VG13cEZVVGpHR3Zrdm11Qy8yY3laUUNDS0Np?=
 =?utf-8?B?akp4N0RFSlo3TVRQTWRIdk9rcVIzUlBPOFhodEoxS0s1Kzhkdm8vVFExN01B?=
 =?utf-8?B?b1llenREY1FrSnFHTkFNN1VrWFpGQUJtdnJydklzS2dCdDRkYlI4UWZ1TUVM?=
 =?utf-8?B?dGF4cCtTRVovQ1AwUXpsbWtnb3h3NTBLb09EZmt2eU5icFp1NkdiZzdxQTVJ?=
 =?utf-8?B?cXFVZTUvbmhWbzZzOEJYOE9aRS81Q016UmczWGlKU01VSDVZSEx1aCtOajFC?=
 =?utf-8?B?bStVeW44cnBranRXS3hTekdsVnJjYzhENkNQRmEyVVQ1WWF5SzVFcmJlMmg4?=
 =?utf-8?B?RVFXYTBldnZUT0pKeC9KTmw1SS85ckFkdTB6cENWUWU5R3lPODdVNUdoVnR1?=
 =?utf-8?B?QlgvWG80WVJMR01ubXp1dGpuZWhyVFRLMjdJcnJpcE5FVkc1Szl0NVF0Y0ls?=
 =?utf-8?B?SGFjSWt3Rndld09xLzA3WXFOSEdtZW1DTmZsSURCa3duVStFS0s0N29xVmRN?=
 =?utf-8?B?WmtXdjdyMWhqeHAyaERLcUZ3bHZJNW94L3NYaTBXTEpsOEhjUXBSUnRya3lB?=
 =?utf-8?B?RkpTK0J0eUhWN3RUWE82SExJVHBOTXNZcFRQeEZ4N1VVdDNjZ0JueEZUWkZj?=
 =?utf-8?B?eG9CSW5OOHByQjNPVWdqelNVK3dHVnp6UXVEU1JWWUloYWJsemlFeFV3cHh0?=
 =?utf-8?B?MjlpOXVDR3l5S0tRSWEva1JwZmJubUVmL0kzRWIyVE9oOXNMeUU0WFlPVnJB?=
 =?utf-8?B?aVJ1dXRNcXBtQTBIV21wdEJHMFQ5MU5CZU9tUVVvQUJ3a3d6aisvemxBUStB?=
 =?utf-8?B?N2RGaGQveVhHaTEzTVFJeW1nR1JaZm9uSVBsRTlFdVl1UHlHSE92UEtlaWlH?=
 =?utf-8?B?eUowUEpvNFVhemJhODZ4L2JlRmdaWXZLTnlwQ2dIWkdBQlJ0WGl3UlBpMDhH?=
 =?utf-8?B?Z0hqVU5PNVk5NWM0ejFwZ3lGRG1FaUVnMWFlejNyd2hPNmt2WUR1cVZvNWJj?=
 =?utf-8?B?MVgxU2xxUXhRU0x0QVNEK3lpY0ZEaVBZWGRmbDdXZllwNG8xU3J5NFpSWm11?=
 =?utf-8?B?b2FRVjJZREYxVXdaMFc5WWtZTWpjOGptckgxL1c4TUk5eHM2dkJ2dXJkYWlF?=
 =?utf-8?B?NTJlcjJvNXZyQTFxMHNaUjg3T2VETTBoeEJwZ0I4SlRZRzNUVnQ5c3NkOENv?=
 =?utf-8?B?SExqbVNNVWE4d1Eyd0VtekJ0U0ExaE1weUYzTEpjTjZUU1I2Y0VHajVweW8w?=
 =?utf-8?B?MUVYOCszdi9Vc2VKdlNvZlpXQ3RzNDJHbkc0M3c4VGxSaUZyTzR3U3B5S042?=
 =?utf-8?B?a21lUVZQNjdSNG93aEhJazV5bGlseHVDVExMVUhxb2c3TGI3OXBkOVBncXho?=
 =?utf-8?B?VzR1QjQwa0ZWR2ZzQnNtMDNNaFNhZk5jSTQrWDJYUmNsYWdzb0VuaWRRWmVx?=
 =?utf-8?B?ZUYwOHMrRlY5OEF5eGRUNzVXRVBSQ2tZbG5KQkJDVXJxc2JkRjFMdnNUWktu?=
 =?utf-8?B?SzdFV2x5Sm1Va0N6cE5QQlBIZDFNaXhvWTc0M1lwYXdaNVdpczdoTzN3bXlj?=
 =?utf-8?B?dEtRMm5HQnJTN0ZCSmp6KzZ6aGxPQmYxcUMvMW84am5rNkZaTnZOa2VJQ2tz?=
 =?utf-8?B?M1JlRzMzb29uTFd0c1F4d0JVYkRCMFBrYXBOVURJU3NkcmQydFVSRkdSR2Yy?=
 =?utf-8?B?MGp3bVpYZ1dBUkZjUmViS3BhS2tBb1ZDcUhyemt1ODNiYW9qR2RheERIVnZ5?=
 =?utf-8?B?VDdKZ3RGdWJsdVFHbTJ5WHRTc01kZTA4Sy9pNzczN2t0QzQ4ZWNsekp6YlUw?=
 =?utf-8?B?c2ltVng1MTRaaFZ2OFNSTkFGTlhUcHZlZzFGdXlNOHNMTWw1cTY1L0ZxeG1X?=
 =?utf-8?B?Z3NyMEJaSlNLWTU4RzVVU0luK015T0gvZHRaZmw3ckpoZlRtbGdaRUFpRWVK?=
 =?utf-8?Q?4l3o9B+vG6I0LFyE37?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea052ce-4b69-43e2-e5e9-08df394b5ee5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB504406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 01:39:58.8983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr0Cj/zLhk9z/Q7rGBb83dsYtB4A5fHHJ+2rcqLRkVcGCzSCVL67j5DUSZ3R7bDd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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

ping

On 10/27/2026 3:50 PM, Amber Lin wrote:
> All queue resets (KCQ, user compute queue, and gfx user queue) are
> coordinated in amdgpu_reset_mes_compute function. The guard guarantees
> only one XCC can execute hung queues detection and reset at one time, so
> we don't need the number of XCCs copies of hung queue doorbell array.
>
> Only MES pipe 0 performs the hung queue detection, so we also don't need
> to allocate multiple pipe copies of hung queue doorbell array.
>
> One hung queue doorbell array is sufficient.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 43 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  6 ++--
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  |  2 +-
>   5 files changed, 27 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 58766b27e150..b58a9ffef4e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -241,18 +241,16 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   	}
>   
>   	if (adev->mes.hung_queue_db_array_size) {
> -		for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
> -			r = amdgpu_bo_create_kernel(adev,
> -						    adev->mes.hung_queue_db_array_size * sizeof(u32),
> -						    PAGE_SIZE,
> -						    AMDGPU_GEM_DOMAIN_GTT,
> -						    &adev->mes.hung_queue_db_array_gpu_obj[i],
> -						    &adev->mes.hung_queue_db_array_gpu_addr[i],
> -						    &adev->mes.hung_queue_db_array_cpu_addr[i]);
> -			if (r) {
> -				dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
> -				goto error_doorbell;
> -			}
> +		r = amdgpu_bo_create_kernel(adev,
> +					    adev->mes.hung_queue_db_array_size * sizeof(u32),
> +					    PAGE_SIZE,
> +					    AMDGPU_GEM_DOMAIN_GTT,
> +					    &adev->mes.hung_queue_db_array_gpu_obj,
> +					    &adev->mes.hung_queue_db_array_gpu_addr,
> +					    &adev->mes.hung_queue_db_array_cpu_addr);
> +		if (r) {
> +			dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
> +			goto error_doorbell;
>   		}
>   
>   		adev->gfx.mec.mes_hung_db_array =
> @@ -276,11 +274,11 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   		if (adev->mes.query_status_fence_ptr[i])
>   			amdgpu_wb_free(adev,
>   				      adev->mes.query_status_fence_offs[i]);
> -		if (adev->mes.hung_queue_db_array_gpu_obj[i])
> -			amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
> -					      &adev->mes.hung_queue_db_array_gpu_addr[i],
> -					      &adev->mes.hung_queue_db_array_cpu_addr[i]);
>   	}
> +	if (adev->mes.hung_queue_db_array_gpu_obj)
> +		amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj,
> +				      &adev->mes.hung_queue_db_array_gpu_addr,
> +				      &adev->mes.hung_queue_db_array_cpu_addr);
>   
>   	ida_destroy(&adev->mes.doorbell_ida);
>   	mutex_destroy(&adev->mes.mutex_hidden);
> @@ -300,11 +298,12 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>   			      &adev->mes.event_log_gpu_addr,
>   			      &adev->mes.event_log_cpu_addr);
>   
> +	if (adev->mes.hung_queue_db_array_gpu_obj)
> +		amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj,
> +				      &adev->mes.hung_queue_db_array_gpu_addr,
> +				      &adev->mes.hung_queue_db_array_cpu_addr);
> +
>   	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
> -		if (adev->mes.hung_queue_db_array_gpu_obj[i])
> -			 amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
> -					 &adev->mes.hung_queue_db_array_gpu_addr[i],
> -					 &adev->mes.hung_queue_db_array_cpu_addr[i]);
>   		if (adev->mes.sch_ctx_ptr[i])
>   			amdgpu_wb_free(adev, adev->mes.sch_ctx_offs[i]);
>   		if (adev->mes.query_status_fence_ptr[i])
> @@ -526,7 +525,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>   					    uint32_t xcc_id)
>   {
>   	struct mes_detect_and_reset_queue_input input;
> -	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
> +	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr;
>   	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
>   
>   	if (!hung_db_num || !hung_db_array)
> @@ -538,7 +537,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>   		return -EINVAL;
>   
>   	/* Clear the doorbell array before detection */
> -	memset(adev->mes.hung_queue_db_array_cpu_addr[xcc_id], AMDGPU_MES_INVALID_DB_OFFSET,
> +	memset(adev->mes.hung_queue_db_array_cpu_addr, AMDGPU_MES_INVALID_DB_OFFSET,
>   		adev->mes.hung_queue_db_array_size * sizeof(u32));
>   	input.queue_type = queue_type;
>   	input.detect_only = detect_only;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 0f368fbd2c80..2baada2276a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -190,9 +190,9 @@ struct amdgpu_mes {
>   
>   	int				hung_queue_db_array_size;
>   	int				hung_queue_hqd_info_offset;
> -	struct amdgpu_bo		*hung_queue_db_array_gpu_obj[AMDGPU_MAX_MES_INST_PIPES];
> -	uint64_t			hung_queue_db_array_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
> -	void				*hung_queue_db_array_cpu_addr[AMDGPU_MAX_MES_INST_PIPES];
> +	struct amdgpu_bo		*hung_queue_db_array_gpu_obj;
> +	uint64_t			hung_queue_db_array_gpu_addr;
> +	void				*hung_queue_db_array_cpu_addr;
>   
>   	/* cooperative dispatch */
>   	bool                enable_coop_mode;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index fa5810209f37..b72cfc9a8104 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1235,7 +1235,7 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
>   	mes_reset_queue_pkt.queue_type =
>   		convert_to_mes_queue_type(input->queue_type);
>   	mes_reset_queue_pkt.doorbell_offset_addr =
> -		mes->hung_queue_db_array_gpu_addr[0];
> +		mes->hung_queue_db_array_gpu_addr;
>   
>   	if (input->detect_only)
>   		mes_reset_queue_pkt.hang_detect_only = 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 496ac632c3e5..b930a6b46b85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1260,7 +1260,7 @@ static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
>   	mes_reset_queue_pkt.queue_type =
>   		convert_to_mes_queue_type(input->queue_type);
>   	mes_reset_queue_pkt.doorbell_offset_addr =
> -		mes->hung_queue_db_array_gpu_addr[0];
> +		mes->hung_queue_db_array_gpu_addr;
>   
>   	if (input->detect_only)
>   		mes_reset_queue_pkt.hang_detect_only = 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index 5573fe981a22..d9e6a2407d2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -901,7 +901,7 @@ static int mes_v12_1_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
>   	mes_reset_queue_pkt.queue_type =
>   		convert_to_mes_queue_type(input->queue_type);
>   	mes_reset_queue_pkt.doorbell_offset_addr =
> -		mes->hung_queue_db_array_gpu_addr[0];
> +		mes->hung_queue_db_array_gpu_addr;
>   
>   	if (input->detect_only)
>   		mes_reset_queue_pkt.hang_detect_only = 1;
