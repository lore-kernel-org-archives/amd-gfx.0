Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AC5C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 20:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0A2113684;
	Tue, 17 May 2022 20:56:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6309113684
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 20:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR1MznwD1JvRGQ2Rw7JOzrAf+gyXcrbNxHuGMOycztKTLtjYHqAonj33x4WLd2ab2ChM+1o5nIFsd88Zzx9MxTt+HbUwjmhNMUbv38HhPF5K6Q9vfVkH62FCjmewcaytqQDN2uOVr1QTnxJlE04mMBkIY+0k6x2kTcMmeWJufZMOFpGO/s3Z/DfP31jGfISLLRS14BmwLkIBAIm7i2Glm/ApfQCLcUmClorpOSYC75pFrBUY83G31HDLbdyjDt9Arf0Fbse0J3zHpRhmStEvktqAL6SSmd6ftcLvJ0UAEIp39fd7qZhA4ABa5pvwgzqU4CD/+2W3Ea6tnHG4OcM2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch3S8fSHs5kTanLfbbRJwFcfa9ZBeaTYMtIZE5C9CYA=;
 b=B9+EvswZ/aECYgmFyRYtUHxJfKnFNZ6jOeC6ripXFvr4hgDjzqZwi33Z49awUAOrIBAd6CRKft3R05IGvRYdIP3fh3Oa4oafzSNqVAagxbEvkFpLx2fu5uuthqm8CizXOSbKD1oghjpdSxxq449uRoV3mx3xch6pVdpVnN5lkqBf0WiLaiIR57b/sZv3BUj2tl6pvZUGI4iz4dVkFIk+hnbxM1Uv5KZzX3Z0uA25WkjQ0Oodk1M3WOs95SUElgZJiSTQAOkZ2LsIEdX82OX4Zajh4mrE86zvTIo2yFHi0VwaQ+RP6sMGk4gRjctilYmVcO8Y9dBqhrnS7NBwLnaRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch3S8fSHs5kTanLfbbRJwFcfa9ZBeaTYMtIZE5C9CYA=;
 b=dFgJQhGSOAppWb9phVcCWq2WNkvxT6g9ODM3SJlsJ9Fl2NvK507eXRQaSbf+izmRn6mvyCEWiPiXunHMmh2h1cdW3nV85x2XVcP7iag/YPvOp0NW5SjHXQ6/5TaIAa7oV3GVkn1Xo0zEyPNW0SoobyejcNUBzREX4wOXZG0v78c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 20:56:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 20:56:48 +0000
