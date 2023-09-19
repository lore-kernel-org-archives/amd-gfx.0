Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35ABCD343E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 06:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA2F10E1F7;
	Tue, 19 Sep 2023 06:10:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC4E10E1F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 06:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlECmjZ821numYjQ0CX9Qu7ra3SQU/3cn+BEDk+P6K07DYDunMPG3jjzedkmJPeX0GVJuv+rEjseFAEKpKl36SooakdvSLI/mziPsUfmHDeIPC0p7iOQ4tBob4e1Vgm/2LX59SUd/EiKkRXWctiyfSvw+acZe7bgem6PvlrF50Ipx84dcWqj5YoAfFFnRwF+hq3qc03yfiDfpBMKHdENtDz9d0jm0MBii0gGED4zVMBGtUOaa/fOQ1WLPv2gwARyfemBhmDtOnqMmI52tyvf/5jpN6IVSCRqmvIOEltJH1pulyOMdSnKqz729Y8qQ+eREosERVywHfUip3ncaPDfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eic3ucoC1NWFLw1gDbXH7uXECExm0bkFuqMhUzESB+4=;
 b=aqWK1RvnobUeqJizwIYKRfhB3NJOoP6v3iYWXluzlP2AAR9/WPrDEib8HqwdKO3b8V/r2jR6YQsUboPMPlVvlMcGy6kFbffjGkwwIeTyGOuuUgHBFggnM+oTHkx5f9UCMvNy/lw+yTUDlzhKfoTyw4s3IE8ELC87fvDjmJGHKS2cBrJqleIduv/toy7aJ6ZziiQNQnzuh1GR9BkHkbVEEH3I6dCiDaVsuj3z0mnnmHRX+4ZH+7B5pnl2R3knapsx8XDefL10HrFA3e6p3pXJo01C04262HWglX1y2Vr0TZevcX3027cBuCfWJ9I/4qsbalfN38nOPruwnVCdZLto2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eic3ucoC1NWFLw1gDbXH7uXECExm0bkFuqMhUzESB+4=;
 b=F84MMW2AzriGzd52WZkTnHjgcN0F8mNXjp/yVvPqT8eMGiZ3X3HRkHHjNGOhhq2+c1BdULeZdvD7z8Hknu71Gh0Nav4YfO1PSFhz4jEbUR2tfE+iA3pbG+6T/aKNrsACPKOnx19CqDVYHg9TIqErE+QqiqrkLVbqUphRRv6Zjdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 06:10:40 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 06:10:40 +0000
