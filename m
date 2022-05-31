Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5E1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 15:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75EDB11211F;
	Tue, 31 May 2022 15:31:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E1A811211F
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 15:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFrLLEOzSAIp532W+cm0ClWwpaNGy9iIwhL42BxJStgulsr0NoUScfR17Q+Mx1RWktYM0pDUUU17X6TM5kWkVwDOL9naqnFid9q+B832GAJtEKWw6mFxcW1hTqoOVd+jlHD1BJo/gUku90Al8sD0chacn3peF8cF+yrScuCluArZgS9Yj+CDwaMZ6VWlOPruTt/Y7ZNO5y8+Oi15PENw4izZlrJ7gY832xzU1+fQpYDjxK2+70lYxkstrJyBXxRYWhLxXH4QC6S+bqsMaIxJDIhV//bCgKYPiuuMTqccLrEMa8OwL8nb3gswPkABxCAXgZxBLqp7Pj4tNpy+VWKmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EVEz3OsgGU0o5vS89e2nqzXoEwHigW5iJC/ymhSdic=;
 b=AHlJd4Mcj6mY1OIzxxSUv20J7bOl/KNZUHFq1dLGyfXfF1mVakUrcYpTPBV2AZnY+NISBgcxK7unWs4U/C3QcBfcyU7wc6XEA6NughMMx6t5i8zHvVB9zEOe2nrk1hsPw2/HcPeBtzJWcs6/flCGVxvm5scJysKmap9yq19EriVp5QCoWxvoVSlij+Nt8WMf6rEHX1/9OIVNlzApuSpiMi9gYdJEMH0Pxshm+uWHg1n2Fh+VUO8j7ajdHDA53iSIlQl6pARm84iEWG96FhTTQHnvDNH5myStsV2IIzLqYKtttaW3xlEj0/NoDBFgLmJEp3k8YQjYm0g3df2JTQGERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EVEz3OsgGU0o5vS89e2nqzXoEwHigW5iJC/ymhSdic=;
 b=YQAX9RJdAhxw0RjbzO31ivnUd0gF6tJgY8xZbMVe7XV4fg+HT0HrpDivRBFCKh9YLi6glABGye6jH/O49Sd3b48AUbc0GG76+GNqdflribGTYYWN2D//Z3RB09XUTg+H13hAR/8eVLx0Dezhk8lYLBS5TI4UYslqRJN9sogAeHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 15:31:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 15:31:28 +0000
Message-ID: <e4616287-91df-9bec-9e92-3584b864acca@amd.com>
Date: Tue, 31 May 2022 11:31:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 7/7] drm/amdgpu: Stop any pending reset if another in
 progress.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-8-andrey.grodzovsky@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220525190447.239867-8-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ee64b7-bcba-4617-2df3-08da431aa128
