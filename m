Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE529C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 01:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CEC10E1DA;
	Tue, 20 Sep 2022 01:16:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1812910E1DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 01:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AysE8byDMgIKFSDWeDOQSKkI6fNO2aheSsSYzljCEPTE82uHLp6MQJUQNQXpXQgmZhZoClWxvdLYXe/DN4qdMbins3K9b63GHoNXzmpL3et8AcQyLP4eSZ6jWDlztHQ/+fONFgRpZJR9yu5ExHJ7OTVv1lnhmPzNPB7VsLdrhh7C84t9C3Ph/sFGEcp4ycQ8/WhKeM4GjK6OKx7EIW8Nw897b/PIwEJJbeSjOqc+R8RmiGotP+q2PWtbLJP0RlT87Qo54v0yEBvHO/4hn3HtBKwdWmdDn3ppBVBICHPXLLVhiSdmxzFv8H2Qj1xo00we1k/bXZfDzDQjXtaOb4IXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCiB+oEZ7hChOGPSrdhczbQn0PZhJ5KKmXZY1PFgypQ=;
 b=RGshjgP7VIPd0nqRchrFh8xNLLsvn8X0Q8KT8J+vpvI49m6koRmBCatUKvxtKRTCWJkn4huMVowxAZ7Ey3NJBNsd2n64FS5hpfhK/AN7XVngGN9yhpY+0frm/qTzqSRgLewWmJkZIU20WwTBpWrrtkigkhChO+QKkFBSIVCDVesi6/SoSFBuutNrDMIPGivSTzdtT7MbYYNBeTmQE92yxFw1EIsPIGN/CeLcFVUBiAYh/zj6e+q+6HwFUQQbdS7p658g6otXrU0BuCcYsEUPagB1FnLzvHfROhKHlGnk9U2w3Wpdy9qF3ysSPfcrre+YlinBBpEJcp2H9ulBDAkiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCiB+oEZ7hChOGPSrdhczbQn0PZhJ5KKmXZY1PFgypQ=;
 b=XbCbcN26NSVq75NPWd1L2NkgBNd5yJ1YGKI6BtwTfk/P9QQbtLRp/tUthg21uBcbWu1j57C12w5KOnlOq7d6uM+eOm8ueFmeFPkVsaVMRG5mu5wnQ3VFKo1jH3Er6P7FK1yOV9UxUW/WuXJHryl4E32CivwZiAr9bQCm6q5nO90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Tue, 20 Sep 2022 01:16:39 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a%3]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 01:16:39 +0000