Message-ID: <e5b5c82d-eb31-7630-768c-60c2cc0e34fa@amd.com>
Date: Tue, 17 May 2022 16:56:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 7/7] drm/amdgpu: Stop any pending reset if another in
 progress.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
 <20220517192102.238176-8-andrey.grodzovsky@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220517192102.238176-8-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a26193-d578-46b3-80cb-08da3847c28d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5874C04ED97CD062AC39EE3E92CE9@BL1PR12MB5874.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhfPdMYJ3pUnSCsTcCpG7pMk3YATFloJ/gLJBFYJJTV8P7qkzz8yC9Zg0j4kgC8u5z/VswgRo2L1WLR5g9G8IzS0eL6El8i3+8R1AJrTkXIsUL4eXoZVrhD4FgayeuSHlcr8BKz8nil8HVBabSM0+y2fXpGrpZzSUIkS+nfV+2WjN+aomkbV0STkja+Ju80aCihADhzBUsTN7KPv4+oma0xAyvz/BnVaRL5go4V0/XSX+K11WVFksS303KQmNUdOiVLV06eFpoPRE8DfncpXCZ50CYZClfbmGmcNXCyZpXKwtWRx/M8ABSbar7/X1ukkZTKoQ6l10XilMunyKC8VY8F8HUEjhJv9SZ5SK7xhKa+Lvvi9tVgWl3Nj+/RPkgVwV/WywOl15UU7Np9MLGv9syc7LK4JsAVPzMsd46R0NJlDAqh3GTKiOLgN/uHL0W98RFlQBcME2ESUqT21fvADwXk9fMcweKHQc4eBPX5Hdii6SnTGTTb+aU5uyI0rBszMzi4R7WBeK1mOuS3pCZLQXX5j4qOGiL3ZI2Zr3MmwELP1pcbziMKV3dI4+BBYGVgZtDgrDXjqljqODIs/rAF/wv15upJ0AOgA+kAB468sKWl4G7sfkISww8bw69IQagVStFfrJXbc9YNoet8DHzjos3dkUKrcBCmJGwyBTfUlflMbSKH2Hi0/9/UGR4piSsTYwCHmNuN613KklJVYPeFOUbk3THBeF7Ucoppq9dlS2HLFySa25xdKhsYxL4q90sKv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(6506007)(6486002)(44832011)(508600001)(26005)(6512007)(8936002)(31696002)(4326008)(5660300002)(66946007)(66476007)(66556008)(31686004)(186003)(83380400001)(38100700002)(8676002)(86362001)(2616005)(36756003)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGttWGpmWll2ZzFRM1poRUcwZzNmczRuOVR1aXVBcUtIU251TzBYU2NvUWxS?=
 =?utf-8?B?TFF0TFF2WDJybEZwV2N4dE15OUQrS0kwbEQrMVY0Sk54dUtVV3JqamJBdFJT?=
 =?utf-8?B?OURsZzIwZURjbkZhTjlwREs3WnV2WFMrZ2wrdjVTSE90UjhmeDQ0Z0NaSXV5?=
 =?utf-8?B?Y1IwVElwbnBrV2VqSTFKTkQzeC9rSjhUaXYxOVlqM1lQUGFndnliYkJtNVZx?=
 =?utf-8?B?MVp6aGhBSlFkbHVmSW5ZN0QzM0RpMWpWNnl4aFZUTUYweTcyNWxoaTJrK2hY?=
 =?utf-8?B?MkxEeHJtYXNqbUxGZllsU3NkS0VCQlJwU1o4Z2JjK3NWZnY2QlFYUEFObkVF?=
 =?utf-8?B?Z1RPZitkNmcyR1Z3MlRwc2IyS0o4WktDVkNPaWFyUDJDLzh2R1BOTGNVQ09W?=
 =?utf-8?B?SHRUSDhZekpONkw0NGZOalg3OXpKRkpjdDhHajFpOFl1WmFISkNnV0pYaUln?=
 =?utf-8?B?MTRoWGpENGdOWFBGTHpBSDZFd0d2M2RzT1g4OTRZZk9IaGVmWGlnQk9hZFU3?=
 =?utf-8?B?Y2JZZDRJWjBtTjhTSGtXSmVRTlNtelUxdFg4aFZVc0R3OSs0dkJHb2lnQ243?=
 =?utf-8?B?clFBQ3FUZVZHVitZVUhGVThQRnNSVS9BaVVwVDJBWmtjdkFnYllMZVczNlB3?=
 =?utf-8?B?eEVyVGJWdWxnc1FQS0RGU0FRRUIxSm5TaDBpYk1WWWtQSmtNeFVhYTR0c0xm?=
 =?utf-8?B?cDc4N0kvREhtcU5IUlduNE15OHB0dGkxcWxsUnR6S1l5YWxSLzJGMFVlOHNR?=
 =?utf-8?B?blZEWVAyTEhKYmFtcHRXQzdqTXMyREhCNHJoeXV4UDBmOXNDeDVkeXdKWkN1?=
 =?utf-8?B?TlVydVVrVHJ1eHNycHY3VjBkYXlqT2xHcDIzTUVDblA2bzZwSHY4bGFtK0tH?=
 =?utf-8?B?V2k0SlFUV3d6d3I2eWE5Sy84QUVwa3JkNjdxVmpzMUl0RWVwSHlFelpNRGNJ?=
 =?utf-8?B?eTZGNjBlZDVFQ2YrRG1qVGN0SGJUYlJiU25zbWp5KzI0Q08zbEJ4eFNRRmZT?=
 =?utf-8?B?aHlRc3QzTTRuWkRWSTRsaWtNaFQwYWNpRDZBZ0Jjd3hsNjdSVTlwaldTSW9v?=
 =?utf-8?B?Y0lnaW9sNEVGajdBdGFqeGF4aklHQjZQSS9qaUVLVWFNM2FkclJuTTNLY2o2?=
 =?utf-8?B?WHpjdm9Ua215S3J1K0ljZ0g2N1RNTkpMU3krNWhxaERNVFBQTjB1TXVhdmxr?=
 =?utf-8?B?aFIxdTlnTWJjL0J0V3IyWE9tdjJvZFI3bWNqdFJLckhnUkJCdG1LSE1NUjln?=
 =?utf-8?B?TUo2bFJKYnZTK1FGRFpsajczaEVMU05aOFBTd1pKKzExaUM4ZEVDZytDQ3FJ?=
 =?utf-8?B?dGlNTFVTLzJXYkhiNUp6c0FXWUNnekQrMExRUXBidGlFSmFjWVpVcEhrOEVt?=
 =?utf-8?B?SlNITUQ2M0NMZ0wvRkRwY2xqOWE0RzZ4RVJLV1pRU2xUcWwzV3BmVFZRb0xD?=
 =?utf-8?B?czdvRy9qRW5zTXM5L2Z1bk4yV2NkK2psMVFKWktVenY5U0RMSkt2SEJURU1C?=
 =?utf-8?B?UjB1R0FNQVFHTzAxdzFSMmlxdTI4V3R1WGZENHBlOGxDNE5vTFZuV3pGaG5Z?=
 =?utf-8?B?NiswSXI4UkV5R1VOMDZ2eW8xTXJ0T0l1Y2Z6NnhIOEwzQjd1eHpLRlA4cURM?=
 =?utf-8?B?YkxpYlkxYVZHM3R4cFJXY3FrVzBZamVvSHM1ajJxN0pPSFc0ZGQ0VDNmSmZs?=
 =?utf-8?B?SHdJdDBXQ2htdjM2NWEyRVZ6TkZ2YVJzRG9ON01TNVdpS3FqTXVBdHo2QjZt?=
 =?utf-8?B?Wmd0Y2xIK05ua0tOZmovZGR0OTJpdFVONytxak1HY0pmZUtPa1gyOXZjYmtO?=
 =?utf-8?B?WlhIS3BhRGVQQm9FSGhrb1UrNVdiaWtKUW9BRHVjTmFzRFFzSmhxbE9TNFNR?=
 =?utf-8?B?czg5M0VJeHZWVDJmOUx4Q1N0QVZheXVnZk1KRTY3dUdPVVlkRVByb29ydExv?=
 =?utf-8?B?clhybkcrWVhvT3I2YW5OMkxNQXFTT2pacmpHdlhsZ3V1Mk9yMTM5VkQ1a3dx?=
 =?utf-8?B?bXRDbG83cEQzeGMzK0FkSjNOc0xuRll1cmhYRkswZnp1K0JDOFFucUVreDZV?=
 =?utf-8?B?VWM0cDVnMGUzRVlMWHlMSWN6QlBLV3pjR1AvZjZIWkVtWDZBWi9oT3R2dmR1?=
 =?utf-8?B?LzFtdjQ4QjdpVzU3UnROUWJZNnZmV2pwWEJQc28zWk9hVHZ2WXhsUDBwZmI3?=
 =?utf-8?B?eVFwY3RKSDFMZ0xiaUF2Vld2bVdTWndncVM4VGpNT0k3ZnFSbU1wVGhVTWFJ?=
 =?utf-8?B?NndjWHdBMENlS21wSG1DcHNOc2FYRXFpYTZ0WFJXYVNFTjlZbXo2a0tVdnp1?=
 =?utf-8?B?eHc1d0xzTGh2U1M0MVoxK0l1UERnVWk3cUxlMnJYRVkwbWE2UlkrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a26193-d578-46b3-80cb-08da3847c28d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 20:56:48.5964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMKzcfVVllPl6/lU2aAIhHcFTkIfLlyYEPG0IqcEVU73e75TZIiACJL5BdXVyDIe41GMKjXMblI2SJfZaqjchQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
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

Am 2022-05-17 um 15:21 schrieb Andrey Grodzovsky:
> We skip rest requests if another one is already in progress.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 65f738fd4761..43af5ea3eee5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5054,6 +5054,27 @@ static void amdgpu_device_recheck_guilty_jobs(
>   	}
>   }
>   
> +static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device* adev)

Typo: pedning -> pending

Other than that the series is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +{
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +
> +#if defined(CONFIG_DEBUG_FS)
> +	if (!amdgpu_sriov_vf(adev))
> +		cancel_delayed_work(&adev->reset_work);
> +#endif
> +
> +	if (adev->kfd.dev)
> +		cancel_delayed_work(&adev->kfd.reset_work);
> +
> +	if (amdgpu_sriov_vf(adev))
> +		cancel_delayed_work(&adev->virt.flr_work);
> +
> +	if (con && adev->ras_enabled)
> +		cancel_delayed_work(&con->recovery_work);
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
