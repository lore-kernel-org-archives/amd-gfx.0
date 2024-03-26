Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFED1C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 18:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667FD10F1D0;
	Tue, 26 Mar 2024 18:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C5xepe3S";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2120.outbound.protection.outlook.com [40.107.101.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCBB10F1AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 18:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI0uYzkPX/OUGBNjyGpuqZYCkxMyFsFz5jabpUlYBM9jHRxLIt61Q/XymcrV+6FoCxJvuMnfdns9idMdkW80r53Ovz5Ls76SPp8rHMoGaB5iyFfKq727w5Vujq4c9dRLoVs8lq+dhil2bukUiyoYH0dFW88GjrOsbb5U0XK1mjaJ/n+VL6cD+blvKrQzvg7VdHLysotlTC4SLp7p16tZANHkitWcF09SOp994pPcs9YtnzYzZTEYaxjRcp/eeSjAN7+emJ7c5WZSAdDqFMN7RVDuC4aSpGPteXOCcA96lTbXvAfPlRW0pLd2hAMj36rOx52XVd7yqM+KlAhjCyxIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWQdSdJ5tWTKchttAGds6spt/ORXYaxwmz9p0V/TMO0=;
 b=gkQWMcqu9KJpaz5RBExhJJHbGHRUBlCKCeQy4RvGJPWXhWaqBU7uMNkaDVytC+XuKJddIfJZ8dGT80aVMcScjq3LOE+Xda7VdPzYbp3xYfZAbr4Phcuj4he5uFI9tr+wuvZQr6Nzp4knq/slTxc3pbTFOIiBWIxZlm5AAsvdWZqY3EsfFONxE3W0DHK861qMVMleskNnpP1eFPmp2xX+zXfcyDxPjK156RAg69q7KrcHVMGYG2Zxxrptd9skjKpBIjB+oEpegLp195DIcEO6awejvy4YaaCxeiFL7cHLiXKYoIFw7QcfTCah1sV1iWy/zyg9JchRnCMq8Q7oD9wh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWQdSdJ5tWTKchttAGds6spt/ORXYaxwmz9p0V/TMO0=;
 b=C5xepe3Smzr/axy+h/uOmi4RzzS2STHU/Gns6rKSYgIEUYV6bkjLUIpgLXXJwt2KKZp+cCaIsVduQ05+Xu47t2moza2QFtMsXPvrAp1mIPFU1u6XRR+VY/wAR4PUBV+CDg6LK9EAvRjQfyeyT6Fa4sVt1NBj2QBFWnC183b3EzY=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 18:21:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 18:21:59 +0000