Message-ID: <0106d358-1ee4-c012-372d-52d4300b43e1@amd.com>
Date: Mon, 19 Sep 2022 21:16:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/4] drm/amdgpu: Implement OS triggered MCBP(v4)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220915081654.876586-1-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220915081654.876586-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::33) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3b97e4-2cb9-431f-1e7a-08da9aa5c4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWpoCxFb/y4Vt32+CWQ/n7yAKHUrGzj/kRCSJHW5lmz9FLOX4E++Bh3DNf+XLWH5mSZCQkIo9QXbGlP4zH1wHwLPKnnq906qV7ihMiZj448nkmH3JXp+xmMKnME3lmC0jIddEhpELVlizHY64xCgsfcJOPvAB7in9yAjVJuj5njyM0cR80zSctx0fzi7XHYD8aGvVKQU9xB+FeVWnB11NqPvTnrfTJ9li2VioSvW+rPIG0f7qPjyI0acsVnNSeIFmJq2pdobsypI8u2831CUGWBgI4I47eZXRa5mAMcxj8SY0VuhrPOWyQ60ZiLjS9DNB1Oc6XWsSZV3YYEn79Sb4wHFWKlm8XRsLF750O1OBXV+vbFD5yZbqs5vCq+A/rJq+Q2PKWQZSlUxAT59H/OcR1WDZiRfk9jBR/HgoIhYeuafq+KQZ1JKQb+Zlq7sew3InXbgNNsKrpJQVl8CEi4F6Xtgam0Ef75TaVpVtXdohUrshOv94vPjI4EAJcu9kxPtz+mhGzNqlTDRCaKah/0hR4GHUjIHWdYC7Ka/NynrOIUnVC9y6pEtq35tLBQWw0h7edpNuVtNGQnotW/+IXzlOmOiqTSFwL07o9zSqVpJTsqvKzEbDBD/d6YP1s2QGSPZcIZ1vtUOZ7Nfronq9jPQ1x0E5QybPyJqGWCYx0QyFyP9WhN8Pps/ZqhK8DpffdmCsqsakE1O3vaWD5VYPZ5rfUk6tHD4sDPyACyKLMs5q4G5LGtdOumyS/leMqyaAzaoOqK8NfJk8XOUlmT4MBa0R7ikg7DarLe1hb2Rc/dRvhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(31686004)(6512007)(38100700002)(26005)(66899012)(6506007)(8676002)(30864003)(4326008)(6666004)(2616005)(2906002)(44832011)(53546011)(41300700001)(86362001)(31696002)(186003)(5660300002)(36756003)(478600001)(8936002)(316002)(54906003)(66946007)(66556008)(66476007)(83380400001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBLVWlxVDBrN2pJY3JEZW5XYXJZQmR5ME1xejVLVmVxaHpHcEFlN1Y5RDBs?=
 =?utf-8?B?VVBrL3NtVE00VjArSXZwelMvZjZxUWd1STJldHdhMjVzSEsrTGgxME1JTDg1?=
 =?utf-8?B?REx2QVR2SExOUDRHSEU2TmZjdC9ob1oxN2ZraTBteE8xZHJ3L01ub0VlQ1FB?=
 =?utf-8?B?T3FhallKeHVjRG5DZmNPK3N3RERYeUlxSWJSZDdUUGNkRmpLdTkwZmFvTVli?=
 =?utf-8?B?MWtTVGtVQUlRT3hSeElZcW02ZDdYTnBQaVJhQTJlMDhNRStrUnpYM0hkTEJJ?=
 =?utf-8?B?ZzRHVWJ0aENTNEhPMXFmMlRNZ0VTaWFYN0I4M2dzZ2h5NTl0OUJWZDRYSEQw?=
 =?utf-8?B?QkwxaTNJdjUxY285cVh3dmZYOUROSFZRT0RZcytzbXlUaWRHSVQ3Rngzbk5B?=
 =?utf-8?B?Q1lqK2c2QVBHOWJFdzdsVlhYeDBIaDJjc05FaC9aSEIvd1RWZ2tqUHpXbjY3?=
 =?utf-8?B?Wkk2ZkN3MEhxdEF3NVh4NHJiaFRyU3FaUmgxazdiYVBKQ2xQYUVMeG1hK2Zi?=
 =?utf-8?B?ajlJVUVmRlFTYnNTQkFMdGdZREdNaHlhSkpWMTltRU5aSE1lZnQ4c293dUl1?=
 =?utf-8?B?RXZVdDI4UzdQWXFjekhHd1kxaDhoN3k2NGQ2eU5VTG9DN1ExR3lodmhOYnVM?=
 =?utf-8?B?Wk1xNWVzQ052VlhrM0ZFaUE0YStzMVdZaUhPdXNPYmRuUk9rc2ZMTW1MM2k1?=
 =?utf-8?B?WWxPSGhRdk9EejFyQmdNWHJIWEI4bXBDWmpZQ2VkNWhJY0lSL25OcVlFSGRx?=
 =?utf-8?B?VjdGQXBXcHY1akdEblZrM1BING9ORGNQSnZqK3pXQkIvNmFIbFdqdDM1WEx1?=
 =?utf-8?B?d2pGSCtFcGw2U1pmcVdLZWFtbkoreXpCaFBjdFRNc1NZNWEwdVpPaTVYTStS?=
 =?utf-8?B?UHAyeG50U1ZPaWFUTkl4QlpPMGdiaWhWeFRsU1BHMUJYdjZ1YTJrVmpSMUg1?=
 =?utf-8?B?enFGSWJQdnhJL1VxL3BZSlNhWmUwY1l3Y0ZGUjBicUlrZWJTcGF4Y3dMd0hH?=
 =?utf-8?B?V3lYR25UdHBRanp5QnRoMGZFS2grZWpGTi82NSsrcGk3bjkvUlkvVUhmZkR6?=
 =?utf-8?B?M1JnWStUaGRrZ3RoSGZTYzVXVjJPbUZlRE96WkJnRExVUUVpU2ZjZEFWbVNV?=
 =?utf-8?B?aktneWVZdGU4YVFOck9OSjRCV3AxQzdVTWZyalVOWUs5cjRGa29KVUcrMXo3?=
 =?utf-8?B?QTc0T3B2UVlUbWVpdE8wRnFSVXBiTXY0Z3pzTExzdWtpUHZ5bWQ5emRpZjJB?=
 =?utf-8?B?cnpmZFpXU0dkY3AvMENMajhCTEs4TmxzOHBBL3g3WFBkT0oyTjg1Tzg1RkdK?=
 =?utf-8?B?MGZWUHdNSUJGN0Z5NU85OU42OGx5QUkvVFBwdit2TmJtMytCNlVyRlF4WnRK?=
 =?utf-8?B?VGpNbWhUWWwybFoxam16M2UwRURBcFpWdmhkY1RDZ2pLZU1ZTHRteDkzNk5y?=
 =?utf-8?B?T0RMYjBXOTFzQS9CYnI0QlBwMDI5Q1M0ZExGR3RSM1NXcE5SVkRuVytNa0ZX?=
 =?utf-8?B?K1d0MkZSaWxYYXBRanBoTjFCN0V5N3lXK1JKSE5HbkVHejFqekRZajY2bkQz?=
 =?utf-8?B?QllmRm1PRU1ySk15T1h4cHRacStldVJqUzN2Z09BOHVWeUFUNElCQ3RHK2l4?=
 =?utf-8?B?MXhtZEpjLzZWSVV3QVFLOEFraXRBNlBkVzN4Qmh0V0wxT1ZmQzhEcUd4Q1pO?=
 =?utf-8?B?NHRPUFh6dHJFeVJsSi9hUDJCUU5YSldycytqYW1FamxnSzZDUmt3RktaWmZw?=
 =?utf-8?B?RENySDFWTFR4U2Z4K0YyRm9lc3NNVDJDYTBHS1FWUmEvYjRWRitZdjE3Y2F6?=
 =?utf-8?B?NUpVV0crcG9UZUZMbm40cmhyMGovdUF1MGMvTmZJM1NMUHlkQ2h5TW1Bcmo2?=
 =?utf-8?B?allOcnoxVlMySjRtK3BDNFV0MXRqNGdmYUpDclMrSk8rcHVzRlR4MVZQWjdy?=
 =?utf-8?B?TnFmNUJRbWhSM0VnbTkzVU81cm9wVEVHRi9CSW10NjBJbWttditVSnBDdzhE?=
 =?utf-8?B?cysyQ2ZPdmxvY0E5SmYwSHNzcWwxZEZvRHFJYW5zQ3NNS2x0S2MvUzA3ZXRU?=
 =?utf-8?B?SjJnZVBsTVBMR0tIaCs0Y2Nmb0JRUWJiOHkyczFlajdTd0dpNDJvTXhVZXgz?=
 =?utf-8?Q?fa+AyA5jE2SfhyBKyVlRXfvon?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3b97e4-2cb9-431f-1e7a-08da9aa5c4f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 01:16:39.1988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: to2/MXZP9V0VPOPAYo8mzbHxvbmF5BnhyVNeA40X5yHN1W/8lhT2HyaNaEUnZpfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
 Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inline:

On 2022-09-15 04:16, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> Trigger Mid-Command Buffer Preemption according to the priority of the software
> rings and the hw fence signalling condition.
> 
> The muxer saves the locations of the indirect buffer frames from the software
> ring together with the fence sequence number in its fifo queue, and pops out
> those records when the fences are signalled. The locations are used to resubmit
> packages in preemption scenarios by coping the chunks from the software ring.
> 
> v2: Update comment style.
> v3: Fix conflict caused by previous modifications.
> v4: Remove unnecessary prints.
> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c     |  91 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h     |  29 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 153 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  22 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  27 ++++
>  9 files changed, 340 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 85224bc81ce5..24c5aa19bbf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> -	amdgpu_sw_ring.o amdgpu_ring_mux.o
> +	amdgpu_sw_ring.o amdgpu_ring_mux.o amdgpu_mcbp.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 258cffe3c06a..af86d87e2f3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -211,6 +211,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  		}
>  	}
>  
> +	amdgpu_ring_ib_begin(ring);
>  	if (job && ring->funcs->init_cond_exec)
>  		patch_offset = amdgpu_ring_init_cond_exec(ring);
>  
> @@ -285,6 +286,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>  		ring->funcs->emit_wave_limit(ring, false);
>  
> +	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
> new file mode 100644
> index 000000000000..4b0aae1a7ad6
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
> @@ -0,0 +1,91 @@
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
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <drm/gpu_scheduler.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_mcbp.h"
> +#include "amdgpu_ring.h"
> +
> +/* trigger mcbp and find if we need resubmit */

