Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A94C7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 20:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11D710E8BE;
	Wed,  5 Apr 2023 20:29:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 641DA10E29D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 20:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioJq6fl6mOmzM5SP8cLlGs5O6gPDkgS5/9PnVQidiwSrB8Y/M8wbfDL9Q1JNUhQMmaMdEMZeV6zPCbOhqQXBKYuEacWFfQaXXdNPjGQheYZAXVyH1bKkHuHE3YXWQke0KAgSpVbNzlpogYgqr4yHDoqBiACIEPNcRxXfUCq6PHjREejEx4WXmw38tvCR0OTPOLhnVSoGbJTAtKMw6gcSQa3caEmW/bU9vGEyH4cZqRSSQeVDOn6VMqvNr2QGBHX3gK457bU9YnTOiJkCGWOGZuKogYlhfmM/xqIEPU/3nS82JjJc117lmcAihNU7xC1Gle+tKvHqdHcKN7EnD9pMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaEal6TacAXD1Cf4TGEbzxE965PjT26b8BIODlzsnXA=;
 b=jfT1lALAxN1+1D2V7+fI6Hfk6qBPxa08pGKvyRNh1YoXAnKD3BU3FeLilreov723+5N7q0/608uxGH7dg4qOduNLN83Je/yd/UV7jS+/tOn0l8l5YZ3/LA0mH9l10aB/lYd79Ri4vn3poZNvsFez0TZ6jJKrxmT9TpABBL4EfeolaXl5pPspXmtQNlr5md01fSNSLFy3dakn5qPcCCh+bMuCxrs7LeNRgJoNcd2efP7h5oEGKfjRmSryn6yfuj+6P1SWXGXddLUBpBqoI6rxkBNhXro5yRyB6+7STvBIYX93x/f1KsyBJ6GMumojW53UrIs0SZ4c7qxe9wT9qCwPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaEal6TacAXD1Cf4TGEbzxE965PjT26b8BIODlzsnXA=;
 b=kZhwgjMTO8NlDLO89T0KvpxPAVfteQdi97EdBUc1dTjI7Z9BIk7fijLVHNLwWWx7zd7+brDyvDkDUnpGOaOQYr4Ne1kZePGvFvFOo0dBNUoqVvDjJXgOWxFsWKn6rft8vIYqEtKZyrpdoglddc6mBeC4BcqtZxq322jpHdUdS9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 20:29:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 20:29:10 +0000
