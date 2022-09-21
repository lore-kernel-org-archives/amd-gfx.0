Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC045ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 12:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA4B10E3F6;
	Wed, 21 Sep 2022 12:34:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74EBC10E3F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 12:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag5vDt8/JnSmQ6/oxGKxsDjdiQjBQiXOqOykGw2UQuhQz2w7fkOloCIUaWCMDqXTRso07uXo5cC7xWRdNkxGWe9Rt1Lv60h6MLN5Q+Rn9mD66+gHP3dB8zNSLokkhC6ik86CEeKFlJBKTEi7pN8sQNCuLH3w8Tkfm3vz/dBVeSfgdBZU6eBtWRf/KG3VlDanhv5YhmWQK1kATPt8AYJFgP4jlsOQRA6ZmucSM4VDtAxSZIv9JQhwJXfJ9AxtwnOzTN7Dj1K4qTmSxXZBhxvjvex+P5RArpCn0UYnre6vqvi3N+bMsclkqVaaLEQwjS6Q3EaQVTXCUduxQn1x+chjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yjcEFdvuUJHMHFL6sTJvw/ZrolTHHVvVfPOafFNwJQ=;
 b=i8sa2A8cCHYh3ULgbsMaMlxsu5KK1FLbzFt1M8L3MXBIXCAlC6A0Jw0cHBzvRVKoelq65/Og6WN0BFvy9d1956YfLLn3YoGkaRmAX/xoJKVrbgGXKQj8Ky2ZXo6QTKxBQb6PEdQaGtYYDVwpbB/M8Rve8YFa9jRUc5ImpsPOmQcXpVeu4yOJ5SeNNKkTx0+L0Ocsk13Rtv+OvJdSjjt7TWJuJKwUWZOCHCi0bm5yZ/VswI7tJ/rmJr7YeJ8re+MH7jklntBhUoxPQVHxsgWMb39/zAonfSSBu0xjYzjHmWmaPiFP5Wv+LgE3cUn9D9CA/i/qyh94Z36yS8D4DkdoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yjcEFdvuUJHMHFL6sTJvw/ZrolTHHVvVfPOafFNwJQ=;
 b=sZp4nGzXxuWB6fBahkfPvgPXyS2b1J+j8fHEwVPjVl84VbLo4WSG71MwKIfjaJhPJKUQBR8LqAPwcXxdM3ZXPjjHpBBjK7kxWy/0xQVQXrvrN6iLlhXUA+YPoQKSflueZp1pz45YxrWXSswBeUGVWik1OxabLJSOb4pHzWxx/cQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 21 Sep
 2022 12:34:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 12:34:12 +0000