Message-ID: <7e15b576-6ece-480e-86dd-ab5e4fbfc5db@amd.com>
Date: Tue, 26 Mar 2024 14:21:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: always allocate cleared VRAM for KFD
 allocations
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240326155203.5246-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240326155203.5246-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8301:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDyVl/r4gj+a5OhXMHexFw/WBVuUjBNa71/GPUwrbVIQKNE8Y2qIAxH0AMZNnhXxDtOo1ZzOqYFlNYFXcc+aFH8xEKlpZoahvVyGfnqHGWT6ojRpEg8wWUstgd4zuj3U+m+bkjLe924Dn6aiVlAU1r+qfKjnQUAbIS6QLmaGMPOi6MgtTMgdwEA9W3Si820tosEYM3gFwBCcc9C0EY1ytC2xZQYrtGwRtpweYbz1hedtd0Wr210lPkj+/qpJSdHAS3XBnbtOJKURih8W7R1IXJDKa0z4bvg4noWkPlB0eWRu4qccumTuMZaaAIkIFEZas1bMrPSeKRTfm63f7psmfJly+krQnGtCk8oKhR6bbWLeYxRsB0lAo3PbkNTRtO1ayg/4K6+iaXnaNZEgx1ZEcpGXI0BL+pnsChAQmplqhsM7hxWhdExKAulVzzvQ7hkbws/lGc/Ix4hcNVMMe4eu02xx5I4UHR5cKmSvO+5nsexet8xtGsc8BcGpaMAXN3h5SygTl2L/n7xKL2CRwciPFxBB2Dvh5PCVXpyVD7EEa5BXjdatnwRHQ81Ib8J5Ll1vFb96VhuI9pqBcs1+c0lOh/XDXo2gIGSNuhQn4dq7dsnan3rIm7EwHI6XBDyd7jb0B3eFJai4S/RiOaQ7bw7fyP92PEGR/jj1oGByoDGFhmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0IrcVMyM3dSZnVyMkRZc3BmWE9IUklVTEJZMXFFYzZxWS9HNnYrRUU5eVVL?=
 =?utf-8?B?WGFBWThNL3ErVys0MGU5L012L2lHa3l1WCtwVjlNUGJybXMzNCtXRm1KNkYw?=
 =?utf-8?B?Q2pEUEgxSWg1L3dzdGdIQ3cwZWVvSENMTTRiRmduQUNDYXVMdkxVMmxkQWx1?=
 =?utf-8?B?MXhVNCt0MDBOdUZTdU9ZVEQ2VUJ2bDUxTWFaS01kUzljNVFBa2F5enNDb2RH?=
 =?utf-8?B?U3hYdXRYMEhyTnkrZE5NVUR5cm1iMWJOdnl2cFlFaFBqaFB0dWZNZ2tscHAr?=
 =?utf-8?B?QkMxY1N1UzV6ZkZuWnJHcE45aVBnUzlOMk5XbmcyQ1ZCYjF0eFl3V1U5Qit1?=
 =?utf-8?B?cmRyeUlJRkUyaXlHVXRJamhkU2pYNk9tMUhKZ29xOHhJR1F2WXJMN3ZkWFBm?=
 =?utf-8?B?SEdmd28rd2NSbE8wcDJvMmNjVU83YytXRkJncDIvMG5SODJ3aVlBS282ZEhM?=
 =?utf-8?B?blRYcFJJSDFKUmdXM3cxc3NzQzlRaWljT0ZyM2o0NStzamtDbVRMMklzL3h1?=
 =?utf-8?B?eDNKbTZ4b0dCS0k0Nkl3NTU4TUE2a2V0WHAvdzhlNUNWTkJ2OU9ONm44Zits?=
 =?utf-8?B?TDZ6cEJyQW5lVFo4K2dCaHM3Sjg3aEZRemk2ZXRjcWQ5d0RPa0l1QUY4cGVT?=
 =?utf-8?B?Ulk4c1lsaDNzUUxYbTZsNVdJTEZHbXZwbkd0WlFsaWVDU0RIQTJwYXBhUlJ2?=
 =?utf-8?B?Z3l6Y0R5V2VyWmVJSUZHYnZKODlzVjAxVnNjZFZFSDUxeGxTK3pWSmIzb1RJ?=
 =?utf-8?B?UnIyeFNKUC92b0phdVQ4TldaZTZkQTZHS2tuYno5OU8yYnFLbHgzMHN5Nmpy?=
 =?utf-8?B?RnVRVXZPMDhvaUdZYU5aU0VWNlYyNzhmRnNnRklXWlFnc2w2aUNDbmh4OWx3?=
 =?utf-8?B?VHlLRDJXa25JWlZvOUdhUWJuOEdKR2pSTkN4c0VseDVlWVZEYkZkRUl3M1pJ?=
 =?utf-8?B?MnpjdWtJZ3c5QjR2eXhYU1o2K1YvZ1h3eGRBSXFTbktnNFhiOXpzb3lJbzFY?=
 =?utf-8?B?KzYyREtUaEFFZ0RycUd4NGdISW1velBnSmdodGJQa1NkR2h1ZlNpbTA0Sk9h?=
 =?utf-8?B?Z0M3OTl6UkdtMlMvam1aN3l4eDZ4NW9VR0E0ZWtRVWxqZVJZSnJnRDh5MlBN?=
 =?utf-8?B?NjkzMzRtaVpVNlpyOGlRQnovZXpmSWIxbDR3eHo5RGxhSmhzRUJwQ0M4QnhK?=
 =?utf-8?B?S2hiS2Q0T3Nhb3dPRXNhTnlSLzNVdGcxNWZCRXdwTG14UXJHRWFUeGc4bms1?=
 =?utf-8?B?ZGZaRGRPdWF3KzFoMU1RUmlNblpmVmhWMks3OUNuOHhCRldNVE5zbE15YzYz?=
 =?utf-8?B?K1M3MExBNzdjck5CbElpZGhOT3dWczhORVFhYWs4clJDeVBXWHJqOEVMbnp1?=
 =?utf-8?B?UlAyT2swNkdaUTZhc054Vk1YSHRES2JtZ1dBVjVCamhEY0FiZEJ5NE95V3k3?=
 =?utf-8?B?ZHZFZnA4RG14WVE4VUJZaDJzcldSeGlLbnZiSnlnUVZFcFAyS2NHc1VqUUpo?=
 =?utf-8?B?MVh3NVdWbzAxZUNNZHVXT0ZQS0pGajB6N2ozdDJpYTIrTFZWcFhTR3JVdGNo?=
 =?utf-8?B?TzRNL2k0U2tjSEplZmpraUVJSnlDMENiTEQzY0J0UW1hMVJ4aUNFK1RURmFC?=
 =?utf-8?B?ZjduZ2hoZFo0WkZvaHFmZlpKYVhNeDZCajl1cUtMei9VNTc3QnV2VWltejJD?=
 =?utf-8?B?dEJZTFRvcXBSVHpYa05TNllaRWxlUVRvbEZRQXAxUEpWZ0UzWlhvcTNFc2U1?=
 =?utf-8?B?cDc0eDBlQXVYRXdiSE9uL2QwaFBkdFozY001eWdvNlZFOE1uYko2K2kwTENT?=
 =?utf-8?B?MFFrdDJoeVlYU1ViVGlXVTFqL2xRdjg0dzg5MnRxakkwOGp3T3lOYU5PdDhs?=
 =?utf-8?B?VFRmRjIxUmpPQThROUpES2cxcjA4aEsrQkluOVlkd0Exdk4vbjk5NjNHUUky?=
 =?utf-8?B?WlZOaXFDM0JQeEZjcit1dUhLUVNkNDBFQVYvdjFhQWdmc1J5cnR4NEc5ZHkz?=
 =?utf-8?B?YWRyZDhNYW5ZOG5qQ1ZXcndqRG5oVlE3R2o2R3lFOHBzaVAweGRhRXNST1Ex?=
 =?utf-8?B?aUZWem4ySjdCbG52QUtaRXlNa0k4KytXUnhOVzNxU3NzcjJlOGVVR1pleC8v?=
 =?utf-8?Q?Iy+13oP7GjXJblTz7zmTZNKRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cb2da0-e3be-41ea-e522-08dc4dc1a02e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 18:21:59.2440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mpbr/oCeQMZnw2oDlYOx4WPP3v/oUSsvtTyI6oAYjK2DAkDRttYWmFeC1bUCw6tbDFLeExbKVbeluwI/7fauYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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


On 2024-03-26 11:52, Alex Deucher wrote:
> This adds allocation latency, but aligns better with user
> expectations.  The latency should improve with the drm buddy
> clearing patches that Arun has been working on.

If we submit this before the clear-page-tracking patches are in, this 
will cause unacceptable performance regressions for ROCm applications.

Regards,
   Felix


>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0ae9fd844623..f9a4ea082821 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1709,7 +1709,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>   			alloc_flags = 0;
>   		} else {
> -			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> +			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
> +				AMDGPU_GEM_CREATE_VRAM_CLEARED;
>   			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>   			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
>   		}
