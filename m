Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3A4C636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 16:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A767710E417;
	Mon,  6 Feb 2023 16:54:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C7310E420
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 16:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF4vUXOHAioMc9Vt9uAxPP1ss1kT+EOcmF/F8SASbsx4Iox2SAMILFrPAdfKRG285/yZ9AlUQZU/ntZdbOpRIjPwF4LXsq/u0jK9hFBBibos+j7ZQDjVZHdc0Qa+QTzS5QcIylApMat39iaCubVd/q48KiWNHpnyjYHUTTNiAPYIAbahxYaP0P79FI2tZK2IngVdG+RwNkxI23zq4sDZRCY3UTX8sNOUN3RFO8UIZg8FzdIOhZy0tJwWqfx6Ujz3t0Lu6wh68miNNrxedKkcbsPL6yVe0dKYLWV62KQB5lyV7sxWInA+y7qAyNJa//3OkZxMHhBWunjkIF6nwHHRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dpI+X1+wqqMHgF38f85Z+G6FY8w/bt02P/KEJsvXBM=;
 b=bon94Yut0HzKsxTctgGPjzhNQKl4UXgv1W3RZOfgGzQYzLQD5+8XiWuP1u6PklwsMLuSzEJkf8VoQ+jrwyWbyhou18F2X2TOz/Hrq8/XHDlUxDNbgsoNj7Lo9x+qLu2FwUYKvxbVp+zOnoPTyUhfy43ScD8OIDAbNi5zes1SzM9fJJ+Vc5nQTE81i/ZjoYEJOMf5q0Srhvwtb8Lqx1LSXvmav4A+mtBbyB4mzzH4SLC6X18PAAYW0PZ8zj0Cn3hcMhl3HmDetGuitOfzrm6B4SmlWojm0+QErwU7FkSoH+t6S8ujxtDl6wTWq1SjcqxIBOh3tIzT2OG611A2bSj7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dpI+X1+wqqMHgF38f85Z+G6FY8w/bt02P/KEJsvXBM=;
 b=yAeWTq+Cwr/az0hPjyztBxDglofl1NzurkouqlvfuonYaFaLbWG9rJ1xiVdCNhveCRTLMuzZn0wVir1AvxUFBxhAlxkQcnOneJ/HZFlZY2XxTnLTkbTO6Uu/GgGOl+L5VJczJEPZ2ecmzUjbAiPNIOEbCtMluVUyVu2ivT/LNHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 16:54:27 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 16:54:27 +0000
