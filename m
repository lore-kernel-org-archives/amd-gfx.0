Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAEBC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 17:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2BE10E0DB;
	Tue,  2 Jan 2024 17:49:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C451910E0DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 17:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaSB37pqBmoXWr7AbcJu3LaTIMEpJA5VPXi3lShNpF29WmTSlfut0pgMPGOot6o7wT9EMPuUhSgL2G0d5PqLEMawte2ZSpm9u2awIwBLpoN9urVlMeX4MVxf7xdL5RBtYDLdlet6m4jQNu0b8vHKsXkFBk2hxXiIxXLI9oH5isN1r9JJ/ogWxjpSdUKtYcTKyZbHADpxu3HqJZSyGKVgZL99tWKwbGMKm0UOrbVtTYZWiWAGmEZCIL6cn8uIOVc9adQdTkStGsfL8ZzDwWXVPjWSRD76fmsR4/RVRGQSz4PHcx1WsAZH40e/umRN/tGgdrZ9mq5gdZlhWZclB20xBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooBMiPRyRiE95l1tRTbZYwlwrRqWckWfQjr7/hlnrAI=;
 b=M44WeZoUJZZK7RTx/ebvgwPV1L0QdASXLn1OZ/bEmhZy65bdXkcJyy6LyK+B2uDVO89zQ8U2br5r6EHTPByjgmh13JnBqehrKtsQ0uW2F8SSHhoR5OoGqV5wfp05lCKjm4E2L3JTPvceAt1mJkVo61sVpgXKnmfczh14c3lwfdKqcuIJPvj0wEeQcoprguuzlkwBXChpBW/YokVDlPJTaW9P9yi3UhBHSIplCmX14m/obppE7siHBZfpoDHrfnQ2gvpZe6BDiy6cz0bhboh7Qujk8yKOgiTd1Xyvxo2LEZeZi0zXOEMj536nPo4f+jGzxu4Gj3im3JTyAkC23sfrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooBMiPRyRiE95l1tRTbZYwlwrRqWckWfQjr7/hlnrAI=;
 b=NwxIKwr0QjM4WCrOIgzSUC1Kxb/UQ0ntQ5FEH/Tl1LLPcIWooyknEi6LRIMAnOpy9eGPCYVhk3PIkas/ayMHNxVDvptYtIXpaGqRjfo6SoBUBGTQnD2UDDkv4HAtBtkiU5JplP9nz8c1rhbHQOxSlzkXTIoTjm2an0ldr2CZX4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 17:49:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 17:49:16 +0000
