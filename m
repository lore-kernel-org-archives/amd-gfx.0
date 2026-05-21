Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7656CD5BAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 14:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F2210E012;
	Thu, 21 May 2026 14:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1BLvcu/x";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257D010E012
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 14:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aliSPSPxrMvBDci1hBuEF2vB1mXLGZoxFpl2ITBEoN0Tdx3rW5MdIXG3qVrPj+eiTysZtkIOq0Xl75Ni6OyVx9P8mIgcTqCjrm5vzyIkgNT2PKn9OmsEHoKHXfRCVnjL+WKA/B87ZC1WTAe+HWCoRg6jO/iQDhOfs39mm8Uha7qya394VT0wPrzZ9VvtY97aJf9u+N0pkafAnHTIGxvhXkeQ0TiSaFSIEjrFpoJXXqd/ShcYxuYEjlmMEzc7OE6kufeUODbM0gC+ikF423by2cAXG02B6LtvDWXZrZ9jZKKXKYu8vJyN0lOqX86bFSEZsz4QCX6UpU4PW9GdVkKG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaMbY/C2FIURBb+n0NxXtVc354X0bCLE8gRsQ4m1KiI=;
 b=TmhKXsnyVruyuDaeIC3Xhqo3qaBXIUCDFn8vI7+wl2WF23c4FdwQVT3wu3L/yQG1nSofO4d6Sp08+aF5HeItWjXX66BtCyYp5sl1bM0IkbN5T7ZV5WWu6HARw2qTj06q+B+y8cEUG6Ygk86i97ZTzHhINJvFA8soyabFbts8gdBU5zyH2lId93BfPu0T7B0AKfWokvJI0+5+HU45i6YLPr07aMqon8uHRXpe/5f+hUh987jnPONLVCsJBUhyiWwemLapvxRly5Bw/ttxeqOg1QkRuafco1AxLyvr3jKbJOr2oNh0kiENtxCDfRzmCBv8DMoKVOTW1whiyot9SkhC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaMbY/C2FIURBb+n0NxXtVc354X0bCLE8gRsQ4m1KiI=;
 b=1BLvcu/xmTo5EvgPg+hPfIzfJRNRhj/eXjxg9Ef3dZN17CtDyw9rjk+MiAhuDQOFtCO3Ey4WusN2GZrKgfLJh5Ylk00s6I6te9UQpBL/OsIX/hvskxaut2anG4Y56z8zbpqBJddguF2g9Kb54zprvZlq9nvht64wvhKn5zQFSmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 14:25:03 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:25:03 +0000