X-MS-TrafficTypeDiagnostic: MN0PR12MB5883:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB58835CFA82279F9BF12C131592DC9@MN0PR12MB5883.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLSeEjHcVCk24mFRtWiYvpum8+0ET5Cuu0MLm/LyEHDpth68wpWZ7JzXf5XZPPHMEbNndWK8ZGKHLO+p6ToGLO/weO4qxHk1TI7Mlp9R7eMR08AL2Zz6aOtQIApECdr0XUFklEhRg3DHKWH1uq44IzB46CTIyTJZKr8kX6oRbkGMQSCkFFnpH01ivLZ+JfqWy2Smzd63wWVPC/K1hCFMF4ALpJGwf22FNrYMO4dyTLFDIjueM3wAly5e1e7Unn+21B4bsMg+IgO7yupGsCcDsqwVItCLg+4zY2GO53O3xZcQZG/8yJ5IYcsTMZdyieDNij6HnRjQMhLQ20D98w0CsFMTnkxWUzJU9tPDGYKlbpuEMZIPzZN6UvQzRRmt+Zch1y9eK9JZarbVIIw+aeepk6reKwx+EHZHDSQb6kKCyH7XsqZkCmgxDhezfMEMMGV87+Vaa+AbFwRAER1oWeD0Gw5HkcoxBXf61fPf96dR+14xzboc+NGIBfgACOmh3UwyNyxro+Y+UXG00D+aPPLoGmDUl4z3N9iWRjjYrjeuDc3U0tZMzvvmw0FHIdBIwYBckHkmsXncklnORIdvSqKg7RUF3ufTYT7zolfD3i9C/9tCdLRkN3ZYNsMLbc5pGPBrg0wOLdxnY12r2Iy8oPss3tUB6N+hhzB8YPMIMTzB49S/h1EstaDEcN0uQlUBhc3mnXAXDXmKYSJ6IIqrrcQff2uabcWTzxUfGfAS/NUFLQgvVF2XqANEaP4EUzzYrWtt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(36756003)(31696002)(38100700002)(316002)(8936002)(4326008)(8676002)(186003)(5660300002)(2616005)(86362001)(2906002)(83380400001)(508600001)(26005)(6506007)(6512007)(44832011)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWlMNTk0R1hFaE45cGFyaTZXOHgzSjlwZkJRSWR1SzFkN3NoYkxsVDVYOGpD?=
 =?utf-8?B?aFc4em00MjFZSlllVXdNU0RaTUlFM3RiVUdOMVZVYTcxdEN0cEU1SmluQnJH?=
 =?utf-8?B?RW5hQVIwNDVFbVA1NnB0ZklCd0xGVW9zVXBVMWRtVFl0LzFIbFI0OU13aXc3?=
 =?utf-8?B?aUlpMUZzVytSQTNyUkVaUnBWV0dFbzField2NXhkenNMN3NCaXA3R3g2YkRM?=
 =?utf-8?B?OUx0YiswVVo4WVQzRkFyZ0dpekhOZ0hXZ0JxdW10VThvdUxvcEJRZGxLSU9I?=
 =?utf-8?B?QUNDdTFDSGREYTZxTWJlc2xveFduamZVQ05mS2dNa2FJQ0ZTaGx6MVY5YU0v?=
 =?utf-8?B?MHJGNTRYamFSTHlNb2IrTlBQc1UvRnhScDhDV1JxMUQ5ZEloSlhhci83SDFG?=
 =?utf-8?B?c0traXpLOGxsNG54NWNFRDkwb0hmcGlITmhnQzJyR2VtQTZvVWI4MHpOM0py?=
 =?utf-8?B?S0ZBRlBISXdXdis0cDA4NlpzS044MEdYZkRSSW9LZW42Y2FtOXRvU2hBeWdv?=
 =?utf-8?B?Q2hZdlU5aVA2UlhGVWhTRHY3TjZNZTBGdkEzTkdTZEkrdzhWYXRvcUlqWnpD?=
 =?utf-8?B?blovNjEwUGQ3S2Jmd1BMNVdta1dxZ0d4bklhQUpwY3FxSjRDL0tyNEViRTNH?=
 =?utf-8?B?NWkybktwUVdYZ0JoZHhGMXY0U0ZsTVZGbjVMb1Q2VDZGQWNzKy9IQlhNYnBE?=
 =?utf-8?B?MWdWMVhHU0dqR1JzZUhyU21uZmtBak1QM0dCREc3a3p1RkZvSWdXOXRrUWdP?=
 =?utf-8?B?VEhReERMZnVCbnloWnJKV3YrNmY0RE9OS2Zjb0hQU0R0ajhPa0ExclhsbE9K?=
 =?utf-8?B?dU42dXZlSnZrN0NCcFRhalpPQ3Rub24wTkVlNHdYRFZVV0k3NURZUjZRMm5G?=
 =?utf-8?B?U2twNkd6Njl6UnlXZ1FTSm5RdjNSd1I4U2lCbHlSVzZMN0RMcTJYa1JRTTFE?=
 =?utf-8?B?VE8xNVR4bVpybWE2Q0Fub0VrQWNqblFRYkM3TENya2FZSGxyVFFqVm1QdENT?=
 =?utf-8?B?cmRDS1crK1NaTi9MZG5xM2FUbkdUbFRBUWlrVlRKQ0o5VEY0SjhsR0g5eWsw?=
 =?utf-8?B?Y3VqSDVpODU0cGpjd3gwMmtFVlZ6a3BPdTY5M2wrN3J3V21wb1draWU1M0lO?=
 =?utf-8?B?S2RjWFBod3RBRndaQTRRTXpaVXhJZitub3I0MkZEdEJWMURQazFXaGtqaEhK?=
 =?utf-8?B?MnBZRXgyWHFuNXN6UUYxUG5YS2pPWnlpY01BL0JteDJpbzdUb0xveFMrNE1n?=
 =?utf-8?B?Y3l1TWJlbXdOcmVHZDhteE9xZUxnN3IyY0lXTSszTjlmb3RTQ1Q1SHVmb2g0?=
 =?utf-8?B?cDY4MW1QazhUMXUxMFFZYXpxREhPTVhsNEV1QyswKzlCYXYyL0Zja1owWlpk?=
 =?utf-8?B?OWg3aWZmTHRHNDlWckhRMVJaUUNUVC83cVA0ZGE3UkFzaEVSUDgrdWRpZDVh?=
 =?utf-8?B?TUxCV0VZa1VwaVFod3Y5T3NESjhuc0RTN1N3eEJoV3o4RTZQL2F2K1VXcGdS?=
 =?utf-8?B?S2JXSG9xZjJwdlpwQW5IdFpOOVBWeTZyUGZWNkpNY21sTS85aHFMekpaRXJk?=
 =?utf-8?B?T2FzK2puaEMvc0FiS2JRL2hFaWtiWkVQN3Fkb3JYNVh5a1RBRm9MTDNBTENT?=
 =?utf-8?B?SlJBckUxNTk5NGVLbGxmdlIrYVRSVE5WZnFBdTQ5ZE5qdzdpbVNBelBNdzUv?=
 =?utf-8?B?UjZLaTFid241cG1JOGIxbDg1SEJRK3ZBOXQxaWZjSUN5d1VxTW8wUlRKZlZi?=
 =?utf-8?B?VTlaQldEQUJ1RktibDlDUHNxTGZvcTM2M0ZKS2ljaGVRNktCUFlYbnNjK0FW?=
 =?utf-8?B?dzdXRWVxdVZSeDV3V3RoVXQ2TFRmN1YwbmU4VDU5QndOM2hrQjlzM3p2MkY4?=
 =?utf-8?B?aWFFNjhyWkVqZnhOL0tCVDhmTzFrN0NFMGVOQVg1Z0pxbi9vZ3pWMXIwS05C?=
 =?utf-8?B?MjN2QVRwU0U3cDU3ODhLM1ZEaDZtdGhtelVBQlN1Q3R3ZlRIeGQ4L1FzMFJI?=
 =?utf-8?B?RWJIaEYvekNhR281cFV2Z3JkczlwdTlIZ0tXa1A1N0VWalJpV2xIRlo2RTcr?=
 =?utf-8?B?UFVvVmRra3cwTGlSanpZdHhkWkx1ZE1LbFpiMUNFTkp5ZUN4Wk42bjJJU2xq?=
 =?utf-8?B?KzRhTWRKTGpFNGVuQTlQRU1xRFdKRUtRQURtMmxCZEVJNDcxSWNsRkhIVHFn?=
 =?utf-8?B?R0V5OGJveWw3MUE0c0I1UHR6WjVTY2Jic08vQzBndWJiZnd0MlNhTlNKUWZW?=
 =?utf-8?B?OEdURHdJSkY5bld3ZVRLUzUrSVpBdVB0NldUQzgwb0VaeTRLakpUY0VhU1kw?=
 =?utf-8?B?VjVFcDZHZWJ6bmROZFcwbld2UGRpbi9BM0p2S2lzZzk5eDU0NGc0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ee64b7-bcba-4617-2df3-08da431aa128
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:31:27.9728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTInj61iBqMacZi+eppnWdqT5QFOhIjdjZd5gX6NVvKsx16fbkEb6FmMygW0RTfi/LqU45H4bWT7Mr9C8oDA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-05-25 um 15:04 schrieb Andrey Grodzovsky:
> We skip rest requests if another one is already in progress.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 424571e46cf5..e1f7ee604ea4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5054,6 +5054,27 @@ static void amdgpu_device_recheck_guilty_jobs(
>   	}
>   }
>   
> +static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device* adev)

Typo: pedning -> pending


> +{
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +
> +#if defined(CONFIG_DEBUG_FS)
> +	if (!amdgpu_sriov_vf(adev))
> +		cancel_work(&adev->reset_work);
> +#endif
> +
> +	if (adev->kfd.dev)
> +		cancel_work(&adev->kfd.reset_work);

Do you also need to cancel resets from other GPUs in the same hive?

Regards,
   Felix


> +
> +	if (amdgpu_sriov_vf(adev))
> +		cancel_work(&adev->virt.flr_work);
> +
> +	if (con && adev->ras_enabled)
> +		cancel_work(&con->recovery_work);
> +
> +}
> +
> +
>   /**
>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>    *
> @@ -5209,6 +5230,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   				  r, adev_to_drm(tmp_adev)->unique);
>   			tmp_adev->asic_reset_res = r;
>   		}
> +
> +		/*
> +		 * Drop all pending non scheduler resets. Scheduler resets
> +		 * were already dropped during drm_sched_stop
> +		 */
> +		amdggpu_device_stop_pedning_resets(tmp_adev);
>   	}
>   
>   	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
