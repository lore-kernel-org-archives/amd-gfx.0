Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADE5C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 08:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250E710F879;
	Thu,  5 May 2022 08:06:21 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB05310F879
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 08:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wgd84NL/BB8ivF9iihjVe18/6BknqUYS/tsrO8qHtLahG6JmqOFUxfR4sj57Ocg1ERR7N+c1lEYJmQ4Qi+8g5BpGTbI+HvNecU9xC16YA7/Z2cev+P6V5NnkCz4o6ap8eHky4CrQR7NVxSMcU3GxpGzc6E/XdNLWOyTNUqxlHCfeiQrp/UGV+FA9IyY2pGlKIyNbC3yFEnlAE1pOgirunb1aDX+F4jEzUswates3alLIVqnKXzjPIFUi/RTW+ncOECgtTqhCzRfpFbI4IOcquMXbDRjyBnti8ugw4xIsi8FTkDWs3kttpzJgPCuEYCnuHhBMA/1RI8r2QBYxc3kVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck/qu8BeWjHhj7kqSudZCDu9MQmFc/eWFwov5iJ1xKo=;
 b=oKYM+ylp/nsIqXTrn8i0ozvzQpoY+EyHrlEx3meM1bLSKUbPvXtNdT43IanuP40V+EPsjveeXu2SAajNMpdrQw4MGGcG/aO1bJLErzb/p14jH1tPy7Kv/CYmgpBJm0m1V779JzAzLdT0hXRenKv4HYaN2qFqq0+2MOzHPgwJv8zddWRxIK/Z23najZmF1ICSXtfzE/OF22HnhPE9UiPzYZkMqBw+C20A9bwC2XePgiWddhlSIuow9LcuWUrTVpQpnXbDJhvRR0a8Nq5vlLADdkPu4jLk3yljU03mDAaDcBEBJOVzeiXdo4azegShqx+oIVhPkzyBQiGObroMoTKf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ck/qu8BeWjHhj7kqSudZCDu9MQmFc/eWFwov5iJ1xKo=;
 b=DKe0OM2S6XEbhtJ0hgT/j2DCls8L1hXA1Gt/fO+FKTqk+t9FOb39SPZmRZaGuefXSv+MjWXfT2FCXiHsIPHEeSkXkbFGT5e/wF/1GeD54f2tEJZTwDOlKbcLM2o3X2DwzLJ33DLQvw+7jHkow9frhQQlEnFrLXUW6n22A8Enwd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BYAPR12MB3384.namprd12.prod.outlook.com (2603:10b6:a03:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 08:06:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 08:06:16 +0000
Message-ID: <031016bc-ce71-38f9-bf2b-e5095019a7c4@amd.com>
Date: Thu, 5 May 2022 10:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu/gfx11: remove some register fields that no
 longer exist
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220505031955.531751-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220505031955.531751-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::22) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0dd62a-d161-42ea-68a9-08da2e6e20ed
X-MS-TrafficTypeDiagnostic: BYAPR12MB3384:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3384B3501AFC9565F9F79A5C83C29@BYAPR12MB3384.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HDNqRM/ha7MOfjS84ltlt55AdWkDPxdnrRtkErkmc2a3XYIr52SPyp6GxnjzuMUdwShob0tfpWRsFsQralvahkbRgkgE8Jh6smVPLwvXx6ysVDlT/PQCIM/afxL9m4YMCVY8TjCNm0dDeRgRwpTlcmgRNZZ40Ug5O9DI3SpW1ygtWfAalY7G2ehsxbJIVr6dlXcEhL5h5kyetCKxz2AyLroiXs8QadocughpLDcPmKueFrzmMTNUhhTh6Zqjqh/GNoOlli7FJRXGaEgvG9NNDGFwBHCHOokR6vScifR5aVs0f/uIXpNkZyFyultXTKDqLA7b95kfd2e7fJOzZew1EWL+ZFAh+exSbJWmGxmwdb9FcXUVrRX74CKZ3gI28cuJ1NGJY6IxC7sSggXfzYLc6yIckppSkpHGrIu5xizZwbBwiDT+Gng4dgFjBZg7DBV2Tw+SY4eHDkUY9yk/jg8fUgCf3O4vy1VrepfCK1C2Cb5urI0Lbsg3ZD55Z+B5mg/OnJYbZ174N9SBb719E/8rl3te9D+lXtpg7kzvpyT4gK9xqxirJ5fWxC/9YQ+hEuFE1Grw+XyBs52rN+3Bu5p5jgqbiGUu0/M9koXIIx2uZScHAjt/H3JrlYcSZClZNxSlaYs6N76q29PBG3fYtjmyyvznI/xpEpOwpuF1b4f90YQM3BcsHphVvwps/ECcnFgWWXlvVloGVFUQUKNb/A7DGCPE0EtSYWjjewG/su5cOFgmNDBCLpWCbXxrokp7hjZH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(26005)(6512007)(38100700002)(316002)(6506007)(508600001)(6486002)(66946007)(66556008)(66476007)(6666004)(8676002)(31696002)(66574015)(186003)(31686004)(5660300002)(83380400001)(2906002)(8936002)(2616005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkFCRTlxWTJETStzc1htNDlMVUk2UGNSNUV1V25hQWtubTFITUlmampBYmxy?=
 =?utf-8?B?Um4wSEhSS0JodStiWkZrMTcyeUZHbHFBVnhhM3BsYi9VQzA5SkRtT2FrS1pY?=
 =?utf-8?B?YjNLc0FUM2VsZEJONjc0MDVEL1liRDl2MUdpSGRsam5SVG9xUUJOdEg3WEdv?=
 =?utf-8?B?QXJxZTVLNGJ6QUJpTjQ5aFBkNXhhQUUvOElEcW1aVlJlclNNenIvaXZROFBL?=
 =?utf-8?B?S2Z0d1pUVUtzU3JQKzNVaStrS2hMRmFOV0YyM1JQajFaQ3F5VTdQVXV6bW9z?=
 =?utf-8?B?VzBkWHNZM2dtanlDbHR2NTJNb1JScVpsSnhzMnRHVVlCTzdScWVMSWhQK04z?=
 =?utf-8?B?VFlUNGNmUGJMVmVBNEJ2NldTUUdVYm0xa3lnOTc3VUlaR25JZkRNV3hBTTVK?=
 =?utf-8?B?ck40eklKQ0JqS0MvbG9vMDRoVGlmWFc1ZnZtU25MUHFZV2pPYkxONVd1OGpL?=
 =?utf-8?B?UUFtQ1VaSTE3YzdVbS9pc1VKbGFIZGJKdWVkYUdSK2NNeEZmOFc1UUlnM1lG?=
 =?utf-8?B?KzZvazI4Rk9qKzVGWTZuWkd1T2dIT1dKSW1pdjRGRVUzWXV2UnRMWHcydEdJ?=
 =?utf-8?B?ZTNyc0p3TVR2KzJzNUVjZ2dtTzMzQUpDcnYwMHBsU1RvcCt0YjBQOGVzbTJE?=
 =?utf-8?B?RlpiRVc2SmZ4eENhL0I0TjBzQU5DQ1hkdk5MR003MHZQcEVsd1lTb3c0ZWRh?=
 =?utf-8?B?bEt3eFMxdXJDV3U1cUs5dnhSL0lUenV2UUZQRk5QdnA2ZGJIamZSVklGWTRo?=
 =?utf-8?B?cG53dk9veDBHUnhCN3N3VUZxdmYxd3hRVHNVam5ZRUtweHo3eUQxY0hSWllL?=
 =?utf-8?B?VzgwRGQrOElpVmEyN3hINGhSM1daaHlxM05UMndJTUx2eFBVK0ovL3ZMWUlB?=
 =?utf-8?B?MmFYVXcwQWpVVTJHaWIwS2RGK2hRSFZ0UGlrbjNDMXJUMkVLTjdxZ00yYTVw?=
 =?utf-8?B?bmdOOWl6WGdSeVlCM3pjYnhWVHp3SDJxc2hCREQ3WDJ4a3VTKzlLUHd2MjRx?=
 =?utf-8?B?TTJ0RUJZYnB2SDlycTRoYXgvUk1GQ0cvZmlseUI1VXpXbERZWXpEM2RKcFVN?=
 =?utf-8?B?byt1TUJpVHlCM0hJRU9YUEJjUE9DSytEU0s1MWJyNzB2ZFNyWUhIeDBwbjUw?=
 =?utf-8?B?SW93KzUycml6VndSNGlhSWNsN2xYRG50V3NUSGExSjAwOEcrR25GZjM1MmNy?=
 =?utf-8?B?MkdkYzlzSm9rNU02cjdxWXRTRi9VMy9UQ2U2K3RYSzZWMkNKcmh3QVVyR0Uv?=
 =?utf-8?B?RDhlVVVhd243V1lNYmpQUlBld21tS0F1TnNkV1NRNEhpUGJBY1pBZXFhSDBY?=
 =?utf-8?B?Ri9RQXcrMWNNcCtMUEFKV2xIc3A3eUJpVUZtWEFSZGRQQXZGNjMvSEdBS1Fi?=
 =?utf-8?B?SU9wZmlpbmZnRG1HZmZsTnRRbnhtYzZDVHU3MGRQT3drak4xVHcwM0paMGNE?=
 =?utf-8?B?RENzNkppQWo1WEQva2M5aUZyMmYzMU5kUWt6WDJ5THcrY01LR3JWbDNOUmJq?=
 =?utf-8?B?ODdxdG4waFBPRWt3T0ZGY0hsMWM4V2hIRjZtQThURUdMenVYK1Jvby9mUm9D?=
 =?utf-8?B?S2tMekxKQmRaa2tiQ3BYRjlZdHNRVk1HVE1MSVF1RTIyS1FiV2U2Y1BwbTMr?=
 =?utf-8?B?Ym45b3NqendEWkROUlBhQi9kY1FZeHZzdVhxVEJ4bER3YkRuemNMN1BqREhm?=
 =?utf-8?B?S1hnOFNCSlNYQmdXcFpVb3hHQytlOGhGOExRb1YySnZsdGM0bGNwMlRNejBZ?=
 =?utf-8?B?S3YyUjZtQlRvWnppZW9wS3dsNEl2QThJQXRaaDRpYTBmTm5zMjZIWkN3NGw2?=
 =?utf-8?B?bHI2MkQvYlBOdllzcy84REsvQUIwS2VWSFpEdjZPNllIcVVVeU8xS1pHaUcv?=
 =?utf-8?B?WGVlMGk0Z0ZiRHFKaVRqQURSby8xYXJiVXFOWmN1SGg0VS8xRElrTk9wems0?=
 =?utf-8?B?dkxFMjg2Vm12RGlJSXpDWERFQTc1M0g2RnBoUnlJaFhUQVpFc2tHVit2aDJB?=
 =?utf-8?B?QkhrTCtwK1MyVWZ3YkxlRDlnZWsxTHNMZFdNekcwb2U2YndWbXhqczc5bytJ?=
 =?utf-8?B?clpncitIK2FEeUtwQ0N1RVRyWGdBcjJaRGJMbXBmZjhSTVo2b1U1VHUwQk9J?=
 =?utf-8?B?RktUczdnNmVKT0grVnVTQ2FEMjdIbGhBZEp2ZnVEN0NmRmhsNHR5NHNlNjZH?=
 =?utf-8?B?Sml1cWRXNXBYZ2dhaUVzQ09rRGV6UHErYXd5TkRPRkhJM2padWN2K2hwTUZI?=
 =?utf-8?B?Y0Irdm1nemtpVXNmSUJQaHh2NTB3dGJvbmhBKzg1ZFhvQnQzMEFNb3UvRzla?=
 =?utf-8?B?Q1UzMUhLVUVRcmJYSWFuZU5sZHgyOGhhdG1HdW1JdnFHOWZhZnM5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0dd62a-d161-42ea-68a9-08da2e6e20ed
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 08:06:16.5837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nbpz4J3F2g5eEuqWiszyJ/HMHTa1FXGb392lkVKEH03mZ/OGE0RyRQQjC8/BzfVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
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

Am 05.05.22 um 05:19 schrieb Alex Deucher:
> Some copy paste leftovers for older asics.  They were protected
> by __BIG_ENDIAN, so we didn't notice them initially.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

I'm wondering if that is are actually working on older asics, most 
likely not.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f0f13eeb4b71..7c75fe51ec20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -3452,9 +3452,6 @@ static int gfx_v11_0_cp_gfx_resume(struct amdgpu_device *adev)
>   	rb_bufsz = order_base_2(ring->ring_size / 8);
>   	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
>   	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
> -#ifdef __BIG_ENDIAN
> -	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
> -#endif
>   	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
>   
>   	/* Initialize the ring buffer's write pointers */
> @@ -4102,9 +4099,6 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>   			    (order_base_2(prop->queue_size / 4) - 1));
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
>   			    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
> -#ifdef __BIG_ENDIAN
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
> -#endif
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);