Message-ID: <4c4e6a7c-2688-4f7d-807e-11a319f19c42@amd.com>
Date: Thu, 21 May 2026 19:54:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: drm/amdgpu: Set correct DMA mask for
 gfx12.1
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260519222524.204872-1-Harish.Kasiviswanathan@amd.com>
 <20260519222524.204872-2-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260519222524.204872-2-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0239.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc7fa76-ca95-4262-68de-08deb744bf97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: e+sqk/n/ONY1KxG2dRWis6BQ+n5Q1pPqz6eyVHMRkqhlBzQBxHfAyDQuDHED88wPrEkgD3pV3MahSh3jQ6LBsINpEIiGYLLI4SBE7T5FrUpPQnrC2IAJjqDgJyeCgxBoDUo/qt98gQkFstPvbBEtgJbMyJ1mDH40K8cI+I6LfJx2/vtpYB//LEMmIYYU0/xY+ozDOWYznSHLyfY2xuj4TlThwnrd4ZP6utvi7Pu6nAAYzCF2Z3v4iKrb63xa6elXEfTRn9f0NBJa/QtczNNzbjjsuPve3OaeD/HP3i9eYFfZq3QsSCDYju1IwCNURWHly4S1Iyt1CsKWL3AV+S2n788MwenO6azsOgbZ8Ode5W9gKUtiScV+DAle7meNwoJ+f2nInRsY9WB5YXmyiALE/6IPrZFaRXW7UUB3oXOVZbnT9pnL6o/y2dDtXlfBvlEdaGO+/0t4pUltd6tfyeNWBLVpYxFjPBfFvSo3jHeIsecINkbYeszlAMTnykHalJbHCeo5apyAqny4rnyRkQV5a/mhU+3LGGg5tivRaKM/MZhSMEDmspRFy2PVrwTlo5Bv1RqycABVzdtidNb9fEqjN8yWnU4Pm/AtZlIDqR5CRXHmx41N3yEgCCsK2agM9ymTIYpbVEoo1hAO17K8a1hIUky0QOXWGXjYjg9NPCSgIYs/i+l1fHrNrFDDIoR1g6LT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEovME85WnNUb3NsZVhZOERNSmhqaUVuQzI2a2J6aGtwSWlCR1diRy82VXI1?=
 =?utf-8?B?OEcvK0xPWXd2TnNjQ2xTMTY0UWVGYzFRYTByeDhQOU1xMkk3VW1YZVBSYURW?=
 =?utf-8?B?UytQR2N5N0IyeGE1a0VOVUNNMVQ1NUk2RFNFYW5xdjZvNUtiMGh0a3Z5bzB3?=
 =?utf-8?B?R0VPSUU3M3FGQklKNjRQSFh1aWxiWVRjd3hIRndvWkxpaytCb2dDWFdrTDU2?=
 =?utf-8?B?SlVPVUNya2hKSU9xYWRRdUIwL1ZNRWgwL1JCUWJpcDFJbWdNb3lJYi92eTRK?=
 =?utf-8?B?Z3RncWU2OEZZWm9HbHhia1pwMHdCNEhrNE0zMWpmWDB2elN6S3JLMVljdzBN?=
 =?utf-8?B?WTVtTGc1Y2RZdXlLMStkaEtTUmxUandkVmx4SVJGbUZDN1daeUJCZjRWVWE5?=
 =?utf-8?B?NkxUMmxrQ2JjL1RTa2VyK2pGOFZSbzFvbjlwOUV2SlF6amZUTUtCKzZNMWsx?=
 =?utf-8?B?WjhIZmlnRjByaTJ6aVQwcjhhNFcwMXZuQVNXWW91c0o1SU43OE1QSnRCTk9V?=
 =?utf-8?B?TG9iTjNXdzNpZGlEK25uS29xNlNiUlJsZUJhVXh0K0Y4NDNPdmJZMkZ2TGRP?=
 =?utf-8?B?Vk8vZnB2cDhnTlpqaWxzbER5YUR0VzlQL0wrZkRUOExnUkVKRGtHWlpqRHBm?=
 =?utf-8?B?Zk9td09tTFFpMWRJeFBhVzRGWmMyT1NvVHA1WktIdStqZXFuV28wVHk2ejFL?=
 =?utf-8?B?ZlZuVjU3MnJtM3BZUGx6UUsxUFRVMTlMVlc3SVBPVGI4cTFySWVNYTFKMko0?=
 =?utf-8?B?OFRIUEE3dDI3K3o2NEQ1WktEaXJWSUxrUkNTVks4Vi9hYVVwMk9MNVdBbWFs?=
 =?utf-8?B?S015MzQ0cE1IOE1yYXVPK2swZXM0Qy9LbTNscDd2MnpMSG02dTdZbFJSWm5h?=
 =?utf-8?B?bE1NNGZCbENFcEtaNVg5NldMUVh4Sm96cEQrc2F4L083TlNKT25pVzZxcnBx?=
 =?utf-8?B?NEVSWWpTU1JxeFZYTnNCRE45eXRsT3ZSTVU0cEtMTGxhYzN1Z2IvcGVVN0VZ?=
 =?utf-8?B?MTJORDZlblNHa0ZmTFhISDZOTE1Pc2pSOFlnVFVwdUVlNDFLRVNTVXYxQThv?=
 =?utf-8?B?aEIyL05UL2l1d08yc2dFdW5jRU5WdlZBSjFuZEFCaURrc1IrdjBDS0R0bUFW?=
 =?utf-8?B?N0ZYWXZieDM5ZGpDcHJ1dG5VQ2t3YUEwWTIrTGxoUEswbnZlVmw3b0hIZVNO?=
 =?utf-8?B?b0Rob2lhTWdKK0dIR2VCeHlPQWMydXA0R01FSUtiRzVteFRqOEVtY0YwVy94?=
 =?utf-8?B?eTdlUXZhaWV5OXRlQ2Z5U0h3QTF1ZDhyWXluK2FKMjVSQ1BNSTJkT0JNdlF0?=
 =?utf-8?B?TDZyTkZYaEEyV1lZU0hSNzhXOExhWU12Q3VkMHpZbEJUMkJTNGlpdTFpU0gr?=
 =?utf-8?B?eVdmWXBVaVh6U2FGLys3eFZhRnQ2OU5RMXhGb295VGg1cGx0Sk5JTlNkK0x0?=
 =?utf-8?B?NnJnRG9zY1o0b2hNS2MrOWFFMEhwdlN4Rkt5dUtTYkFMcEZzTW8wMUFZMk1P?=
 =?utf-8?B?MnNDTXlvMkRpRUpKZmZSQjBCSTZWQ21Ud2ZnNkM3WTdVT1ZWbXFVbUlYS2RS?=
 =?utf-8?B?NnVuekJFVjlMcytBdGM4eVBWQ2dQZWUvSkMrdHl2bEJwWndpMys1RU5vM3JL?=
 =?utf-8?B?L0tUWkhQQ3gxK1pEeFRwdjRaZ2tvNW14UzlVNW5Ed0VkdW1mVUJWQlRzb3J4?=
 =?utf-8?B?SlpGalBPdDVJUis5LzdNekEyWnlQaGczNjVXUHFIOFVob2NZRnlqbTFxZEpw?=
 =?utf-8?B?ZmRkYlkvTGVJeGI4TWdnNHNaL2N6cnczZlo1WkY5TWlNWW1ZNjJrNXR2ekRI?=
 =?utf-8?B?N1FnM3hRaGlySzNaRVpEWXJuM2pFK1drelpmdFNvbzM5U3lwTXhhcjVIYXpF?=
 =?utf-8?B?TXpFbFlXdElpT0dPMEx6aWFtTGZZdHFBTHBodW55Q0xnN1YrUElwemdLcUZZ?=
 =?utf-8?B?L3l5L2s1NmNxK0lJWTcwem1NSEtadFptaU1QeC9lb3ZYVWNMRDhOd3Qya1Bi?=
 =?utf-8?B?MGtZMzhjQkp1Nm94ZkM0c1htV29LWE1UbXdZU3pJZWp2TmJSdjBnTHR5dnJO?=
 =?utf-8?B?a1ZLQlJWOUE0UGdJUStmVndBZXJNdjd1LzdVWWpySVlUYzk3VjAvWnBnaFRY?=
 =?utf-8?B?UGlzUldPSloyck94MEJsWng0VVE5WmZndzBBeGhIL3JGMmtkRWdJOWZMaVVD?=
 =?utf-8?B?RHVvRVNlYm5iRTZ2QnhuR3lWZHdTRGZySGxrZ3ZDZDhUYm5wekZzMHYvU1hx?=
 =?utf-8?B?TW9reUl1N1pyKzRNUFYwd3o0cFVBQlMrS1prZ09zL1FIcGd6eEUvNUhMWUNy?=
 =?utf-8?Q?OfQuPr7uf4Dc74Gf2p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc7fa76-ca95-4262-68de-08deb744bf97
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:25:03.4660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckqp2kda5Qbkya+wh9PpIJ1zIrrHikkWaIY/YTTHADkP/1eSvDod6dOBqwlsU8n3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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



