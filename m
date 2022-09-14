Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7761DC6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 16:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A873A10E990;
	Wed, 14 Sep 2022 16:48:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21FF10E990
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 16:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwskGgEv3wdgtP2BzCRVo34sWzOewz/2Zxci38OidBCS9OO4mM9kagC+7ZRxycrfu4exqEDnnbdMFuAa8j7A5B0x0UHEDtE8f1cmSDLYt6XG5HoA30/fNqJOKkiPdB0Q2oqmymdruA9xRIgWiMz7CFokSwoIBSAI8JAW8fEuCo/6NPgUY8v4CmYlqUAyFh3SuSs9PVQFGooUJKWKCNhAoswFoFtZL52fF4QbiMz2hEhW2N+ZyFVQld1m2bvOXje31KkXVM+C6JyKF5rE9XfVkxVdCT1xZPT64Rt+c+HCXnISlJiC71Y9hOLJuOZtT12FoemWZvYCmrPTZuKmdaM46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gchD3ahGZvD8faSATmGdop/3AraT16xXXujv1z0jbO0=;
 b=bNkHS/tHsuzfNTYjKHPSaGWwd/VenxEL4ussDnL+HWQBUycMm83/7wqdfebf/X5L3rtnI8k7HW4rNO+NgcTWJ9ZqdiH1y5kbKIFeW+pzQU6+Qzxrq+GCadyvzM+3IeffDz1GITHuj5/kq2GdTQOiadFYhE7G5CSSOL44OqJrtaulCiXYdYDjGJk3SWA12Ks9eXsZ1apre5921ej1CBEugIS0B8BufS2kF/B4QPr5Z2ObAbUnexu0PZC4VteSUIdbb420WNzFyqv9EOSiq0SOrlURuKdceDxQHU++HblgBW05salqIEdYICWclBQHYgP5fplG/1EDmBKTezu6Q0bdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gchD3ahGZvD8faSATmGdop/3AraT16xXXujv1z0jbO0=;
 b=v3GKa/TY3/tPvmY3Tvtps5Gf0gJvDyu0Xe9Jeb9dvyttGU+lhANP32cz8OnlUPM20WkiwKXPJ/zQ8EgdFDw41QHe4Z1ty3fJeVcts1lemQh89ky/mG0W6hbWSZFF0EW1CwW9RzxdsSen27m6xWp+qM6ZAZpCY5NJpO8Rc9cp15I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 14 Sep
 2022 16:48:43 +0000
