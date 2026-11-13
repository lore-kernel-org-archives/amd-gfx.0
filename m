Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F1606A32D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aTl7+VJV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E44112419;
	Fri, 13 Nov 2026 12:01:14 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A11F1123F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 12:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPfWjf06ZqhM7xKJQLOhi8trpPIyKJgO5nzK8q5a3GXmF9zxE8Z3gv5pYzFcnxP7L0VPZN8/beYbNdnWBA7iHjAG0S3qD0LAABYTOdbFi59AdYu7BU4+6dLqn6/HXeuVnatdeMaji8MtXGRG1vakn4AaKCzrtIt9+cmkRn595/7qJsDcDpI2u3X7VSA2XnvjWmcErtRxXrfhugkqlPqJDZXkZ7eaBBj3lrxSEDbTwaCKbLXLbUFCFwPyRCGMQu8qrMoAMPmkeP91Z4lsn0OeYT5gv3oX7w3EkC3GsJmZA8IlBqzXf3maji3wHQ/lst+PLscQ3kqpmdaFw3gnWTeYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KOxuoYOHdWdf0cIJLkynoG30boRJ6ciazjPsD//Elk=;
 b=R2MbRpWTs+Ylm0OheZYxpvt9S4voaDUItE5qKd7ekRDGdE/vn9HwnPMg0bWIc3krP+kYq6vG/FN5d3RRh57iZrfzpjD/cmw8N3wwLUEcpRxTGk1/dztc0cbCxgn8iI8dWqMHfRQfxrBqritgOe4kmgLPp2gzQYz56UdTWV5REtgFOG0iN4KZMYL5XPA1nZPY/ZYXI2JnkbATtdKWauDmTb9AzmZIA5Rq1I+HDo5mqY1nI7AHv9BakWbOXpnki+/8nMdM5KaPsDkiQusQeupUhcEo7FziSarqaGfE2c9g3cAPGZrWj3tQFfcweoONLGFPcx8moCiCz45V4XjlbVxrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KOxuoYOHdWdf0cIJLkynoG30boRJ6ciazjPsD//Elk=;
 b=aTl7+VJVaDY/1OeZH6ZSiV/gm7kFI+u4gcVxWTWnZxnRbTgtTDmL4Jyata3P6yMSFrmbE6AESELSspwHnKuL8f+ZE1ANIwDNlG/QKPxF2sqpDgOYlw/mhKvdUQ+3uTE+5KimN5TadYWAvrem/J+DD2dMTtvx1a7uSIm+ADDciMI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 12:01:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 12:01:04 +0000
