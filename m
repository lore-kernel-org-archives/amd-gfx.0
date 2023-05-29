Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71EBC7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 19:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461C410E127;
	Mon, 29 May 2023 19:30:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0950D10E127
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 19:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EChe/sScQUGimBVMlC1vHTYhT4E0ln9gAZGE+q4sieTejOBRMUOJS3gTUsOrkQOteJfWzDtV7OfKTURxCaCyjyvjkSWJSZuR1LQUiLPRADnUTsI+Xr2O3EyHD4QB1Y7oLe68js0tZ6x6k4u7Uu2Ip9lXPXaJhH85ACp0UgZhXwJeZ3FAMDHHs12c1ZI0MAGLRTHEU13rYRG0K3nTKnZHB0e4q3j3RVVDPT2vMmwZ4Uv7vbyqPpy+Fe2bD/xJgkEmTbOKESaPW+JrWjSHRifWmqXasJWOHzogj+h8UENpyhpFKB4yfMVsUpSnfHJlwcqLy7NgV3lH1StFiFjgDR6iTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VRgJinT10jP4UuqSjwiWkpUYxg6r8YBYvlbUcAnft0=;
 b=JzBm8wyqE8OG5d5319SRfZlwc6/pcP7yh2OU29bbRrcfyv9dLNV4psw6TaplQaGAoKslZ+5pUlT1tmrWuslePcVApsrshQJOjfxhRSJXInK6292NUv5DFSAy5h9wcTSzCzJH24lGnSHaMmiCgx72uRNTlj/QiwHwaBAPnr/OmqHahoD4f12AYWnlGTGmxB9CC2/8/JBizeVrSGyd21dKiKpImNyWABhz6oN9sIKSol6V/ZGeJHyZvo0W2nt5LLoI5GBWFaVGVRK5DwVkdVx/5FLEsJtH4C7Z+fnQyCIp2T8jbh7yN4DXCY8JgmnV6jIjOyi9FylfMp0vEIncPCfMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VRgJinT10jP4UuqSjwiWkpUYxg6r8YBYvlbUcAnft0=;
 b=xpDwUJt4Wlqjtk8TB9/IdhnSCCMKMcSuqsr+CC+vVVpcHZ/hbWNFXnC+bwOvLVIiWEvHOSyVoGEEa9hRRK5rtAITkMRnBwLoPySnZU35sWJaBDngpzPLyIzNFtSowNUg4FHsMPwalM+IlxvlpDuxSEArxGZkHYsDU1RpXWi7O8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 19:30:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343%3]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 19:30:22 +0000
