Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC29C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2076910E36E;
	Tue, 22 Nov 2022 05:34:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2686010E36E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z52B8oRuxVS/dXN4/XNSqOPIKhfUcHf1sBP4dyoqXDG0vRbkLd/+FxTg8tIz2Dwwy/l28Z+iFmykpmnoFqt6DwGVTLQn0/dG054AZh8S67FdqrYPziouCllnW3ZD+H+2TaY6Ag97jkCq7mOJE1VXX8G0hl+FzB5B/KZSmr57XvnXoY2anldHkI91U4KTuYcva/Lu2k1n0YPQtx+n/jjhcuyoZ8qgZ2+qvN09AHgjm831zPKriCBd1210swwYRmQG4xWL0XhU81Z+F0RGv8+q4nRN57eJP/BrfxI/BbL5ssyGMCEVuGLbMrLjHppQYcn8sXSw1XFuqwncFO++cqsl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l+ViOMl0OlUGrPWfHblHPKg4DqGwHE2ZlKVRyuzk3Y=;
 b=Xgx7AVM2vylgsVDHCTXZSMFlBUGjUWB1eHcu1aiHSYUW42D2wNtHJY3w/qjFolgg4/QfTzzrSnHuIu5ehtif1CpqSkba+s2YuA09ClRCkRTLsLQVqxYQuN4FShWnzuSNWsJ3c+UcPXtNN/hUR8c3Bv5n8sc31P/64B3LIQY+bx35ZqtFlhMC9JkIOYVqHTn5SgpbBvC+aA+/wdNvFMziVZ6rHd1fBWXFPr1mpeQmfBMAzBFB37zCvGY0BQKC0Qq4P4c5J6Scqje/LXBufdjfdrqFER6Z/MNS79IIkE166rlX0/Z4lVd5s/9hpFm9Bm6c1w1sSCR6f68drJSJXjk2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/l+ViOMl0OlUGrPWfHblHPKg4DqGwHE2ZlKVRyuzk3Y=;
 b=TojDqy6JLwbM9PAwRoIYTW8zrCjZ6AggS/lXtIFY1Mk/49cVqsmCdkUqMX+6N8MoHFeseuEjKpPLCGqRtGnK/ZP77oJ0ku3MLGMi7hlWuJNPbcWtVLR4i+5R+j+CrI4ZHuCWga+I9wdrX0D2Ge2ElCusmoJCwJIzgzuOawBsXQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Tue, 22 Nov
 2022 05:33:58 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5834.009; Tue, 22 Nov 2022
 05:33:58 +0000