Message-ID: <3a8e182c-f103-52eb-2745-7780b1aaacb1@amd.com>
Date: Wed, 5 Apr 2023 16:29:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] drm/amdgpu: DROP redundant
 drm_prime_sg_to_dma_addr_array
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Philip.Yang@amd.com
References: <20230405153121.3324620-1-shane.xiao@amd.com>
 <20230405153121.3324620-3-shane.xiao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230405153121.3324620-3-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::32)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: f0966666-5036-4259-af31-08db361469aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdFwadekzloAC4xtDGtaCFFLS+n74Fps9giALXwz9/6NmGHTSNhEcyYHsEYc/6OWLZ8wmUBXI88nUw0WuDXLa3V39C6ZLf9a+mpHMKS5bm4OhBUM7YOUk+zc+yskhS5yxoZPpo4dGWaMCOZLBXgJjsVM8Sj7N0N6J6vyBXdsNVVU3dBK7q5hMTAFSlDF8CfZMb8zfBVo65UPvgDC4iZEGLJnyNi1OsUaFx8mGljdb+WzYPG6rbwKNje+hxYeWg5i1XV1guQlz5Wv0MLUZodayFAEhBlDG6HJXPc2O1xXPj8N7yKbbgppHODpxWsocbis6dbpE8XJFiP0zGpz8sEvenj+QT/+YRxqeSp0oIufbRAbKy/yDOtvPb5fBaWXVWPRCUV9Fn91UJ1FxWWMTnraz/mNcLzGr2mRbDiZu0bR9z1RYgChJv5tWdCk2T1puMP2noogmzeMXiE5C7CBTNoqMNfVqoAg+9F0t5giUiS/rGxAzYY52amp8ohQ+SeLxABgeERDN7wuXRMtZT9hbixhkuytl1JPS1omoRxpHfSqvJ5Qhygxv70i8jKxhzv/CCPWBy+ZLIGSMEF/K0VnJl0F6R22iBZtUtok4eWIbDvaO9yoY+t/PeOwbS3bu9GIrUIFJOnM+6Eo35khCYcCrT87tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(31686004)(2616005)(83380400001)(186003)(53546011)(26005)(6506007)(6512007)(4326008)(66556008)(31696002)(66476007)(8676002)(38100700002)(66946007)(2906002)(44832011)(41300700001)(86362001)(316002)(478600001)(6636002)(5660300002)(8936002)(6486002)(36756003)(36916002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU5SVkZrb2RHNnNTZjUyMFhQV2Q2SXJIWmR5Z00rYTh1aW1tVm04QTI2aVEw?=
 =?utf-8?B?S3d2V0haazBMdFNUYnlMN2NDazJkbkdzQ25PRGtpT3hELzZtdXRiVHNvZzlo?=
 =?utf-8?B?MzZwVDlvUklWU0Nrc2o2bGlzN2dZQVdNK3J6WEFmenNsL0J5VEY4SUlCWitF?=
 =?utf-8?B?ZlRzZGE5ZDBIR1ZOVWQvL3Y3OGxMdEZOZExVQys3RHJmaGZOVXRaVjcwNGkw?=
 =?utf-8?B?ekkzRjZjbWM1dXZ2VlJkdjVLSlZOdWhSVWJDSHUxc0JLK0xkUlRIVHpCbS9o?=
 =?utf-8?B?Z1FJVW80cVhXRll0V04yZGhiOWZxbFF1NUc1RnVNS21vVmREbWRvbVlzcGVa?=
 =?utf-8?B?QkcxZUVtYlJCQjRkOHR5Rk9TOEpVM1lHdExwVDk2ZjI2cGUxdjJOTmJoaWxt?=
 =?utf-8?B?c3hrWjRuNmNJMmYyb01laGhyRm45Q0xMZWduZHFjMWV4Ty8vMm5qTGl2TmNZ?=
 =?utf-8?B?eElqZjF5Q0F2bGNZSlVSVzhLNVRSR2gyeThRRWJOUVVLRklHKzZOOFdEOUcw?=
 =?utf-8?B?S2NNaDBTYnVHNnNrUTlFcCtsMll4cjM5Wkcwc0VVZytOVzN0aE5uNnBKUmJ2?=
 =?utf-8?B?SFNyOWovQjVoV2l1MkZhRkhhYUVkWFdaS1h2ZGRzMG93OS8zTlVmRjVMVDBz?=
 =?utf-8?B?R1JLSHVlQzhlaHprY1BVWHFkanQ4U2ZCemh1ditBdjAyRTh2ajcvdW8vbHAz?=
 =?utf-8?B?NzQ5Rldqd05xOEM0SHM3WHRGUEZ1WHJFeHBMMjRyaTIwMXFjNGppT1VwOURW?=
 =?utf-8?B?NHQzTTh6QjhTM1ZIM25PdDZUNDNRbXFaVXpBcWRYbU1ud09pVlZsdDcwWUNW?=
 =?utf-8?B?NWExVUNYQ0lRTFZld1N2cEZBVUVQelZPSWdpbnlFbUNmUGhoWUhMeFZMQk5l?=
 =?utf-8?B?K0NsZzVCOVFSZXpNd29mU29ydWNzUndCemJGR3BXRjVUNDVaR2k4YjFIYlJJ?=
 =?utf-8?B?ZVZiRjVCMTducVdYVVQweVo0bExZOHd5d3loU2VZTFNZWVRwRUFmR2xoWDlF?=
 =?utf-8?B?aXd6UGthYjB6Uzg3UU5ic3RpcnQ1amxTRGVRa0pGVUFseEhFOFR4MExLeEM0?=
 =?utf-8?B?d0ZYNnc4dkhrSTBwV0ZNTGw5dGMydGRNUmtUbzRBRG9PbUFLTDNLOGdlWUJQ?=
 =?utf-8?B?a1NwMGhheXhoSE9VZVVDcmFjc0ZlTFBJVFZmejN3S1RhSlF1ekt1MUhmb1c4?=
 =?utf-8?B?Mitkd3dULysrcTYwa29SV3EvczNocENaeitRd2dJZkVqdnJuL24wQUExWTZB?=
 =?utf-8?B?Q3F1UjYvSldnZW43b1NvYy9kNnhIU0xSR3c5dmE1UkpCcndreVM5ZVBEaEhm?=
 =?utf-8?B?QWZFM0J1SDNieEI0MHgwWXY3eVNQL3diQ2R1dWFlOVVQQlFoWmQyU2dySWJ4?=
 =?utf-8?B?eUtKRFBuYXpzaExSVFJtakFCT1hZZ1NzckkyZHRsNjBuTWNHRnhGTGlLNkVT?=
 =?utf-8?B?eEtWUGkxTWJOR21BdVgvUlJLMENFeFAvQ0h2ZVdyNXJwbGIrWWNNSXdyRU9l?=
 =?utf-8?B?MGlEWXNad0hBMjBiZWF1WDlKZzhRN0pDZ003cW9pOVBLd0JRVFdvUEp6YlZz?=
 =?utf-8?B?dnRoSEM1LzZiUWgxeHFHdHh2Mm5HSExkZzBudTBVZUs4dHdTRm9qWVc3cVVK?=
 =?utf-8?B?ZC9vUkdBZ1h2VFhVZVU0WWdqRHNwR0FXMXlTdTAvUXltRUpPVDhBRDNTUDRn?=
 =?utf-8?B?WmJUM0ZuaWRtSzQwZWMyb09ONUhCTHJ5Vm1DV0pLSXJQVjZVRXM5enptTE0v?=
 =?utf-8?B?ZTdBUllGN3lVS0lJU3Z1WlZwL0pPbTlDLzJWOFg1OXY3b0g3KzlqNmhsRUd0?=
 =?utf-8?B?QXpscWhockE2V1BISnZkV1ZTSTZPOWozT1RRNkdmSCtjUmVIU2JFOUdpeDdK?=
 =?utf-8?B?Nm52M1Z3Tm9CenBXWndtMm9GOG1xTG1DdG94TFkxMU1hZk11TTB6TUdGeWF6?=
 =?utf-8?B?Q25ET0I5Z0lZOEduY0xFQWV2Y056UmV0RlJRUDRSZ2lKcXBUWHRFVC9PWjRO?=
 =?utf-8?B?UVl6TkFreTJKTDdXcExOZjAya1dMejhPNzFtYURMOVE1UHlXSjVZTm41VGRz?=
 =?utf-8?B?UWRCRy9LY0cxeFVURDZ2YVR1bHdpT3V2cnhjRk5pa2VNcXVudkd3YWorUCtE?=
 =?utf-8?Q?1J1Q6SKUUPhla5ezxRobuvGew?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0966666-5036-4259-af31-08db361469aa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 20:29:10.4879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rmW3tqaXbpsaO8XKukbhzAvbkQgTuPQCagNin+Oiu23gp2Rz9ZXTQt1alEMazQS34jz8xC7vgOaAn+uTFtF2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082
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
Cc: aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-04-05 11:31, Shane Xiao wrote:
> For DMA-MAP userptr on other GPUs, the dma address array
> will be populated in amdgpu_ttm_backend_bind.
>
> Remove the redundant call from the driver.
>
> v2:
>    update the comment

Thanks. You already have my R-b. :)


>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b181bb373783..74a1070f0be7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -503,9 +503,6 @@ kfd_mem_dmamap_userptr(struct kgd_mem *mem,
>   	if (unlikely(ret))
>   		goto release_sg;
>   
> -	drm_prime_sg_to_dma_addr_array(ttm->sg, ttm->dma_address,
> -				       ttm->num_pages);
> -
>   	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>   	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   	if (ret)