On 20-May-26 3:55 AM, Harish Kasiviswanathan wrote:
> Set correct DMA mask for gfx12.1
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 0052a40214a4..eaa1d821a9e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -811,7 +811,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
>   
>   static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
> +	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
>   	struct amdgpu_device *adev = ip_block->adev;
>   	uint64_t pte_addr_mask = 0;
>   	int i;
> @@ -844,6 +844,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		 */
>   		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
>   		pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
> +		dma_addr_bits = 44;
>   		break;
>   	case IP_VERSION(12, 1, 0):
>   		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
> @@ -857,6 +858,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		 */
>   		amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
>   		pte_addr_mask = 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
> +		dma_addr_bits = 52;
>   		break;
>   	default:

Sorry, just noticed this default case. If not expecting to come to this, 
better to exit, or use 44 bits as default dma_addr_bits.

Thanks,
Lijo

>   		break;
> @@ -915,13 +917,13 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	adev->gmc.mc_mask = AMDGPU_GMC_HOLE_MASK;
>   	adev->gmc.pte_addr_mask = pte_addr_mask;
>   
> -	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
> +	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_bits));
>   	if (r) {
>   		drm_warn(adev_to_drm(adev), "No suitable DMA available.\n");
>   		return r;
>   	}
>   
> -	adev->need_swiotlb = drm_need_swiotlb(44);
> +	adev->need_swiotlb = drm_need_swiotlb(dma_addr_bits);
>   
>   	r = gmc_v12_0_mc_init(adev);
>   	if (r)

