Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEE4C19F28
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Aug 2022 13:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0776612BEE3;
	Wed,  3 Aug 2022 13:41:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD79118A582
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Aug 2022 13:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UngfI+JpK1wMXSBauw4KuBrgShmApiVBbdMd3RU4+SofTUysJTAtkEg1buC0AHaKb2Yey7CjNZ7VThvSxwezccsOYBGT/71LzpzECy5OQ+fcgYGGdDo6kZOjGFd60OsXeacpKhNez6djFdMFq/p1B9NbyJQUR8XgWzgComzUErFnepxe7neb8T7TTGXBvL3bg8Bnmfnf4IA83odBeiFowOeT3rmU34n+W3dgQHW8rH/sBz7DSnpnvAtLRcQ9FzUe5JxIKooXoxVaefDTcq2vkK3mTPJdJjIyGX5/s8R3m8Cnj4XR6ZHt/lsmxAUwE9B/oflmx3w6s6QS3dCuvV55fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNsYf6Hv68uJyi+sMDWmWAluZ7oAp9yPUt25w2Pp1dY=;
 b=IZXf4F8iS4QwwmK8jEuPrhSlYPuAPVOy5H5XG00XSdSw0J5uR4SpfEwyGUPNrpyjfS2hrzt9uue62s+De0RYbcuDgGFdwzzT3a4k6BFM5CLyjVwdJOwg9xsLbfOP5Dh3hUuAjriKX3irO/2+95AUUHZzYuPce5JsqszTFhTl47wIF32CxBkBwjtN/fQLtqNbXwNQv61tVKcgwgIUKePD4ozN5Ej0+2n9Okdosf917AZa1a7ZnRaWjd8u/X0CADAaQE7I25veG/SzNXT55R6xyhR2rED+fla2U2l17AnjXLtyyIB98+T8cFJKomIVEh6SdqAm+O9IHkeN24Wj4kVHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNsYf6Hv68uJyi+sMDWmWAluZ7oAp9yPUt25w2Pp1dY=;
 b=E/TuYLcrqiqcLLI6UxClyqKdZd6nlNmY7o6iF3gsRTAde9g31YuVIbmPA/UyVkXIW8SmYpLvK65JemeLzdp2WBoQvr9Hb/gTB5YhvYY/F7lTLPgJVmyL1/0Uj0J/0kfzfg/jcHZr7sjByuGeav6APBUQRDnTx/s1Mvi7anYiizg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 13:41:15 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 13:41:15 +0000
