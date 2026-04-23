Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6576F99368
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 10:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 428F710E323;
	Thu, 23 Apr 2026 10:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1AM9Vz6g";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C4C10E323
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 10:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6wPi1kiX3jQ6jM7Meer7f/1Kes9pLk6K5t+O6hKKhfMjJSLk/OoK1Ybbllg/b/Ef0OmPCgzE73u4Q4S41MhC1XSbKtB8nihdGTmBUMKHPILcHqeZWSrlgKKxKRTAy6kRSVvNyduR2Tt5o9+etJA5hyvU+e4/jIsrUmdCKksfSU+8izUHUEHxWyEu3RZXme/w/2z+TdcaU0mRPH/ud7v/y6WituE3Po4OWruudqneX+9ZhooVtucPbliANyzAuWJZ44km9NyuGx7xrYxSbYVxcTI1vKp3c814l0Mccb1q1aGxNp/VL9JTl5yw2VAmXkxoepi30lYoAyqoqC5E4pDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3XjE/H/AhVotGw5jclWxWYZkJ1r7ZN8mJJplWhJrPE=;
 b=ALwBeuxr0/p01v0OsCO96obA1WoDEBZ73tMrP+dH/Y55do4JahoKWPI9zq9oVvzYivMERqicjeXdBuYJW5wtRC1blpjfKJqxlIseXiytLgevTghKeD5WjAbkdfvG0HDZeIqYpzq9vSt6UjFQy2rH+i6/drdDudFNS7JidCQCsELABjOEdFNMijjeJrAgziAkVHSw+KxMjJAmkmHZW7JqWk+/elgGrW0efY+wR0CdkoIaU3GYe5YKgNzHgqvwfWhwRvYRKvUXsgsXZYx6Jz+O//lJJRB8XyO3qkVIhSRiQoICFS5R01R4oScSzWwM+rIfrio2DoURxzjBAPNkEgpMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3XjE/H/AhVotGw5jclWxWYZkJ1r7ZN8mJJplWhJrPE=;
 b=1AM9Vz6gq8r5hSRejrIvj+eOxLszaW3XkwjFdo9sehFWlAlAa2McemrUQbqhJepjeGKXwJap6p5FTxMgOZnqud6X/BbYDSZm8zXuZ+PBfzjBQ43qvmxsEGyu8yMSPV7FsboGTBUeYeJvUcDByRkzSvLPR/dA9BDzSSFfG+uwWVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 10:43:36 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Thu, 23 Apr 2026
 10:43:36 +0000
Content-Type: multipart/alternative;
 boundary="------------7atV4pbI3wRdr8L85RWxV4wl"
