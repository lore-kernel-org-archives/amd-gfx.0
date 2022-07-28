Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618EFC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 18:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF09A10FDE9;
	Thu, 28 Jul 2022 18:39:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D5F10FD8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 18:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W46Pgubl6h44yTvolNo6B5pg/U382aF8jDeysvlTk0oUAVngrhGA5q8IzexfkLizNxGKwOLVkV2Ymj/0zrUYLOIXVUZb0BcFAvkM0m45gX5I96fGKKJ3NUbGzLRvQJr75o8l192mTZqoEynF7CzEx9atyMlmhHvyik6AmtGDjLoHse1IS7milUA+GdNxfU9gAcbJGjr2PCMD5apP94c98m/e0C5s6xjRqTdfR9Rz2oaEUZCCwWcYFt7A6vNHE2uUQQ6ohDelv6jlCTOjG7EcotwmROsb0opwtk+xUZnXA6E9U3lSMMGx9J/ziYb5ti2QtXJjFYpcXO44JO5GbtMf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FB69lZUlBwvVL2kl3WCli1z2FuPVLYkswWpPw7zMt48=;
 b=BiRdgnEUwwm6KpUkqBANK8CUSgcEoSwYB2bVw+C3IwTbsljgQwjQfUdBbteJdp/c/iOMQHZWZjfFuaj7EpjxGVk7XyakN4UM8c0jWxg3WBEkW+BE3JUyJDovWPaT5mS2TJg7vYSmOTqeLF8Vexa1Dg/jZlv1oUjxOxC+4ZiFLZjBzCl7hrzYUVEd1y07jk7jLTcrqFaKsDHe6mvd1kHVf0NNDOE76P0U6ESnFAHAe5Wzr8F5XuJQPtc3Pamvd/yT2cj4GWWemxshVG5OqxI7hptEzVjmwJPSX54Yrh0Y6oyhSy+rS3s7y4HwJMG8Dk+hGkNchVsRWb0VKv+vRdBlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB69lZUlBwvVL2kl3WCli1z2FuPVLYkswWpPw7zMt48=;
 b=B5W5JgwREwRNkzl9XAT4IhxnCQ/94JEhvqMt7TxhCpUQn2YWCHa6p9TTUAZ9DjhLeZxKCvJeFAX4IPstGZ/eW8I5WS+BslphqxO9hEwKLExKPtZ0gxWmVa1Wjr0Hd+yGP9G+6hy+qUJD2V7igg+FKhzhbTdadj8BgBPSFntCWKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 18:39:42 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 18:39:42 +0000