Message-ID: <dd041660-b5b2-2f1b-9ae3-7bc384555583@amd.com>
Date: Wed, 3 Aug 2022 09:41:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/6] drm/amdgpu: add mode2 reset for sienna_cichlid
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220801040714.5102-1-Victor.Zhao@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220801040714.5102-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::6) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 927d977e-4b9b-4e55-6925-08da7555d606
X-MS-TrafficTypeDiagnostic: MW3PR12MB4473:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFwXMPwTMmfxXPr4v4WDbxmst6plodxEQswLCO89tVHkWTZp93zI4j5eZ0AEGJpJTOycK2kWOPzdLA3ZJdGVWjQXlJwi9xjHy6GDDgymUSLQsXztsu+9v3iPRi9K+LVQXp5eWDT9OxTVgC8R/alSL/qCCLIVDxv7crJotJOqoSb+uY2OK04vLQNu4u5h5Qi8nLaETIOGcWHuvA0IUBlb1icxqjrGhuiANYyjIeJeJCam0dvvTZ7+mnaV9ur8uhOU8Tfoc5S6ImUATaIwwNUHMTa2uCD6UVl59DoGAw9/ZJLxQHYYTZd9bsQ0CAra+aLjNft93Wq+OPqZDtVWt2fpM76uL+oqH3HWAIE80rzBL8VfLglMF46RvcYLfwqf9MBU18wLvdXsHp5USfSjZvqGa5RtpiPY5IEtdOCtvYmEVkQIiV3yyuOrKZPaijAqC0dTnJsUQCgqME2z7iue2FsdKXAYf79cL+yF0dHkgcvQb1wxPWWvB3L/l14D+bM5MTL1Q31dz4CiAMkbe+EQapJAB/b3bVG5Z4If4y2yyVn2X2iX8Nq+mak3ocEF4b9NvMECWnbr3aiZOYr5Vbr1ZlLSuKU12molui/FYHarpRs3NhmsSlnss127zQV7RAI+2KgGJwindCuGsZbb6wXeKS3K/Eaj+q3IDGearsWI6Adje31qI7jWLDOXCPkHi0lAO3WGKpXjy5Bexl2DuPLX96eHeolDAWHxJLA5fnxxa8IzFcMFOLIp+XIFzuMS8mNmIo/xIAYXX+5vuUp3jII/b08Yrwkh6dXUVD28/W9gNwTTjwjPng2HiBr8mih7b5XX6QUV6HKX7mkDUXkPN7OlTx2kaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(31696002)(86362001)(83380400001)(316002)(4326008)(8676002)(66946007)(66476007)(66556008)(19627235002)(36756003)(6506007)(5660300002)(30864003)(53546011)(31686004)(2906002)(8936002)(38100700002)(6512007)(44832011)(478600001)(6486002)(186003)(41300700001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emQ5VERBWHhZdU8wdEhrY2kxNFFhRVUwR2U1UllQRXJHNmZVYjBZc2Vmeit0?=
 =?utf-8?B?cFdINmZwVDI1anRHVldJOTVOcUhtS3JERWE3OUg3bG1EUXI3c285U0IyUHVD?=
 =?utf-8?B?ZUxvKzNsakExRjNGRDBYZE41ZFhiajhsa0VGbmpDN3RxTkhTZTM2TnJXUEs0?=
 =?utf-8?B?S2MvSkVpaGVuTlNFc3k5d25ldXd5NFJFRVgyc1YwOTU0b0R0TnNTVFQvWUwx?=
 =?utf-8?B?eWFndFVlOFFLVWhFbnRlY1IyQ2E2dEk0dWpncWlOd3NjbDlicHRmeGFSMjdL?=
 =?utf-8?B?QTRWNXBCNXA3V1dOZy9MYmJjcDNwSkdHVWxnSDFtckxURTU4Q3JhVlJjVFNz?=
 =?utf-8?B?VkN0MW1YVXI5empPcEZPYmx3dWRBOEhtQVpRd1VmejFjb2pNVVdGQmxsVEZR?=
 =?utf-8?B?U1pISEVYQnJvbHBxVDlPbS9qYkM0aXNnMnpML3o0bEY2ZzFWRGlwb1I4dVhx?=
 =?utf-8?B?Wllnd1ZuUkpMN2pKd1AyRWhKaWl2eUxvcTV2MG5zQTk3aDJUWEszZTI0cWhh?=
 =?utf-8?B?NWpBRFUzS0ZyVmNmaUpXRG9jOHYramxCeWFzL0tOM1lNd2RuUzUvNnIrSHl3?=
 =?utf-8?B?SDNTWGpzbWorQ0pweUxyRGpzaEE2V2dNUVRBRjZNV3E3bytseDNkYzV6dXBi?=
 =?utf-8?B?NnhibUpORmgzRDM2dFNrdVgzeU53V1FTbTM0bUYvRFpXMVNhYVZOWmd0SHl1?=
 =?utf-8?B?ZzY3cWdRK2VnUmYrUlZMM2pOK2c4VmlIOERLVXh0R2xrN0Y4NkVlQjNSVTBO?=
 =?utf-8?B?eGFXRE9mN3dGdVZBckZWc05jZDl1TFVDQ2lnOHV4NkdhMnF6N0hEM0JTMndu?=
 =?utf-8?B?MTlERzJobWptZlRCUlZITlkzUmZ2WE0waDVRVFphNG1nK05ZWmJIU0ZEeUt6?=
 =?utf-8?B?NU1aRzFKd2l3Yms4cWdPM2NvNGttdmduT1RHUTZCdGt1N3ZSazVrNnczeU4r?=
 =?utf-8?B?bFRnamJEV2lUWVl1cGUxNlhPSTJNMGQvaGZJUWdtNlVKaHd6b2IwSDJNMlFP?=
 =?utf-8?B?eS95aFVBc2I0TXlHc0RSeXBFQnlGK3JZdGc2bVk1dXBlYmtvUUZHeVloSTQy?=
 =?utf-8?B?eC9aT2hFdXZNdUFtbk1ETktzS0E1aVN1SnF4akREQi83Qk92S2pxcXBiTm9T?=
 =?utf-8?B?YzNsNEdVOG5UZnFXbTlBdHJhMzF6M3NBTlFtS1gwRkFzLzE1STgxdDVOUzRN?=
 =?utf-8?B?SkFhSjhUeW50RFJBVkZzMG5hYmt4L3JHRnVOS2tYb1phbHZURU42WWM0Zkwz?=
 =?utf-8?B?TVdPbktMcU1WajliOXVycmY1VjZEVHFOaVNVOGZva3J6NXZSZ01JUmhvMFZr?=
 =?utf-8?B?NzNBRFdtWG15OVVKYVVJMTB1VjBiS0cvK1VydkxQdEhlNFNySDBOejUwTFlv?=
 =?utf-8?B?RC9Eb012MkRXWXBLVGEwRXJ5akJQOUljU2l1Tzd1dTVDMjBxRk5BT3g5SnRS?=
 =?utf-8?B?cW5YWnFPT0U0bUpIdFAyamdxUUZTZ1VtNThJTlFnRDB5Zi9HRnBlTzMxd1dU?=
 =?utf-8?B?c3BSb2JkR0dJb2VYTWxRbDA3TG93RUhIWDc3dWFSUFpNRjIzSjRVelBiOGd1?=
 =?utf-8?B?YWt4Z1JXcWZvNnFYR2d0WE9DQlVESHhNMktVLzgvMzNRNmxKYWc5VmJuT0R5?=
 =?utf-8?B?UVozY0V4SkRlUkswSVJ5MjR5bTRxMVBoTnh5RzRha3pLRUVZVG1rVzIrOEkz?=
 =?utf-8?B?cStualBWbnZNeVRWYTgvUjQvRzN4b2I5b05YQUwxdU1iU2JFYjZKNndFdEg5?=
 =?utf-8?B?NlpNbjN0YWNkdy9peEYxUDlyT2ZydnNkM3NuRHk3SlJjM1d0RzR4SDRUWGV5?=
 =?utf-8?B?UzV5T09zMFRUZnlLZ3JMb1hJTkhDc3pmazREOEhiNHhSKzRrWHVaUU0wWkNK?=
 =?utf-8?B?SmUzQ2dJZzJKQW82SDJ0b3VzeHV2aWE0eGdoMG1BM1JtbktJNnlBZFZqaEdP?=
 =?utf-8?B?WDdvYklyUTJQYTgydGdqbDVSZWxmZGlIR1RaYlhibU1wTnNqdklqSStrWm1H?=
 =?utf-8?B?MHUwd3l5YzVVOVE4ME1Ld3p3NWVNUWJwNEdhVlNyejBDM0U0M1cwQW9LSTJ6?=
 =?utf-8?B?MmFKc3FKeXM0dWd4NXhEZXhjK3B2SUIrNmI4KzJSeU5GaWgwMXdYaFY5K2wy?=
 =?utf-8?B?aUh1RXh1ek5yWVNkNXFIWmNTcVBGcjNNVXM3MHZscm1LYXgxQ1h0cU1ZeVVL?=
 =?utf-8?Q?dMFgScx9CJ8YXKpmAxne0za9R3Vv+M6PCUeYCXTEILec?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927d977e-4b9b-4e55-6925-08da7555d606
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 13:41:15.1323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31o7O6MkcqcdmkiMxWYlB1QzHK0m1q7XaREiFP/C3/9YRzP6NOdJTECAem2xaif0ZTgnXiPaHnTyVK6aM6MeeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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
Cc: emily.deng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-08-01 00:07, Victor Zhao wrote:
> To meet the requirement for multi container usecase which needs
> a quicker reset and not causing VRAM lost, adding the Mode2
> reset handler for sienna_cichlid.
>
> v2: move skip mode2 flag part separately
>
> v3: remove the use of asic_reset_res
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   7 +
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   | 296 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h   |  32 ++
>   .../pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h  |   4 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  54 ++++
>   7 files changed, 394 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index c7d0cd15b5ef..7030ac2d7d2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -75,7 +75,7 @@ amdgpu-y += \
>   	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
>   	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
>   	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
> -	nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
> +	sienna_cichlid.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
>   
>   # add DF block
>   amdgpu-y += \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 32c86a0b145c..f778466bb9db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -23,6 +23,7 @@
>   
>   #include "amdgpu_reset.h"
>   #include "aldebaran.h"
> +#include "sienna_cichlid.h"
>   
>   int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
>   			     struct amdgpu_reset_handler *handler)
> @@ -40,6 +41,9 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
>   	case IP_VERSION(13, 0, 2):
>   		ret = aldebaran_reset_init(adev);
>   		break;
> +	case IP_VERSION(11, 0, 7):
> +		ret = sienna_cichlid_reset_init(adev);
> +		break;
>   	default:
>   		break;
>   	}
> @@ -55,6 +59,9 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
>   	case IP_VERSION(13, 0, 2):
>   		ret = aldebaran_reset_fini(adev);
>   		break;
> +	case IP_VERSION(11, 0, 7):
> +		ret = sienna_cichlid_reset_fini(adev);
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> new file mode 100644
> index 000000000000..b61a8ddec7ef
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -0,0 +1,296 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "sienna_cichlid.h"
> +#include "amdgpu_reset.h"
> +#include "amdgpu_amdkfd.h"
> +#include "amdgpu_dpm.h"
> +#include "amdgpu_job.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu_ras.h"
> +#include "amdgpu_psp.h"
> +#include "amdgpu_xgmi.h"
> +
> +static struct amdgpu_reset_handler *
> +sienna_cichlid_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
> +			    struct amdgpu_reset_context *reset_context)
> +{
> +	struct amdgpu_reset_handler *handler;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
> +
> +	if (reset_context->method != AMD_RESET_METHOD_NONE) {
> +		list_for_each_entry(handler, &reset_ctl->reset_handlers,
> +				     handler_list) {
> +			if (handler->reset_method == reset_context->method)
> +				return handler;
> +		}
> +	} else {
> +		list_for_each_entry(handler, &reset_ctl->reset_handlers,
> +				     handler_list) {
> +			if (handler->reset_method == AMD_RESET_METHOD_MODE2 &&
> +			    adev->pm.fw_version >= 0x3a5500 &&
> +			    !amdgpu_sriov_vf(adev)) {
> +				reset_context->method = AMD_RESET_METHOD_MODE2;
> +				return handler;
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
> +{
> +	int r, i;
> +
> +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> +
> +	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> +		if (!(adev->ip_blocks[i].version->type ==
> +			      AMD_IP_BLOCK_TYPE_GFX ||
> +		      adev->ip_blocks[i].version->type ==
> +			      AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +
> +		r = adev->ip_blocks[i].version->funcs->suspend(adev);
> +
> +		if (r) {
> +			dev_err(adev->dev,
> +				"suspend of IP block <%s> failed %d\n",
> +				adev->ip_blocks[i].version->funcs->name, r);
> +			return r;
> +		}
> +		adev->ip_blocks[i].status.hw = false;
> +	}
> +
> +	return r;
> +}
> +
> +static int
> +sienna_cichlid_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
> +				  struct amdgpu_reset_context *reset_context)
> +{
> +	int r = 0;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
> +
> +	if (!amdgpu_sriov_vf(adev))
> +		r = sienna_cichlid_mode2_suspend_ip(adev);
> +
> +	return r;
> +}
> +
> +static void sienna_cichlid_async_reset(struct work_struct *work)
> +{
> +	struct amdgpu_reset_handler *handler;
> +	struct amdgpu_reset_control *reset_ctl =
> +		container_of(work, struct amdgpu_reset_control, reset_work);
> +	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
> +
> +	list_for_each_entry(handler, &reset_ctl->reset_handlers,
> +			     handler_list) {
> +		if (handler->reset_method == reset_ctl->active_reset) {
> +			dev_dbg(adev->dev, "Resetting device\n");
> +			handler->do_reset(adev);
> +			break;
> +		}
> +	}
> +}
> +
> +static int sienna_cichlid_mode2_reset(struct amdgpu_device *adev)
> +{
> +	/* disable BM */
> +	pci_clear_master(adev->pdev);
> +	return amdgpu_dpm_mode2_reset(adev);
> +}
> +
> +static int
> +sienna_cichlid_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
> +			      struct amdgpu_reset_context *reset_context)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
> +	int r;
> +
> +	r = sienna_cichlid_mode2_reset(adev);
> +	if (r) {
> +		dev_err(adev->dev,
> +			"ASIC reset failed with error, %d ", r);
> +	}
> +	return r;
> +}
> +
> +static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
> +{
> +	int i, r;
> +	struct psp_context *psp = &adev->psp;
> +
> +	r = psp_rlc_autoload_start(psp);
> +	if (r) {
> +		dev_err(adev->dev, "Failed to start rlc autoload\n");
> +		return r;
> +	}
> +
> +	/* Reinit GFXHUB */
> +	adev->gfxhub.funcs->init(adev);
> +	r = adev->gfxhub.funcs->gart_enable(adev);
> +	if (r) {
> +		dev_err(adev->dev, "GFXHUB gart reenable failed after reset\n");
> +		return r;
> +	}
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
> +			r = adev->ip_blocks[i].version->funcs->resume(adev);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"resume of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
> +
> +			adev->ip_blocks[i].status.hw = true;
> +		}
> +	}
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!(adev->ip_blocks[i].version->type ==
> +			      AMD_IP_BLOCK_TYPE_GFX ||
> +		      adev->ip_blocks[i].version->type ==
> +			      AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +		r = adev->ip_blocks[i].version->funcs->resume(adev);
> +		if (r) {
> +			dev_err(adev->dev,
> +				"resume of IP block <%s> failed %d\n",
> +				adev->ip_blocks[i].version->funcs->name, r);
> +			return r;
> +		}
> +
> +		adev->ip_blocks[i].status.hw = true;
> +	}
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!(adev->ip_blocks[i].version->type ==
> +			      AMD_IP_BLOCK_TYPE_GFX ||
> +		      adev->ip_blocks[i].version->type ==
> +			      AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +
> +		if (adev->ip_blocks[i].version->funcs->late_init) {
> +			r = adev->ip_blocks[i].version->funcs->late_init(
> +				(void *)adev);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"late_init of IP block <%s> failed %d after reset\n",
> +					adev->ip_blocks[i].version->funcs->name,
> +					r);
> +				return r;
> +			}
> +		}
> +		adev->ip_blocks[i].status.late_initialized = true;
> +	}
> +
> +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
> +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> +
> +	return r;
> +}
> +
> +static int
> +sienna_cichlid_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
> +				  struct amdgpu_reset_context *reset_context)
> +{
> +	int r;
> +	struct amdgpu_device *tmp_adev = (struct amdgpu_device *)reset_ctl->handle;
> +
> +	dev_info(tmp_adev->dev,
> +			"GPU reset succeeded, trying to resume\n");
> +	r = sienna_cichlid_mode2_restore_ip(tmp_adev);
> +	if (r)
> +		goto end;
> +
> +	/*
> +	* Add this ASIC as tracked as reset was already
> +	* complete successfully.
> +	*/
> +	amdgpu_register_gpu_instance(tmp_adev);
> +
> +	/* Resume RAS */
> +	amdgpu_ras_resume(tmp_adev);
> +
> +	amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
> +
> +	r = amdgpu_ib_ring_tests(tmp_adev);
> +	if (r) {
> +		dev_err(tmp_adev->dev,
> +			"ib ring test failed (%d).\n", r);
> +		r = -EAGAIN;
> +		goto end;
> +	}
> +
> +end:
> +	if (r)
> +		return -EAGAIN;
> +	else
> +		return r;
> +}
> +
> +static struct amdgpu_reset_handler sienna_cichlid_mode2_handler = {
> +	.reset_method		= AMD_RESET_METHOD_MODE2,
> +	.prepare_env		= NULL,
> +	.prepare_hwcontext	= sienna_cichlid_mode2_prepare_hwcontext,
> +	.perform_reset		= sienna_cichlid_mode2_perform_reset,
> +	.restore_hwcontext	= sienna_cichlid_mode2_restore_hwcontext,
> +	.restore_env		= NULL,
> +	.do_reset		= sienna_cichlid_mode2_reset,
> +};
> +
> +int sienna_cichlid_reset_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_reset_control *reset_ctl;
> +
> +	reset_ctl = kzalloc(sizeof(*reset_ctl), GFP_KERNEL);
> +	if (!reset_ctl)
> +		return -ENOMEM;
> +
> +	reset_ctl->handle = adev;
> +	reset_ctl->async_reset = sienna_cichlid_async_reset;
> +	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
> +	reset_ctl->get_reset_handler = sienna_cichlid_get_reset_handler;
> +
> +	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
> +	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
> +	/* Only mode2 is handled through reset control now */
> +	amdgpu_reset_add_handler(reset_ctl, &sienna_cichlid_mode2_handler);
> +
> +	adev->reset_cntl = reset_ctl;
> +
> +	return 0;
> +}
> +
> +int sienna_cichlid_reset_fini(struct amdgpu_device *adev)
> +{
> +	kfree(adev->reset_cntl);
> +	adev->reset_cntl = NULL;
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h
> new file mode 100644
> index 000000000000..5213b162dacd
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __SIENNA_CICHLID_H__
> +#define __SIENNA_CICHLID_H__
> +
> +#include "amdgpu.h"
> +
> +int sienna_cichlid_reset_init(struct amdgpu_device *adev);
> +int sienna_cichlid_reset_fini(struct amdgpu_device *adev);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
> index d2e10a724560..82cf9e563065 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
> @@ -137,7 +137,7 @@
>   #define PPSMC_MSG_DisallowGpo                    0x56
>   
>   #define PPSMC_MSG_Enable2ndUSB20Port             0x57
> -
> -#define PPSMC_Message_Count                      0x58
> +#define PPSMC_MSG_DriverMode2Reset               0x5D
> +#define PPSMC_Message_Count                      0x5E
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 19084a4fcb2b..28f6a1eb6945 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -235,7 +235,8 @@
>   	__SMU_DUMMY_MAP(UnforceGfxVid),           \
>   	__SMU_DUMMY_MAP(HeavySBR),			\
>   	__SMU_DUMMY_MAP(SetBadHBMPagesRetiredFlagsPerChannel), \
> -	__SMU_DUMMY_MAP(EnableGfxImu),
> +	__SMU_DUMMY_MAP(EnableGfxImu), \
> +	__SMU_DUMMY_MAP(DriverMode2Reset),
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index fa520d79ef67..a73d241bb64f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -154,6 +154,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
>   	MSG_MAP(SetGpoFeaturePMask,		PPSMC_MSG_SetGpoFeaturePMask,          0),
>   	MSG_MAP(DisallowGpo,			PPSMC_MSG_DisallowGpo,                 0),
>   	MSG_MAP(Enable2ndUSB20Port,		PPSMC_MSG_Enable2ndUSB20Port,          0),
> +	MSG_MAP(DriverMode2Reset,		PPSMC_MSG_DriverMode2Reset,	       0),
>   };
>   
>   static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
> @@ -4254,6 +4255,57 @@ static int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
>   	return 0;
>   }
>   
> +static bool sienna_cichlid_is_mode2_reset_supported(struct smu_context *smu)
> +{
> +	return true;
> +}
> +
> +static int sienna_cichlid_mode2_reset(struct smu_context *smu)
> +{
> +	u32 smu_version;
> +	int ret = 0, index;
> +	struct amdgpu_device *adev = smu->adev;
> +	int timeout = 100;
> +
> +	smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +
> +	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
> +						SMU_MSG_DriverMode2Reset);
> +
> +	mutex_lock(&smu->message_lock);
> +
> +	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
> +					       SMU_RESET_MODE_2);
> +
> +	ret = smu_cmn_wait_for_response(smu);
> +	while (ret != 0 && timeout) {
> +		ret = smu_cmn_wait_for_response(smu);
> +		/* Wait a bit more time for getting ACK */
> +		if (ret != 0) {
> +			--timeout;
> +			usleep_range(500, 1000);
> +			continue;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	if (!timeout) {
> +		dev_err(adev->dev,
> +			"failed to send mode2 message \tparam: 0x%08x response %#x\n",
> +			SMU_RESET_MODE_2, ret);
> +		goto out;
> +	}
> +
> +	dev_info(smu->adev->dev, "restore config space...\n");
> +	/* Restore the config space saved during init */
> +	amdgpu_device_load_pci_state(adev->pdev);
> +out:
> +	mutex_unlock(&smu->message_lock);
> +
> +	return ret;
> +}
> +
>   static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
>   	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
> @@ -4348,6 +4400,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
>   	.set_config_table = sienna_cichlid_set_config_table,
>   	.get_unique_id = sienna_cichlid_get_unique_id,
> +	.mode2_reset_is_support = sienna_cichlid_is_mode2_reset_supported,
> +	.mode2_reset = sienna_cichlid_mode2_reset,
>   };
>   
>   void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
