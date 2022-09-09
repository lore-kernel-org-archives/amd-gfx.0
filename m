Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1304C6FA8B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 17:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F73C10ECBC;
	Fri,  9 Sep 2022 17:02:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1464E10ECBC
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 17:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKTQ60x0HR1bx8TTU3JzwWX+h6LTKqXBQv4g6gNvCh+IBXxD/t8gsSLZO6uc+4RI2p5eSy+xeg2RATc04vMZVO0VZmlAG6wOasMCr2vu+WN11lLJrOY2kjaK4wZcu26syYbZjorAkyP+ljqjG+SjksbvnVJPFtEPH/BZoFgADQmrWy1+QpZ/UIugB2d0uTlw5vfyOqu5jCZHmAZDP4MLH8qT9pYlUyylSqCyQeC7IwL9t6H/nYM0SlWN3yKWbBAIxvalIXMzOZGufXrjNRKUnDqrPhRGb0+uPlsZHasX+E7J2Nqb6SRvpj+JAJjSTbytA7p88gg2+TLEgqjNF/5U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHj9rQeCyb6EUqPAI8NiUV+gJQkgsWixNFn45GSjdIs=;
 b=PH5fdVTzd3YxBFWnfGuI6+GSnvuByVHIGJrR/UdixLcWhFg0hjov46bs4SlXHFn01o+LmkZ1WtPt6nrHfexV6hXnvCv93O+jLWotlbcUsZvwydb+8Len+kYY3EhOhIZofo/7/xSmu6UNImeMqhQXcNqFcNxCAzuLEFQCZ7VPLBY263HlpSdiExP92SHHdTRn+nbIuQeVYS7hgq/1ODfbqyCJeAm72NWoE+5tmQXWtYk/xroyxnW7Vyv58Amu7qDpJxEP27ht00PXl0HnIabO7jXq0l/INe9Oi4ScL+YpCxsL2srhFHdrdW3Jhh8iRm7ZZ2PmdiiC3Pz+RCkLyKL/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHj9rQeCyb6EUqPAI8NiUV+gJQkgsWixNFn45GSjdIs=;
 b=WEFiWRp0pLxQim9pRhpQbsmrvhCuBBJWcPqJXfsf2B7Te7QVeTj0q1DiH4zdRvcxHNUuDN7MrTtJlpvBbYF0sN6u9Gp3DzwqZn3ffSGFe1KKd2X0G1v+02DO5nZZb2B3DVcZ6VMW8hMkVzSMjbpn9c/IQxJwzKBeQuj9MEEmXFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Fri, 9 Sep
 2022 17:02:24 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5612.016; Fri, 9 Sep 2022
 17:02:24 +0000