Message-ID: <17b511a1-8f75-69df-3a64-cf1689071fd4@amd.com>
Date: Thu, 28 Jul 2022 14:39:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/6] drm/amdgpu: add mode2 reset for sienna_cichlid
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220728103027.27255-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::16) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c9ae0cb-55c3-49e5-bd0c-08da70c88920
X-MS-TrafficTypeDiagnostic: CY4PR12MB1943:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CV9O3vdGqimlruDMx1AdAWoSpS20mOZizH3TpGqY8XFrVBcj0JcyDYUdcWE+5JMCh8uwi+cCJ6VJvU+c0S4hxT4PcvKVdwpHg8fQ7UCnd44w3XytacyyEpWyiagIMOaT6okQBx4h4H6TnsXU+qDE2PaeRK58NJZsjD+yqAxbirc+A/XcTphuHc1A0xD2k1tdAqsQFtb442f+yxWFtK+MTrlFe9CZMWeBTbJ//0n+6RUu64ejpyYrQN/RI649cA3EPhznsO1QVhLNNz0Lb1mDVAJxGtSEjozakJy8A04ic+y2vm5hWN7nNmhtq9XrUr+haGzyzb9Fe1NDZMGPntgNF0D4RrU0m14L/1Md4CNK3rQ8hzmDOqgFV1YVVR17mecU1sPOQfC643LX/aKzG4F59WLVLMvcUE/EcVplEYCXsR3mTIS5XFskB2WR7bKZBb1H74FEHrE9R4bGw/m2teLxe/yKVtVtrKOg0bbpv3tvvmfhQO2Q6p0hLBRw5NLYXpOvd7zd4oOpazxtRJ7E/jCieKNSop4uKrQdyfd94su+lNOM1bc+a50B/rcgxPYwD3w9hUrbPmwqBRmnuXRZ8QmIxY3CAxo1j2RgRQIr/E+Ul6llfIF+wZ09lYC/3qtIwbzjyG4gZdw9fHA1QPH5r2iIb8+GMwYrdH+D8Vc+J4Wo1snFqkThpdPlZswhombRIservh+yfRPcMkCaXfwiJ+rMC8ckQ5ygGF+jDfmpVh1DBj4fGvbd5ia/RsT0p3K3ZElGVr1rJRou/tDkOSbJxKCaILECcnlvvBSEIjHEP+YL+0vUe8zjUzZi/zuTaOaRNaHXxSTngJyyzzn/Kk5Y9EO18A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(66946007)(83380400001)(316002)(31686004)(19627235002)(36756003)(30864003)(38100700002)(186003)(53546011)(6506007)(31696002)(2906002)(66476007)(6512007)(86362001)(8676002)(2616005)(8936002)(4326008)(5660300002)(6486002)(478600001)(66556008)(44832011)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2hZTTJ4SUFKODBwajFRMjFXdmY1dEc5ZnZGY2dqWjNUOUIyVW9qZ0VzMEpH?=
 =?utf-8?B?eERmMytpbjNBMkRKR2VzY3RDL1FnaXVzb2FRc2JpSTJHa2VmTGJveHhDS2lr?=
 =?utf-8?B?VzRLYXpxcm9LM2owWndHMkgra3ZOOE9mRGNGaXppSFBvR1NrWjhsb2VMZ2tm?=
 =?utf-8?B?ZG9ORkNjdUd5Qk53TThBQXJoa3djV1JYL3JVSjVNWmNjOHBlaDJYbDNiU3Ur?=
 =?utf-8?B?WExhTTVoc0tkWTJQYmFwSGR1NGxBNjFaeWVEVlRLVjhMYVFXclVTTm9kMU1j?=
 =?utf-8?B?TmFTUVJoTlpuemQ2VWZwSWVVYzVKTkI1WlRLa1VQUVgzb2p0K2pFSGhQMmVJ?=
 =?utf-8?B?UXQvNWxLeW1pdTVCL0lmNFIxT0dnNmdzaXdlY3l5citaTzZSZi9rbU43NkE3?=
 =?utf-8?B?TGNrREdUa3V1ZWlHa2Q2UnM5Z3ZGMTNnY0hvM016S3ZtL1A2VTA4Z2IyQUV5?=
 =?utf-8?B?L0lSVTJQenlraEhoN1lHdDE3K1UyWWFyTkI2dTZUZU5QY1lPbERJK1BMR21x?=
 =?utf-8?B?dVhxaXE1TzZsK0VSRXNMajJ3MUNBZ0lub0NjL1FGSEpreCtEdUg1aFBzMlFa?=
 =?utf-8?B?aGl0SDUvek1uWDVKaGdGNWRHY3hDNXM0SG84dzV4RjhpRm8ySjJta2FzaGtn?=
 =?utf-8?B?S0xwbGlyYlpxYXI1SzByV25lb1FjLzl0OWdPOHRTNHNkOXU3VnorY05iSkRC?=
 =?utf-8?B?dTc4TkQ3T2p0ZEEwejl2eDVwYWFnNmJvbDlmbThQSDVmZFpuZWJzZEdtdUNN?=
 =?utf-8?B?NkxmSXVqeTN0ZFEwQ2didGR6cXZzU0sxaE9qVUd4QWxrK2Q3WHFRZ3RzZDhk?=
 =?utf-8?B?SzRWN29qMUhDd241bFNBSlNnbFpNdjczY3Y2cVNqdUFkSTl0ZUJvM092ZlFG?=
 =?utf-8?B?bnZwTE03NDZuUFB4d2pXbFc0NnRtWHFqWTZoZDI2bFFZTmxRQUFrVzV2dEJp?=
 =?utf-8?B?ZWZ4bHR4Rm9jSmJPN05UN0I0aytXN29IMEtIQzN1TCtIYWplNFRkOWNMOVRK?=
 =?utf-8?B?NUs2T3JoK3NZbHFmSk9FdVprdi9uZUw4b2RKTnlMdXpxTDFxaklMbUtIMUdy?=
 =?utf-8?B?b2RpUVUyeVJvZDJETW5SUkNibWxuVktkV2VxUGl4M0hIY28xcEhFZGY3d2xh?=
 =?utf-8?B?eEpSWTRyNEVSVnA1dWdHc3dGZlJqN01JdmRFZmc1QlFtUDJhTXhzODFWdG1r?=
 =?utf-8?B?K2tvc2R6Z3J6T0REaXJFTUhVWlBNR1l6S1ptRUlGUHNuS2JVUnIwWjZuQWhF?=
 =?utf-8?B?V0JMbVFqSjArckdLMmdrNXJZOTN3MDJOa2NwYW9kQ1RsT0xLeDAvYjhaUk9D?=
 =?utf-8?B?QXVZdWJCSVo2MzhrbDRkY1ZMeW9GYWFnMEVJam5welZTV1JxT29QbWN4SzRk?=
 =?utf-8?B?SytLYS9HVm41NXpsY3ZGbDlhYVBiQTFqZGl6UUlLU28xWU8wczNTTHBxSVE1?=
 =?utf-8?B?c1hZTFlvdDJoRU5xSGVyTllPemtvS2E5dENuZUQzUlJFZGVwck92eURRRzBE?=
 =?utf-8?B?SUpHRXBTeWdDclZmR1dUcWU1L2ZtRGZWVlJpSUljblkrK3lYNUR3OUUyU05Z?=
 =?utf-8?B?dGNXSTNHdWI0a1VFMkV5WHhrc2E4Y2tDT1BvSGZKLzJQeVovaWJTU0c1aXZK?=
 =?utf-8?B?UFhnSHVOOVVzZWd6Nm44MUM2Z0huc1hpZTRNSzhuTHllWUlCTFdkc0tkV2Jq?=
 =?utf-8?B?YTVFdjBSY3ZzZUFuMGFFWFNDYTVCMjQvd2VTWWFDSGhLVitvaXcrK0VxT256?=
 =?utf-8?B?SWoycG5BczdCY2poTXdjNDdUaXkvbGtac2svUnVSeXZCU0s2cnNFME9rZmpv?=
 =?utf-8?B?ejhEajBlTUdMSU03STJzSHUvZmc4L1BQWnMxRzE2OFZ6TVVrT3Q0Tm1QODUw?=
 =?utf-8?B?cDB1a1h6WDBRTmJDRWVZNE1YUGdYTnFwaG0xMXlUdFVraFpGTVhWejZxbFJs?=
 =?utf-8?B?Ty9RV2tzY2QxbXVHN25nQmtIK3FMMEhObzRJTEcvRnh0M1R0RzZFMUViQno1?=
 =?utf-8?B?VjVZSVVrVU84MS9sOWx1dXNQbk8wWkpCRXI1VVpzRmoxVS9hTk1wcWlHZTZT?=
 =?utf-8?B?K3JYTmE0RzFvK3FmZHNlc252TGVWTVNRSFR0d0Y0WFNUdEY1cGpiWXR3L2t3?=
 =?utf-8?B?YkQ3bFo4cG9ycmdobzZXK1ZtY3FkV0x0dUczODgvbjlUUG5NYnZrVzJvaGRo?=
 =?utf-8?Q?5LrVrkZVc1AbJ3Fzh7IsdgV1cyl8jWxT3Cgj/zFvHyPX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9ae0cb-55c3-49e5-bd0c-08da70c88920
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 18:39:42.4146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WcAhGNb1lts5tREl8F+Koq7k3wvExxHwXntYGoOfC5v0MrXhIVs9ZVKkmve8NOp9wBuuBwAnqind8u61srB4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1943
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


On 2022-07-28 06:30, Victor Zhao wrote:
> To meet the requirement for multi container usecase which needs
> a quicker reset and not causing VRAM lost, adding the Mode2
> reset handler for sienna_cichlid.
>
> v2: move skip mode2 flag part separately
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   7 +
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   | 297 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h   |  32 ++
>   .../pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h  |   4 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  54 ++++
>   7 files changed, 395 insertions(+), 4 deletions(-)
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
> index 000000000000..0512960bed23
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -0,0 +1,297 @@
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
> +	adev->asic_reset_res = amdgpu_dpm_mode2_reset(adev);
> +	return adev->asic_reset_res;
> +}


Why do you need to set adev->asic_reset_res here and
not just return back the result ?

Andrey


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
> +		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)
> +			r = adev->ip_blocks[i].version->funcs->resume(adev);
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
> +		tmp_adev->asic_reset_res = r;
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
