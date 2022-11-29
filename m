Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727B5C4321E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Nov 2022 11:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07C410E3C0;
	Tue, 29 Nov 2022 11:46:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 659DD10E028
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Nov 2022 11:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2T6eqzl5ePGYIZjPCiopDmRQNqcKkcaNoDCgesE4rh8YPfmAUVSUoAPT+B+JpEP2P1lENoGV7A87CalOcnk/4z9vuHDv7LZrXo+KO0m9Z4hqSPzg3g1+8obfYTUfqD+IGohisW/6HW9/QqAvHmnQuigqO5406LVc/r5wg43k2rdYpUaemq0ltrjewOtazOcGML/hX4VJiRD4fyc/ddOP6fMLls0tE/DQ9nBq9a6ebjL2kcj45sOJNgdAQEvTa/d2mbQoElMBmefSl8neXfLq+RnN5WmnEiYKnfrVYZc5bBezpjDkmzQxQIp54QpM/Kh4y9gXb5zC9gnGnE0//NDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPgAGpuFwuHvROh3wS3ZnLPucyQSLOGeTsj+Fo5LYdk=;
 b=X5XLo6szvrvjcOSWrK4gxWZdnU3m6aSPUTVPkRRUefV846S0xfp48fkvaSTypzEbVtBzz0zHP1O5QiHZ430XqE+RBlghja5AJT7lRifJlDy8oBVs4nxDjDeQZFYq1l3m0y0tiZmYapsQ0hKyMTpJDqzqKU4HVjFUKw8lmfzkIL0aZxtFbP2uL/IUXNeG1gDxllFjz9aVN+EemPEf28lfHAfff1/SdGhTidmBvfcobbT/Na+rUR/MbtO2rooDsH/DtSe38DjG7VeuaCQhp8SFK9G7cq6IxOehiDLtnKHTCqnmwYz0104c4p09vQaRuz6QLbFOid3JSXXogVCIf6W2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPgAGpuFwuHvROh3wS3ZnLPucyQSLOGeTsj+Fo5LYdk=;
 b=ZJzXQ7rWl0Fdnr+iUs3CV1LXGXKjLRiUlALkCgIpUQoFXBBO4+aoVSMVqtoNtPOk8AChEBVhzAOPScvVgTUjWFJsqKe9RHddmeWEKelxJ2LPjhTwLnn67Secu7ruyRweTaxC/WlZVkoRAThKb5B6KzDkLVSgsCfKd2jnxiAE4w4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 11:46:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 11:46:45 +0000