Received: from MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b]) by MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 16:48:43 +0000
Message-ID: <3645ac67-57d9-eb51-9ddc-0577237ecdb4@amd.com>
Date: Wed, 14 Sep 2022 12:48:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v4)
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220913090558.685714-1-jiadong.zhu@amd.com>
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220913090558.685714-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::31) To MN2PR12MB3375.namprd12.prod.outlook.com
 (2603:10b6:208:cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9c66a1-0409-4dfc-777b-08da9670fbe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFfxiBjo6gNcyAF4Ui0ncRVNZArzSKlK9ljokHkS8Rkv2hXNVFj40oEp/UUQB5qLrho30cCa7r8FZVuVBNvORtDKTx6AFLrbx/jueyxw5ZB6bObQS+2Zc3AudbykPtWoiAcPsrHT48VK3WmxSZ9Bf+bCcBaXk/et5XLgyjXZsHCTP+qnjqO52P8curTp4oJWcJFp9JfsVoBvzf0HRkG289asZzX1/ktnnJ9wyuVvscyqHaYn3RPknNFxfRv93rS/HBijoi4W9uitA4WFKfL3So5xYaWww6AMA2mozSJIodx95Dx+rFl3mUqebdB/bOZp24zpJRzoKfFS2aObZyEOvoNv0nxiSCGYSwocUn5+Lm49+c2SCAog+XEyeBJIRLPRSUaOLuft6kf+p4UsXhdWxTgDTDOf57xUs44JJ+SUJ8Oh93QMeq9EK+kg45UvVxtRwKa7G/dC27K870GB71vo+r4PzxT1FsoX/dAaYcwuZIgDOl3WoTg2to09hdI1l3+SIVs7sadWbyM3iocZPkqQ4ExLzoVfpMEpZkQCXYF5YwHv6ja2T98439PUvAqBwqNdwHdfSnFNLGxwzNDOXQI64NBSMxnAla2incLkwnW+eF4dCGxn89bCKUN/jc5FuaQeixvCEMUHd8QbK1SH7Mtn81vKMO5GM2hq7ceUJiXB3+HhGxWK0Yaol/CKhtQayGCkQcNnT424LzI34lE1G0VMC6auSn+KWHqi1tYbBAFFuoPe39jY2SyiSQLz6ZNaGRdE+xgNCfW1x0JoaR9M8/gYhvnHLn/v4SLyu9YG2cnYdx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3375.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(31696002)(36756003)(86362001)(6486002)(53546011)(6506007)(30864003)(31686004)(2616005)(66476007)(66946007)(83380400001)(66556008)(44832011)(54906003)(186003)(5660300002)(8936002)(4326008)(478600001)(38100700002)(26005)(6512007)(6666004)(316002)(41300700001)(8676002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEM1MjV6azlIdWRYd0prVGh4cUNEMnYxbGtpRVRsbDJ4aEREUGx5UUpZTHY4?=
 =?utf-8?B?bDh3Z0hlWHczTmZhRGtQRnZQRm5JUXNGeXlCRXJHdDRTbnlyVTJ6SUVCZkJI?=
 =?utf-8?B?bFBvOVFYWGlBU05WSHU1SlRTaUFhaWlBR2svbXk3ZFF2VEtnaWNsU1d3M25v?=
 =?utf-8?B?SWhLYUViR3Vqb2ozT2xGSnlHbGFmTFBDdnZFK2pnQnVCWTRjSlpFMDVlbmJp?=
 =?utf-8?B?QUJBNitsUTIyL1BwYjVTR2l1SVVNM21TbWZWYXRzWVNja0V3cjQ0bmgwSmF6?=
 =?utf-8?B?SzRpcmJpOXhZTXNYejBYVGV0NEZZUDNLbGVuMlhlaXJ2Y2dLbzI0NnVrN0Zy?=
 =?utf-8?B?ZUNzYkhYM1pRdmV0dzdrUFZSbzRsbkg2Rlp6dUdXVFI4OHFRdlBYTjFaeTZy?=
 =?utf-8?B?S0xOWXk5a3d5MDdhNUJmWmRwTVZSVUE5NUlkOSt2L0hxc1dKY0RQTVd2N3lw?=
 =?utf-8?B?bTZiOVJncDNDejhkWXFZTC9sd2g3SmMrMHNPKzhOa1IyRFduOWMwdjJRSXdF?=
 =?utf-8?B?Z0JZZnlzNVVwZEpxc0syeFViNUQwdmllVmRUZkwvMmxTRWlsYlpmRnNqVURW?=
 =?utf-8?B?RlFIMDYzeW80ajBjT203RWRoalJwRk4za0dGNmF5dTFscm5hOWxPNkdEd2lW?=
 =?utf-8?B?QXM0bllOcm9vUFdlWHIwWmUrblZmekM3Zk9lTGJQUVpkdWVEYWRDRllVb2sw?=
 =?utf-8?B?RXMyZ0szbFpvNnZNcHBnckJ4c0ZYOTcvNXlNZ3RTRDVXUkxCa0ZVeXFtVDdh?=
 =?utf-8?B?RWpDNnZhVTBGeVdzL0ZyeHZsNWswc2kwWEZEbGMrS0FZVnF0Y1VrWGdiUGZ1?=
 =?utf-8?B?WEphMXJIaFhsMWx1aGFyOU9pYmxFMXJQc3ZnQXM2cERHSE91cTlRRGtjYWV1?=
 =?utf-8?B?OU4rMFZ1aDMzRFBONVZCaFpJZGpDTVhvVkJvbEc0QnZTQTBPRlphdHo2MUs2?=
 =?utf-8?B?a3hUeFZuN2dMZkNLMWFmR2N3cVRZN1N6LzQ1bndrdWsraDJFa3ErOEIxa2hQ?=
 =?utf-8?B?M2F3TldnU1pSV1pvQVpTUVRXQnE2VVhOKzNQNXJub1pIT2xBVVNEcjF6OXlU?=
 =?utf-8?B?WE0xbnFKQjNFaDBnSFhRWklxZkhpellLa0I1QlRaUW9peTJqNEFrcnowdjJr?=
 =?utf-8?B?aDBBS0gxWUt6MzVFLzFuZExuOVNDOWtvaUxRTDQ3SmxGTUtPcS9UU1hYUXZu?=
 =?utf-8?B?WDE2N05iSHEvNzVmaE44UjBWR1R1ZW1QTTJGMTNmVTZTdWQxMVJIL0YvcFRN?=
 =?utf-8?B?Si9zV2RWd0wyTmJBZHBYSldqZWh5V0hwYmNzc0JMQW9lMDRzaDBodzYyTjNj?=
 =?utf-8?B?MFJYbXUwM204cTFPN1p0UzZwS0RHV21jR2dGUTF6SERmTGtPOHdmZ2NnL3lI?=
 =?utf-8?B?V1F0cUZsWHhzWVlrMWJHdlo5NkJKTUkyTnZycEJsTE1Rd0VVcFJGQUdjSmMx?=
 =?utf-8?B?UlUvUU4wUlVWS25lTXVsa1IvVG9NMm5tOXV0ZGdlMW5sR0YyL0RSalI5a0ph?=
 =?utf-8?B?WjAzWldmUEFEY1licGdFUXZla2ZvWXZhRVErTDhTSXNuL1lMRW1hc2dPdlIz?=
 =?utf-8?B?L0NKdlBodzNGclV2ZTYwMXFqaGV5MUV2Qm1jYjlWdkdzTUQrdFAycEppTTVC?=
 =?utf-8?B?bittVWxSM2p0eUNDbVNiK2lqNW1rSUVPekc2a0I5UmhyS0cxZDVFSjR2aFRJ?=
 =?utf-8?B?dDUrNXlHbER3NnRkYjBuMTc4UDhqajFXVk5xd1pnbTd3akVsbW54UTh4bllM?=
 =?utf-8?B?U0JjNWticGI2S0dIb210c3ltcUdiWGNobDFHbWhzY080QmNuZlFZS1o0RXJy?=
 =?utf-8?B?djRoR0tTSm5MRjZCTE9kTEM5VDZJbzAvTHpKTHhGcXZna1QwVEIyb1NjUE9B?=
 =?utf-8?B?Y3BXZFhvTll5VXpEOVdYeTltaUVxRWUxNUdVVk9EcXg1UUdHdmZ2aXVxc1ZY?=
 =?utf-8?B?VytSTnhXb0pJbVEzM0kxelhxL3ZpVCtlY1dNdFA4dTlhQXZJTHIyQ2dOMDda?=
 =?utf-8?B?dFhENzdBQ0E4N2tNNHlUTi9pdzk5ZkVFSTJ2UzZDZGZtSGVOM3dFcU9CT2E2?=
 =?utf-8?B?OGdoa3FaZDZMdXpmMU94T2w1V0FLRGxEWWhjMUhueVRiZ3Q0ckVJcWlyQ2V1?=
 =?utf-8?Q?8wYc21W70Dny4MSp5kHhqT87c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9c66a1-0409-4dfc-777b-08da9670fbe2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3375.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 16:48:43.6210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MDkvbq8JN6oM/cwdEi1+aIa60W7B5kqU+oyt65PSmrGdlAY9elOGu+sTGNxKqqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Ray.Huang@amd.com, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's customary to add a Cc: tag in the commit message on subsequent revisions
of a patch, once a person has reviewed and commented on it--Christian, Andrey, me,
so that subsequent patches' emails go out to those people automatically via a CC.

Inlined:

On 2022-09-13 05:05, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> The software ring is created to support priority
> context while there is only one hardware queue
> for gfx.
> 
> Every software rings has its fence driver and could

"ring", singular.

> be used as an ordinary ring for the gpu_scheduler.

"GPU scheduler".

> Multiple software rings are binded to a real ring

The past tense of "bind" is "bound", not "binded".

> with the ring muxer. The packages committed on the
> software ring are copied to the real ring.

Use 79 column wrap setting in your editor, not 50 or 60.
Wrap at 79.

> 
> v2: use array to store software ring entry.
> v3: remove unnecessary prints.
> v4: remove amdgpu_ring_sw_init/fini functions,
> using gtt for sw ring buffer for later dma copy
> optimization.
> 
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>

Add Cc: tags before the Signed-off-by line.

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  60 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  43 +++++
>  7 files changed, 360 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3e0e2eb7e235..85224bc81ce5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_sw_ring.o amdgpu_ring_mux.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 53526ffb2ce1..0de8e3cd0f1c 100644
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
> +	struct amdgpu_ring_mux			muxer;

It doesn't align, possibly because TAB chars were used between "bool" and "is_poweron",
and because TAB chars were used between "struct amdgpu_ring_mux" and "muxer".

>  };
>  
>  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7d89a52091c0..fe33a683bfba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -278,6 +278,9 @@ struct amdgpu_ring {
>  	bool			is_mes_queue;
>  	uint32_t		hw_queue_id;
>  	struct amdgpu_mes_ctx_data *mes_ctx;
> +
> +	bool			is_sw_ring;

Use spaces to align "is_sw_ring", not TAB chars, as I mentioned in my review of v3 of this patch.

> +
>  };
>  
>  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> new file mode 100644
> index 000000000000..652a6d3e0ec3
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -0,0 +1,182 @@
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
> +#include <drm/drm_print.h>
> +
> +#include "amdgpu_ring_mux.h"
> +#include "amdgpu_ring.h"
> +
> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
> +
> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +	u64 s_begin, u64 s_end);
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	mux->real_ring = ring;
> +	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
> +	mux->num_ring_entries = 0;
> +	spin_lock_init(&mux->lock);
> +	return 0;