Message-ID: <99fbb7b9-bdd4-4c97-b089-5f6a3bb7a6c8@amd.com>
Date: Thu, 23 Apr 2026 16:13:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] drm/amdgpu: rework userq reset work handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-8-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-8-christian.koenig@amd.com>
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 9308f775-e156-444e-0298-08dea1252bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MrrWQR8weQHZrbR3BZf2LBzeN75z+R54SaWsFj3SEex37XEWQwZ4rgoySJUjMJnbZdiByN9ESmV8XEHyMTApTHBbPYHBDEi2nD0RAMlA2fCmUsxK5z27SLIdEv1aOozyy/wuF0sVF2x+meSbO0d0qCtZ5OiUU3k06UJrIe/lAzFmfR/iq8IJ9P/OPaRsCo0kjl0dqyxzOO7AguWFt2F8WqMOd/GfY3VegoI3misDCTSYTRzjWtZnDmRDqn/JrKdDXtdN392w+Z9u17CPBqnTbgQDdTJiOYI1PYvB/WQvlC7QzeyvTsgrT8lWfPSHngA3V2XDTMe/V9SPjXngVlXqmjwaXq/Lc16RMeC1sHNTVHl19CzTNFzRl2wgL/4N3twWtJ1Dtu1UH/X6e3CKuy6UoY2Kt34xyAh8LGYwqrOjYo0u80Jq6GZOJq4Gk9igaXdmLFtbnJcnMGTjpeyLURXpfUMN5feNTam74sMKEPr7Sxs/mry00QFypE9L2P2fauen+qSTj+1ZyjVssdMD9fyBHgvOe/zvnoPYShVHlzlxiyAFy1rNYN/emwMgL3s04gcJqilMmab2cvR7e3xD6Kf3+q/Rdscbq3Zcd2ODv03fo/A0hIydj2QZg2hM1VC0ZNg612QF/CvPYPVfSF8pODyEz27run9XWYLmMqCg7f1tVMg/vXI1aFsfm5QPkWQuFIyapVmiYGYOb9rHCjcVgczx66MGfMJ4T/03F70QTGsH0VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUVuUVZ1VDIyWVUyRE4zRlhZWCtxSjVaU08rVWdibVlzK3pCVTVpTUQvQTZy?=
 =?utf-8?B?T2lrZ21jUWtmNko2aEpnM1JMZ0ZXbFg0cExRTmhzS3cwaHJMd3U4L3NYODZP?=
 =?utf-8?B?WWJwOHA4MUhYOFRwejQ2dEJxWEQyQXNEdmJlQmE2N0YwcHl4R0ZXRStXbm8v?=
 =?utf-8?B?Zlc4QTdjRmdUcHZudVE4NlNWZmt1dXZIaEhEUUR1UklQZ3BocHcyeXNJVFVn?=
 =?utf-8?B?UnkrbFB0ZkJNNExnYklLWHQ0OWYwMGkzYlZlSFNxWk1QWGJ2YzY4L1lWcGRY?=
 =?utf-8?B?NGJoM01HZlRDd0tvT0hyS3BhSW5yU0M1cXdDczhOZVVKQ2JzNkVtQmZieDU3?=
 =?utf-8?B?Vjg2OEcyWUVLb3QwT1ZmZmlPTjFuc1RrbUtDYmQyZ2EwTzJydTAyYlhsK1Bn?=
 =?utf-8?B?aTRBUzVxRmFOcStadGtqYm0wYlpGNVlFTDVyYUloMU1QNVFCRzhmUU1uZHFm?=
 =?utf-8?B?MUluTjUrM2U5cHNJcTIwWVYwS3V5RS9XQk92OEUvVTZHTUcwN1JjMkxkUGFt?=
 =?utf-8?B?UXVRd1RFWUV3NVcyRUV0M1lhNDJyWU40ckNyYkgzOE1UTFE4Z1hoRFp1ZjZW?=
 =?utf-8?B?S0tmMHhvR3JnYXFBVmR5WVF0ckQvaXNtUmVHLzIycjBna1pXTTRzWFZiUnpW?=
 =?utf-8?B?REV5SjBNNlgwOWxCL1pLeDJZRHIreEp4WldNcTBiMVp2NEsxNmxRSkhoQ0No?=
 =?utf-8?B?ZzdzSEpwQ3g1MllwenNuMG5URm9FQjloV0pUd01UNXQwaHgxOSsxT3FRdkt0?=
 =?utf-8?B?YmhkU0ROK29taDEzQ0JVdktxSkNlS3BQdjdyYWlkdUpFNDV1cWVPUGpiM2Y2?=
 =?utf-8?B?T3h3MmFkVVdFK1M4UGR6SXcweFY0azFEY1MyOGZYeXNDRXFnU20wWXdpQ2Iy?=
 =?utf-8?B?K3psZHBHNDY4Z1JkRTBVczFlOEdvVEVMNEIxQTlJNFRydS90VVFUTGtMVzEy?=
 =?utf-8?B?elhTUGFLSGc5b0NTNnZRYms4SStKZDMyeExSblY1L2FBS3MrclNub3gxZ1Fz?=
 =?utf-8?B?WU8vOWNTMStFSEFwVUZYN0Y5UkNiY0dhQlljZkJLUWsxL2JLNHIvcy85Yk9Z?=
 =?utf-8?B?TElsbVhNMXJPR3BhU3cwcmRNUnFBYVZzWG1wYWJBVHhFWlhpV1J5SFdaUVV2?=
 =?utf-8?B?ZXVxa25saDY0aUx2QkN5UUhKbzVhdEdtTFR5MkpndXdPdGJlRldkQ2N2bElR?=
 =?utf-8?B?R0JaTWduV25LQlNwc3NVOVcyVkhhWU1yMThTN2JOTEZkWHFTa1gxeDFqQlV2?=
 =?utf-8?B?aVN2ZGRDTHM1c2owSGJ1OFB5c1NCTDZVNGFwYVo1UFNvbmptb0dpVG9PYTdB?=
 =?utf-8?B?eUFBRUdJa1pYQTZTVmhraWM1aFVyYTdqeWxhUjJMUDNtZmYwM1hJaURvWjJV?=
 =?utf-8?B?c3lPNGFOQlNQYUV1YVZqVlQ4Y3FJZnZSaGNpQ2Q2eWo3bUNuSHNxYVlYR2lt?=
 =?utf-8?B?UCt4L29YbTIwVksvTC9xUldCbDlERnJiM1pscldZbzBJd1Z1L0FQWVc5T0xJ?=
 =?utf-8?B?aXFsc0lKZTUwejE5bS8rOUJLRUhBVE1OcWFWTWlkbG9GUkkvTU1NZHh0anNG?=
 =?utf-8?B?UEs4N3A1ZDZ4c1ZOQjZOR0hYRm8zeU9xYk1RUEx4UlVta2FLQUtOV3FnaXdL?=
 =?utf-8?B?aVJnd3F4ci9wR2NZa1djd1B0UCt0WGpxbEx5dkI2cGJkQjNLTjJ1ajd4Z3NI?=
 =?utf-8?B?bi9pUVdYUURaWlllV3JSS3B3SHlLMUY1VEQvQmRHNmpEaXQ4VnpyTjJOQlBw?=
 =?utf-8?B?NTFLZGVUOFhxMEZmY2UyYXFKZ0NlRmtRbzMwN0ZmZWpqQTNHUSsySUZ1NW5T?=
 =?utf-8?B?Y2ZFWGRpekRISWpCdWtObFZqdnlxK20xcEhQV0pibVIrVkJTQ2dEYUMzbnZG?=
 =?utf-8?B?aEhOMG04Yk1pc1NEa1VaUHU0amFlRmdQUk9zK3padG1nOXZtRnh2MHhDbXUz?=
 =?utf-8?B?OGVrK0RYTG9XMTB1TWtDV2xveTgxSHgyVlpGQU1pUXpXZW56Sk5pVXVvdlRH?=
 =?utf-8?B?Q2ZiYVV1eG9jL01sMGloN0NkVGY4d2w0U25Sdml4dkloUHZFa3NHQXprL3dw?=
 =?utf-8?B?NDBWRWdhcm1OMXRCaGJDYWNjZmlpSm5iTTRaU3FKSEdBVmJhSTlzL0xKVkls?=
 =?utf-8?B?WGpkdHdoWGZ6WFc4dndsSG45S2tPUU55R3hBc3o0Sm1xKzhnMkFMOGt6UjFx?=
 =?utf-8?B?bU1iMXVQMTdhMGV0NUFHS2NuaUx0OU14ZmRxeGhIMEc3MnJRNkFWWHlXRkp4?=
 =?utf-8?B?Vy91cGpMeTV1MUtseExHaVk4aFcyNGU2NlB0T0tLNU5LMC9HZm9nem1mZFlX?=
 =?utf-8?B?QS9BelZodEhaWnNWVU1hOVhhMkFEYjFVblg3RzBZSThsb0dpeGlIdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9308f775-e156-444e-0298-08dea1252bed
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:43:35.8585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tegi366gmFxuqvSdxP+m7BWXj+sw1xNfFvqXEiq4kDyrzCiFN042+IS3AOofDS+pjZZiCZgzonNOfMrlOYVatA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