Message-ID: <abb2b39d-0206-70e3-c8b9-4d3d4f852a41@amd.com>
Date: Mon, 29 May 2023 15:30:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix create_dmamap_sg_bo kdoc warnings
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230529192201.2133174-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230529192201.2133174-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::39) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 573be1e8-60a9-40ea-985b-08db607b24e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tG63A8JbnIs2DnjZVVhGUW6Sl+0cEPD4xwBgZXt7az03tk4ldFspZ80eVub7av+kxYVzI5Emy50UZqEO3ej2j6oZUmh4d0t6A8+aWrHJUMCirDFJdfvWmpUuV96ABA0K4VeE7nacfejwFhW+3N5m58qMnguydj74tX8aev4w+8LMUh7gHOygXrIFwjJxJuKXoyYUar1IQYlikysd61sZ564aOElI0OQx1ib4wooz/eU8xLVnT5jANvnh9biD8xN+JhT412Er9PuJTUD3Zf5LHuxLdwvAOtHOpBKTCVNhW4Bfl1r47CRKkV83O74jyM6Lmbd/OnfPye2yq52sKBmIbrg5WLY3ok7Uj72mZM+hAhdfO+bR5JNj8mAG4KWkhrDxYG9O3b65PHC/gqZUGgLOZlUxRc5pPk/Dwz+peJwIu5tZFHLGPoxvUZDJKriakStWmJLBMinBUajl8oFeQgCUM7kpL2PRTsmXsIemQ8Qfx3IO564Ui2ef89zE/0q/imZjKzkR7R02kDowNxG9Ww3uOnWFY10jm8oMU7M481Lk098ZI51zpQ/QY20nf9xKnznxy/61ZBMfMEOCnqNTJ16hsPBMVoioEl5tNXa0ZpGSQaqXEIzOe4kcecdQjuCI8fUbKUv5sbzVuV/KirOm8HxmDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(83380400001)(66574015)(5660300002)(316002)(66946007)(6666004)(66556008)(66476007)(36756003)(6636002)(4326008)(31696002)(38100700002)(41300700001)(8676002)(6486002)(8936002)(86362001)(36916002)(110136005)(53546011)(2906002)(2616005)(6506007)(6512007)(31686004)(186003)(44832011)(478600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2MwY3ZiM3ZDMTNMZDFYMC9sc2hOTktBSEdlWmxXVGM2WCtDRm9oNVVwWjlS?=
 =?utf-8?B?YTJVUmVveXB0c0YweXI2VHlGWGJkSThXS3h1VGVmT1FiMkZOR2pJanNZQnNQ?=
 =?utf-8?B?a2lucWcrN1VtTmNwdmdkRUFnTHNiditXOEk5Qk9aeFFJUEJVTlVmL005UUpR?=
 =?utf-8?B?bnRsT3JuUndZM0QvUitzTFFQaGdXbjZiMVZsaGhVelJxd0xlSWN5RGdjemVT?=
 =?utf-8?B?bWNGODliWVFHdG5UeHVEczM5aTRMOHB2dksxdW9pUE1Ud21IK3NhZ3RMTklr?=
 =?utf-8?B?bnlCNC82VkFnN1NJdWlzVzlOUUZIQThUcjA5TVFuTTdsTFFlc1ZId0FSVElz?=
 =?utf-8?B?TkVXVG5SNlc5YmlhQWluL2M2UktGUUQ3MzFCSjcwTEhXWTVwR0RBTjUyK251?=
 =?utf-8?B?c21tYjFRTE56NU4vV203aVc4T1NRME5oZnhjTFJMSGxJWmxPZkJiaDlsMml0?=
 =?utf-8?B?Qk9NWjV1a0l5S2FBN20zWC9qWU13Q2VPVWh0TkFxbElsZ2JSYkpaR25xVFRX?=
 =?utf-8?B?K2V6R0VkUTJ4UzBiOTVBZWdXWGZKaUwyeHd1Q3RNWDgvakhjbVJaRU1ZNmNu?=
 =?utf-8?B?MjR5SWllc1VzMzhQYmNURGpET2VTY0lLTG1RNU9PZ04ycURmVVY0bkw1dURo?=
 =?utf-8?B?amttNEVJaFpFZ004NjRlR2daRWdsV2Y5SHhpZ05mWW9xOERtSXhQREtRemhW?=
 =?utf-8?B?cXNLTnpBK3RkK1FaQ1l4YTYvVDBuVklMOEJDWW5wMDZmRCtVOHBSK082cyto?=
 =?utf-8?B?bHdSaWdJV0Rjekh1Q1o2QmhzRFRiYTRhZHZjbjhRMlBkaEFUM0hqcyszR29h?=
 =?utf-8?B?WnlWRHVJWGg3V3Jxb3B1QnlqZHovc1FqZUxNNnIvWUZCV1M0d2xFdmNYWTcv?=
 =?utf-8?B?dVJPVWRlNjlaRjRVQkhrVzA4NHdQNE9KZm1Od1BUeTZDQWdQRDM3V0lZWlEr?=
 =?utf-8?B?Q09Hb3IvaUVzc05SMXh2YzlsSU9lZ2hIQUFrbmxJb0NxVGVhbVk5SWJoaDNu?=
 =?utf-8?B?SS92US9haVVRZEUxUHh2Rm4ybWEvVGl5UmdURG80QTdta0YzUFRrdElQWnlu?=
 =?utf-8?B?d3Z5YmFXL0NFN1h6ZUlwWkRnWVFRbXVpZVlrTDFFRlV0dElFRTZIZytIazhX?=
 =?utf-8?B?M3JlTE01cS9EMnhSTjEzVkx1ZGVKUmI3TlJnZ2d6enpDTDA1RU16RVpkaC91?=
 =?utf-8?B?WUdvc2xVd0dlK3c4SW91SXRNaVVrOWJuVm5OM1RGWnJLbGVDN0VWSmc5Nld4?=
 =?utf-8?B?NWtHSWNBeXk0eGdHeGRCWHBaY01zUjFhM2gzUmJ4eU5wWFRPZS8rNGlZRTFl?=
 =?utf-8?B?SFhtVkw0TzRlY2xWK3ZjNDk5Ymd5bzhCKzBwWkhlWHd1dVBIcFg1WDJidUc4?=
 =?utf-8?B?cW5WK2hpU1JrbFZ3U2ZxYWVJRkRxSDBjeUlPTU52bFhHQkJoM25nTXpIWmtS?=
 =?utf-8?B?OGhSdmhuRStRRmwwRngreGxSRkRyU3M2eHpMVDJsb0VCR2ZnL1laQ3AyNkpp?=
 =?utf-8?B?bUxacnBYeDZUZ0t3L05sc2JJY0QwVmtSbEZmN0h2MTR4VGNEdUNPdDljY25I?=
 =?utf-8?B?QTIyZDB0UXpGR0tLd09aQnV0S0c1TFJSL1lxbmNzVnk3QXZpUUFWM3RlRFJN?=
 =?utf-8?B?NEtqODAvd3g1cm5id3ZSelZ6b05sZHFJSFpKQkxEKzUrbEh5QXhPWmtEWlBz?=
 =?utf-8?B?c1U2VzFZSkd4U1hYZDZidUxMUVdSSnNFdVdGbzZkcjl6NVB6OFovMFVCTDJj?=
 =?utf-8?B?WFhFcEhDQlJFZFllVm1sL1djdFd4L3NIaDZyUG52RDJYNjE0cXcvK2dpVTAr?=
 =?utf-8?B?b3l5bDl3ZDlQa3hKU1h0TVRFRDFKY3hxWlFLMy95NnUwZ0g0SitnYjVLN3NJ?=
 =?utf-8?B?TTk0TjBGOExrdEY0Z0lWWXRVejF2T0o3ZUZHYnhHOUNvWDQ1SlZxN3IrOFlJ?=
 =?utf-8?B?T3RqcEtsS1RSL3dUR0xEeGdkMC8vYUdJM1JiMjJEdVJyRlJwY1JTeHc2Yllh?=
 =?utf-8?B?MHh4OWl3a0NMMm9JVkdJNjhEZm5DREJSTlpkQ2diNytRaDl3UWxhWWg0b2Nx?=
 =?utf-8?B?YmwzcnpFY0xhNDNoNUJhKzQ5Q056S1hFMVE3YXEyQ0Q3dTM4dUFOeU5YQlpL?=
 =?utf-8?Q?detUYS6s9epj4++SmjyCAZNWM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573be1e8-60a9-40ea-985b-08db607b24e0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:30:22.0894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7SE/nsW/EmooQm1uisrdGvtB7isX5d41B8cLc0CUETDmbRomi0DcOK+lE4/2jN65nXAM/vNdOgDYywPuNJ8vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-05-29 15:22, Srinivasan Shanmugam wrote:
> Fix the following gcc with W=1:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:292: warning: Cannot understand  * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information
>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>
> v2:
>   - Fix "@create_dmamap_sg_bo:" format (Felix)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cd5d7a39ad0c..e73cbe126286 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -292,8 +292,9 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   }
>   
>   /**
> - * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information
> + * create_dmamap_sg_bo() - Creates a amdgpu_bo object to reflect information
>    * about USERPTR or DOOREBELL or MMIO BO.
> + *
>    * @adev: Device for which dmamap BO is being created
>    * @mem: BO of peer device that is being DMA mapped. Provides parameters
>    *	 in building the dmamap BO