This is a new file, new functionality, new capability.
Put a better comment here, not all lower-case, not abbreviated, not missing a period at the end.
Change this comment to:

/* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need to resubmit. */

With that change, this patch is:

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Christian and Andrey should take a look at this patch as well.

Regards,
Luben

> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_ring *ring = NULL;
> +	int i;
> +
> +	spin_lock(&mux->lock);
> +
> +	amdgpu_ring_preempt_ib(mux->real_ring);
> +
> +	ring = NULL;
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		e = &mux->ring_entry[i];
> +		if (e->ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
> +			ring = e->ring;
> +			break;
> +		}
> +	}
> +
> +	if (!ring) {
> +		DRM_ERROR("cannot find low priority ring\n");
> +		return -ENOENT;
> +	}
> +
> +	amdgpu_fence_process(ring);
> +
> +	if (atomic_read(&ring->fence_drv.last_seq) !=
> +	    ring->fence_drv.sync_seq) {
> +		mux->s_resubmit = true;
> +		amdgpu_ring_mux_schedule_resubmit(mux);
> +	}
> +
> +	spin_unlock(&mux->lock);
> +	return 0;
> +}
> +
> +
> +/*scan on low prio rings to have unsignaled fence and high ring has no fence.*/
> +int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
> +{
> +	struct amdgpu_ring *ring;
> +	uint32_t seq, last_seq;
> +	int i, need_preempt;
> +
> +	need_preempt = 0;
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		ring = mux->ring_entry[i].ring;
> +		last_seq = atomic_read(&ring->fence_drv.last_seq);
> +		seq = READ_ONCE(ring->fence_drv.sync_seq);
> +		if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
> +			return 0;
> +		if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
> +			need_preempt = 1;
> +	}
> +	return need_preempt && !mux->s_resubmit;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
> new file mode 100644
> index 000000000000..0033bcba8d03
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
> @@ -0,0 +1,29 @@
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
> +#ifndef __AMDGPU_MCBP_H__
> +#define __AMDGPU_MCBP_H__
> +
> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux);
> +int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux);
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 4eaf3bd332f7..94362c39b73e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -574,3 +574,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
>  
>  	return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
>  }
> +
> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring)
> +{
> +	if (ring->is_sw_ring)
> +		amdgpu_sw_ring_ib_begin(ring);
> +}
> +
> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring)
> +{
> +	if (ring->is_sw_ring)
> +		amdgpu_sw_ring_ib_end(ring);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index aeb48cc3666c..36726c28a806 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -312,6 +312,9 @@ struct amdgpu_ring {
>  #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>  
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
> +
>  void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>  void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>  void amdgpu_ring_commit(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> index 5e9c178f358b..4f52b706b659 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -24,30 +24,59 @@
>  #include <drm/drm_print.h>
>  
>  #include "amdgpu_ring_mux.h"
> +#include "amdgpu_mcbp.h"
>  #include "amdgpu_ring.h"
>  
>  #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
>  
> +static struct kmem_cache *amdgpu_mux_chunk_slab;
> +
>  static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>  	u64 s_begin, u64 s_end);
> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux);
> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t);
>  
>  int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>  			      unsigned int entry_size)
>  {
>  	mux->real_ring = ring;
>  	mux->num_ring_entries = 0;
> +
>  	mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
>  	if (!mux->ring_entry)
>  		return -ENOMEM;
>  
>  	mux->ring_entry_size = entry_size;
> +	mux->s_resubmit = false;
> +
> +	amdgpu_mux_chunk_slab = kmem_cache_create(
> +		"amdgpu_mux_chunk", sizeof(struct amdgpu_mux_chunk), 0,
> +		SLAB_HWCACHE_ALIGN, NULL);
> +	if (!amdgpu_mux_chunk_slab) {
> +		DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
> +		return -ENOMEM;
> +	}
> +
>  	spin_lock_init(&mux->lock);
> +	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
>  
>  	return 0;
>  }
>  
>  void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>  {
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk, *chunk2;
> +	int i;
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		e = &mux->ring_entry[i];
> +		list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
> +			list_del(&chunk->entry);
> +			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
> +		}
> +	}
> +	kmem_cache_destroy(amdgpu_mux_chunk_slab);
>  	kfree(mux->ring_entry);
>  	mux->ring_entry = NULL;
>  	mux->num_ring_entries = 0;
> @@ -67,6 +96,7 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>  	ring->entry_index = mux->num_ring_entries;
>  	e->ring = ring;
>  
> +	INIT_LIST_HEAD(&e->list);
>  	mux->num_ring_entries += 1;
>  	return 0;
>  }
> @@ -174,3 +204,126 @@ static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_rin
>  		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin], end - begin);
>  	}
>  }
> +
> +void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux)
> +{
> +	mod_timer(&mux->resubmit_timer, jiffies + AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT);
> +}
> +
> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk;
> +
> +	if (mux->s_resubmit)
> +		amdgpu_mux_resubmit_chunks(mux);
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry!\n");
> +		return;
> +	}
> +
> +	chunk = kmem_cache_alloc(amdgpu_mux_chunk_slab, GFP_KERNEL);
> +	if (!chunk) {
> +		DRM_ERROR("alloc amdgpu_mux_chunk_slab failed\n");
> +		return;
> +	}
> +
> +	chunk->start = ring->wptr;
> +	list_add_tail(&chunk->entry, &e->list);
> +}
> +
> +static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	uint32_t last_seq, size = 0;
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk, *tmp;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry!\n");
> +		return;
> +	}
> +
> +	last_seq = atomic_read(&ring->fence_drv.last_seq);
> +
> +	list_for_each_entry_safe(chunk, tmp, &e->list, entry) {
> +		if (chunk->sync_seq <= last_seq) {
> +			list_del(&chunk->entry);
> +			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
> +		} else {
> +			size++;
> +		}
> +	}
> +}
> +
> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry!\n");
> +		return;
> +	}
> +
> +	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
> +	if (!chunk) {
> +		DRM_ERROR("cannot find chunk!\n");
> +		return;
> +	}
> +
> +	chunk->end = ring->wptr;
> +	chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
> +
> +	scan_and_remove_signaled_chunk(mux, ring);
> +}
> +
> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
> +{
> +	struct amdgpu_mux_entry *e = NULL;
> +	struct amdgpu_mux_chunk *chunk;
> +	uint32_t seq, last_seq;
> +	int i;
> +
> +	/*find low priority entries:*/
> +	spin_lock(&mux->lock);
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		if (mux->ring_entry[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
> +			e = &mux->ring_entry[i];
> +			break;
> +		}
> +	}
> +
> +	if (!e) {
> +		DRM_ERROR("%s no low priority ring found\n", __func__);
> +		return;
> +	}
> +
> +	last_seq = atomic_read(&e->ring->fence_drv.last_seq);
> +	seq = READ_ONCE(e->ring->fence_drv.sync_seq);
> +	if (seq != last_seq) {
> +		/*resubmit all the fences between (last_seq, seq]*/
> +		list_for_each_entry(chunk, &e->list, entry) {
> +			if (chunk->sync_seq > last_seq) {
> +				copy_pkt_from_sw_ring(mux, e->ring, chunk->start, chunk->end);
> +				amdgpu_ring_commit(mux->real_ring);
> +			}
> +		}
> +	}
> +
> +	spin_unlock(&mux->lock);
> +	del_timer(&mux->resubmit_timer);
> +	mux->s_resubmit = false;
> +}
> +
> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t)
> +{
> +	struct amdgpu_ring_mux *mux = from_timer(mux, t, resubmit_timer);
> +
> +	DRM_INFO("calling %s\n", __func__);
> +	amdgpu_mux_resubmit_chunks(mux);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> index 0f6430fe16b3..116ca95864a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -35,6 +35,7 @@ struct amdgpu_ring;
>   * sw_cptr -- the begin of copy pointer in sw ring
>   * sw_rptr -- the read pointer in software ring
>   * sw_wptr -- the write pointer in software ring
> + * list -- list head for amdgpu_mux_chunk
>   */
>  struct amdgpu_mux_entry {
>  	struct                  amdgpu_ring *ring;
> @@ -43,6 +44,7 @@ struct amdgpu_mux_entry {
>  	u64                     sw_cptr;
>  	u64                     sw_rptr;
>  	u64                     sw_wptr;
> +	struct list_head        list;
>  };
>  
>  struct amdgpu_ring_mux {
> @@ -53,6 +55,22 @@ struct amdgpu_ring_mux {
>  	unsigned int            ring_entry_size;
>  
>  	spinlock_t              lock;
> +	bool                    s_resubmit;
> +	struct timer_list       resubmit_timer;
> +};
> +
> +/*
> + * amdgpu_munx_chunk -- save the location of indirect buffer's package on softare rings
> + * entry -- the list entry.
> + * sync_seq -- the fence seqno related with the saved IB.
> + * start -- start location on the software ring.
> + * end -- end location on the software ring.
> + */
> +struct amdgpu_mux_chunk {
> +	struct list_head        entry;
> +	uint32_t                sync_seq;
> +	u64                     start;
> +	u64                     end;
>  };
>  
>  int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> @@ -63,4 +81,8 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>  u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>  u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>  
> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> index ec50793aa54d..4809ecf76180 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> @@ -26,6 +26,7 @@
>  
>  #include "amdgpu_sw_ring.h"
>  #include "amdgpu_ring_mux.h"
> +#include "amdgpu_mcbp.h"
>  
>  u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
>  {
> @@ -58,3 +59,29 @@ void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
>  	WARN_ON(!ring->is_sw_ring);
>  	amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
>  }
> +
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
> +		if (amdgpu_mcbp_scan(mux) > 0)
> +			amdgpu_mcbp_trigger_preempt(mux);
> +		return;
> +	}
> +
> +	amdgpu_ring_mux_start_ib(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
> +		return;
> +	amdgpu_ring_mux_end_ib(mux, ring);
> +}

Regards,
-- 
Luben