--------------7atV4pbI3wRdr8L85RWxV4wl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 21-04-2026 06:25 pm, Christian König wrote:
> It is illegal to schedule reset work from another reset work!
>
> Fix this by scheduling the userq reset work directly on the work queue
> of the reset domain.
>
> Not fully tested, I leave that to the IGT test cases.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 84 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 16 ++++-
>   4 files changed, 60 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 39894e38fee4..17341e384caf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1191,7 +1191,6 @@ struct amdgpu_device {
>   	bool                            apu_prefer_gtt;
>   
>   	bool                            userq_halt_for_enforce_isolation;
> -	struct work_struct              userq_reset_work;
>   	struct amdgpu_uid *uid_info;
>   
>   	struct amdgpu_uma_carveout_info uma_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b11c4b5fa8fc..cf61be17e061 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3786,7 +3786,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	}
>   
>   	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> -	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>   
>   	amdgpu_coredump_init(adev);
>   
> @@ -5477,7 +5476,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>   	if (!amdgpu_sriov_vf(adev))
>   		cancel_work(&adev->reset_work);
>   #endif
> -	cancel_work(&adev->userq_reset_work);
> +	amdgpu_userq_mgr_cancel_reset_work(adev);
>   
>   	if (adev->kfd.dev)
>   		cancel_work(&adev->kfd.reset_work);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0a4c39d83adc..ad6dac17dd21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -82,19 +82,11 @@ static bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
>   	return false;
>   }
>   
> -static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
> -{
> -	if (amdgpu_device_should_recover_gpu(adev)) {
> -		amdgpu_reset_domain_schedule(adev->reset_domain,
> -					     &adev->userq_reset_work);
> -		/* Wait for the reset job to complete */
> -		flush_work(&adev->userq_reset_work);
> -	}
> -}
> -
> -static int
> -amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
> +static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>   {
> +	struct amdgpu_userq_mgr *uq_mgr =
> +		container_of(work, struct amdgpu_userq_mgr,
> +			     reset_work);
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	const int queue_types[] = {
>   		AMDGPU_RING_TYPE_COMPUTE,
> @@ -103,12 +95,11 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>   	};
>   	const int num_queue_types = ARRAY_SIZE(queue_types);
>   	bool gpu_reset = false;
> -	int r = 0;
> -	int i;
> +	int i, r;
>   
>   	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
>   		dev_err(adev->dev, "userq reset disabled by debug mask\n");
> -		return 0;
> +		return;
>   	}
>   
>   	/*
> @@ -116,7 +107,7 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>   	 * skip all reset detection logic
>   	 */
>   	if (!amdgpu_gpu_recovery)
> -		return 0;
> +		return;
>   
>   	/*
>   	 * Iterate through all queue types to detect and reset problematic queues
> @@ -141,10 +132,19 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>   		}
>   	}
>   
> -	if (gpu_reset)
> -		amdgpu_userq_gpu_reset(adev);
> +	if (gpu_reset) {
> +		struct amdgpu_reset_context reset_context;
>   
> -	return r;
> +		memset(&reset_context, 0, sizeof(reset_context));
> +
> +		reset_context.method = AMD_RESET_METHOD_NONE;
> +		reset_context.reset_req_dev = adev;
> +		reset_context.src = AMDGPU_RESET_SRC_USERQ;
> +		set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> +		/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
> +
> +		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +	}
>   }
>   
>   static void amdgpu_userq_hang_detect_work(struct work_struct *work)
The function and the work handler for are using the same name and it 
causes confusion to understand.
queue_delayed_work(adev->reset_domain->wq, &queue->hang_detect_work,
                            msecs_to_jiffies(timeout_ms)); The queued 
item here call the work item where the function name is same , so its 
better if we can keep a different name

Regards
Sunil Khatri

> @@ -153,7 +153,11 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>   		container_of(work, struct amdgpu_usermode_queue,
>   			     hang_detect_work.work);
>   
> -	amdgpu_userq_detect_and_reset_queues(queue->userq_mgr);
> +	/*
> +	 * Don't schedule the work here! Scheduling or queue work from one reset
> +	 * handler to another is illegal if you don't take extra precautions!
> +	 */
> +	amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
>   }
>   
>   /*
> @@ -182,8 +186,8 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
>   		break;
>   	}
>   
> -	schedule_delayed_work(&queue->hang_detect_work,
> -		     msecs_to_jiffies(timeout_ms));
> +	queue_delayed_work(adev->reset_domain->wq, &queue->hang_detect_work,
> +			   msecs_to_jiffies(timeout_ms));
>   }
>   
>   void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
> @@ -1256,28 +1260,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>   	if (ret) {
>   		drm_file_err(uq_mgr->file,
>   			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
> -		amdgpu_userq_detect_and_reset_queues(uq_mgr);
> +		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
> +					     &uq_mgr->reset_work);
> +		flush_work(&uq_mgr->reset_work);
Flush work is called here with userq_mutex held? Is it ok to run for 
that long time and not sure about it but the flush_work might try to 
take the userq_mutex again, that was problem initially during reset.
>   	}
>   	return ret;
>   }
>   
> -void amdgpu_userq_reset_work(struct work_struct *work)
> -{
> -	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
> -						  userq_reset_work);
> -	struct amdgpu_reset_context reset_context;
> -
> -	memset(&reset_context, 0, sizeof(reset_context));
> -
> -	reset_context.method = AMD_RESET_METHOD_NONE;
> -	reset_context.reset_req_dev = adev;
> -	reset_context.src = AMDGPU_RESET_SRC_USERQ;
> -	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> -	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
> -
> -	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> -}
> -
>   static void
>   amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>   {
> @@ -1311,9 +1300,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>   	userq_mgr->file = file_priv;
>   
>   	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
> +	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
>   	return 0;
>   }
>   
> +void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev)
> +{
> +	struct xarray *xa = &adev->userq_doorbell_xa;
> +	struct amdgpu_usermode_queue *queue;
> +	unsigned long flags, queue_id;
> +
> +	xa_lock_irqsave(xa, flags);
> +	xa_for_each(xa, queue_id, queue) {
> +		cancel_delayed_work(&queue->hang_detect_work);
> +		cancel_work(&queue->userq_mgr->reset_work);
> +	}
> +	xa_unlock_irqrestore(xa, flags);
> +}
> +
>   void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
>   {
>   	cancel_delayed_work_sync(&userq_mgr->resume_work);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 85f460e7c31b..49b33e2d6932 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -84,7 +84,13 @@ struct amdgpu_usermode_queue {
>   	u32			xcp_id;
>   	int			priority;
>   	struct dentry		*debugfs_queue;
> -	struct delayed_work hang_detect_work;
> +
> +	/**
> +	 * @hang_detect_work:
> +	 *
> +	 * Delayed work which runs when userq_fences time out.
> +	 */
> +	struct delayed_work	hang_detect_work;
>   	struct kref		refcount;
>   
>   	struct list_head	userq_va_list;
> @@ -116,6 +122,13 @@ struct amdgpu_userq_mgr {
>   	struct amdgpu_device		*adev;
>   	struct delayed_work		resume_work;
>   	struct drm_file			*file;
> +
> +	/**
> +	 * @reset_work:
> +	 *
> +	 * Reset work which is used when eviction fails.
> +	 */
> +	struct work_struct		reset_work;
>   	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
>   };
>   
> @@ -134,6 +147,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>   			  struct amdgpu_device *adev);
>   
> +void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
>   void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>   
--------------7atV4pbI3wRdr8L85RWxV4wl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 21-04-2026 06:25 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260421125513.4545-8-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">It is illegal to schedule reset work from another reset work!