Message-ID: <3a44e0ab-0a56-e9bc-8c17-2dc5c8a4f002@amd.com>
Date: Mon, 6 Feb 2023 17:54:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 12/14] drm/amdgpu: initialize doorbell memory pool
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-17-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-17-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: f13db2f0-d2bf-46a9-d866-08db0862ce9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfndLDzA+4vu1vGJmIGXYvDXnKNADuFv1fQsc/UyGV76e3YFE9rB6okCZTSJ4uXE5uRNO4sdSu8Dqx1s2CAo3VU43cJh7dtKmS6WrNZ4An8gfEuEEhnuNQNkijQA3kgg4ZbCwke5qaqarELqIn+m65r0sP5IXubK6w/RP3bfgIMmAWo8Z2YQgmDNNgmh00k6rgwjUitfnFWQHaiJqLzpV5IJMh/EoJWTPs0QXMwADmwqoC+LT2afpCcuB6N6C6os3KGfGfbsHXxW0tOGct6bNeOAvmAeREPKZflxs8tdsAJQik9fZq6CwHeMRY52dt3s6bSJxIvEUldKdYGubsA6N9sYr7fZiOVdiHqvFFT+NGYiihInl+MpNMHZSlS0mIPP3url4IMd+M+Uw7kDC6/YUzimViE04/uIVEYY0cfUwHHTYCOmXiNmk5fLX65qRWvVZEj5aVpLC91xzohsAg1aJKk6pZmU0IFbj9iaSpGmzKpSbZQ4aijWLHl37GyRZdoc1vDlfXyQnVWOW7wmHo//bvJZMiKzEER8Y+bMSKDPE1c/rTSuLI4YDxJ87xvBqMSO2+UWUbAyU1UOa/63LOP3mrdC4+eT67sEIZ70HZPQwz6sRxpVG6s5+bjr5sbpY8gxjUkfsqJDHQNCPgRnFJGM7HCypZpvHXclBLrCA2Zf82mekLRTUWxJInyG+MnIvkMClu2VHiAIJLyo/gETsyeWvl3tato6h6+VX/HyDo3G68I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199018)(316002)(186003)(6512007)(31696002)(86362001)(36756003)(31686004)(2906002)(66946007)(8676002)(4326008)(5660300002)(41300700001)(478600001)(2616005)(66556008)(6666004)(66476007)(6486002)(6506007)(8936002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEREQUFLQVdyZS9GK01VZGdRVkFsbEY2aDhoUllaVnNCSHdraSs2ZUt5T1Nz?=
 =?utf-8?B?YTBIeVhTNnpuVUI2cm4xN3NkK0RKV2J2ak82SW9jRVlIc25rQmJZWnVRWVpF?=
 =?utf-8?B?dzZKaGxKRXJqNWlURCtuVURORmFyNkh5OXVYMW16Y0JuUWFoaTk5b2M0YWVt?=
 =?utf-8?B?d0wwOFBPQVFqUGxQOHlMOXFKQ2UwNkZHQyszUFZzcmhMalpBZ01Cdnp3NThh?=
 =?utf-8?B?QTNHOUxKVUg3RnRneGsrTmpVWVEzRERVSjlIK1dnMEFBWjMvNSt0bUVjcHRJ?=
 =?utf-8?B?Wkwrai9CaHB6cXgvMkluY0Q0TjBHZGZUSXhydEpKTzBvMDRkaENJOWZlSERY?=
 =?utf-8?B?dXJoaFFpYVEvdGNSSUkxR0VwdWdHMUpZMEZ2SWJJLzFLY04wRnZmblZaRnlD?=
 =?utf-8?B?VVRtNmxjT3lja01aWTRobnVVRE5wc3E2UWwwR3Y3T2RQeDBRWjVSU1VVSHdn?=
 =?utf-8?B?VnJYSlkveThJbnFWQnp5bHBPdmRNQWEvODJhTnRqVkE5U3lIM0l4UzkzblBD?=
 =?utf-8?B?Y0w0WmRuK2d4RUZMTS9tZDR5cllxcCs4N012enFnWEs0dENudE80Wk9jcU1k?=
 =?utf-8?B?T0lzSDZ4QjBDWHhuVVF6WUZqOFlpOE5aQU00MnA1amMrN1kzaEIxTVZDbTQ4?=
 =?utf-8?B?TjJFTUVJNmRvNmJOa09saTVhanQ4RkJjTkhuQ2VrZFlnZEI5ZUFyL2d4dUlM?=
 =?utf-8?B?WDVSV1hjdTdyQ0dPM1BWNzdNeFptVzhOak1ZMzZoWkFJS3BXUVhQSXFUK2FU?=
 =?utf-8?B?VHBZcG9rbi9rSTdOWXNZSG81OG41QXF3QTRtYklseHZGU28wWDJBYmNhN0FL?=
 =?utf-8?B?R0x3bmJpMkZmN0RQa1gyTXZURTh1dW1FbWhtMHNLYjdtRnRWR0dQVmFjdzho?=
 =?utf-8?B?eTRQaGZPNHY2eEhxL3BiVDZLYzE5ZXFvekNxNnlDMkJUcWdtSHZhWGY1M0ty?=
 =?utf-8?B?YTFhT0hQS2VEVXpidlk1ZXV1VU1LSGtyTGIyN1psR3RreHYrS0NHUThOSDJF?=
 =?utf-8?B?Vk5aM1kzbWpRZEdNdGsxTkI0TW9sR01GSkdWRlUwTGQ4MXlTTDV3ZGM1NFdG?=
 =?utf-8?B?d3VORjQ2RUFxY2wrcGlicjBITE5wM0diR0luQ1E0d1hKdjRZU0NZRklrNStD?=
 =?utf-8?B?Z1V2a2h1U2RUeUJ0NXJiNlorTE9EZmxMbHd1aXBxclRTSCsxOFR2VjQ2TzR5?=
 =?utf-8?B?TnZhNm40ZzIyVnh5WG5ZMnRyUWxMT0JNRG40dEprVlFZaHFLZ3hQVm51SVpq?=
 =?utf-8?B?U2h6cGJiaGEzK3hvTjVMSUR3Wkx6Vk1hZmlRR29OcDhEZDF5Q0RYcVZyRi9U?=
 =?utf-8?B?NGNReFR5ckNrZTNKdjRUYURkaDRzYU9GS1dwTmhydzh0VlZnei9vSHo3T3JX?=
 =?utf-8?B?cWRsaWdGdjdsV3RheXJNcUc5NWZPTlpuMEJYQ3puVm9CaFlLdmc4WlJNVXhR?=
 =?utf-8?B?VC9vZXFXM0VkZzNZTnpoNDllUi92VXBhR3BVcDRtdE9ENzJKLzE1YnJLN0JJ?=
 =?utf-8?B?WGdnakc5OEd3VVFZVnE3enNqUVFEOU1scVNhUEpZSTFhWVdIVUhSQTdjM080?=
 =?utf-8?B?cktOblgyaGErRWhvekR4WnRHK2pYdmFkcHNVTHlocktQaTZDN01kTHVZZjV5?=
 =?utf-8?B?dkQvUVJNUFdiOVhuSm9mdTVCQ2dkck5NVzlVUG5lQnFYbkFkSS92KzhqRlJn?=
 =?utf-8?B?RGdUdWNEUVd0SjhyYkxLY05lMVRMbWh6dlpGSjhXd2FXR1lOQWEyT1JXYURR?=
 =?utf-8?B?TlppcXB6S2ZWQXNyNFVMT3N3alFGTWZKU3k5YVRZWmcxMTBrMldiVnZsVVlt?=
 =?utf-8?B?UEd6RHlTWGJXLy9ERkYwOEcyaWVrZ056dWhBeVpJb2IySE01MW9jdFE0R1JQ?=
 =?utf-8?B?TUNsUWhNNDBzd1BTdG5aVzhjdGx0bUU4dmIyVHhGSHp6aFNoaW9BM1RXNW1j?=
 =?utf-8?B?SWZNUHFkZy9wTGxWeFo3TXZ1SXQrT1lTdzZ3YmtRNC94Tms2alB4SU0veE5C?=
 =?utf-8?B?dTB0Rkw3WTBUVFVrSlh0dzF2VXE5M3JDdmlKdjlPYlNEWU1JaVJBMG9QOXJT?=
 =?utf-8?B?dXZZQjJhN3FYVFVLMTVYcWZzM2hpLzlkV3lPMWFkZURTSjBCZWRTNlF5Z1dF?=
 =?utf-8?B?Vmp2TmVuZTZROXpwYVdkdkVtSHRwMDFCYnBsVkl2Z1lKKzhKV1V1VFFrSm44?=
 =?utf-8?Q?NDxf9zT33laym6uHHvXjCFCQTHQ8vWOoI+qF6cz9qzPz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13db2f0-d2bf-46a9-d866-08db0862ce9c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 16:54:27.1915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TI6XntZKEZIiUqaSO3zTD8YI03jX7WR9ELQG8UcMnqLs0r4R3pylJ5NJvFad5CL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch initializes doorbell pool with bar manager, which will