Message-ID: <3c58a7fc-6c93-44cd-ab73-04ce917f964f@amd.com>
Date: Tue, 22 Nov 2022 00:33:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] drm/amdgpu: Introduce gfx software ring (v8)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221018090815.2662321-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 01328785-f102-4b46-bbec-08dacc4b2757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Z0cMHppXCGOaPdOyPPEH7QNwIR4hkTA3VDcx88KA5aCXwBYNNUVV2PeMdZh5HNBcRWv8sBIpESvuebKmmqE+Sh8Dfy+YQwovuRTzNUNU6JcSVaa9RdjfbXN0os+wjkColw9Ym4kMjvuJemx8K9crXQmgei8atB8AyuQs6yCdSUh0p4dWpCVisK3QAWntjkR2iP+heWAkALKQxs3yY34zuMK9AIqLIzcSHTXJVPW19ji+r1gmEC6ApS50wqwRCQEY1bS4bExKAdkFyViCaA1k9qaqLMS3fPgif/kqXLdJxMeL3H8lP+hjGf4qPVDR/xjFxifJKoCslDQTyliYJalqYjX5PODhnv41XCw54gCoOcs5E6eD9AtTaLo2CaQtbLk0to6cmpMvUq3sh76f1PbaVRnTPT7geGsW31iWScxl7xPRtl8pWh8iPTzyrdY6MOZXaN0D8qYjFk2grUmWrbF70IzFQSsWDGPpp5cm31rk+34/rij14tZHZgP8a0utglnVq9CSNU1oUdDaaWh1ALiUP4A/Fc9WQF2dc/XDzLlNRbdSGfo+US8prFdaGTHJSRWpCLbYsH56fG+rOX8LT4KxvvPS5pZL051uwy+O8g4BG9XqHMxMxfSRc2mBQqv5XeB8pgGvOSJ4FLspDEOUw2CuPLqZspM+jnzM7rTuCOCarNCzgVXz+4VpCEQhjYJapIQllyLi0KIv6wDfuBATOIgZlxoJHNRUcAp3eLcgWMILCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(478600001)(6486002)(66899015)(31686004)(53546011)(6506007)(6666004)(186003)(36756003)(316002)(31696002)(54906003)(6512007)(26005)(86362001)(41300700001)(66556008)(66476007)(4001150100001)(2906002)(30864003)(5660300002)(2616005)(44832011)(66574015)(8676002)(4326008)(83380400001)(8936002)(66946007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0VrSXYyZ2ExSFRoM1gyNStHMk1JaXlyakw3UTNldm5pOUI4VXVUY3A4R2oy?=
 =?utf-8?B?R21iekhnUXZTSnlub2RiSStVbURIQWE3KytEajFwbDU4SDhFOUwyL0tiTDNV?=
 =?utf-8?B?ajBLQkc3NlRXRkgvWFRhcHlNZFJHQllNc3o4bzQ2dEhOU2lOdGI4MTkveERS?=
 =?utf-8?B?ZkUxbEFPeXZvSVFJRkdBRnhDdTJlRUNGQXAzd0VVaW90Z1dleSsyR01xZlNa?=
 =?utf-8?B?TFpqY1QzYmRzM0wxdS96dzdqYjFWUE5iZWFwanl2OFdsdWpjSEczRE16SUZa?=
 =?utf-8?B?bC9oM3l0MU9VbmhQTGNFeXZ6Z1RJSERReEN1cHd2NzlKVGYrT2w3S3QxTXNl?=
 =?utf-8?B?bUcva2dXZEtNUHFiVm1HUkJ6OXBDdG9Cdis0dkRRQndEVzdBZEtkRGFOWDBu?=
 =?utf-8?B?YnYyMVhnZGFIeVNvM3o5elFPNUZTdURtQzdhOU5tdDVhOWtRVTc1aEhyemdj?=
 =?utf-8?B?MlR1ZGI1SHFSUG0yelN0UEV1QWgwd1NRR1l6ZGNyNU9QMmpzR2xrTVlOU09i?=
 =?utf-8?B?RGc3UXkyL3VhdEVjM0ZDUEdPK0R0Ym1oRWtoVHlFL1F3MFdpRWhjNHZIbGlh?=
 =?utf-8?B?WHJwZTlraUZCZ0ZFbDRpN2I5b0lWOVZSM0ZjOUJMUnFjSzNid3h6RlVHdFE5?=
 =?utf-8?B?YVp4Q1E1VU9rR3F2TFNMUURjU3l4ZEZhZkNTSndCbTlnOFN6RGhIT2dtQ1V4?=
 =?utf-8?B?bVZURUJEeWV4VkxWWjhvQlZMckcyZGZEdytCcjBvUlVvc0piUGtPR3JoQk1Z?=
 =?utf-8?B?akJaVnUzblNyVlpMeVZubml4WGJKYVlPVGlqT1U4cUtVdUJmd08rT0YzL1FQ?=
 =?utf-8?B?Y1VneEdFaUZXV0lheVZrUDFsMW9KZVJKT2NmZTljbEYwaEFzMHF2VWVlNzlw?=
 =?utf-8?B?RHFNTnlQRE51UlA3MzQ2elNRQ2YzZWhiakU5V0p4NjFwWGMrL0o3NjFTaEhX?=
 =?utf-8?B?QlJUc3crMS8yVTR4Uk4rd2ZXcTYvUjBrYkhKNFpqSW1XNmlndHlKeDZCK1lI?=
 =?utf-8?B?L2FMaXJEN1VQSCsxVEtjVVQ2c2ROUEJGSWxuREJPWTMvSUEyaE1sNDR4UWdQ?=
 =?utf-8?B?MjVHYUh5dEJwSElWS2FpeXI3WUxoM09EMU9saG9EUzZ6L21OQlNaM0g2ZnhP?=
 =?utf-8?B?bUxBbEVCM205czZXSVdsNFRHWGhnTzZleld3R2RRTnM5bXBlKzF5R2I3ckt5?=
 =?utf-8?B?cXp4ZW9QQ25JZHRJWWZPNTgxZlRKQUJmK0prRERqTU1qZTkxOURaRkE4cXBI?=
 =?utf-8?B?SUpDejRPSXFidEJLdTRyay9ZRGN5VWF0SVFjRGd2b3NEdHc4aUgxYkUrZXdL?=
 =?utf-8?B?c0hrd3hraEM3S0lSUjJLYnJyOVZHV0tZV3pVQXF3MW5GNE9TcWJwYmgvdzNu?=
 =?utf-8?B?S0QzOWgwQkEwZzA5NHRqOW82SzNoNXZOalVKOGZBK3Iyb2NhQzROMVVHZ29X?=
 =?utf-8?B?d2xMaDNqTWdHZmFBMTljd3BBR0RNa2RQbXFGdEhJLzFxbDA2dDJaanpYYjBo?=
 =?utf-8?B?WXpFdXdsdVlwMmFoN3QwUXRCWDFZV0ZHVFgyTU00a09kakVzRktrZ0tPT1VC?=
 =?utf-8?B?TFFzdWZGYjBEakNyZmFDeE9heGxvRlhFNkV6cnE0cEVsWFZERUtTbVVESTYv?=
 =?utf-8?B?a1c0VWxmUE1TL1VZZmNnRWU4eFRNVTNSb2ZzN2Y1ZWppWk1yMmFoR05jN1Nh?=
 =?utf-8?B?d0tkSDcvNGdka05qMGJtOFlNMzF6R2xLeVBHUVVXakFUL200b2FoZ0h2dGFT?=
 =?utf-8?B?bTBBdjNpK1RWbVIxejVCRW5CRC9iV0NhRnh1aUVER2JlSm5jYkYwMEFGc0Uv?=
 =?utf-8?B?Mmw4bXZzcTZmU1BxcnZpSVNRUzBsMm9ZSHowa3JoRnJVb1BRRi9Mb1hMQjQv?=
 =?utf-8?B?a2oyUDNEa244aHc1Q0RUcmc4cFM3UE15N0h3c0ZBczRhL2J1RWZZNlFZMVZh?=
 =?utf-8?B?ZVdXcytWMGR2YTh5UjBvWEc5N0gwYVVTR0Y1TWJpK0YxeWZVQVFHR28yRFVY?=
 =?utf-8?B?WHphVXppUDR0Y1gyZ0kxaDFhL1VwYWhlM3RZMUc4U0NMZTRVTWFJZ0lQeDQx?=
 =?utf-8?B?MGoyKzNNc2M1NjE3VGdzMFpUMlFaeUJNZTYreWREOVZhVmZ2SUo2eTVFR0o2?=
 =?utf-8?Q?NP9wQ0Xjr2qM43C39c6g60tlc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01328785-f102-4b46-bbec-08dacc4b2757
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:33:58.2271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcmDQ1Tkv8be5t++stsq/y6jfhobjZYRt6muZsot/eLnAL6/Yted9RSp6VSOROJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Huang Rui <ray.huang@amd.com>, Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-18 05:08, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> The software ring is created to support priority context while there is only
> one hardware queue for gfx.
> 
> Every software ring has its fence driver and could be used as an ordinary ring
> for the GPU scheduler.
> Multiple software rings are bound to a real ring with the ring muxer. The
> packages committed on the software ring are copied to the real ring.
> 
> v2: Use array to store software ring entry.
> v3: Remove unnecessary prints.
> v4: Remove amdgpu_ring_sw_init/fini functions,
> using gtt for sw ring buffer for later dma copy
> optimization.
> v5: Allocate ring entry dynamically in the muxer.
> v6: Update comments for the ring muxer.
> v7: Modify for function naming.
> v8: Combine software ring functions into amdgpu_ring_mux.c
> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky  <Andrey.Grodzovsky@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 217 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  76 +++++++
>  5 files changed, 302 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3e0e2eb7e235..add7da53950c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_ring_mux.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 53526ffb2ce1..9996dadb39f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -33,6 +33,7 @@
>  #include "amdgpu_imu.h"
>  #include "soc15.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_ring_mux.h"
>  
>  /* GFX current status */
>  #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>  	struct amdgpu_gfx_ras		*ras;
>  
>  	bool				is_poweron;
> +
> +	struct amdgpu_ring_mux          muxer;
>  };
>  
>  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7d89a52091c0..40b1277b4f0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -278,6 +278,10 @@ struct amdgpu_ring {
>  	bool			is_mes_queue;
>  	uint32_t		hw_queue_id;
>  	struct amdgpu_mes_ctx_data *mes_ctx;
> +
> +	bool            is_sw_ring;
> +	unsigned int    entry_index;
> +
>  };
>  
>  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> new file mode 100644
> index 000000000000..43cab8a37754
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -0,0 +1,217 @@
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
> +#include <linux/slab.h>
> +#include <drm/drm_print.h>
> +
> +#include "amdgpu_ring_mux.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu.h"
> +
> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +			 unsigned int entry_size)
> +{
> +	mux->real_ring = ring;
> +	mux->num_ring_entries = 0;
> +	mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
> +	if (!mux->ring_entry)
> +		return -ENOMEM;
> +
> +	mux->ring_entry_size = entry_size;
> +	spin_lock_init(&mux->lock);
> +
> +	return 0;
> +}
> +
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
> +{
> +	kfree(mux->ring_entry);
> +	mux->ring_entry = NULL;
> +	mux->num_ring_entries = 0;
> +	mux->ring_entry_size = 0;
> +}
> +
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	if (mux->num_ring_entries >= mux->ring_entry_size) {
> +		DRM_ERROR("add sw ring exceeding max entry size\n");
> +		return -ENOENT;
> +	}
> +
> +	e = &mux->ring_entry[mux->num_ring_entries];
> +	ring->entry_index = mux->num_ring_entries;
> +	e->ring = ring;
> +
> +	mux->num_ring_entries += 1;
> +	return 0;
> +}
> +
> +static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
> +								struct amdgpu_ring *ring)
> +{
> +	return ring->entry_index < mux->ring_entry_size ?
> +			&mux->ring_entry[ring->entry_index] : NULL;
> +}
> +
> +/* copy packages on sw ring range[begin, end) */
> +static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
> +						  struct amdgpu_ring *ring,
> +						  u64 s_start, u64 s_end)
> +{
> +	u64 start, end;
> +	struct amdgpu_ring *real_ring = mux->real_ring;
> +
> +	start = s_start & ring->buf_mask;
> +	end = s_end & ring->buf_mask;
> +
> +	if (start == end) {
> +		DRM_ERROR("no more data copied from sw ring\n");
> +		return;
> +	}
> +	if (start > end) {
> +		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
> +					   (ring->ring_size >> 2) - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
> +	} else {
> +		amdgpu_ring_alloc(real_ring, end - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
> +	}
> +}
> +
> +void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return;
> +	}
> +
> +	spin_lock(&mux->lock);
> +	e->sw_cptr = e->sw_wptr;
> +	e->sw_wptr = wptr;
> +	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
> +
> +	amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
> +	e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +	amdgpu_ring_commit(mux->real_ring);
> +
> +	spin_unlock(&mux->lock);
> +}
> +
> +u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return 0;
> +	}
> +
> +	return e->sw_wptr;
> +}
> +
> +/*
> + * The return value of the readptr is not precise while the other rings could
> + * write data onto the real ring buffer.After overwriting on the real ring, we
> + * can not decide if our packages have been excuted or not read yet. However,
> + * this function is only called by the tools such as umr to collect the latest
> + * packages for the hang analysis. We assume the hang happens near our latest
> + * submit. Thus we could use the following logic to give the clue:
> + * If the readptr is between start and end, then we return the copy pointer
> + * plus the distance from start to readptr. If the readptr is before start, we
> + * return the copy pointer. Lastly, if the readptr is past end, we return the
> + * write pointer.
> + */
> +u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)