Fix this by scheduling the userq reset work directly on the work queue
of the reset domain.

Not fully tested, I leave that to the IGT test cases.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 84 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 16 ++++-
 4 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39894e38fee4..17341e384caf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1191,7 +1191,6 @@ struct amdgpu_device {
 	bool                            apu_prefer_gtt;
 
 	bool                            userq_halt_for_enforce_isolation;
-	struct work_struct              userq_reset_work;
 	struct amdgpu_uid *uid_info;
 
 	struct amdgpu_uma_carveout_info uma_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b11c4b5fa8fc..cf61be17e061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3786,7 +3786,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&amp;adev-&gt;xgmi_reset_work, amdgpu_device_xgmi_reset_func);
-	INIT_WORK(&amp;adev-&gt;userq_reset_work, amdgpu_userq_reset_work);
 
 	amdgpu_coredump_init(adev);
 
@@ -5477,7 +5476,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&amp;adev-&gt;reset_work);
 #endif
-	cancel_work(&amp;adev-&gt;userq_reset_work);
+	amdgpu_userq_mgr_cancel_reset_work(adev);
 
 	if (adev-&gt;kfd.dev)
 		cancel_work(&amp;adev-&gt;kfd.reset_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a4c39d83adc..ad6dac17dd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -82,19 +82,11 @@ static bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
 	return false;
 }
 
