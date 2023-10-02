Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379BAE784BF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 15:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA6B10E2DB;
	Mon,  2 Oct 2023 15:45:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF0D110E2DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 15:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjNHI1wt0ieuNPrPiZxqsNB4nupD4LN3F6veRwXMKfIYNmH7SYtAIDM6aDsY2EKXafKsuNPIxx6c2YlGbEddM+7pYgDNMJOexY1WAsdhItybxGTS/jAq4UqVh58IJjR/U8e3KHsOvpj5pOtSwkRtjSwL6t7mEPcX/IEGC/okBq8QZQC+xl6QnnX0Ku+pAK+bUQItzKIpdPy0ozt8bxtuDUdz0ENKBQRVYyizPj9yleaEwykBMxt3097XgS+4f6nZcDKY3dWfIsxvxeAMG+x7hnmL5km6yeyz4AzxicigbTTI0hfl3WUB53+xq/1+TvpNbOnNLP0yGF+gias6/gUh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxv/DpptJSOd0M6MzPZkOkfXLv+b0UmBbY/j4M/nFjw=;
 b=LXl0TFobiC/XgCN2dJy6ZG0t7mwEoM7uHD0iaLyK726LIbTU/x/smcFPCVy5thu93wkpEtlJ48Lhumz+WyGmFKgjVqms415n5OwEKWh/fm3x1BhJa9dU5OtnlYtIlw/qgnuTIgRNtRQXItVTl+EsZgdAB8vNI0kslNAG6xty6wQ3pRxRaL7I3wMcU7vR9+BFLF4qLDbrKXn7Lifo3Py0xmSHsBNwXnQv6xa/yFvkwBzvySVBDIfeJqJlusDBBuiNWr/iVRMs68aziGEXpI9lC16tw/1mVZI/JYyyJm96Kz7MNwnmcTUKSbBnG6l13KWVbyXW/f2haFvG8AZmpm4s0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxv/DpptJSOd0M6MzPZkOkfXLv+b0UmBbY/j4M/nFjw=;
 b=wGnqU60D/RqDQat9PTcVAcot2G2vGbcmFDzvMP3SpJxmHoOFEkYcExCSULPBP356JjCiHmf0ycw5XrB0aOzNw086kDbsOIswf2IgOBZUBuaW2uMx0uLho25RfKGDt1fQA4X+xdmGskZSRGjZU9rQwFL4SQlUU1/GTQlZs/uo2FM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Mon, 2 Oct 2023 15:45:02 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::d192:af9a:25fc:4945]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::d192:af9a:25fc:4945%7]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 15:45:02 +0000