Perhaps this comment would be better being a kernel-doc comment. Please make it so.

> +{
> +	struct amdgpu_mux_entry *e;
> +	u64 readp, offset, start, end;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("no sw entry found!\n");
> +		return 0;
> +	}
> +
> +	readp = amdgpu_ring_get_rptr(mux->real_ring);
> +
> +	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	if (start > end) {
> +		if (readp <= end)
> +			readp += mux->real_ring->ring_size >> 2;
> +		end += mux->real_ring->ring_size >> 2;
> +	}
> +
> +	if (start <= readp && readp <= end) {
> +		offset = readp - start;
> +		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
> +	} else if (readp < start) {
> +		e->sw_rptr = e->sw_cptr;
> +	} else {
> +		/* end < readptr */
> +		e->sw_rptr = e->sw_wptr;
> +	}
> +
> +	return e->sw_rptr;
> +}
> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_mux_get_rptr(mux, ring);
> +}
> +
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_mux_get_wptr(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	amdgpu_ring_mux_set_wptr(mux, ring, ring->wptr);
> +}
> +
> +/* Override insert_nop to prevent emitting nops to the software rings */
> +void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> +{
> +	WARN_ON(!ring->is_sw_ring);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> new file mode 100644
> index 000000000000..d91629589577
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -0,0 +1,76 @@
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
> +#ifndef __AMDGPU_RING_MUX__
> +#define __AMDGPU_RING_MUX__
> +
> +#include <linux/timer.h>
> +#include <linux/spinlock.h>
> +#include "amdgpu_ring.h"
> +
> +struct amdgpu_ring;
> +/**
> + * struct amdgpu_mux_entry - the entry recording software rings copying information.
> + * @ring: the pointer to the software ring.
> + * @start_ptr_in_hw_ring: last start location copied to in the hardware ring.
> + * @end_ptr_in_hw_ring: last end location copied to in the hardware ring.
> + * @sw_cptr: the position of the copy pointer in the sw ring.
> + * @sw_rptr: the read pointer in software ring.
> + * @sw_wptr: the write pointer in software ring.
> + */
> +struct amdgpu_mux_entry {
> +	struct                  amdgpu_ring *ring;

"amdgpu_ring" should be next to "struct", like this:

	struct amdgpu_ring      *ring;

With these changes, this patch is:
Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Given also that it has passed rigorous testing.

Regards,
Luben

> +	u64                     start_ptr_in_hw_ring;
> +	u64                     end_ptr_in_hw_ring;
> +	u64                     sw_cptr;
> +	u64                     sw_rptr;
> +	u64                     sw_wptr;
> +};
> +
> +struct amdgpu_ring_mux {
> +	struct amdgpu_ring      *real_ring;
> +
> +	struct amdgpu_mux_entry *ring_entry;
> +	unsigned int            num_ring_entries;
> +	unsigned int            ring_entry_size;
> +	/*the lock for copy data from different software rings*/
> +	spinlock_t              lock;
> +};
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +			 unsigned int entry_size);
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
> +u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
> +
> +void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
> +
> +#endif