> divide all the doorbell memory into pages.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e04409210415..95017de6b23d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1837,6 +1837,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> +	/* Initialize DOORBELL pool with all of DOORBELL divided into pages */
> +	r = amdgpu_bar_mgr_init(adev, AMDGPU_PL_DOORBELL);

Just replacing this with ttm_range_man_init() should be sufficient to 
not use the VRAM manager here.

Christian.

> +	if (r) {
> +		DRM_ERROR("Failed initializing DOORBELL heap.\n");
> +		return r;
> +	}
> +
>   	/*
>   	 *The reserved vram for firmware must be pinned to the specified
>   	 *place on the VRAM, so reserve it early.
> @@ -1890,6 +1897,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>   		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
>   
> +	DRM_INFO("amdgpu: %uM of DOORBELL memory ready\n",
> +		 (unsigned) (adev->gmc.doorbell_aper_size / (1024 * 1024)));
> +
>   	/* Compute GTT size, either based on 1/2 the size of RAM size
>   	 * or whatever the user passed on module init */
>   	if (amdgpu_gtt_size == -1) {
> @@ -1991,6 +2001,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	}
>   
>   	amdgpu_bar_mgr_fini(adev, TTM_PL_VRAM);
> +	amdgpu_bar_mgr_fini(adev, AMDGPU_PL_DOORBELL);
>   	amdgpu_gtt_mgr_fini(adev);
>   	amdgpu_preempt_mgr_fini(adev);
>   	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);