Message-ID: <5d475294-5a8e-ade7-ff64-e39a8374115f@amd.com>
Date: Fri, 9 Sep 2022 13:02:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] drm/amdgpu: Implement OS triggered MCBP(v2)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <20220909015022.557099-4-jiadong.zhu@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220909015022.557099-4-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::21) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 66787875-26ed-43b1-3a34-08da9285116e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yy6Cssh7yBV3yfMSghA0Sb7YtQGi3nak0DsN5EMiq9bLHulH6ppcximLSVcCXjq08/oJ6uy/CWIGttvK/VTueNC5ilRNWg0uXLmJEyWj/TMbrIIN9qPIP0uy/2NJGpW+f0OVmZQ0WEeTKg1Nv9TZRyF0AGOnkfqpjqMKKFtnx22hWyRINgCcPfDylGw9yaL5XS2pCwqcgAjk4lXyDyqIQ0/s0gNFlbYPY2eIauVncvC4LxxMsvUJjXDz2+swGAUWYxGKMHTCcEdL7ceo+YOzIzJuphmZWWnxW4mnIVmwHtMSQm/ZmNS8Qb25aUfNLGmSbTL2LZ27JavQTHlZeXAaAUl7lnZWTQRZt5g5jHtlIj93E9otYKEyrqcFFMDkQnrYIX1kSKwv3WTJu17yQFpHUqk8/rYP392SaragqRQA7WKR8R/qlvkkjqNSqkDjmBo1pwYzrVnmoZ7pkIwwtFxmbBQpVpI7IVUacRsdsZ5bEXjNp0EZsCGaPJrhAavxKEybOXjagf5+8g3sdZIw5FwdlHyxQdhjS8GWtW+dRHz3tv3y1Ip0mLgEcTqAKEqp1a2+17JyhiMNmDr+ECmdMPMj+g6dIH0Idz41rYpIE0wwdVSLoXlKNdSsSwyzEIViIY0ZzncN6oFaJQMVYBrBG/AwL6FYIFrG+ZWNCu8rywTXvHjAX0J+6I6adaz78n1bO6M0gBQGVx1vwb8xffnwDDDw1nuHfjReRvhVGPxPpfYQs+fejh49avY2suu3n0r7Hv7EJJ929req2fFbOSg+ktJhwpF0rtr3keMKyOUa6zR04Co=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(53546011)(6506007)(30864003)(6512007)(8676002)(4326008)(8936002)(5660300002)(2616005)(44832011)(186003)(41300700001)(86362001)(316002)(66476007)(2906002)(66946007)(66556008)(478600001)(6486002)(31696002)(38100700002)(83380400001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUNHelAraXl1MmlvTnRRRVBqM2hSVU5JdGlQdzl0QlMvZlBjZDdHTHR0b1hr?=
 =?utf-8?B?bUxvSFNQU1lneVhoTGVqWW93N3lCakllNzZBRnBVdjdtYTdXV0oyMFppZnRS?=
 =?utf-8?B?MU1HNjdoQTR2c2M4Q2FrMTE0RHIwNkhvYzAzUEZDeVZZclNZQWMrcjJrN3Za?=
 =?utf-8?B?bEJHLzRaVWFnbWsrSHZ4OHhDQjFRNVA3dzJxd0pyZEd5MHlvZFZKTVVsTWZY?=
 =?utf-8?B?eFFyRjl1Rk9xT1RZOUxkM0ZGV3N3KytveVVYaVZSYnpHUWtTTWlhdks4NklL?=
 =?utf-8?B?RTdmYWVEQWVUVG1wRGc5dm1IQ094VWFnazZyL0xua1pFb3NCQ1R6U0pYQllH?=
 =?utf-8?B?bHVUcXljOG1HNHRGdlhCbkxTbTltV3ozejRZRUxyTkhrTmtHbVB5L1RVNC9L?=
 =?utf-8?B?Y292OFJZRi9OTzR3K0VKVGpRcHJzNEd2bmovZlJ4TkxTUlRWQmY4MUtPVHlW?=
 =?utf-8?B?VXRSZ2U0WS9DK21pQlZ6eGxqcE1SMDhCNmk0ckZaUjBHeUZiUEZrMW8wZkdn?=
 =?utf-8?B?RWU3Q0M2Rjd2cVNlb0NNVEtMdWpVblBvRkNyYjkzalA3OGoreVRJRFArZjZ5?=
 =?utf-8?B?TlFmTU5CV0ZxYlVNY3VpdVJMWGlGYXUxRDV3Q3Z6SFk3OGpSOFN6T3pWVVUw?=
 =?utf-8?B?L0FMNDhtdGNiU0RSMmpRV2FPZmY5L1pobWNGanNHRjk0YlZQWVVhZlMrM0dr?=
 =?utf-8?B?MkRNRG55NmVESXVGbUFCdHIvZU4vdFhFYzhBNzl4M05WMlVibElJM2hMRS96?=
 =?utf-8?B?NkJDbUt0QkZHc2pZN1lzTlVFNnZ2VU1tMmxudW5wcW5RbkxWeGxnYjhwQ05o?=
 =?utf-8?B?Q1h4RFk5NCtTb01EMGlKWkl5T3NBOUhsUjNzeC9zajh3QW5HNDA0ZklFdG1h?=
 =?utf-8?B?RFpTV0xLeC9BK2VkTEFiNWJTaXJsUFNEOGhpYzNpaW1pMzJHM0J2Q0dxMnVD?=
 =?utf-8?B?aFZQamVyaWdHRHpDcFdZU3hQT3FlQ1d6Rlo5a0NDdEtlRnBHb2JZTUMvMzk5?=
 =?utf-8?B?enpKa0RXQlJuMWdXWUZGV2FHSVRZbFp1WUNmVnFHL1ZzTVBHRzNpR3dONEVN?=
 =?utf-8?B?Tmk1Tk1ENk5Gc2t3NUR0ZHhoeVRrVkM4ZFk4WDdGVFVydjlubm5IN2VnVTNX?=
 =?utf-8?B?Z00ya0V3Q2M4M0U1Zmdtc1VzSEhFZVhveEg5ZUFXTjMxTTA0NnlJdFo3Nm0x?=
 =?utf-8?B?OVVaa1ZDNDZnZWFmTmhIb3VEOUpmanJIMVV2QzdaVUJxRFNGR2VoOWVpbmpP?=
 =?utf-8?B?YkQ0ZDAvZWNMSW5peGw0Zk5UNmtZeWxSZ3ZzL1hUNGVnakxISk4yZWlaUU1j?=
 =?utf-8?B?Q1FsZkNwZFBmcU9Vd1ZFbzdMNWVKYWJ1QTJkK1JZYS9Yc2QrczBheTV1Y3h3?=
 =?utf-8?B?N3duNWV1b1pPdWNTN3VlU2hkVEdHbnBBSFRHVUptS2hMUDFtbUNxQnZyQ2Mv?=
 =?utf-8?B?MUpIV2h5ZTZLLzg4dzFnWFk3d0EvMXVya2VsV0NCZW90VXpTMlJDOE9IYlBx?=
 =?utf-8?B?VWJwWHcwN2ZBYjZmUC9CSUxqMTROWmRGY0cwbEg1SXE0UzRvNWJ5TnhTT3p3?=
 =?utf-8?B?ckJGS2FkbURaQVluOXRKSU56ckYrVjlyK05pNFdMVEJnRVZUcmZWWWZFck1E?=
 =?utf-8?B?dGNNMVU0Z1RFbUk5cCszdTRUR3lhdDN5eXZ5cUpncjZBaGFiazVidmhaWERR?=
 =?utf-8?B?eWo5YzFlMXlFaXZ3NlgxTnRTendSLzBORk4yK1FuNjZiVW9XK0h0UjAwQXZn?=
 =?utf-8?B?WTNIV0dSL0hvOFRuYVRZUlVWU0tNbGtzRW1aaDdGcFhBWGRJWTlLSGFEM2Ex?=
 =?utf-8?B?b3JJcDFwQkVIaWFucjY5Y1dQNEFnTWJyRHkxaEtna0VGekI5bDR3QWlFN3hv?=
 =?utf-8?B?M2ZiRytuTXdubElFNkhLWVpPNTFuaEpvYXFJZGN1ZW1uVm01TmVpUGt4dDhv?=
 =?utf-8?B?NWdmaTVRVEZMZFBUc1M0RGJtV094VWVYREFQTWY1bWx1QVBjdFhFd08yeEVF?=
 =?utf-8?B?OVlUQnVCQTVzNmRjRVdmbUhFMitJeVpKRnlJT21xK3RPSEN0eGV6RjhRMlph?=
 =?utf-8?B?Y2QzQXFSL2RndFhjYXludWU4emZudFRqS1pXdnBQcmZXbXl2RnZmRVFlaFlj?=
 =?utf-8?B?cXArZTdDNXY3aXNSRVAyY3kwY3hRZitBQUhYeXdhYXA3aExtU2ttL3Y0Ni8x?=
 =?utf-8?Q?R6Y9O9ajG4Jp6KvGjshMyFVAweumJ84jiqqRK8pcIpcT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66787875-26ed-43b1-3a34-08da9285116e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 17:02:24.8807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlrKSnUAZJtOq52EOd0h/F8AR44lggWlZj/7SXnaWE6Tqn94wpnMYPVrGW3+/fOOZtmpKRp54vemNtu/GrBjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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
Cc: Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-08 21:50, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> Trigger MCBP according to the priroty of the
> software rings and the hw fence signaling
> condition.
>
> The muxer records some lastest locations from the
> software ring which is used to resubmit packages
> in preemption scenarios.
>
> v2: update comment style
>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c     | 101 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h     |  29 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 163 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  16 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  26 +++
>   9 files changed, 351 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 85224bc81ce5..24c5aa19bbf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> -	amdgpu_sw_ring.o amdgpu_ring_mux.o
> +	amdgpu_sw_ring.o amdgpu_ring_mux.o amdgpu_mcbp.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 258cffe3c06a..af86d87e2f3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -211,6 +211,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		}
>   	}
>   
> +	amdgpu_ring_ib_begin(ring);
>   	if (job && ring->funcs->init_cond_exec)
>   		patch_offset = amdgpu_ring_init_cond_exec(ring);
>   
> @@ -285,6 +286,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>   		ring->funcs->emit_wave_limit(ring, false);
>   
> +	amdgpu_ring_ib_end(ring);
>   	amdgpu_ring_commit(ring);
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
> new file mode 100644
> index 000000000000..2a12101a7699
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
> @@ -0,0 +1,101 @@
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
> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_ring *ring = NULL;
> +	int i;
> +
> +	DRM_INFO("%s in\n", __func__);
> +
> +	spin_lock(&mux->lock);


