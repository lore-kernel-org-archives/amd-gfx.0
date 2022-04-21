Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE14C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 09:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D13B10F88A;
	Thu, 21 Apr 2022 09:23:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D32510F88A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 09:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQFHV+VgN+12nK5RNkpORTLlPoBRXjkJTPDUTH7iuFLaSyw1VKLkmPyyNMVn3G0xtM/0ruMkpRdZgpOii+7Ph+7bmE3Kej4pc4IgoHyQBlbufZNXy4OCofiK2sdYGoXNVMvcLzu976sw0v8gJuoKd5CCzRwWyzpmje/YPSgxv3f2OT3dJIqDWtbqyXwhZyOKNtkPb1E50Li4NARZLhoHDw4mvkrbmvXJjJ1p5n/TuKWl15wCrrdx/cTW0865tFoaYLlS0C9o8eU3CVlond0GwIuEqmtoxExDUAekrPwdZiPNTvkpZsoHkg6CKgy88fqBmdKpP0KuCGAwmYpg8FMeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOaxysktpqKWIcvpzy//J2xq9jXjBwoFQPSOTPBU3lA=;
 b=VKz7PKDLj+Wa3j2eUgT0k9uLBRaj5ysMmRAREBi7YIQ76QzEiYpbmU48AZj6DGKIIXOCvd4for7qT32yTVIMx8PH4PZxIFp0Evt5n3KYqYz2KyzL5r4A5zKZ7KCZdnIyS/PNPEiRv7WeC8GG55k6kockTnFDUOJWO/yWcmPut6eT2iHwOMuFD5cSImpTKzttpSWkqtxuJ06SsYihkEFWAw58JR9jrXwLWy/g/FuS5FFjXRIclZyGxAlLXvWtoezlFjp3siGJ6GP1I1SqTb8qF8IXlvg7zZjVtNX71csPJ1q1IlaiIZGHKyfWGLDFt0aMCUK9Ldq4AT3h7uHaoJBqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOaxysktpqKWIcvpzy//J2xq9jXjBwoFQPSOTPBU3lA=;
 b=cFsW8jSbK3n12H9UKxtcY3WrahBSpkznLzU3+sHVI8ijhdD6/qtndyiKInDmIjC6lFv4W9FfmJCQYYFy7WnTLjCP9bDU3Bsig4wNvHKPuHaxBHYhJJWyQ/XN3WZ4/qDeh8LN3yh+nOOA1gWpj8LnSgmYv8Ex923yt9tMx1kp2js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM5PR12MB1484.namprd12.prod.outlook.com (2603:10b6:4:11::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 09:22:57 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 09:22:57 +0000
Message-ID: <a48beb99-5843-b457-9382-dd46d7b50ac5@amd.com>
Date: Thu, 21 Apr 2022 14:52:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke
 support
Content-Language: en-US
To: Candice Li <candice.li@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220420111357.9488-1-candice.li@amd.com>
 <20220420111357.9488-2-candice.li@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220420111357.9488-2-candice.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::28) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fccc883a-dbac-47e4-316e-08da2378854e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1484:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1484AA9FF9FAF352A52D58F697F49@DM5PR12MB1484.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNu0nUIPQ8pBFRwEw1fQjc6LvsSljERlrcGwpIPQQR3+oDfoC1SvMOPsPUnAi5dr17U5yQyksep9AkKPUDJy0kg5qthH6KNtGJhgrBNcW4mD2l3ZGorPmkKFk1DAEyLhu4FxcPrT0y2QiHLj9HdQA3717G8cjVAR/s6DE5zrZ1Ly0XEZiTxV85BghdDHx55Hi3HwipFraR8nJoKTaC+9iaTrU5en2kMxuACNix6vR6ZMDZzmWFM4RGu8/AN3be9mWE+E1qVx2BeacbZKtRDUMR9ru+vA2BfXJf/yhB2+4+aHqtKrAwcjVXkDKrIMA7fQEn2G84r7t/7chswMfKESCBnZGbqMCWvN9yJ75DqboeHFQWNneshZ/z+gQwgYgYCo+QS85+ok1x5fGRlKLriVG5v7lhGrE2iBXO1bvaJu/jvzCig9CidBSxDjuXs4xcl/YKemBoVbrcetWNIyRXaSlph555W99SEDl4RgPGSP22AVkcGEEgKN0jSj4N0guAteKW799xjy5+gT++7alllsGzQTcvI9elJs6QLRLIwO5fS6eWBz8d9xjyhOf1ZvXpNWn7nbkNo20u2CVUczjTDAE67X5aRnK+q5q4HvHsg11R4YlfKXzlE11Jk1DPGuJK8tEwwcRZGtoCq/3x8xBJLNY/i2GM2NY2ZOMWt4/BU718L5X0yRMur0SlSdwZTxkkoK3RQHz6bAAeAnJLs00lUijH3Pc5X3QfVwOo/tEy9Ty1lFuE3I9JRp2ZWXdEpzZwsyQbzqDc/Z4a9Ex6HBnDpYOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(4326008)(8676002)(66556008)(66476007)(66946007)(36756003)(6512007)(8936002)(5660300002)(30864003)(508600001)(6486002)(2906002)(316002)(31696002)(53546011)(86362001)(2616005)(6506007)(83380400001)(26005)(186003)(6666004)(38100700002)(461764006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFFOHoyUGZXTlNndjk3dE9LeDhrWVNOVUZBZlY0ZjZFaE0zOGR3a2hERE9K?=
 =?utf-8?B?eGFVV1JQd1Z5N0ZJV2xGNFp0c0tqdUF4MDBNQVFvOTk4eUxGV2NTQ0FxZ0ti?=
 =?utf-8?B?aUFESDRiM2V0R2REeWJkQk8xZ2VvNGt4aGpoWStOM3J0WnAxTXZucVgrY2I1?=
 =?utf-8?B?SjBrUDNjVldLcVk0NDZFMEkyZWZoeWxaUVNoK1ZkbkRwaWpFbDlJQ1B6N2JE?=
 =?utf-8?B?K0dhQmR2QUNwYTFrS1VxTHBjY2xjZ0t6cTBieTNjdHlublpOVTNpdG95WjZL?=
 =?utf-8?B?Zll4VXZJOE9sSmZ2NnF2Y0xpTzhBVW9FSVFNcmdPQTYyWHhMNlNWclJnaHk0?=
 =?utf-8?B?RUI3VGZVOVJsZzFhYnlIVDZnUGdhQlh6Y0ZuSXI0UjBpQ1I3eGQvV2tjVVNz?=
 =?utf-8?B?VkhiT1IvUm9VZ1owZVF4MFV5dVh4L2hDSERCaFdDS1Nkd0d1MVpXMnZzeU54?=
 =?utf-8?B?Wmg0K1ZWbXVpcm1qSE1uUXRDenFCa3hVYzNuSGp5MTFIc0xnbllNaUU3emVv?=
 =?utf-8?B?dThMTlJPdGVzY1lnV0J6VDdMK0JRT0JqWWxKSzJxMjBZR200Y2J5Q0NkQmFF?=
 =?utf-8?B?eEQ5QzdXOEVFcVVvdGNJdE56QlpmdkVOdFNDdEJnbVhlTVJxajJ5b2ZpRmt5?=
 =?utf-8?B?T2hha3dEd2pGNGFJS25JUkJHSUFPZ0FTeWRJOVRCS3pPL0haR0d5TkhJNFBJ?=
 =?utf-8?B?YUZPRWdFaUxnVGE2cGRTUjYreVdPUmVENE9rMVUvS1kzODlFQTV1ckM4S1di?=
 =?utf-8?B?SFp0OWhEYXIycFdTTWxPMURLd204dHVuWHJoVkppN1NGT1lGb2x5eHVSZlNk?=
 =?utf-8?B?VkhndTRXR3dsK0xqZ3BaaDhsTnNCNjhoVzQxZmNkeGRYZ01HanlrcEJ1WDRi?=
 =?utf-8?B?WWNweHY2UUdjRXp0WllBM2RsZ0FibXV1dlZrUGdpMGlxU2lETEtGeThNUEZz?=
 =?utf-8?B?Yy8wSEhyTEZramZKTlJBbjdVSUVYbnFld0oxVktTVEE2SFJ1WFhNaHNqbWxT?=
 =?utf-8?B?VzNkZVlFNHY0QkNSZ1RRRytVaVYzMnFqWFIvVmxvZTdNb0FGZ0tzdXROZEJQ?=
 =?utf-8?B?NHB2eWJPRUh3eDVta1RHdkxydTBhKzlLeVdzZEpZZnNvMFFrZTQwZWp4aks3?=
 =?utf-8?B?TWxTMDVDYjVpMTlyS05OaUFXaktia3hnZlpXNlZ1VzVSelJnbWx2UGxXQ0ZO?=
 =?utf-8?B?bUhFVEs2Mi9OSjNIWU5rcStDVm9UUC9xSXpiNTdPT2tXaEtsOUp4aG54Zjdp?=
 =?utf-8?B?Rk1pWjJEZkUxK21zT0o4RzdWckwwNVAzMGN3R3BhbWYzd251R2JxTWtIajBG?=
 =?utf-8?B?YmQyS1EydTNMN1hoY2V5RU5tZENTQkZvbzZTRzYyc0dFUDVXODI5dXBib1F3?=
 =?utf-8?B?bjlUODBpb1UxTE5wUUdqclBmL09wdGgxS0ZTSDB3SEtRNW8vZmk0WlhLSi9t?=
 =?utf-8?B?VjlNb1JQSkNZaVgweDAzUHR0WWZSWnpxb1FrVnhaSnlEaVhSVUJKTU9zalNl?=
 =?utf-8?B?RmZ0eXUvNWt1VU92U1I4cFo5bHNQUlA2cTlWcmsrQTBuak53RW5aT0xmNEMw?=
 =?utf-8?B?eXR4UmJPcHVYbnZJTjdYOXg4bm9DZDhFV0VrbHA0YkUralR4R1E1YXFkcWNr?=
 =?utf-8?B?SmNFZHlTMnlVb2VKTkpPSDV6bVNhbjNaSnkzS3A5RXFYL1NRdExNY3QrQ0tl?=
 =?utf-8?B?WHIwZkF3K3NLZWhCSVVyU3ZIVnYvdWQ1VEtMQ0ppdWdRcno5OTJwU2FpdWVr?=
 =?utf-8?B?UDZFMTZlUlRLU1NCMExCcy83c0Y4UmNBVGZ6cnE0Z055VHl6MDZMOFo4VFg4?=
 =?utf-8?B?ODNLU2trcGdKK0xKcWF6R0RBd3Qxejh5Ny9tT2NZRVhOUzJXbHFmd0dOTVdB?=
 =?utf-8?B?OWthN3E1a3NtYk9kUXU2WVJHMmR1NWJlb2p6ekdFUmpBU1BwVmdWQWJ0YzZG?=
 =?utf-8?B?U05IYm5yY1hWd2lBd2xuaE5zdGVFTlNWdW1NL0RPb0hvMDVkTTRmYmUxTklh?=
 =?utf-8?B?UDBManFoVmlGWHZHZ2tKRVFSeTdOTW9Yalh3K0F2OFhPaEJPTE12UDBQRjI4?=
 =?utf-8?B?dnRLdEhkcWtZUFZLcWd4eUFyU2RQakMvN0dveGQ4cDgvQllDV2hudG5NUVBu?=
 =?utf-8?B?dXZSUXdTSmgyclNPVWhncWtjQ3c1SG9lSlVHSmRrR0VQTVBTV09nUGdKS1A3?=
 =?utf-8?B?dTVXeWxlak9PekVlUGt2UDJRbGRLSWIwZUREemkrR1BzY1VGTVJVM0svLzNM?=
 =?utf-8?B?a1BUSFFDL1AySURtZTJHcmtpS2FjY2F3TUtTNDNzUVBFRVNUbUl2NmM5eDkr?=
 =?utf-8?B?c0s1UStyUkMzSXpFd0N5Q0V3NlBnak16cTlkUlpKQjBUdHAyYUVBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccc883a-dbac-47e4-316e-08da2378854e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 09:22:57.0263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlQHMcfs3nHH1QWEdkA9rFtyKzEu4WLP6JH5TZVfYGEcsDaaIjz6eLkYVRJ1ErcB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1484
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
Cc: John Clements <john.clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/20/2022 4:43 PM, Candice Li wrote:
> v1:
> Add debugfs support to load/unload/invoke TA in runtime.
> 
> v2:
> 1. Update some variables to static.
> 2. Use PAGE_ALIGN to calculate shared buf size directly.
> 3. Remove fp check.
> 4. Update debugfs from read to write.
> 
> Signed-off-by: John Clements <john.clements@amd.com>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 308 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h  |  30 ++
>   4 files changed, 341 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 7d7af43a258f83..b525f9be9326f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 13e4d8f9b87449..eedb12f6b8a32d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -38,6 +38,7 @@
>   #include "amdgpu_umr.h"
>   
>   #include "amdgpu_reset.h"
> +#include "amdgpu_psp_ta.h"
>   
>   #if defined(CONFIG_DEBUG_FS)
>   
> @@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   		DRM_ERROR("registering register debugfs failed (%d).\n", r);
>   
>   	amdgpu_debugfs_firmware_init(adev);
> +	amdgpu_ta_if_debugfs_init(adev);
>   
>   #if defined(CONFIG_DRM_AMD_DC)
>   	if (amdgpu_device_has_dc_support(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> new file mode 100644
> index 00000000000000..247a476e63544c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -0,0 +1,308 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
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
> +#include "amdgpu.h"
> +#include "amdgpu_psp_ta.h"
> +
> +static const char *TA_IF_FS_NAME = "ta_if";
> +
> +struct dentry *dir;
> +static struct dentry *ta_load_debugfs_dentry;
> +static struct dentry *ta_unload_debugfs_dentry;
> +static struct dentry *ta_invoke_debugfs_dentry;
> +
> +static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
> +					    size_t len, loff_t *off);
> +static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf,
> +					    size_t len, loff_t *off);
> +static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf,
> +					    size_t len, loff_t *off);
> +
> +
> +static uint32_t get_bin_version(const uint8_t *bin)
> +{
> +	const struct common_firmware_header *hdr =
> +			     (const struct common_firmware_header *)bin;
> +
> +	return hdr->ucode_version;
> +}
> +
> +static void prep_ta_mem_context(struct psp_context *psp,
> +					     struct ta_context *context,
> +					     uint8_t *shared_buf,
> +					     uint32_t shared_buf_len)
> +{
> +	context->mem_context.shared_mem_size = PAGE_ALIGN(shared_buf_len);
> +	psp_ta_init_shared_buf(psp, &context->mem_context);
> +
> +	memcpy((void *)context->mem_context.shared_buf, shared_buf, shared_buf_len);
> +}
> +
> +static bool is_ta_type_valid(enum ta_type_id ta_type)
> +{
> +	bool ret = false;
> +
> +	switch (ta_type) {
> +	case TA_TYPE_RAS:
> +		ret = true;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations ta_load_debugfs_fops = {
> +	.write   = ta_if_load_debugfs_write,
> +	.llseek = default_llseek,
> +	.owner  = THIS_MODULE
> +};
> +
> +static const struct file_operations ta_unload_debugfs_fops = {
> +	.write   = ta_if_unload_debugfs_write,
> +	.llseek = default_llseek,
> +	.owner  = THIS_MODULE
> +};
> +
> +static const struct file_operations ta_invoke_debugfs_fops = {
> +	.write   = ta_if_invoke_debugfs_write,
> +	.llseek = default_llseek,
> +	.owner  = THIS_MODULE
> +};
> +
> +
> +/**
> + * DOC: AMDGPU TA debugfs interfaces
> + *
> + * Three debugfs interfaces can be opened by a program to
> + * load/invoke/unload TA,
> + *
> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_load
> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_invoke
> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_unload
> + *
> + * How to use the interfaces in a program?
> + *
> + * A program needs to provide transmit buffer to the interfaces
> + * and will receive buffer from the interfaces below,
> + *
> + * - For TA load debugfs interface:
> + *   Transmit buffer:
> + *    - TA type (4bytes)
> + *    - TA bin length (4bytes)
> + *    - TA bin
> + *   Receive buffer:
> + *    - TA ID (4bytes)
> + *
> + * - For TA invoke debugfs interface:
> + *   Transmit buffer:
> + *    - TA ID (4bytes)
> + *    - TA CMD ID (4bytes)
> + *    - TA shard buf length (4bytes)
> + *    - TA shared buf
> + *   Receive buffer:
> + *    - TA shared buf
> + *
> + * - For TA unload debugfs interface:
> + *   Transmit buffer:
> + *    - TA ID (4bytes)
> + */
> +
> +static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
> +{
> +	uint32_t ta_type    = 0;
> +	uint32_t ta_bin_len = 0;
> +	uint8_t  *ta_bin    = NULL;
> +	uint32_t copy_pos   = 0;
> +	int      ret        = 0;
> +
> +	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
> +	struct psp_context   *psp    = &adev->psp;
> +	struct ta_context    context = {0};
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	ret = copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t));
> +	if (ret || (!is_ta_type_valid(ta_type)))
> +		return -EINVAL;
> +
> +	copy_pos += sizeof(uint32_t);
> +
> +	ret = copy_from_user((void *)&ta_bin_len, &buf[copy_pos], sizeof(uint32_t));
> +	if (ret)
> +		return -EINVAL;
> +
> +	copy_pos += sizeof(uint32_t);
> +
> +	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
> +	if (!ta_bin)
> +		ret = -ENOMEM;
> +	ret = copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len);
> +	if (ret)
> +		goto err_free_bin;
> +
> +	ret = psp_ras_terminate(psp);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
> +		goto err_free_bin;
> +	}
> +
> +	context.ta_type             = ta_type;
> +	context.ta_load_type        = GFX_CMD_ID_LOAD_TA;
> +	context.bin_desc.fw_version = get_bin_version(ta_bin);
> +	context.bin_desc.size_bytes = ta_bin_len;
> +	context.bin_desc.start_addr = ta_bin;
> +
> +	ret = psp_ta_load(psp, &context);
> +
> +	if (ret || context.resp_status) {
> +		dev_err(adev->dev, "TA load via debugfs failed (%d) status %d\n",
> +			 ret, context.resp_status);
> +		goto err_free_bin;
> +	}
> +
> +	context.initialized = true;
> +	ret = copy_to_user((char *)buf, (void *)&context.session_id, sizeof(uint32_t));
> +
> +err_free_bin:
> +	kfree(ta_bin);
> +
> +	return ret;
> +}
> +
> +static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
> +{
> +	uint32_t ta_id  = 0;
> +	int      ret    = 0;
> +
> +	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
> +	struct psp_context   *psp    = &adev->psp;
> +	struct ta_context    context = {0};
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	ret = copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
> +	if (ret)
> +		return -EINVAL;
> +
> +	context.session_id = ta_id;
> +
> +	ret = psp_ta_unload(psp, &context);
> +	if (!ret)
> +		context.initialized = false;
> +
> +	return ret;
> +}
> +
> +static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
> +{
> +	uint32_t ta_id          = 0;
> +	uint32_t cmd_id         = 0;
> +	uint32_t shared_buf_len = 0;
> +	uint8_t	 *shared_buf    = NULL;
> +	uint32_t copy_pos       = 0;
> +	int      ret            = 0;
> +
> +	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
> +	struct psp_context   *psp    = &adev->psp;
> +	struct ta_context    context = {0};
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	ret = copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint32_t));
> +	if (ret)
> +		return -EINVAL;
> +	copy_pos += sizeof(uint32_t);
> +
> +	ret = copy_from_user((void *)&cmd_id, &buf[copy_pos], sizeof(uint32_t));
> +	if (ret)
> +		return -EINVAL;
> +	copy_pos += sizeof(uint32_t);
> +
> +	ret = copy_from_user((void *)&shared_buf_len, &buf[copy_pos], sizeof(uint32_t));
> +	if (ret)
> +		return -EINVAL;
> +	copy_pos += sizeof(uint32_t);
> +
> +	shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
> +	if (!shared_buf)
> +		ret = -ENOMEM;
> +	ret = copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf_len);
> +	if (ret)
> +		goto err_free_shared_buf;
> +
> +	context.session_id = ta_id;
> +
> +	prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
> +
> +	ret = psp_ta_invoke_indirect(psp, cmd_id, &context);
> +
> +	if (ret || context.resp_status) {
> +		dev_err(adev->dev, "TA invoke via debugfs failed (%d) status %d\n",
> +			 ret, context.resp_status);
> +		goto err_free_ta_shared_buf;
> +	}
> +
> +	ret = copy_to_user((char *)buf, context.mem_context.shared_buf, shared_buf_len);
> +
> +err_free_ta_shared_buf:
> +	psp_ta_free_shared_buf(&context.mem_context);
> +
> +err_free_shared_buf:
> +	kfree(shared_buf);
> +
> +	return ret;
> +}
> +
> +static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *adev)
> +{
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +
> +	dir = debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
> +
> +	ta_load_debugfs_dentry = debugfs_create_file("ta_load", 0200, dir, adev,
> +						     &ta_load_debugfs_fops);
> +
> +	ta_unload_debugfs_dentry = debugfs_create_file("ta_unload", 0200, dir,
> +						     adev, &ta_unload_debugfs_fops);
> +
> +	ta_invoke_debugfs_dentry = debugfs_create_file("ta_invoke", 0200, dir,
> +						     adev, &ta_invoke_debugfs_fops);

This uses global variables, is this tested on a system with multiple GPUs?

Thanks,
Lijo

> +	return dir;
> +}
> +
> +void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +	dir = amdgpu_ta_if_debugfs_create(adev);
> +#endif
> +}
> +
> +void amdgpu_ta_if_debugfs_remove(void)
> +{
> +	debugfs_remove_recursive(dir);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
> new file mode 100644
> index 00000000000000..883f89d57616d0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
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
> +#ifndef __AMDGPU_PSP_TA_H__
> +#define __AMDGPU_PSP_TA_H__
> +
> +void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
> +void amdgpu_ta_if_debugfs_remove(void);
> +
> +#endif
> 