Message-ID: <ce2d3e80-dcc5-2e27-2489-3fa7dc720e82@amd.com>
Date: Mon, 2 Oct 2023 11:44:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] drm/amdgpu: Initialize acpi mem ranges after TTM
To: amd-gfx@lists.freedesktop.org
References: <20230929181856.2311515-1-rajneesh.bhardwaj@amd.com>
 <20230929181856.2311515-2-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20230929181856.2311515-2-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::15) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: f7735f07-9515-4be4-7abe-08dbc35e8a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJROp1gEKCP6eNhAQDshSD+pGm6zEIoymbo7W+/FQFkTftiFjMYcZUvL24vDukq9BFLmkDVFKEI80flLKSe3g8l3KcPnjMQfxbrxyYflMbp4cy3tl2wHmvVGuDsCckPxjRMczs1sYhWiZypGhvmU/B9QeYRayyng7vYcuB090CUdIIa64XYiIL1Rz8fjyySqBt6R3Br2+MPW99zVqly4Fvp9F3BaC/Ggxn4jYsSQzcPFrI6TEyEnglXJlyAcJ2udATSe9zMU1NEY6ClA4r13bRh+zsmVjnQIRGpACmZbQpDADVj1iLxygj0cTon+3Mb+KpstfAc1o7G1Scuw/HQQ7R/90fe+hc6CumrtsoJCVWqqTJyuYCY6V/t4rJXjInyTbs6sz7uyC7Zjv8qWeaMtrS9fTBnwfMYvQjdyyHFy1PEngGQSRoPBNPfy352WgftJsyE9Kp2ywyo1ulTrfiSf+9reH3eokkFekrFyg8jRMhk8lDCJcFxZSchjMQehCxhXK1xgqaBC92xZBmrsAdxwI4pSqcdCV44zm0M0+13ojhUASAkVjkq6wFh5PMFTTzaL1kjyPBQ7BWZ6r4z0ZTsYV3czmDLpXT1CyukglvHr30PXqb81Yp3k+cWZXOvATp3SaNJAwVkvB15HxFV6kggcoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(31686004)(86362001)(5660300002)(83380400001)(8676002)(4326008)(31696002)(8936002)(41300700001)(26005)(36756003)(66476007)(66556008)(66946007)(6512007)(478600001)(6486002)(6506007)(53546011)(6666004)(6916009)(2616005)(316002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01HU2owY3hRWEdObEZqR1ordXcxa2lKV1RRZG1McHJtUFFWeXlNQmJlU1gr?=
 =?utf-8?B?cU9iNXhnSDkvMFluL3lybFVKZlJoUzRDQ3dRMm9rM3BUY2Z5NDVPaXNPZ1k4?=
 =?utf-8?B?aERHTWxLUTFvd1VHbkJaRHlPcjVHamx2VGtaM0FLcUc2d2JSWDhXUXIzOFVH?=
 =?utf-8?B?ZnFQL1FzcGxYNFc4Q2M4SlFSOWF3SDAxekwrejBrVnVCd1J5NmJhU0JDWldV?=
 =?utf-8?B?UTc1c2IxdWVGMXMzN21kbi9rS2RucG8wU0s1NEhkSDN2RTNPWG5nb1dJQTE2?=
 =?utf-8?B?eVV1L0plQ1NLTE1tSFpVczZMbVhLYkgxZGoyZ2d3Z1BpeXJmZldwN0JkdlUr?=
 =?utf-8?B?RXNOajVqMVBndEV2WkRzMThlamhJQytUY2xVZVRkd2t5WFROdExXV2t3TXp3?=
 =?utf-8?B?bjZ0SlZ5U09kWFF0c3dxc0krRFFMMW5QeHdqNE1TSmlWYUlRcmtxM0N6SXUx?=
 =?utf-8?B?MldBVEZUL2J0VW1OODhwZTd6ZmhteWo4QVQvSzJUbjA3V3M3SEZsK1hUOXRp?=
 =?utf-8?B?RUx5SEd1bWozSGE3dEtSbnJSYXR3ZTFqcEZDd25QNUdadll2VHNJMmluZncz?=
 =?utf-8?B?U1pTYWtjaDVaeDcvS2ZWc24zak5YdFNTTWRzeE02Ym9mOGZNR1ZKOXJyVFAv?=
 =?utf-8?B?UzMzYUtpY0Z3MTRSaFR4TlN6bDZidFpocUJjbVpheU0rQS9qZTZEUG1ocC9r?=
 =?utf-8?B?M3E2QjIvcHZPYVVhMnMyTitrazJvTGFHcFFkYzlydTEzcDJ5cTVnYWFlS29j?=
 =?utf-8?B?NlZ0dFQrYTFoM1RwYWR0ZDBqM2pPU1hEVUFyTjVWL1R2bklJYjhPVDdveGJG?=
 =?utf-8?B?MEJYdjFYMStkbTRQWGpKTEIxMTV1ZS96K3BRekM4M0ZyOC9qMWtlcWMxRVB0?=
 =?utf-8?B?SlRwSWd1ZlFFSWFCa0RSN2R3bktzMmNWNitPejRlSlpGdTFvWHNzelZVUkFF?=
 =?utf-8?B?dEtvYWVZcmJMRUFqUU9yUVVrbE9SS3FKK0tZUSthSVY0bVRnUjVnZWdIb0Js?=
 =?utf-8?B?NXRZZFd6NWFoS01oN3ZnQ1ZjRTM4ampaOUd0cmFNYlpFK1JkbVlhL25jdnJT?=
 =?utf-8?B?WWRiZUZnY2pwU3p5dkpYNzBNQUQ1T0dxREFsdWdLM2I4R2xkUWJlVlMyazAv?=
 =?utf-8?B?RGV4SG9rUkJ1TzEyeWhzeW5iOEFZWG9nSW9EenRyNWRGdi9EUXFRRFREK050?=
 =?utf-8?B?by9sMFphOWlVRlZrT2JJS1U2Y1dwZS9kS05aMUVDRlVqbU5WVnhXUlZ0a0tJ?=
 =?utf-8?B?Unp1MXFDZjlLYURvMi80MXlVeUhjR1cxU3dMNmdMdEtpUG9UTks3M05GWDh4?=
 =?utf-8?B?ZzBCQW1zdHdzVWw4SlBCVVZtNkl3bHl2UFZxNldYOHpFNnA5SUU4cmhlU1Iv?=
 =?utf-8?B?SFh0VlZ3UGtLT0lHMHh3cmJOYWxwQ0VCbUtDc0R5dzNWeVVOWjFhdUUyRWln?=
 =?utf-8?B?ajZ5MWhJUHVOdHBkamJ1cXlDd0l2VzJsMDlac3ZJVE9OdlZ1a1E3ZTRXQmhW?=
 =?utf-8?B?bWtSdHFya05uMzBvZTNBM0dzUGJiWDVyRHFIM3dwZE1SZ3NPT3pwSXM3bzNw?=
 =?utf-8?B?WXdzakMyS3JkcmxBc2syYkNLVWFqbERlU1A5OUhFZ2w5Q0dSTWJ4RjJuOGtp?=
 =?utf-8?B?QWtvYk42TlVmRFMrVmJ5Yzk4eThFQU5UM3hNelVJNmZJekNpM2c1OEdRNG40?=
 =?utf-8?B?TExKS2VSdlE1MkU5NUFCMnBydHU4bU5CWkk4amRxNVlWY2tiVUo0SWJuZDVI?=
 =?utf-8?B?VVRZcXNIbGtGU0lZNmJxd1VwZjRuLy9pWG1WbGpYeGR5ZExpT2g4YmxqUDls?=
 =?utf-8?B?SHpybGNPV1diSzQxbk5YSGRibzk4OWo2OWUyTjVPZG1mZWZFc0dZTk5RazA1?=
 =?utf-8?B?TGdmejQrYThHcmlweWhKNDYyUXFDMzN1NUYxMTdORm5YYWtBRHBUakNPTm96?=
 =?utf-8?B?MGVrU0ZZSmxoVEFYWDBYRnQxaVM1dlRVN0E0YWhmWkk1TktGK1g3Ri9wTHlP?=
 =?utf-8?B?dCt1b2RLM2RYak5tWG1SNkxTN0tLQStvSm8ySzB0ZlJHQVovL0VBQ29rdmpn?=
 =?utf-8?B?SUVtSWtidTBHRFlGVEwwbithTVViRjNleDdDMEV0bWRvekU5S3RBd1F2eFpD?=
 =?utf-8?Q?SNMnEnxykZ5hhwiBDAvimPxqq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7735f07-9515-4be4-7abe-08dbc35e8a9a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:45:02.5031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HTz1+Ejk/hzfA8YzehrdOAcP2ISPhm5QKdIWgUHZ9yv13cyw9RJdX0ktRZkDfk+mIyHNlOz6+KXRbByUsFf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
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
Cc: philip.yang@amd.com, felix.kuehling@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I found an issue with this patch, that leads to performance drop. This 
leads to incorrectly initialize numa pools on a multi node system. I am 
working on the fix and will send another change set.

On 9/29/2023 2:18 PM, Rajneesh Bhardwaj wrote:
> Move ttm init before acpi mem range init so we can use ttm_pages_limit
> to override vram size for GFXIP 9.4.3. The vram size override change
> will be introduced in a future commit.
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 268ee533e7c1..005ea719d2fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2190,17 +2190,17 @@ static int gmc_v9_0_sw_init(void *handle)
>   
>   	amdgpu_gmc_get_vbios_allocations(adev);
>   
> +	/* Memory manager */
> +	r = amdgpu_bo_init(adev);
> +	if (r)
> +		return r;
> +
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
>   		r = gmc_v9_0_init_mem_ranges(adev);
>   		if (r)
>   			return r;
>   	}
>   
> -	/* Memory manager */
> -	r = amdgpu_bo_init(adev);
> -	if (r)
> -		return r;
> -
>   	r = gmc_v9_0_gart_init(adev);
>   	if (r)
>   		return r;