Same comment/question about locking as in patch 1


> +
> +	amdgpu_ring_preempt_ib(mux->real_ring);
> +
> +	ring = NULL;
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		e = &mux->ring_entries[i];
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


What's the role of fence signaling here (sorry, I am not very 
knowledgeable about how exactly mcbp works) ?


> +
> +	DRM_INFO("after preempted ring_prio(%d) last_seq(%x) sync_seq(%x)\n",
> +		ring->hw_prio, atomic_read(&ring->fence_drv.last_seq), ring->fence_drv.sync_seq);
> +
> +	if (atomic_read(&ring->fence_drv.last_seq) !=
> +	    ring->fence_drv.sync_seq) {
> +		DRM_INFO("schedule resubmit\n");
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
> +		ring = mux->ring_entries[i].ring;
> +		last_seq = atomic_read(&ring->fence_drv.last_seq);
> +		seq = READ_ONCE(ring->fence_drv.sync_seq);
> +		DRM_INFO("ring(%p) prio(%d) last_seq(%x) seq(%x)\n",
> +			ring, ring->hw_prio, last_seq, seq);
> +		if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
> +			return 0;
> +		if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
> +			need_preempt = 1;
> +	}
> +
> +	DRM_INFO("%s return %d\n", __func__, need_preempt && !mux->s_resubmit);
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
> index 5b70a2c36d81..6d7f8a40e308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -583,3 +583,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
>   
>   	return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
>   }
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
> index d3155dc86c07..399037b0d6e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -311,6 +311,9 @@ struct amdgpu_ring {
>   #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>   
>   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
> +
>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>   void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>   void amdgpu_ring_commit(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> index ea4a3c66119a..0c9b639b844e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -20,28 +20,60 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    *
>    */
> -
> +#include <linux/slab.h>
>   #include <drm/drm_print.h>
>   
>   #include "amdgpu_ring_mux.h"
> +#include "amdgpu_mcbp.h"
>   #include "amdgpu_ring.h"
>   
>   #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
>   
> +static struct kmem_cache *amdgpu_mux_chunk_slab;
> +
>   static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>   	u64 s_begin, u64 s_end);
> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux);
> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t);
>   
>   int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
>   {
>   	mux->real_ring = ring;
> +
>   	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>   	mux->num_ring_entries = 0;
> +
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
>   	spin_lock_init(&mux->lock);
> +
> +	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
> +
>   	return 0;
>   }
>   
>   void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>   {
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk, *chunk2;
> +	int i;
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		e = &mux->ring_entries[i];
> +		list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
> +			list_del(&chunk->entry);
> +			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
> +		}
> +	}
> +	kmem_cache_destroy(amdgpu_mux_chunk_slab);
>   	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>   	mux->num_ring_entries = 0;
>   }
> @@ -64,6 +96,8 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>   	e->sw_rptr = 0;
>   	e->sw_wptr = 0;
>   
> +	INIT_LIST_HEAD(&e->list);
> +
>   	return 0;
>   }
>   
> @@ -180,3 +214,130 @@ static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>   
>   	return 0;
>   }
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