Message-ID: <8b796f04-da75-4ab4-87e9-be9abada93e8@amd.com>
Date: Tue, 2 Jan 2024 12:49:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Content-Language: en-US
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Tao Zhou <tao.zhou1@amd.com>, Stanley Yang <Stanley.Yang@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Candice Li <Candice.Li@amd.com>
References: <20240102140742.23917-1-Hawking.Zhang@amd.com>
 <20240102140742.23917-4-Hawking.Zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240102140742.23917-4-Hawking.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::42) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 1555558d-e171-4257-aedc-08dc0bbb2341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bwtlth9ahkeBBBvdFHTyMd1gQ0GU0wo3p3Tu2Zuo2dVloP/AclPzRAP3BiImn28TubAqIsM/geDBwST8D9ViECzRCc1erlQ2DZUT2OiKpBNxvjFzren6yaHz07Lp8AHNdeKQDcsVVLlXtGNJvI0dWtcR2or+50nrfYsyEiuI0DVfpymm3LSNRupxItz+udURCL4RMJO8D0moAU49hKd0gqLOFM4RLOrjADhYEHxqYb+STPC+0b6IJSunl+ll4ZCyzR9v5w9jh6TUR/jet8qkWR0139oHq9yDRCOJIfOR7ULCrFoGRdZ9lqESRXMjcAKJS/7WaIxUkBaXcbWUeqEcbfRqOw2cCLcIiO71vdFomyrDL5vQ4uARmuB5HVQCgANWuVC+ztf6O7vjwBmcPLMqO7Dhy87Qmd/8aLxvgbaHRJIH0Kxhh1Kbaxj89K79THtB7/LW4Uz6UAdrNgrA8pA99/YNg9Ym99uhJoopiV3lo37V4HosBozyFA4Z3l2LF3tTXItIP7hU4/TNL1RAR/ydkGWuJzeOWMVxZ5EiGFnJn31DeHBto2XwuiorAkk/LCod26LNUC71OeZAeZVTvMqP1WL9yMKFvwguYgQA7ytiwlstAPe0d8VXQ+/cH1mRdX2kkwqT9Lv3o+V7N3u6GvDwww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(31686004)(8676002)(8936002)(4326008)(5660300002)(44832011)(36756003)(54906003)(316002)(66476007)(66556008)(6636002)(31696002)(86362001)(6486002)(478600001)(41300700001)(53546011)(6512007)(36916002)(6666004)(6506007)(26005)(2616005)(38100700002)(83380400001)(66946007)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hHekZNZ0RJYlVpVktnQzJVdHUzbmVldzZTdmEvd0h0M3RDYWY2OGxUWHdv?=
 =?utf-8?B?NXIzVnM2QVRSUFkxRUxWMGJ2ai9mZCs1ZnpZeUd5VlFEWWVUZUdhMFFZdkNR?=
 =?utf-8?B?S0JYTHpGZFZOb2ZvNGt0cWFPWGQ4NndQMHg4RDJ3ZFFwbDZqcVd2N0xKaWJo?=
 =?utf-8?B?RjVKQlVVVWhveFUzVWlCMjRRZklZSlJNenk1NnJvZXVDbEo0ZXk2M21qYWhF?=
 =?utf-8?B?aUJJZ0RiOHdYZjJLUjhUbWhOa0RabU1La2hBTlFlRDMwUGRHRUlMMW96TEJV?=
 =?utf-8?B?V0hhSGFydDJRbzJHWlNIa2J6cm9RbGRzRjZEd2JjWW52SGhuaE5tZlRGMzNQ?=
 =?utf-8?B?Vm1DTWJHNTFXU2RrZEJGcUJNb1RteEZndXVycFVqd3I4bXp4YnFHVjJ3VHo3?=
 =?utf-8?B?bitKSDhPUlJqSUJJWEcvYXJYY2FBM0tEeWdMY3pUNC9GeGo5ZlduU1RzNVBE?=
 =?utf-8?B?UGFyUG15ckdZR3F3N1Y4UUxvdkNlcEhUZWx6QWs0ajVZMTFFR2xvdjEwazZm?=
 =?utf-8?B?alJaWWMvV09KVFV6U1Z1ZXUxYWxRTVFrcWU1VlBsTW5heGxKbDZvaHNGTFdG?=
 =?utf-8?B?cGo0eXZ4RTZ6THhKTkpRaDNmRUlPTkUwWklCZ3NveDlBeTRDL2hPcFRmRXow?=
 =?utf-8?B?aWJNUXdxZnFWMytFT0FGYllHWVU1b3pMVUpqRVV4ZWpkNTArSWc3ZTgrejFS?=
 =?utf-8?B?YkI1V2ZMby9iZlVVU3Zkb3hQSDIrT2dMdUswVmNhSnQxaXprdFhVblVhWmpV?=
 =?utf-8?B?M0NUdWZFck1DUmxLclQwZ3B4bk9vQy9HTmRERDV3Mi90c1BBRUU0YXVEMklw?=
 =?utf-8?B?YTFpRjQ0enpNbkw1U2dpSVdIOFBYNkNITWlmYm9EcW55SXVFL2xZYTFxK25X?=
 =?utf-8?B?cnRWZVpwc3VBN0g4QUIva25JeGxsRmdiTlpqelVlb1U4M0ZhR1cvREdaQjN0?=
 =?utf-8?B?amNSOXBZTVlTMVBoQmo5dHV1UFVCSDZPSmJROHBnaVhjcEQweTM1Uk1MTlFh?=
 =?utf-8?B?YjFtTkcvenN1R3JrMU5yQjhCVXdmRFdxOWdueTExVzJKNmphU3FETzV3bVdZ?=
 =?utf-8?B?aU9CWmZLYVFrSXl5amJDcXRZQnJrckhqZzhDRmRId3hFMy8rL3JSM1FvRGRq?=
 =?utf-8?B?T2U3VlU1NWdzTGtyc2pBWVR5dzJRME9WeE5qMGlWOEROVlJtWTQycGlPQXZO?=
 =?utf-8?B?QTRzVTAwOE9Cbm1leWhRZVk2TmY0MEp1MWZuT0ZNNmJNZVBHU3ZMM0U3TTZ1?=
 =?utf-8?B?alZWKzdwaVhkc2VMMDNOaVdFTEJXOEt5STZYSGhVRVhVWUVwRzdxR1J3MDhw?=
 =?utf-8?B?WVNDL1oweENlOXQrMGsvWVZWNmhlazN6ZXd1VldjaEwyNkFBUHk5VC9WM0Rx?=
 =?utf-8?B?UEEwaWRtQUVXaWovRWM5alJ6bE04S2JoTXBnZ2Y5QldZWWF5QjMwblJlWDVO?=
 =?utf-8?B?NnlpdktSOEpmcElpVXJSYnEydUFLWFAwL1ZGNjdaY2s4NVJkWS9CZko1UUNj?=
 =?utf-8?B?d0ZsMmlXdWVxdllqVEpWekx6OUEvYVFzNk9ESUV6b1BwL0tXeFdwU0dKTy9L?=
 =?utf-8?B?cEt6ODBVMEU0MGsyWUtGNUxOYTNENEt5VVg0YkZMcGdaYVZQYlFSeDBzN09I?=
 =?utf-8?B?K0FPNEdFZWVzangxS0JFOEZsVE5GZDNzclZ6VTloMmtyK21kaWpBalJ2WjVy?=
 =?utf-8?B?Nks3Ympnb3QvZk04cVM0ZnZuSThmeDk3bXhDbGpBbGxOb1RwRWVQc2FRaUtt?=
 =?utf-8?B?T0VVM2NqN2RiOWdwRmpzSUthbTk5YUZOcEtGZHFCVGpRN29YWmFPRlBMSENu?=
 =?utf-8?B?alNHUTdXRTN3MGY5RGhEcmFzTy92MWxFQWNCYklMOW1qVWZiZ1FrSjBsVHE2?=
 =?utf-8?B?eDFydmNYTlN5amg1Yk1SOTJEZFMrNGxoYjZtU1AxMGRPcTVRMCtiNjA3RmJB?=
 =?utf-8?B?RDVLeDlaL0NXclU4cmNPR2tjUXRiT3d1TXZzdzZtRVdCSWVJcy9LU3k0V2gy?=
 =?utf-8?B?V1ZIem9rR0pnVGJ3b2hRc0s2QWhhY0Y3Z2cwQXZkSG1LTWZoTmZaTFBMSHRB?=
 =?utf-8?B?WGVoZEFMc3BUbGk4eVFyRUdGNzBvbXFaQWR5WEFsWlZCdU8yVjR6YlFsNFZz?=
 =?utf-8?Q?gw6zGWClJGFkJKIkAsTom0YHF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1555558d-e171-4257-aedc-08dc0bbb2341
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 17:49:15.9747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo9dUUHUnw6hTS53vZM9lL9DDWeOrdtpGNm+mHx9ikfZZL7yIF7dv2mT9hcTN0NNuH1BPMZfL6mPhcFy2GbjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-01-02 09:07, Hawking Zhang wrote:
> Check and report boot status if discovery failed.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index b8fde08aec8e..302b71e9f1e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -27,6 +27,7 @@
>   #include "amdgpu_discovery.h"
>   #include "soc15_hw_ip.h"
>   #include "discovery.h"
> +#include "amdgpu_ras.h"
>   
>   #include "soc15.h"
>   #include "gfx_v9_0.h"
> @@ -98,6 +99,7 @@
>   #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
>   MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
>   
> +#define mmIP_DISCOVERY_VERSION  0x16A00
>   #define mmRCC_CONFIG_MEMSIZE	0xde3
>   #define mmMP0_SMN_C2PMSG_33	0x16061
>   #define mmMM_INDEX		0x0
> @@ -518,7 +520,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   out:
>   	kfree(adev->mman.discovery_bin);
>   	adev->mman.discovery_bin = NULL;
> -
> +	if ((amdgpu_discovery != 2) &&
> +	    (RREG32(mmIP_DISCOVERY_VERSION) == 4))
> +		amdgpu_ras_query_boot_status(adev, 4);
I'm not sure about hard-coding 4 instances here. The code you dropped in 
patch 1 was using adev->aid_mask. But I guess that's not even 
initialized correctly if IP discovery failed. Will this work correctly 
on the APU version?

Regards,
   Felix


>   	return r;
>   }
>   