Message-ID: <de4657e0-4eaf-3dc8-f1ad-f0a3b4ceb09a@amd.com>
Date: Tue, 19 Sep 2023 08:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] drm/amdgpu/gmc: add a way to force a particular
 placement for GART
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230914182200.679059-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230914182200.679059-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e34734f-6558-46ac-c48c-08dbb8d72623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWO2vrVuifIgKg+gy/Nn+XmFZ38ddgRhQw2by+291hzk2OOPOJy19OaYyDLKTPSYZGsFJ7/3EHbMcK28flRtqO7xg0p3eVuT56/QP5wuD/WTGUOrAEBvZ3iYkPDgPVAZ7q91dMVA4y6TynhJFlFAI6r8iZmKrAd5ky/N6/tqBelWzRg0eWjxuPDwQ5hjFe1KRUB0zTppv8Yg2iZmxHSkbI0faQ0gFC0JZxkis61gaoyUqZiEBlNei9xVn+bi0J+PAkXbPGEv3gvxuAmGjTzKEPf/r6EYKioA1KT+fZoZ9kdoTwZU4KECKRgEMeTKGjDb8kn7wWTuKBtk73mSgdIOei4gin3L13i5AsJ/B25eJWZlXi6uXd2uZve3g7nxPU6xuA1Wphq3BNwYiZ9AW0GXadINxdRx/TIGhTwzI3Md4OI+tIx1d4+B3uPQBOmqAR14PXkH/kJGRvVUwekNsgN4XFvVUcU9gUslHg/3UYC/nAv0KRuwrYP4PscBV39q32yRvKPnecmHbAK1Sf3LGJ2xI/FEzTcOBk/3qNdb8psCo95SKmzQAoetQg+aPexaYYWKaqj69p3vbztqDfBygDKDhG3bYqIeeqIXH1QtzrVr/4gO0YFG9QwHCMxXSPHhi0miaZr3ZLyhRlH/kzdig6QFAjNrku8jmD6CJJ3a/YiXfeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(1800799009)(186009)(451199024)(86362001)(66899024)(2616005)(8676002)(66476007)(41300700001)(6512007)(8936002)(66556008)(38100700002)(66946007)(2906002)(316002)(5660300002)(83380400001)(31696002)(26005)(6666004)(36756003)(6506007)(6486002)(478600001)(31686004)(43043002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZySGIyWXJyVGt3ZzlIWlRGZGlKRnFqdHlnMjdoQ2Z5V2hUdHZPRHBFQ0ls?=
 =?utf-8?B?ellJVXBEK0RtZXpZV3ZYLzlUbXgreEVIMXRtbnFkYzE3N1hVL1RFNlUxc1J4?=
 =?utf-8?B?ajNqSWE1c3RWMU8vcWdHM0F0aGFxWXMrUlFtdTNEYmFDQ3FDZWlXV0xUdjBa?=
 =?utf-8?B?K3pVdXlGaGNTUk4weXAxZmRFK0lvY0hGNDN1cjdvaHJwUE13ZlNrQ2VRZFoz?=
 =?utf-8?B?ZHlTWHFwL0pHa0VjZ0FmdHBadG8wWTEwM0ZPcVNsODZoNGc3L1ZVeGNvKzlW?=
 =?utf-8?B?V2FPcHM3cGEvMlZranRRdnl3LzhJQVM5SjNmY1Z5eGl4UGdWNVhYcVZkcDBr?=
 =?utf-8?B?MXN0cDkwOFpYS01NcUVhVnVMTmNOdGdIenhPYmJiZVRUUjUwTFFZM3JkMldQ?=
 =?utf-8?B?RFV4SFY0Smg5eVI0UURUYzEycnBGRGpOMC96U0hhRHBoOStIbzBLRkFzR0to?=
 =?utf-8?B?Wi95aHRFUW5XRzZlZXFiQml6VEF2VHVsU3lKVHdnWmZVWk5CYWFPM3hRajUr?=
 =?utf-8?B?UlJEVHlqTTE0eEdISjAwcTREUDYwR050YXZ4aFo5SDlYNUVVcThkU0NuZzha?=
 =?utf-8?B?cUFiaWs1YS9wYUhxcHpWYjArL0tDUDdYNFhiRjFaNk1TNW9INDJFZVVQRXJI?=
 =?utf-8?B?NmZ2bTVoWTl6bXdiSEc5a0pudW9mSmozMDBDQlJCUnlxdEJrdWw5K3N6dE9O?=
 =?utf-8?B?ZklzL2Z1MVUwZEpKYXNFQWVBSThIcW15cTZWUVpWWVRoWmtabHZOZ1hGd05u?=
 =?utf-8?B?WS9wYkZhL1R4R0lZKytQbjhjSWJKc0lZNXNOU21paFZ3MmM4QWVWTDBvaU9i?=
 =?utf-8?B?Ym1ML0VSOTNKY0d0NDEzMHFVdUFLN0pKcTM2Y2JQZW1YakdOOWpQQUV0QWJC?=
 =?utf-8?B?d3ptdUZhOUUvekJkTjRIbEdEZGEzdzV3V0lGYjJMdXNKT29UOGdkOGVFcFIy?=
 =?utf-8?B?b3hGb3dSTGlKQTJYY2RZSFBaNUtSMnVacXdHNzRaYXIzckh5d3ZseHlIOEFh?=
 =?utf-8?B?aWo2NThQWkhNSkVwZ1BBdWp1QWpHVWVrYStpN1FwRXhCcjBuK0VDVkVNRklj?=
 =?utf-8?B?RlU2aURtbUtERHozV3ZkNkpPeU5BRTZSU2tHWk9NRnYxbkE0UVhnem8xYy9C?=
 =?utf-8?B?NytlY3k1WEZldmNTUUxmbVo5b2tkSWNQckZuMUFNT1BrRHBEUlJmTjVaUjk4?=
 =?utf-8?B?N29NV0JVNUJVeWpHb2c0SHRSSHBoQTUyaDZrTzU4djhZQmhyZGpNTWJFbmZK?=
 =?utf-8?B?Y3Z5aHVjUWdSaG80MVh6S3ZCWkNNcWFTRjk1Q0xrdi9OWlljS2I1TjRVNnVs?=
 =?utf-8?B?RmcwVGp5M1k1aHVES3IyUGJFdStTZmZvT0htdGpic1dZaDRiQnVJRmpaRHpB?=
 =?utf-8?B?SHlNcFRzWk4zT0tKaWlKVFJDeWdhT2JRODNzU1YzWUhDcFM4bldSc2J6TlIx?=
 =?utf-8?B?WGQyZXpGL3lkUk92LzFIVUdiZEs4RW5PQXNjWDlHc0tiRGI0QnVIZnI1djNW?=
 =?utf-8?B?RFZYSGJjbjdxY1pXRE1vSm1MZmtWdllFOVgzd05uN1RtM1M4akRIREtoR0t5?=
 =?utf-8?B?NGtnallCbmFXZWJZbTB0eXdvMGpzUDdkWHZ5bjFCRkd3R0RmaHNhVFBQY05X?=
 =?utf-8?B?cFVqSFFGcFRiK3FtcjFaQW1XVUdHNlduUDBOTWZ3Vm4xTmMwbjBJeFVDQmxC?=
 =?utf-8?B?ek9uOFpPbm9ycTErRWJMbFRFK3A0VzRMV3MxN09NZWhHUERQTUpuTmU2QXBl?=
 =?utf-8?B?a2F2dWxyUTFaM0ttNW4vMlN6OTNPdXdNN2g1eE1NbjVHU0gxWHRta2w3aEZo?=
 =?utf-8?B?dXV5dlJ2ZDM0dDVSb0ZYTGR2bEtHU2Q4QytzZHN1bWt5WnlaTmg1N3B1bi9x?=
 =?utf-8?B?Z2RkRHNJUEtSbVJiSDZhQ2UvMEdJSEFKTms2UTJJRnNIZ0kvSDliS01DbmE1?=
 =?utf-8?B?YUgvbGlIajF2QTByMEcvL1Qrcmd5cnB6NHpmMytSaWh2ZjVLaGJwUXY1Y1ky?=
 =?utf-8?B?cmZRWjcvQ1dkaHlCR28vc3pPcDZGZk04TW9kQWxuYm94VU1ia041c3dGYjF4?=
 =?utf-8?B?RlkvZXYrMHFNMlBWQ0V2clZnM1pyMXRpYXFXalpkMDVSZGIzUXkxamtzUDFM?=
 =?utf-8?Q?fG65IvWUFmzOy0hdE4BM1penB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e34734f-6558-46ac-c48c-08dbb8d72623
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 06:10:40.1482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAjDXqZM/8y7ib1EtNEbAo1Id9jvL8mdJs/rmpEAP3dt1mOw2BAAszKs4IM9JH+b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
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

Am 14.09.23 um 20:21 schrieb Alex Deucher:
> We normally place GART based on the location of VRAM and the
> available address space around that, but provide an option
> to force a particular location for hardware that needs it.

Ah, somehow that patch arrived delayed in my inbox.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 +++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  7 +++++++
>   2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c7793db6d098..c41321c456fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -286,11 +286,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>   		mc->gart_size = max(size_bf, size_af);
>   	}
>   
> -	if ((size_bf >= mc->gart_size && size_bf < size_af) ||
> -	    (size_af < mc->gart_size))
> -		mc->gart_start = 0;
> -	else
> +	switch (mc->gart_placement) {
> +	case AMDGPU_GART_PLACEMENT_HIGH:
>   		mc->gart_start = max_mc_address - mc->gart_size + 1;
> +		break;
> +	case AMDGPU_GART_PLACEMENT_LOW:
> +		mc->gart_start = 0;
> +		break;
> +	case AMDGPU_GART_PLACEMENT_BEST_FIT:
> +	default:
> +		if ((size_bf >= mc->gart_size && size_bf < size_af) ||
> +		    (size_af < mc->gart_size))
> +			mc->gart_start = 0;
> +		else
> +			mc->gart_start = max_mc_address - mc->gart_size + 1;
> +		break;
> +	}

I'm not very keen of this because it doesn't really handle the problem, 
but rather just works around it.

Ideally we would use the kernels resource management functions for the 
internal address space and declare everything which is reserved as such.

Christian.

>   
>   	mc->gart_start &= ~(four_gb - 1);
>   	mc->gart_end = mc->gart_start + mc->gart_size - 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index fdc25cd559b6..caa15639d3d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -197,6 +197,12 @@ struct amdgpu_mem_partition_info {
>   
>   #define INVALID_PFN    -1
>   
> +enum amdgpu_gart_placement {
> +	AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
> +	AMDGPU_GART_PLACEMENT_HIGH,
> +	AMDGPU_GART_PLACEMENT_LOW,
> +};
> +
>   struct amdgpu_gmc {
>   	/* FB's physical address in MMIO space (for CPU to
>   	 * map FB). This is different compared to the agp/
> @@ -333,6 +339,7 @@ struct amdgpu_gmc {
>   	u64 MC_VM_MX_L1_TLB_CNTL;
>   
>   	u64 noretry_flags;
> +	enum amdgpu_gart_placement gart_placement;
>   };
>   
>   #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))