What's the role of size here ? Seems to have no impact.

Andrey


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
> +		if (mux->ring_entries[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
> +				e = &mux->ring_entries[i];
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
> +	if (seq == last_seq) {
> +		DRM_INFO("skip as fence signaled seq=%x\n", seq);
> +		return;
> +	}
> +	DRM_INFO("begin to copy resubmit chunks\n");
> +
> +	/*resubmit all the fences between (last_seq, seq]*/
> +	list_for_each_entry(chunk, &e->list, entry) {
> +		if (chunk->sync_seq > last_seq) {
> +			copy_pkt_from_sw_ring(mux, e->ring, chunk->start, chunk->end);
> +			amdgpu_ring_commit(mux->real_ring);
> +		}
> +	}
> +	spin_unlock(&mux->lock);
> +
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
> index d058c43bb063..1d91c235061a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -44,17 +44,27 @@ struct amdgpu_mux_entry {
>   	u64 sw_cptr;
>   	u64 sw_rptr;
>   	u64 sw_wptr;
> +
> +	struct list_head list;
>   };
>   
>   struct amdgpu_ring_mux {
>   	struct amdgpu_ring *real_ring;
>   
>   	struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
> -
>   	unsigned num_ring_entries;
>   
>   	spinlock_t			lock;
>   
> +	bool s_resubmit;
> +	struct timer_list		resubmit_timer;
> +};
> +
> +struct amdgpu_mux_chunk {
> +	struct list_head entry;
> +	uint32_t sync_seq;
> +	u64 start;
> +	u64 end;
>   };
>   
>   int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> @@ -64,4 +74,8 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>   u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>   u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>   
> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> index 452d0ff37758..143a84c18534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> @@ -26,6 +26,7 @@
>   
>   #include "amdgpu_sw_ring.h"
>   #include "amdgpu_ring_mux.h"
> +#include "amdgpu_mcbp.h"
>   
>   #define amdgpu_ring_get_gpu_addr(ring, offset)				\
>   	(ring->is_mes_queue ?						\
> @@ -202,3 +203,28 @@ void amdgpu_sw_ring_fini(struct amdgpu_ring *ring)
>   	ring->adev->rings[ring->idx] = NULL;
>   }
>   
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);
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
> +	BUG_ON(!ring->is_sw_ring);
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
> +		return;
> +	amdgpu_ring_mux_end_ib(mux, ring);
> +}