-static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
-{
-	if (amdgpu_device_should_recover_gpu(adev)) {
-		amdgpu_reset_domain_schedule(adev-&gt;reset_domain,
-					     &amp;adev-&gt;userq_reset_work);
-		/* Wait for the reset job to complete */
-		flush_work(&amp;adev-&gt;userq_reset_work);
-	}
-}
-
-static int
-amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
+static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 {
+	struct amdgpu_userq_mgr *uq_mgr =
+		container_of(work, struct amdgpu_userq_mgr,
+			     reset_work);
 	struct amdgpu_device *adev = uq_mgr-&gt;adev;
 	const int queue_types[] = {
 		AMDGPU_RING_TYPE_COMPUTE,
@@ -103,12 +95,11 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	};
 	const int num_queue_types = ARRAY_SIZE(queue_types);
 	bool gpu_reset = false;
-	int r = 0;
-	int i;
+	int i, r;
 
 	if (unlikely(adev-&gt;debug_disable_gpu_ring_reset)) {
 		dev_err(adev-&gt;dev, &quot;userq reset disabled by debug mask\n&quot;);
-		return 0;
+		return;
 	}
 
 	/*
@@ -116,7 +107,7 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	 * skip all reset detection logic
 	 */
 	if (!amdgpu_gpu_recovery)
-		return 0;
+		return;
 
 	/*
 	 * Iterate through all queue types to detect and reset problematic queues
@@ -141,10 +132,19 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 		}
 	}
 
-	if (gpu_reset)
-		amdgpu_userq_gpu_reset(adev);
+	if (gpu_reset) {
+		struct amdgpu_reset_context reset_context;
 
-	return r;
+		memset(&amp;reset_context, 0, sizeof(reset_context));
+
+		reset_context.method = AMD_RESET_METHOD_NONE;
+		reset_context.reset_req_dev = adev;
+		reset_context.src = AMDGPU_RESET_SRC_USERQ;
+		set_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context.flags);
+		/*set_bit(AMDGPU_SKIP_COREDUMP, &amp;reset_context.flags);*/
+
+		amdgpu_device_gpu_recover(adev, NULL, &amp;reset_context);
+	}
 }
 
 static void amdgpu_userq_hang_detect_work(struct work_struct *work)</pre>
    </blockquote>
    The function and the work handler for are using the same name and it
    causes confusion to understand.<br>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div>queue_delayed_work(adev-&gt;reset_domain-&gt;wq, &amp;queue-&gt;hang_detect_work,</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;msecs_to_jiffies(timeout_ms));