Get rid of the "return 0;" here and make this function "void".

> +}
> +
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
> +{
> +	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
> +	mux->num_ring_entries = 0;
> +}
> +
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	if (mux->num_ring_entries == AMDGPU_MAX_GFX_RINGS) {
> +		DRM_ERROR("adding sw ring exceeds max gfx num\n");
> +		return -ENOMEM;

Copied from my v3 review:

You can't return here -ENOMEM, as it is not a real out of memory condition.
Maybe EINVAL or something like that, but not ENOMEM.

Also, under what circumstances would we get to this condition here?
Are such circumstances valid?

And if so, then when this is returned, what happens?
Does the driver die?

I feel we shouldn't ever have this here--it should've been
calculated correctly to never have fallen in this/such a circumstance like that here.

v4: Perhaps make it dynamic? So that it works for any ASIC in the future
without the need to modify AMDGPU_MAX_GFX_RINGS, or modify the driver.

> +	}
> +
> +	e = &mux->ring_entries[mux->num_ring_entries++];

This seems hackish here because you're not saving the increment
of mux->num_ring_entries. Also rename the array to "ring_entry",
so that "ring_entry[i]" means "ring entry at index i".

Perhaps keep a "ring_entry_size" member variable in "mux" to hold the size of "ring_entry[]", and
use "num_ring_entries" to hold the dynamic (populated) size of "ring_entry[]",
so that the _next_ available index is:

if (mux->num_ring_entries >= mux->ring_entry_size) {
    Complain;
    return -ENOENT;
}

e = &mux->ring_entry[mux->num_ring_entries];
mux->num_ring_entries += 1;

e->ring = ...

> +
> +	e->ring = ring;
> +	e->start_ptr_in_hw_ring = 0;
> +	e->end_ptr_in_hw_ring = 0;
> +	e->sw_cptr = 0;
> +	e->sw_rptr = 0;
> +	e->sw_wptr = 0;

If struct amdgpu_gfx is kzalloc-ed, then this is all zeroed here anyway. Something to think about.

> +
> +	return 0;
> +}
> +
> +static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct amdgpu_ring_mux *mux,
> +				struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	int i;
> +
> +	e = NULL;
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		if (mux->ring_entries[i].ring == ring) {
> +			e = &mux->ring_entries[i];
> +			break;
> +		}
> +	}
> +
> +	return e;
> +}

This is a bit naive, as every time we want to do an operation on a mapped ring,
we do an O(n) search, as shown in the three functions below.

Perhaps add an index variable to struct amdgpu_ring to tell you this mapping,
in O(1) time complexity, and eliminate this function.

> +
> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
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
> +	if (copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr) == 0) {
> +		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +		amdgpu_ring_commit(mux->real_ring);
> +	}
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
> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)