Message-ID: <d5b42708-da04-b52c-8719-a8bc5faea286@amd.com>
Date: Tue, 29 Nov 2022 12:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring (v9)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221129071037.531124-1-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221129071037.531124-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e41581-9040-448a-dfff-08dad1ff6453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsrqgGOTRtOpqD5YY6zgnmeV8Py+S3NBQi50L+t9+y/RBreyh5bhNsKJ7XhE1AOdsvW5VfuJfmv6DsICFhcH0Y5yjNQxlh+AXIFpIeGRdMaDtjQ7CoYuKNUXkvrvHcU2InB1sNiE0lZZKsHWJlPD8SZZIC6grCkasurkLoBkAAr3iqXz9HjnKJudIbwfMDYo2dyeYKnmzTuPnEvp62CKZC46bKBEPmE5t1f/q4GRQVj6h4RO45PlB6FsFgHE4121SCEAXRsBonaKd0pCvgYxN+udp4IkodJTIAx4+fyWYErOAwjRFNpCIfGhFuVrrOjMLymMPAq7HiIhhVZdV1PTUHslX2HN+D6FnB6DEL6qfO7R3GT1/cWx0VtlZOykuqM3kaj2kB9YvFnfzSvJoo/jivGAuW4EJy6a6YCpJqmpjN70q5pcNh9gwuuk4KRN3H/rkeKCJBL8xxNsSOlbM7lfZOD8dQfROu6xYxY/Y7rjEP1q9ASWqqcsx3nqkcFAyY1XEMU2S1e/LjDagvpIMvKrxPGTqty7TrrwNT6lGgrY0mZ54bnrDJZMsA5ClxumUyXrDNEgh0MlfXvL8/pOVJkg3W0Hj8+Mpev3vEyoCdAqqC3GQTRuSCAckVwlqQnIAIiHbETVF1+4P5tnZLKg8p8jctwuCfr/rDxQXUF2OD/SmQ509Gybybggi65i1oCPvFQCHdOkbOIgCfoOkZpoxhEXoetOhY4kgFv5lWAOFr74zXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(66899015)(36756003)(8936002)(38100700002)(2906002)(5660300002)(30864003)(66574015)(186003)(2616005)(83380400001)(86362001)(31696002)(54906003)(66556008)(31686004)(316002)(8676002)(6506007)(478600001)(6486002)(66476007)(66946007)(4326008)(6666004)(6512007)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tnh0WHpsYWNseW5DV0EwZTNwdDc0Q3pYUjlSR0wvOXhQWXZHSnMyakhLWCtY?=
 =?utf-8?B?Rnd2U1FwaldXSWk5d1AvMHQxQzNyL2lWUjlkenVpTjhYRUswcDdyVlpQZmFR?=
 =?utf-8?B?TG54OFpzTy9nRHB4S3hiQmNLUlF3bW1lSTlCRW9WS3pGUk1SaG9NRnpSdFJF?=
 =?utf-8?B?Mk14RWNDVGNtV1hhZ0hyNm0xNGllNlR1UlFiUkZYTzFndlp2SG5DV01zN2tL?=
 =?utf-8?B?TzZMT1NPa0oyMFg0V3pYcW1CeWN3b0Y5SUFRdFNjQ2NaUStRZVJwTFY3bDlU?=
 =?utf-8?B?YnhjSm8vRFQybXh4dWVVdklUZTNUbG1OWjVQSmljV0Q3d3pKZDhQUkl0c1dD?=
 =?utf-8?B?QWZUOERWT1gzeFdsNWZHQVRFTWwxT1Z3VXJoMTVDVGpqcG9TYXdZUEZ6QVJz?=
 =?utf-8?B?Ym1qK0RjN3lHK1hsY0tQT1BqUFNjQVBHOEV5TjNJWmFGQndORlBPVXFoakJp?=
 =?utf-8?B?alp2a2FLRjRmaHc0cXlDQlB0MldmVlVoVHNCK0JHQnMyZjhIeXptRDIzVnRR?=
 =?utf-8?B?TjF5aW9tZzg0SXQyZFRhT1o2VDFoV21ZNGdoWnAweGtoVm9CZ0dmRC9ETlox?=
 =?utf-8?B?UlE0RE9ZL3FrMHlUcGwrc0o5cjlFYVJXV3pGQnBKNlJIeU1DZlVIMmQrcWg4?=
 =?utf-8?B?ejlld1YvSUFta1pJNTFURkU4U3FhTHRJM1RCMitURTdQM0toMHY3VnllUWdo?=
 =?utf-8?B?WitkbXVHblJ0YnVwejVHNlN2em5IRmN6WDlrUTNKcDJvbkR1ZW54aXFTdFNF?=
 =?utf-8?B?cUdld2dUeWJLVER2VW81QkJqOGs1eDdXN2JWTDkxQzhtTi81ZjRTYm5uRXJn?=
 =?utf-8?B?bnJ6ZnJaVE1WVkREb0hOemsxV3g1b3pEMmYwOWIyL0htbmxtQm1sd3JYZlVV?=
 =?utf-8?B?Q1BOdjE4clRLK1JwcEN3UmNMeHJReU9nZ0lUa2p2Nkp0bkc2MnEyUUdocEl2?=
 =?utf-8?B?VWhlSHdHNXlleGUrWGRxNmFjcDNKV1hhM1pnTzl2LzlMeVE0ZUhlRGJRVlRU?=
 =?utf-8?B?dWgzRDZyY2k1Ry9UQkIrVEYvMU5sZWExcnNhU1gwckZXamIxTEFveWRkZC9M?=
 =?utf-8?B?ek5jL1hiTkpwODR2b2VBbEVUS0RkaGVHeng2endObm5UQW83dTBOS1hIMVVM?=
 =?utf-8?B?SUxzRFhYQ0ZKem5rdE1MYk9ES2U3TVBoaWpaTHNHcE5PN2lPeEppd3NnQyt2?=
 =?utf-8?B?UHh5eE1WSEp3UTVHQTdleHZRQzFjOFBodk52QUZDNmEvK09Ub0NrY2dOS3dv?=
 =?utf-8?B?c2xyRFUxZ2l0ZkE2TldQcHV5LzFsbWJTdE9GZGhvZ0xlMWQvQXl1RlB2bzI3?=
 =?utf-8?B?N2xxVTQ4WEZUc28xN3NhL0FzS2szbkdxN0FsRk8xK3ozRTgxSWpOaFNGdExZ?=
 =?utf-8?B?MWNuWTRZUlhlZGR4bTZlU3BraWZyMHREK2xXWm9BV3VFY3A0Ukc4eWJ1RTBo?=
 =?utf-8?B?eHJRMHRGZzRoRmNIM2tId0Z1U2ZLOHJ5WUc4RjFldEwxNGVyczR0TmJOSHVS?=
 =?utf-8?B?cmswN0VuQlRYQWNSbzltY1VNSVo4d0Fic0JJb2NUb1lHUlhpZUdMNWN3K3Nz?=
 =?utf-8?B?ZEl3bEtBZURzWDNQRmp0TTcrWHZJSmlLUFFKd3lweU4wZ1VrWGhLOVd2aTBt?=
 =?utf-8?B?dko3djRSUDJNeWk3MkNyWjNBa0JGUlpCVGhBbFIrMzhlTTltdTQ2QlZQeFBt?=
 =?utf-8?B?a09BcWhKVEtkYmFDSmdTVFpVUmVralBLS2NwZzEwdVpYclF2b2tjd1ZPSlJa?=
 =?utf-8?B?Nm01cmJjRm9zWFc5bzlWUUZnYW5UZ2V6MU1aOXF1Z1I3KzJCR0NOWlhFNUV5?=
 =?utf-8?B?RWtiSWJBRWxNVWdoYU9BMVJndzJjVEpycFlWMm9IWXlwenFRT0F6YjhJRmhj?=
 =?utf-8?B?dkF1TTY2d1VFTncxcWV2ZDQ5aFZ5WHc5NitidzgzTTloUHpWQzgwdFJhQ3ZW?=
 =?utf-8?B?c01KZXhFUFJwN0xMNi9wRDVJRWdhQ0Jwa1VPd0Q4MWpLZXhDRjB0WHk2LzN6?=
 =?utf-8?B?bi8rUnNhb2ZUOG9QdEN5YjFwMlRoakg4Yk5JV242ZXplQnRKWW83RjZEMDJS?=
 =?utf-8?B?N252Q2JkS3RaQTYybEVoSnhUZHdzUWZzZWNubVRBWDE3QlZpZ0xDeTljSHBl?=
 =?utf-8?B?eUl5Q2JUdTBWaGpZVjFYUWI3eUU3RFA3dnpxbzdvK2l2UDFBRGg4R0ZNWHds?=
 =?utf-8?Q?yaPFhuAprvUYqHmdRkP8nZxCx68m88V0x769YOvyWfzZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e41581-9040-448a-dfff-08dad1ff6453
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 11:46:45.8149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsP79XYLoBWnoxn7opAsF8FthV4vX5tjb5UnKPq5kFHezl9akGqtx77yzVZyRNnW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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
 Luben Tuikov <Luben.Tuikov@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.11.22 um 08:10 schrieb jiadong.zhu@amd.com:
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
> v9: Use kernel-doc comment on the get_rptr function.
>
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky  <Andrey.Grodzovsky@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 221 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  76 +++++++
>   5 files changed, 306 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 74f109a56d90..f58aa5d2e83e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -62,7 +62,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_ring_mux.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 1e6e35ff3f13..7c2692f29311 100644
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
> @@ -363,6 +364,8 @@ struct amdgpu_gfx {
>   	struct amdgpu_gfx_ras		*ras;
>   
>   	bool				is_poweron;
> +
> +	struct amdgpu_ring_mux          muxer;
>   };
>   
>   #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 82c178a9033a..8be51ebfedd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -279,6 +279,10 @@ struct amdgpu_ring {
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
> index 000000000000..6fbf71451e29
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -0,0 +1,221 @@
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
> +/**
> + * amdgpu_ring_mux_get_rptr - get the readptr of the software ring
> + * @mux: the multiplexer the software rings attach to
> + * @ring: the software ring of which we calculate the readptr
> + *
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
> index 000000000000..f58672a8e0ad
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
> +	struct amdgpu_ring      *ring;
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