Message-ID: <3e7e1963-74d7-8119-200f-6f4981fe166b@amd.com>
Date: Wed, 21 Sep 2022 14:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] drm/amdgpu: Introduce gfx software ring (v6)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220921094117.1071106-1-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220921094117.1071106-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee1bea9-3b12-4078-79fe-08da9bcd9638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnfXWxVdgmgvgnfaL4MQwQvgiX9Rr/vB0CgVq4q6K7RecAXX0esGOCXDUBpXezVf7H3aJ7HitjBigrYp+Y8GKF2bq32K589ZRgCcZYLy5ahAUxBscAgdmpdZbmf72FngaAcnGTjH3JOgghIqj85Z2rRe8+ykhbpIGNUgIOPBuuwCBsyQ2wuAqSjnKvA1KhxjxdVZtysfwtNb5unaIqAtd+Pk4ImGwiIOOzwGqAvKxHcSEeeuTsR1EcUy9FUGUhuENPIzwODIbREtUcmGwrfkmdcPaKgyCmjR8rrqmuwYaBjs2hf/3lEqAxGLF38Z9aU7mVMovLbe7tPMwy8w0T8QwRmxzH8oTGwnYWzG7CMdDKkHmHZNS8Ygic6v3DeJFIURGKKxtiCgNvwHPcZk6PcsQrUPoCyxQbX+f/vdb7f3Js6O/B/1ITsChLXFG6WTvXhxDfkRX/w87eWK2axQ7jxZEB5IM/81rpT1X7Li+z+rEy8fC2UeY41qyicOzP/aJZ/+rQscuhbVTDrECX8zpvH1ZnVmIiF3DnOuudeaTEAwV3b445UW2b4NWay8uwMg85P9hSn9euf+vct3uGDqPnCi1uMbt4cvxKOnk1HsEnkN9xyMlF7rn8AB71qpEdE+HdsL5VbkT6a6pblE8kcodwbq1r/Rra2xqkxRaJEe2ENBNCKnjHd9HgM5QSNewwAB414HWAhEhiwk/L88/wIgQU5IMyEwI/aDLa9CMdLlYiDz/APkTtsqzu6Q0ZPvs1FHyNlR/4oKXTIDYK1y1omWq5wn/bd92i8tTEjTqSYEBP4Pkw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(6486002)(54906003)(66556008)(2906002)(5660300002)(8936002)(38100700002)(41300700001)(66476007)(4326008)(66899012)(31686004)(8676002)(316002)(86362001)(36756003)(478600001)(66946007)(6512007)(6506007)(31696002)(6666004)(186003)(83380400001)(30864003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MndBYTJBNU45TEErTVFCaGUwTENiQ281UDNLRjBxbHQvMkZQcmI2T09TZVJ5?=
 =?utf-8?B?RFJaK3c3bmt1K2xBOGkwdFl2ZHNHZEQ4VWxmd2JqbVBuWFJTMUlMeWp1S0Rv?=
 =?utf-8?B?bFN6QzlXTmM4cG55bFN1ZngwNU1yMEc2VEZVSEI3V296RmdScGgyMWlTckRI?=
 =?utf-8?B?VGZnbHRGSUxFMVQvWEQ0YTlYMTVlbjBGS0IvSVNnSDJ1RDJneXkwQ0thK3gw?=
 =?utf-8?B?ZVV1SFVHRWREYW1UV09VNzhCZnpKOXhDNUFZOXo5cnVuOUlSZVZvS0tjNitQ?=
 =?utf-8?B?TmV6N284aWMvWjhpYWhyZ3BldDdBV1BGSC9oMHR5QkhQRXBLdXNuUFpjUFBO?=
 =?utf-8?B?Z3RoL1ZHTDNQYVVmTWxSY2FwUVd5OVVwUWw2QTR6SGwvRDdtOUROa3BkeVJz?=
 =?utf-8?B?L1hOWTV4cFE3R2NETW1PU1h4NTh3VWgvbmZTS1BTQVcxZHh0Vlp1dXZtblpi?=
 =?utf-8?B?N1dDZWdIVG43M0dEMmFEMTRoZlp1ejNxZjl2UnMyVDdQd1NSTGY0ZXlHYmI1?=
 =?utf-8?B?ZHZNSTVYKytJcG1DQ0R6VE9EV3R2Z0xya3M1d2tRaTkvbnd2aGhQaUk1RzVQ?=
 =?utf-8?B?Q1dpdXl3MTI5THpnYmcvTGpqQmhHbEtlT1VwTGpLdHkwM3lUVWNhV1AyVGYw?=
 =?utf-8?B?SllKMUN2a2tkOWxEdjhqYTRKMGU0WDlyTjk1VWRpbTUzZUFqbWtVYUNzQVpS?=
 =?utf-8?B?VHNLd1FlSFhKeVA1VGM4K0xMVkl6YnhNWmtPc1dYK3U3TDYyT2tucisxbHY4?=
 =?utf-8?B?WU84Ly9HWnZQendaTE5JRUZ4MWRsWDJXdjR6OGdyZ0w2ckhabW1KSGVla2pE?=
 =?utf-8?B?cmQzRkV4YmRHMHJ4d2JlRWNvS3ZQLzk4Tjd1VmxYbkRFUHRpWW9IOVBhRWdK?=
 =?utf-8?B?RUttT2lxdVZDeFRoUjVXQ3hGS0JyWElvVWw0Rm5nUHBSd3NialZzTTNlSmFh?=
 =?utf-8?B?WmNWREd1dU9MenNvU3pVZ0pBekJoNy9HdnBlR0FSKzdIc0VBTnR4d1RiREEz?=
 =?utf-8?B?TFB5WFo3bXhUVmRzWWE1VjVaM1pCUkdWZDhSVjEvZVdEeGNLRi94YWRCOWpB?=
 =?utf-8?B?dEpHSmk1UWRQTFQwZ0Fuc0pJcmo2TE5nM3RzQnJ1cGNsdC9TaHR6RlJ2SGFR?=
 =?utf-8?B?YjcweHZsTnRTUlNhR04yWTBTdEozT2hjaWhLSlpoa2lsYk8wYWY5SHF2ZWM5?=
 =?utf-8?B?VlBubENVNVBFZnJoRlNMOTJzcW0wVGZyVDk5N0dodWVHY3ZaYlNOWnVzT3o5?=
 =?utf-8?B?SEkrVm5oVXhvaGNiWm5qaWxuVGc0SGo1VFZLQ0lHbkhuYWo2cXNiYzAvTGY4?=
 =?utf-8?B?T3RNZE41eEsxeitTaEdiQ05YSjNuUTFKZzB3UmFiNC8xS1JDVlYzak9uVytK?=
 =?utf-8?B?OEJuMEhFaVVuRFNKZDluRUdqSWxaTThRcjRwNmNkK3ZielQ1bjZHeGhGOWNW?=
 =?utf-8?B?a0lBb3N4MzBQZzdUNFRZZmd6dUYwOVk2d0Y5SkdPWVc4Qm5FbExjcFRua3c4?=
 =?utf-8?B?OW5Xc0FVRVZmdW9Odmg2eEJGNUF6akMvdEppcFI1OGQwNXVWTG1OZDNmWFBO?=
 =?utf-8?B?OVNIVzZRRDVXYUhsNXc1b0JjRXpkWnUxOEIyQ3FweXdTbGdJeExkUVFsUlE4?=
 =?utf-8?B?VlkxNWFnYnRJaStDdE05UHdkUWxsN3JPckZCY0ZJbndIVlgxN3lhaFI2MGZH?=
 =?utf-8?B?Z1VLeTl2VVBUUmovK0dGUEpvdFFtU21wbTlYYk9CSzc5M3p6SUlqRUlQdDZ5?=
 =?utf-8?B?MUJFQUNWQnBqQWQvaGhsbmRHWlhGdXRzQ1NTWmtUazVyUGRkcTEvMlMyS2pR?=
 =?utf-8?B?VHlrQklqamM3REZOSFRKOGZkMnFIQVJUR0RsZUJUTTZPek51RVNYYnFJY2FB?=
 =?utf-8?B?WkhkQ3FiTGdvVG5GZ1hac0Y5T1FicXh6TWw0bWd5dklDcUtBWU1kdk5vbGpa?=
 =?utf-8?B?LzFsWmwzMnYrUldtc3YyYjhjYUh6SVBTU0haN2F5eno0b2JCVUUrMy81bkFW?=
 =?utf-8?B?c0RIdStPVFVrcU9DT2luZGIzYnBFQWwwUERkUU15aHpHVWRoUkR6RzY0aXB2?=
 =?utf-8?B?U3J2TDFGcDRzT3MxbjRyZHJGazk2czF5YllPZVMxdmNpLzg3RC9VSXM2ZzJT?=
 =?utf-8?B?RHBnVVJKVXFSQ2JjaXpSempzeThxZkVPdkVKYy9MMkR1SjhFSmlCUXhKTXgr?=
 =?utf-8?Q?2I4nECqlWdGYiEkRlCtAz9BT4FMp/jrDGoTmI4/Oouah?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee1bea9-3b12-4078-79fe-08da9bcd9638
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 12:34:12.0824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2B8ofssq3TyZlkkmxHQAreszAT4K3Tb51N6256sAXzvIHR3nJvBuzNntQawk/2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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
 Luben Tuikov <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 21.09.22 um 11:41 schrieb jiadong.zhu@amd.com:
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
>
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky  <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 185 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  66 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  60 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  43 +++++
>   7 files changed, 363 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3e0e2eb7e235..85224bc81ce5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_sw_ring.o amdgpu_ring_mux.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 53526ffb2ce1..9996dadb39f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -33,6 +33,7 @@
>   #include "amdgpu_imu.h"
>   #include "soc15.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_ring_mux.h"
>   
>   /* GFX current status */
>   #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>   	struct amdgpu_gfx_ras		*ras;
>   
>   	bool				is_poweron;
> +
> +	struct amdgpu_ring_mux          muxer;
>   };
>   
>   #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7d89a52091c0..40b1277b4f0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -278,6 +278,10 @@ struct amdgpu_ring {
>   	bool			is_mes_queue;
>   	uint32_t		hw_queue_id;
>   	struct amdgpu_mes_ctx_data *mes_ctx;
> +
> +	bool            is_sw_ring;
> +	unsigned int    entry_index;
> +
>   };
>   
>   #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> new file mode 100644
> index 000000000000..d6b30db27104
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -0,0 +1,185 @@
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
> +
> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
> +
> +static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +				  u64 s_start, u64 s_end);
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
> +static inline struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct amdgpu_ring_mux *mux,
> +							   struct amdgpu_ring *ring)