So, between the function names of "amdgpu_ring_get_rptr_from_mux()" and "amdgpu_ring_get_wptr_from_mux()",
they are 96.6(6)% _the_same_ name to a human. How about "amdgpu_ring_get_readp_from_mux()" and
"amdgpu_ring_get_writep_from_mux()"?

> +{
> +	struct amdgpu_mux_entry *e;
> +	u64 r_rptr, offset, start, end;

"r_rptr" is not a very descriptive name. How about "readp"? It is more descriptive to a human.
They are all "ptrs", but what is more descriptive is whether it is a "read" or "write", etc.,
so "readp" is more descriptive.

> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("no sw entry found!\n");
> +		return 0;
> +	}
> +
> +	r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
> +
> +	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	if (start > end) {
> +		if (r_rptr <= end)
> +			r_rptr += mux->real_ring->ring_size >> 2;
> +		end += mux->real_ring->ring_size >> 2;
> +	}
> +
> +	if (r_rptr <= end && r_rptr >= start) {
> +		offset = r_rptr - start;
> +		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
> +	} else if (r_rptr < start) {
> +		e->sw_rptr = e->sw_cptr;
> +	} else {
> +		e->sw_rptr = e->sw_wptr;
> +	}
> +
> +	return e->sw_rptr;
> +}
> +
> +/*copy packages on sw ring range[begin, end) */
> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +	u64 s_begin, u64 s_end)
> +{
> +	u64 begin, end, r_begin, r_end;
> +	struct amdgpu_ring *real_ring = mux->real_ring;
> +
> +	begin = s_begin & ring->buf_mask;
> +	end = s_end & ring->buf_mask;
> +
> +	r_begin = real_ring->wptr & real_ring->buf_mask;
> +	if (begin == end)
> +		return -ERANGE;
> +	if (begin > end) {
> +		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin],
> +			(ring->ring_size >> 2) - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
> +	} else {
> +		amdgpu_ring_alloc(real_ring, end - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin], end - begin);
> +	}
> +
> +	r_end = real_ring->wptr & real_ring->buf_mask;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> new file mode 100644
> index 000000000000..d058c43bb063
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -0,0 +1,67 @@
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
> + * start_ptr_in_hw_ring - last copied start loc on hw ring
> + * end_ptr_in_hw_ring - last copied end loc on hw ring
> + *sw_cptr -the begin of copy ptr in sw ring
> + *sw_rptr; the read ptr in sw ring
> + *sw_wptr; the write ptr in sw ring
> + */
> +struct amdgpu_mux_entry {
> +	struct amdgpu_ring	*ring;

Don't use TAB chars to align--use space characters.

> +	u64 start_ptr_in_hw_ring;
> +	u64 end_ptr_in_hw_ring;
> +
> +	u64 sw_cptr;
> +	u64 sw_rptr;
> +	u64 sw_wptr;

Align all members to "*ring".

> +};
> +
> +struct amdgpu_ring_mux {
> +	struct amdgpu_ring *real_ring;
> +
> +	struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
> +
> +	unsigned num_ring_entries;
> +
> +	spinlock_t			lock;

Don't use TAB char to align. Also note that TAB char in the kernel is 8 chars long, not 2, 3 or 4.

Regards,
Luben

> +
> +};
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> new file mode 100644
> index 000000000000..7a59e3fbb970
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
> +	BUG_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_get_rptr_from_mux(mux, ring);
> +}
> +
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_get_wptr_from_mux(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	BUG_ON(!ring->is_sw_ring);
> +}
> +
> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +	amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
> +}
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