The queued item here call the work item where the function name is same , so its better if we can keep a different name</div></div>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:20260421125513.4545-8-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
@@ -153,7 +153,11 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 		container_of(work, struct amdgpu_usermode_queue,
 			     hang_detect_work.work);
 
-	amdgpu_userq_detect_and_reset_queues(queue-&gt;userq_mgr);
+	/*
+	 * Don't schedule the work here! Scheduling or queue work from one reset
+	 * handler to another is illegal if you don't take extra precautions!
+	 */
+	amdgpu_userq_mgr_reset_work(&amp;queue-&gt;userq_mgr-&gt;reset_work);
 }
 
 /*
@@ -182,8 +186,8 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
 		break;
 	}
 
-	schedule_delayed_work(&amp;queue-&gt;hang_detect_work,
-		     msecs_to_jiffies(timeout_ms));
+	queue_delayed_work(adev-&gt;reset_domain-&gt;wq, &amp;queue-&gt;hang_detect_work,
+			   msecs_to_jiffies(timeout_ms));
 }
 
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
@@ -1256,28 +1260,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret) {
 		drm_file_err(uq_mgr-&gt;file,
 			     &quot;Couldn't unmap all the queues, eviction failed ret=%d\n&quot;, ret);
-		amdgpu_userq_detect_and_reset_queues(uq_mgr);
+		amdgpu_reset_domain_schedule(uq_mgr-&gt;adev-&gt;reset_domain,
+					     &amp;uq_mgr-&gt;reset_work);
+		flush_work(&amp;uq_mgr-&gt;reset_work);</pre>
    </blockquote>
    Flush work is called here with userq_mutex held? Is it ok to run for
    that long time and not sure about it but the flush_work might try to
    take the userq_mutex again, that was problem initially during reset.
    <blockquote type="cite" cite="mid:20260421125513.4545-8-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	}
 	return ret;
 }
 
-void amdgpu_userq_reset_work(struct work_struct *work)
-{
-	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
-						  userq_reset_work);
-	struct amdgpu_reset_context reset_context;
-
-	memset(&amp;reset_context, 0, sizeof(reset_context));
-
-	reset_context.method = AMD_RESET_METHOD_NONE;
-	reset_context.reset_req_dev = adev;
-	reset_context.src = AMDGPU_RESET_SRC_USERQ;
-	set_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context.flags);
-	/*set_bit(AMDGPU_SKIP_COREDUMP, &amp;reset_context.flags);*/
-
-	amdgpu_device_gpu_recover(adev, NULL, &amp;reset_context);
-}
-
 static void
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
@@ -1311,9 +1300,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	userq_mgr-&gt;file = file_priv;
 
 	INIT_DELAYED_WORK(&amp;userq_mgr-&gt;resume_work, amdgpu_userq_restore_worker);
