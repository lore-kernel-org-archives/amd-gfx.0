Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AA606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OcJ1f4c9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B3611289F;
	Fri, 20 Nov 2026 09:59:38 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8B311287D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 09:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDR7gALJDZsVGRb9AwtJYTAcXoiqewNZEhOUb0abYG34ivobQWxUMVwxouzVSvquw/yCt20C1hQrP7po4FnMUHrtXUUc9fT+OpYXUXNSa1MFFhqrcFCqz8ANIi0BHejnc1Clwl6qX7AO4B/okxqITcG8IVACciqCbZVTZLoyzHNk4HgXvKgfE/M/R5OYU5RUu/WTiJljQFygEIXd6H1gepR1DuuhUar1i0O4Ch0oYRxxPAgGNSXezt9db2UwXLF0CKA2Sv2d8qzqyhYzGWZL1F+jB4F1tHal394LyCAOBeyOUDfOB4MGffMVNN/WzSFVMnNTkgKoBGdbvvG9LPfMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x26VRLXI93nVPu6pIMhcQMV5k801CTcus1bWb3Xj8W4=;
 b=pJAhYjDBZ87Fc0gBZqqRozVfpGCWbUbsS1i6g52arCgsD6gw06kBhMRrn0RWNu6FeVzjTDZfjJY4v92fzgZGuxMuCcwRXj5DUJRDdr3Hq08qBH7getmxrzogDDlazIBJwFe4DfqlwfjLlMfV0iyzYQmqIyViGEcDO3p33pbPevBetGsRzFh9V9DqITx9LjpBOsdoBrz7TiP2J4hgn24Ok8UslBAzV3oMEqXK4NkAXFXsrOXHszjZj3qBvSaIB5U5hvVqIcd6QCa4kykVG6ncuDZw/9Le49eNu+q0vPyWx54z0ACeME8mzHqnks2Oyf4FT7KjhuSrQYIP7Oca7llrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x26VRLXI93nVPu6pIMhcQMV5k801CTcus1bWb3Xj8W4=;
 b=OcJ1f4c9bfKyp2Xi2esq7gEcIajZTgwOg1mHZc0S8yPsCmHdmrEEISIaFwxkCVaVpVQnPkq/HqKlEtKqSwte1BHZSuzDbSHkIl34ep2kWcX+AjYO2S340ZFJr3ebsRkk2M6cA2qQdpRNALQfU19+yOae+RrG+8xeBKikUrZcrSQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV5PR12MB9755.namprd12.prod.outlook.com (2603:10b6:408:307::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 09:59:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 09:59:27 +0000
Message-ID: <2268da75-2dd4-447d-9ae8-5287f2235658@amd.com>
Date: Fri, 20 Nov 2026 10:59:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] drm/amdgpu/uvd: stop using amdgpu_bo_fence
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-6-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261119144049.2057674-6-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:91::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV5PR12MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: df830433-0da4-4a22-637d-08df46ecf6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|261021123027099003|56012099006|4143699003|11063799006|261028144727099003|261026140227099003|261102123227099003|261021121427099003|261022105027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bpb2E4DnlEtvz9liJfMv8pLAmsME7tAZjkPT1DoDQIJ0yhrtY/EsuHvsbg6uQyof4/EDVPs2Z6vxa3LIzfQOnSyjjw0g+8iEyWPi4qrbxV2W3kebD8ywkMpYJ6QVsaArtrynjYKPwah1EWl/+5icFN+slWxhiTrei8Hk9PtK1teuFxpRBF5prUxAS76LO8s79TBTvkqKLegb5wsPwJ7D/vMnmR+1AWtpCA7GK7H2Jp5CMOI7zdtVOmd7NzcOgOXLBhIYNuBxQs70hc3DUIjS9/EeglCQ2PzReMXakA96f6OJgnUbnDHseoJlOeYXPEcvRhcNrl97UObJK7NROiLHqmj5S2FZi0pYB+5VL7to2EChQNGv7IeHMizgMcBj3eZnbga+OmGO3lbz/SbiA8Z7aHyQmHlFMgdTAcDLwc244gg/f9NLL1vIzjzhGSuplZwNRGpZWo3ygdEOL5ypuPrkrQN3+WA2U3imY046rkicLlgeU9+NUDTGDYi4hsqrSz+P8AXakkh/ui25OvmLpcstqz0xVVovgJAKV0eay7uJRqq3CInNM7QAVmxjGW9WOWrBxGPpOTyPkr74z90sIlSGsW78JahHVw9O+EjaVer0RpsNjyQ6UC8a82G49UI55jucxjfh6v8FQ6UpTJR3BgQpLVOicQ4LbsdWzlkSAolOr2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(261021123027099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhRK2lEMm1mWEI0Wnd1MFU3WjNXU0x5RHVzTERLdVNMYjAxV2Nmd25meFlq?=
 =?utf-8?B?dTB4UlZ4aUkwQmp5ZU9jcnBWRlNwSzQ1YWNoQWFWWFZ6U0kya2tYeFBxYmkz?=
 =?utf-8?B?R09kV1pLWEdlUy83cndPTTF0Y0F4QjlUVS9uT2IwLzFTb256enMzV2xWQVE4?=
 =?utf-8?B?UkV0L0dlcnVJU1l1QVpCQ3RyZG0yUzI5dURXdDd6SnZBZi9iN290eTRFdUdK?=
 =?utf-8?B?dGVNbmxzZXVzR1ZPQ013K2ZSZmZReTdlVWsxVXB5bXBNOGlmWWtnNUZjTnpr?=
 =?utf-8?B?RXdUTUhhVWt0cCt5SlhwL0svRlNKTS9wY00vTDJRSVltQi8vaGdyZkxSVFdX?=
 =?utf-8?B?RVErb01leDFhbTJKVk5ZMCsyanhSYm42NnhqR1NRc25oQmMvUlNYcW95Yiti?=
 =?utf-8?B?cFlvRzZ2RFJjYkxvRkMvemt6Ry9xWTNDOTk3Y0pPa2JLOGtxWnA4eWlXSVlM?=
 =?utf-8?B?QmFZWUxzMG03TFZYUGwyaEJXc0hKYXJWcDlOcnRxbjQ1R1ZnMHByQzdZNjN3?=
 =?utf-8?B?M2Rpbm03QUZOYkNMeFcvZ1laVEpFbjROWExhK1FpakprREQyeW16aUdBTFps?=
 =?utf-8?B?NXg2WURiZnBSZEU4ZXZZOUdUL2JBeHZSQkZTWU1PNzhpV1V6ZEtSUGZFTzYy?=
 =?utf-8?B?bGdJMzBsQ2NoTFhVSlQrZUJVZ2thZWRKR2ZjSGV1bDhkRk0yR1RvUStCSEZi?=
 =?utf-8?B?SHJvNFRuZUFIcFQwWWtMNVBpOHRRYVMrbXA5cGxSMVZkZGJlL0pzcWx6OWpq?=
 =?utf-8?B?R2Q4NStGNWhTQ2tRQ3V3SjhrVHlqL3J0OHpsNDRRVk9ic01vdkxhVkw5aXFM?=
 =?utf-8?B?SHF3eWNDKzc3d1dCS2xyV0FMelZpVlF5anpZWFR2TldRZDRPM0Y0RWxrSStZ?=
 =?utf-8?B?dm8xM3orSldjemxyNDdZdjc2UDZHZXBsUzJmZE4wN1ZhZjZWeUVSUzVuckdj?=
 =?utf-8?B?cWxmYzFsQWREVW5HZ0tBUGlSOEg4OWhndE1jQnVrRzdTNCt3MjdkekRsd09D?=
 =?utf-8?B?YUJBTmtuRE9PUy9KUEp1STVFWmRmTFJmL2Y0K1htNmpFRnhwSUhXVEY3VU5V?=
 =?utf-8?B?QUdhSVl5L1RjUGNMd01KazlRQlF5NFJDVlZJWDg5eldGM3FCR1R4akh2eWlp?=
 =?utf-8?B?dnBUMWdzSEJBSmdnUUs5OGMwTEhtQXdVN0t5YURXV21sRDg1ZzROYitlYWQ2?=
 =?utf-8?B?Vy9uV3RzY2FmSHZvSW9UNWVRTVRFLzBDSDFpVjZzakVrRGFzTWpuRkRSb1FE?=
 =?utf-8?B?MVV1M0E5VnhiT0RnWlAxU2tGQWhsbUxOMXJZVWs1NjlaaG9HNGFvZVJvUStW?=
 =?utf-8?B?QVNpOEFrM2xZcG42MmNQMlJxL3d4YzBXaWR6VVJhb1g2ejRCSWozSm9CQWo1?=
 =?utf-8?B?YXcvekxlL1p2OFIzVDR4SEk1M1ZGV08vYStQbjRaSFlwM3ZYeFFsNmxPUmp4?=
 =?utf-8?B?RG5Ub3cxTXNqZ1hiZDJLbG5ObDQwU3lKdG4rUzFOVFVDNXNBYTNKN0pod21V?=
 =?utf-8?B?M3R3eUJ6OTNnUHpkN2VHejhXcWZxKzdnSlR1SFZMRzRQNFNVQldoSno0bnFP?=
 =?utf-8?B?a2xVWGNBbm1qbFFmSXlmK0FOc1ppeEdLTTk2WW1Halpzc0ZBTS9YdTJHVDdP?=
 =?utf-8?B?NXlEVUIvQnQxUTZVang5UjQ3WWMyU3ZMc05mYnhXdkMrS2FqRjRoYVc5TXhw?=
 =?utf-8?B?QmZLdGx0UEpzbmFVWDVHOGIyL05FVXdqcjFuU2RDUGxNZkQyTEVyOU1iUU16?=
 =?utf-8?B?RDl4aklYdGpJbVNnWE9sT1VJUXdCU1Z3SzNYUWVaQWdkY3l6SS9CeWFSM2NF?=
 =?utf-8?B?THp0dTVuU0Q5US9jOGVYRVBRcndVVnJlZ0NrY0V5cEVtZklwWjFKVUJXTkdu?=
 =?utf-8?B?ZnYrOUl3UmJnTkR6cnRULzlwNEU0bExQdlhQZ3o1VTZIRGtza2l4UFNXb1pD?=
 =?utf-8?B?QjFmTlJ6OXorSkJTM0VsYlIzUW9UNWtmcFczMHVwRExzNUF5bHY0UHJ5eXZr?=
 =?utf-8?B?RnU1T0QzY1BjVDR1Z05US1dGc1dXZW1IbXliSm9NRFVXenZlMjZZdUI5Qkox?=
 =?utf-8?B?L0pzWXVOanhGbzRXbTNVTzg5TGlJdnF3cUFHTzJFa3U3RVR5WXc0SnJvWm9j?=
 =?utf-8?B?dUJPd2tKK2RzYTk1WU9hbUFKZTNIcnlPZUJZelpJTXRoUzRIWFQwUDF4aEFX?=
 =?utf-8?B?WnZMd01MczdTZk5PbzBuVnphRWxZeWZ0MFVWYktYMGFLOXJMVEZuMUFzMHhm?=
 =?utf-8?B?a0JQejdnQU5jeVVhQmFXV09PL3NVUDZaZkZEZCtiUkVYVXZjTW1vcWdVYnY5?=
 =?utf-8?Q?h/a5LPFKlYqI3md4gs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df830433-0da4-4a22-637d-08df46ecf6b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:59:27.7560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWKKQAVsUTsZPi2igISkrB4CW95jhAupemAKoVrGUcpbcPzr+QpVB9aAN6toB08C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9755
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

On 11/19/26 15:40, Benjamin Cheng wrote:
> This helper is deprecated since it is incorrect in most circumstances.
> This was a circumstance where it was mostly correct but it is the only
> remaining usage, so get rid of it here.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v3:
> - Moved the reserve_fences call above submit (Christian)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index d88dde859615..1d9a18203d39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1154,16 +1154,27 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  		if (r)
>  			goto err_free;
>  	} else {
> +		r = amdgpu_bo_reserve(bo, true);
> +		if (r)
> +			goto err_free;
> +
>  		r = drm_sched_job_add_resv_dependencies(&job->base,
>  							bo->tbo.base.resv,
>  							DMA_RESV_USAGE_KERNEL);
>  		if (r)
> -			goto err_free;
> +			goto err_unreserve;
> +
> +		r = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
>  
>  		f = amdgpu_job_submit(job);
>  
> -		amdgpu_bo_reserve(bo, true);
> -		amdgpu_bo_fence(bo, f, false);
> +		if (r) {
> +			dma_fence_wait(f, false);
> +			r = 0;
> +		} else {
> +			dma_resv_add_fence(bo->tbo.base.resv, f,
> +					   DMA_RESV_USAGE_BOOKKEEP);
> +		}
>  		amdgpu_bo_unreserve(bo);
>  	}
>  
> @@ -1173,6 +1184,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  
>  	return 0;
>  
> +err_unreserve:
> +	amdgpu_bo_unreserve(bo);
> +
>  err_free:
>  	amdgpu_job_free(job);
>  	return r;