Message-ID: <6a36de8a-e5c7-40fa-ad17-20292beac7bd@amd.com>
Date: Fri, 13 Nov 2026 13:01:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/object: get rid of amdgpu_bo_fence
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-4-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261112164408.1748006-4-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 49956143-b35e-4734-1eab-08df417dcad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261028144727099003|261026140227099003|261021123027099003|261009223027099003|261022105027099003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EBo9NAfyYAKYqecdqWSKyS7nC1QpRb9ULbzxUGkJpi/rlB+m2RkDKbStkDyjyN7P0hiwtx0siBlDxqPEV1LsLr2FtY9kczwXuboQy+hqFbPEfiqlMPIboZcH7sUNGygdrBv9FYlUca0G/JvQyS11fkuZ/lyh9nYtoYLW6Xk2bo2eXrQOpwOpKWvvbSsmLzQXWEFrtRfBpdNg+Mi1NJTx7XSd4UUcqJiHKGFxzttQkt2OuCv4VUM6jgPKxrBatTbvgKd9x5DfSH6QrP8kpYT2dJfQxexN7r+5H9k4FqKANL1KR7G8PmQF5sl4nhd1Pcyde/r4uQMDJDQTsezB1Grp+DxYE1gp3bUkJH+p6x5Un8rceIKsu9cBUfCSWYtGWeqVvwRRpkhrgl+ilLpo0fM+Ifd1gNYRLmjkKhOlgf6K5PZYP58NcHFgiBc5GvUqNq05ktTICe3qiqeHTHi9qWNStGgxAjuIpmaA3U7tKctZCAaiNRELM0vMnixVNPgbUq4ebakZ8mhhBRp1ZNXv7NB3/vmLum/c/KXGBAaSN/LgdZOLDWEhiM3QLryv6PrqQGJHSlueBHHDrrjdFNzkosF+gJIAP6tYSHm5ORCvHnrncbAjp0BrN8+2tlJEjaQBiz/q4UiuSLBDzdjNeOPaDS0KgAAw54fLXCo1A3w7BTr0qb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261028144727099003)(261026140227099003)(261021123027099003)(261009223027099003)(261022105027099003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDdQNXFrdDFnUTFOdDIwWWh3WWU4Mmk1Y1VqZ1lpbnh3V0FXK1V6NVdSSHpw?=
 =?utf-8?B?ZWtWaEV0Wm5EclNxc3NUT0V5SHZjOGpoSnhsYVVlTnR0Nml4akgwZ29VeE1w?=
 =?utf-8?B?MTNDemg1Zm80amlQaHJLMWt3Rkdadm00U0pZR0h2REI5eG1zN1hKNk9XVkth?=
 =?utf-8?B?VGh2d24rL0daV040NERaZ3Z2M3BMTkxGaC9Mbm82Ymg5RmhaY3J2STJjeUxF?=
 =?utf-8?B?UHVWcTZKaUxLd0xySFJpZXpLN2NZMUVmWG1Ea2dzaU55OEJGRGliampCZ2R4?=
 =?utf-8?B?eEZIbWRxaVdxSGFHVE1sakdsVmZub1daMGZTTkNtZTRuZWdjZUFVbXUxd08y?=
 =?utf-8?B?VERkOEFaUzFCRFlobUNtS0lPR2NVZ2dZYXYzNlhSa21Sd2dUejk2a3F1RjNu?=
 =?utf-8?B?aDVDOHZvZWoxeXY4QTZKeGRxQVJvR0l6bmxzYUlqc1VYQ0xiQlZrc3VYN2ZU?=
 =?utf-8?B?aTZUMDdzTmY2a0ttT1l6UXVDdERYaEtsMTZnQThaTW83ZzdyQmp3TEFkWTkv?=
 =?utf-8?B?WDR2c05vcnJ0ZUFvSWhXMjdLRHNmdEI2RmswaTdNSDVpL0MzYUlqZWQ1M3k1?=
 =?utf-8?B?NXpvYnJRY1ptTk4rWjJDZHc5VjA3TENNbFdFZW5kaWN2Vm1tZmMxREJXNjQz?=
 =?utf-8?B?ZnNnSnpHZVlERHFDbXBXMzc0dkQ0dGN3cHQ4dTFQVmZCMEYzSGF0aGczZENR?=
 =?utf-8?B?aTdybEwrMTRsYnJ1bGRtQUh5azZPTmdURWlQcnZJOFByMTBTdjRCZUJ6dTkv?=
 =?utf-8?B?UzBrNTJROFRac3hCa2RyTWgwK3g5d3ZYY1V6ei9JaTNGdkoreU4vT0Z6cUNI?=
 =?utf-8?B?clZONDkrSWlFR2V3NkJtRC9YYU9BRm1Yay9hL0RsdHYyN1h1VTJrZDBJY0JC?=
 =?utf-8?B?S09JaG5sdVBzSWp6VDUyeFozem9zL2J3RjNmY3UyZlRzakpKQ0kzbnJSVldT?=
 =?utf-8?B?aktZaXd2RG40eFBZbVRLNWpJejBaamdBNEdnNW5JNjNOcTlVUHhJSXlqRUJC?=
 =?utf-8?B?YWZtMEZaOEM5aEZtejRWRnBTMVRzUWpFNU1mc2FFYmZYT2w5ck53M3krRlBp?=
 =?utf-8?B?dVlpWDFLTVFlK1BxMXFLUWRCNzQxaDlBL3BxdCtaVzZLcGpwblUzNnMxOUVH?=
 =?utf-8?B?Rlh3WGtVc3c2RWthcUZ3em1Tbkt6Zm1IWTlKZW0rWUhncjBqMkwyenNTci9r?=
 =?utf-8?B?eWdYOE1aTXFpdDkwY29IVmhjOFgwdk1ucFBkcEQxZTJ0NG1uRlVwaWNNeDBj?=
 =?utf-8?B?THAzMTVLSHA4UngxeTlSUnpkRHQ3UHNpZjlmczhSWSswbkx4dENIWW1rOU1t?=
 =?utf-8?B?NGpyczNzRXhTSk1EQXMyYXpydW16ZVgrZlJSWXdLZjBEWEF4UEMzYnRsS0U5?=
 =?utf-8?B?NFlpRG1CbnZSNVFoMm5PNWh1MUlFY3I2RVVHNEZHL252NzZEZndaek04cnFh?=
 =?utf-8?B?aUlBcURScEJqUTVFdjVueVBxNTRzdTRmQVYyUjZKQ0o5eG90MUFTa08xTTEz?=
 =?utf-8?B?aG92cmNKNkpxMHQ3UUFDM0dIbWliWGVtVEZHeC90YUgxRUM5dkZCQk5HSzJx?=
 =?utf-8?B?SUgva2dQZitwSTM5Z1hLelYvZmZiNVgvYytjTkZhYmpITFpDenhCYnlUTHl3?=
 =?utf-8?B?S1piN3dHcWl3ZkJDbVNDWWQrV2x3SmZremQvVHBPb2Z2Q05vSnFrWkhNdUJn?=
 =?utf-8?B?bG12ekJpWG16NTg1SUU3SkcyamF1bW9vS3JNTnFiUjR1WHZVeHo3M2t1cEF0?=
 =?utf-8?B?UzdKL3B0R1IxbHorZS9QTC9CenlGRVg3aTQzV2ZVR1R6TGdMYkdaR3RKMmE3?=
 =?utf-8?B?OEVFMkh2akdhR3VSRTV6Uyt6ekNjTjRJcmo5Q0wwdWNxelBTOHFSVXNXTXNx?=
 =?utf-8?B?RjlKU2docE5zWWYzNmdkY1I0b2d0elArOEp2T2RYMzNBcXJqakI5UDVSS3RY?=
 =?utf-8?B?eDF6N1VCMXlzbG02SG5oeTdGTlpOOXV4dzdFdmhKQ2dmcDh5VlA0ajF2Wmht?=
 =?utf-8?B?bXc0ZTBrZ21LSmVGZnYrTHhYWlFmNlpDZGdGZk9KOFM5dUlmWU9lYzhHMWVY?=
 =?utf-8?B?Z29UK1VQMGpENGJUc1hJMGJmazI3dUdoMXU3VmdJMUpTaFFnWXNISDM3aGFZ?=
 =?utf-8?B?c3ZPUWNxMGNBYTlwNnNyNyszK1o2NHFpSGJ2YWkxSmZMZXdYMEltZGgzbTBO?=
 =?utf-8?B?ZjNid1ZOVVFEci9yZFBLajFiZHhrc2JaQnRPZ3NnNmQ0RHltS1ZwcWFDQUVt?=
 =?utf-8?B?eW02Qm9mMWZRaXJXZFVGSmVISlFTVkpsbDV0R0YvR21YaDVMUEQ2YVk1Znov?=
 =?utf-8?Q?g+9BsoFu6BNdB7Iitm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49956143-b35e-4734-1eab-08df417dcad4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:01:04.1883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VEWNAzOG2wHWYfozK/bmbU2bAZ/EQMEhIPXXhNqfgJIXM/FY28hmRHdySCqoZ8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

On 11/12/26 17:44, Benjamin Cheng wrote:
> All uses of this function have been removed, so we can now get rid of
> this function.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 25 ----------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 --
>  2 files changed, 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6aa895f63aea..7fc43363ec62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1441,31 +1441,6 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
>  	return 0;
>  }
>  
> -/**
> - * amdgpu_bo_fence - add fence to buffer object
> - *
> - * @bo: buffer object in question
> - * @fence: fence to add
> - * @shared: true if fence should be added shared
> - *
> - */
> -void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
> -		     bool shared)
> -{
> -	struct dma_resv *resv = bo->tbo.base.resv;
> -	int r;
> -
> -	r = dma_resv_reserve_fences(resv, 1);
> -	if (r) {
> -		/* As last resort on OOM we block for the fence */
> -		dma_fence_wait(fence, false);
> -		return;
> -	}
> -
> -	dma_resv_add_fence(resv, fence, shared ? DMA_RESV_USAGE_READ :
> -			   DMA_RESV_USAGE_WRITE);
> -}
> -
>  /**
>   * amdgpu_bo_sync_wait_resv - Wait for BO reservation fences
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 2e6a8e6f577a..3a568ec56c84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -304,8 +304,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>  			   struct ttm_resource *new_mem);
>  void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
>  vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
> -void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
> -		     bool shared);
>  int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>  			     enum amdgpu_sync_mode sync_mode, void *owner,
>  			     bool intr);