Better keep a consisting naming here, e.g. call this function 
amdgpu_ring_mux_sw_entry().

And in general don't use _get_ in a name unless you are working with 
reference counting.

> +{
> +	return ring->entry_index < mux->ring_entry_size ?
> +			&mux->ring_entry[ring->entry_index] : NULL;
> +}
> +
> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)

Why _to_mux ? And not just amdgpu_ring_mux_set_wptr() ?

Same for the other callback functions.

> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
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
> +	copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
> +	e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +	amdgpu_ring_commit(mux->real_ring);
> +
> +	spin_unlock(&mux->lock);
> +}
> +
> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
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
> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	u64 readp, offset, start, end;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
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
> +/* copy packages on sw ring range[begin, end) */
> +static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +				  u64 s_start, u64 s_end)

Please re-arange the code in the file so that you don't need to forward 
declare this and also give it and amdgpu_ring_mux_ prefix in the name.



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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> new file mode 100644
> index 000000000000..e8ee34e6b9a5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -0,0 +1,66 @@
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
> +/*
> + * start_ptr_in_hw_ring -- last start location copied to in the hardware ring
> + * end_ptr_in_hw_ring -- last end location copied to in the hardware ring
> + * sw_cptr -- the position of the copy pointer in the sw ring
> + * sw_rptr -- the read pointer in software ring
> + * sw_wptr -- the write pointer in software ring
> + */

If you document this then please use kernel doc style.

> +struct amdgpu_mux_entry {
> +	struct                  amdgpu_ring *ring;
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
> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> new file mode 100644
> index 000000000000..ec50793aa54d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> @@ -0,0 +1,60 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#include "amdgpu_sw_ring.h"
> +#include "amdgpu_ring_mux.h"
> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_get_rptr_from_mux(mux, ring);
> +}
> +
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_get_wptr_from_mux(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	WARN_ON(!ring->is_sw_ring);
> +}
> +
> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
> +}

Mhm those extra wrapper functions?

Regards,
Christian.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> new file mode 100644
> index 000000000000..0a2e66318f3f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright 2012 Advanced Micro Devices, Inc.
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
> +#include <drm/amdgpu_drm.h>
> +#include <drm/gpu_scheduler.h>
> +#include <drm/drm_print.h>
> +
> +#include "amdgpu_irq.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu.h"
> +
> +#ifndef __AMDGPU_SWRING_H__
> +#define __AMDGPU_SWRING_H__
> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
> +
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
> +
> +#endif