+	INIT_WORK(&amp;userq_mgr-&gt;reset_work, amdgpu_userq_mgr_reset_work);
 	return 0;
 }
 
+void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev)
+{
+	struct xarray *xa = &amp;adev-&gt;userq_doorbell_xa;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags, queue_id;
+
+	xa_lock_irqsave(xa, flags);
+	xa_for_each(xa, queue_id, queue) {
+		cancel_delayed_work(&amp;queue-&gt;hang_detect_work);
+		cancel_work(&amp;queue-&gt;userq_mgr-&gt;reset_work);
+	}
+	xa_unlock_irqrestore(xa, flags);
+}
+
 void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
 {
 	cancel_delayed_work_sync(&amp;userq_mgr-&gt;resume_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 85f460e7c31b..49b33e2d6932 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -84,7 +84,13 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
-	struct delayed_work hang_detect_work;
+
+	/**
+	 * @hang_detect_work:
+	 *
+	 * Delayed work which runs when userq_fences time out.
+	 */
+	struct delayed_work	hang_detect_work;
 	struct kref		refcount;
 
 	struct list_head	userq_va_list;
@@ -116,6 +122,13 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+
+	/**
+	 * @reset_work:
+	 *
+	 * Reset work which is used when eviction fails.
+	 */
+	struct work_struct		reset_work;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
@@ -134,6 +147,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev);
 
+void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
 void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
</pre>
    </blockquote>
  </body>
</html>

--------------7atV4pbI3wRdr8L85RWxV4wl--
