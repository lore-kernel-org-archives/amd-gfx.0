Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0618AC6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 15:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB8B10E1F7;
	Tue, 13 Sep 2022 15:47:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8833D10E1F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 15:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXohbOuZw6jc4QAEAXeRvYycY31LxAfnkkqb3DLaJWaHNrxmMSQTHasANhMQJBjzJue/Y4zvZ/y00tBZrFTf0hPS0ZG2F38Z+5J3eug8ymejsBD/VsErD4v4ak0r1tkf0KeYYYiZlpVf/2GSjwV6sRbJtKZgMdl52koRfjBUFqZrUC9gI4PC/nDVBAcSf6umgIWxSOHnZY0n9eyvgp7M4EF2bjLaAPa9/DMbWvX6CNIy5WkbCa7LMl1d0sqkrYmp2MpngDMS78XcV0D2ByBwtmZBMOyLcXqTKm/fzsuijmb6JqOeUmjFEb7K71CBDdwXzOHvbCODi4hgvonBuuRlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYHpzfxoGHdll1dMZjB1muHyX/sGpFaIq6nEp9FTTS8=;
 b=BH8Ceun7Bi3iELop/EZGbfpzYk06FhCkZ9StCrEi8Fr8BSi5JuLe+a7GTQFJzo5g5cwl0WiTDzu7jUlUIubnPTa9iYOX9ty2Zf0fghZn69lrS3p5kXGYy8lg4l3Zb6Jxfs2eothX0tqKa7HY0DMcu2n06amHoNtniT9W93dKJJC5Uq2FhyAo2Uvn0FAXw4Nl3/TNQ9Q74yZsywQxDHYT5zBXKu0VvvQDJNphyOu4lYKBlx/r9uQqpaClk83vTTTq5YOcLRKRa7DtrfImSocjRiENq3baoJza7lMaWDPlzejNy4KANB6TDacdyj7lM9dGXCBkUTQB/eN5y/mqE66SAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYHpzfxoGHdll1dMZjB1muHyX/sGpFaIq6nEp9FTTS8=;
 b=W8HdZyjCvjC+EYgxYz0QmJrsFEh50859ZxCuFXAOgQNL2Zc5pNqMfzGOkShYgI/MbU50VKaUx2pN39P9ijg3cqyKjaoCD/DmIO29edXacHx0ARB+O/hGpXfyToa2ereuu66TTaEcDutKRcrp29wTzN2JJsoH9bRGJYfFBVOrdEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 15:47:19 +0000
Received: from MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b]) by MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 15:47:19 +0000
Message-ID: <e6b334c9-35cf-5e47-7835-3c7307e0ead2@amd.com>
Date: Tue, 13 Sep 2022 11:47:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/4] drm/amdgpu: Implement OS triggered MCBP(v2)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <20220909015022.557099-4-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220909015022.557099-4-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To MN2PR12MB3375.namprd12.prod.outlook.com
 (2603:10b6:208:cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a68d804-ac66-4ce2-56c7-08da959f3d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5u8eqjApn+ux/CyVLtUppIMMExiAtlgTAow3bB8Wf0CqVAMBo5ECmd+aeakfIOp5NhHo5uIhaGsNd/tnvU8k32j/6J32MQji4/uVeWlk8OzW5XK+j0PAAG3alOLFOPtU9MKkigrO0I/TG6CedVupUk/avP5KkVYu8ZoA7337P0/zumFA3bDsIcuH2JIKHCWKuzWqnqlPgyWZCtsENBW1doddodgLt5/+30ThDhuSRo1DZgYQcJP0BmOUshCWCs4JpiHX+C06ER3zlBWKMFHRtSQRP4jjFkyeOw7N0c0o/zmaRnl5CUe67QSb3eg7SARoqKVpOpgjJjC8VCSc4vlRk1vdumgtFvkXI/bNby8K2xPV1/58nWsD21HBAieri/BpAgwWELN3ZbKm6HRKpGEuE6b8Le1KxFHYqWZEnEg89QgINeSEIs4s17kGOrjDb3m0JGrs5tOVicdefpDAiGU06mwFFGhM36ilg+XHHTymcFDBmyYFmp1uDd60BuIIMlc7PLVe/JSiYgV2q7Uf5WajV2uJDZpnqW0He1Y0z/W7lBhQAXnWmyQO6tgknZPPFrncuSZFOWoGYPdVBhl2YYZjZ2Op8WgWpt+LDlUmfNGGq6Yv4Zsg/VPYvfG751sSPULK1yGu6/j5UROkXKO3PnedNhq3DY9g5BABAsOTJL7w2GnBZym9BerKBhtdRRltrpn3iD8X+ee9kpVPpoUbVZY0BnaT8r427kx6sQEvdzesSipiQCRp7tfGWvbHWG2pR5juOwkV5Nu9QWgtmVf6RX3k2jv4Plzg0oU4ZAf6MGSav+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3375.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(66476007)(8676002)(2906002)(41300700001)(316002)(86362001)(53546011)(31696002)(30864003)(6486002)(186003)(2616005)(6506007)(6512007)(26005)(5660300002)(44832011)(66946007)(8936002)(83380400001)(478600001)(36756003)(4326008)(31686004)(66556008)(38100700002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEVTRzZCNnZzZkZ3TTJnK3V6QzN5dm1xSzdoMDBlRTZKNjlLMDNMbzJXQUJn?=
 =?utf-8?B?a3ZhYUNZM1hCSEJ6M0RKMXBrRnpWcjMra0pPSzFaemhmQm05TGJDQWJVaFZH?=
 =?utf-8?B?Wm1sRUpORjVVVVA2UkZEenVVaUVtanZxVWpZWXI1RktLZExvOWxEYVF0Zmxt?=
 =?utf-8?B?aWcwOERqVFQ3MTJjbG9CbXh4ZXZXa0diSUd6Rng4YWFDZytELytyNzRkSTc2?=
 =?utf-8?B?UjhoY2FFQnQ0THNId1pLenJ1UjZjZ3p2ZGJ1Zk1OQkVYOVMyL0t4ODZicDRn?=
 =?utf-8?B?SlFscHh5N0FSTVlrQjE0U0xjQkpsVitSRDZUOGk5enAvWXR1WmJyb25YMEs3?=
 =?utf-8?B?Q2hVVnM5Y2hZUnU3MmQvVkdEcHJBSGMzS0J2eHNvTjRhakxUZ3daVVhROE93?=
 =?utf-8?B?Tk8zMzlWUjhFelYydDByVXJFclVRRVQxbDFFMndQYytlOWYxRFQrbjh1cWFY?=
 =?utf-8?B?SGpGRCtTNUllQTE1dmY0NXd1NlBFSEZYNk1HeVM4ZklUS01iQUZSQ2pUMHN3?=
 =?utf-8?B?VXlLbmkzbW4zVjUyWG9heDByUlBLYmtpdkNUdHAvRTBoaC9tQWd5SkpmZkky?=
 =?utf-8?B?ZFRoMTJXQnVmTlRWTmRZUFVGRlZpQWE5UWhEWWlYdWFkNng0UGxUV0QxMXpr?=
 =?utf-8?B?dVcvb0pSNEpFS0I2ajI0UklFS09nQ0dyeVRqemhMbTJrZ1gvUEptUHVVdDVR?=
 =?utf-8?B?dTQ4RUJ5a3AvSWdQblo3ZGhmVlZGQ01UZGVwM3Y1Q2p4QlpQcVNvVm1EeVZ3?=
 =?utf-8?B?Z2orRlhpNTBveWpqNTB2eG9PVTRKWk1qN0R3S1EycXVOTVpMRmc0bGF3Vk5n?=
 =?utf-8?B?V2R4KzcvVFg3OFhlK1lFOE1Wd21IdXFSS0NlTVZ0K3Q3OFNqSXpabjVlUVZX?=
 =?utf-8?B?YVdqa1owZHFpREZGTVlidkVXYlpSN2hKOElPNHJqZ0Izd3owUzdnbWdheW9B?=
 =?utf-8?B?WTVRZHIwT3FwbkVxUVRQTEVjWDZUUWJoOWY0T2FQMGhLdUlOWU1UazZ0aE0r?=
 =?utf-8?B?cFQxS1JjTnBGZUlTdjNycDVEckduNGNtd2VJV3dKUGQxVCtWOUdKbk5QWFo3?=
 =?utf-8?B?YThTNVZMZERHWDd2QW5ZRVpiYUFaVlZUcXFpU2tTZUI5amNIVGVqUTB6WkZw?=
 =?utf-8?B?dXNCaitNN1QwZzBaL2VDdnUxcDZueFBjOXlrRGdvMHoxSk5pak5nSlNSVXF4?=
 =?utf-8?B?Rk9HN3RDdWZmcU5VWUxTaEh4S1N4L0svdUpBRWlydm8wM0dUaVpuQUdXdmR6?=
 =?utf-8?B?WTFIRC9MeFVRdUZSTEM0Y2VzZ3pjZWFGN3MxMGZkSDI0T0ljaTEvMnI4TDVD?=
 =?utf-8?B?K0kzYzNDYWpOaTFBYmV2bVRUWFJYL0ZQdTBJWUhaNTh5MFB3OG05L2RTcDdz?=
 =?utf-8?B?blpzaE4zZ1U2SUlKcnA2Q3dIVG9HUWdOUjN5SWM1NG9kaDQxS2Y1aEFzTFVz?=
 =?utf-8?B?RzM0dTl1LzNpamRZdkRtb0pSc0pXQXdCbE9wVnc4YTcxaDFiR1UrZFRTMzFj?=
 =?utf-8?B?NEFJSzRybUpsR0pDTlN1WU9xaGlSODR6T1hHK0pVUktBcm45VkQ2dTZDREFR?=
 =?utf-8?B?SkZ0U2hkNTVOK1ZRTW8yOXUxRTd1NDJ3ZFRsQUtNT2hCRE94ZDJVbGFWV2RZ?=
 =?utf-8?B?aU1NQ1NzWVdyRkFoRlBoMlpYZGt2UDRrd3ZpOHYwd2MrWlE3UEtzQm02dGgr?=
 =?utf-8?B?T2h0c1RtUmxlSDViRTc4RHQzelVlUGlJMWFOSE5ZWGdvYlk0am9HTDQ4bkt2?=
 =?utf-8?B?MmpONG1Ra0swY1g4eXN1OFd0Y2dzUDhub0U3Q1F5TmE0SS80OHJOZnZ0ZXZC?=
 =?utf-8?B?OVVXcS9jcEdvQ2lRcXdWUjZXMi8zSjF2QWdES2xSUDFIUlllVHRNTnpmNnlI?=
 =?utf-8?B?cHJlRmtvd1hwVHRGM3E5REpzRnRUS25ZeFlvVTV2TU1jR0ViRUhzMXFKa3k3?=
 =?utf-8?B?alh2aUJmUHMwZHdBVjk4UlF4bndXVHJuUUFoOEgxUGtiQ2pQWVJ5WDlZMmVk?=
 =?utf-8?B?VGMva1QwNVZ0aTdwYTk2VGlEOGJvMmZJa0EzdlpJYStSdk02eDlvQ0ZsaUpy?=
 =?utf-8?B?WGpUcnk1NXFHTXpFZS9kTE0xb1hhK1NWV3dYNStnckoySkZkZUMxQVBaa2Jr?=
 =?utf-8?Q?O6i0A0U1Qr9f+bmbHTzhkrHYJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a68d804-ac66-4ce2-56c7-08da959f3d97
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3375.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 15:47:19.3575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7jd6eyF1erSH3d7TdKnJq8MbiJC8WKIGGs/fgDK9+CfNOVDd7QT9TjDDQo+f96H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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

Inlined:

On 2022-09-08 21:50, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> Trigger MCBP according to the priroty of the

"priority"

Spell out MCBP here, "Mid-Command Buffer Preemption."

> software rings and the hw fence signaling
> condition.

"signalling"

> 
> The muxer records some lastest locations from the

"lastest"? ENOENT
Please use an actual word.

Run your patches through scripts/checkpatch.pl.

> software ring which is used to resubmit packages
> in preemption scenarios.
> 
> v2: update comment style
> 
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c     | 101 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h     |  29 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 163 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  16 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  26 +++
>  9 files changed, 351 insertions(+), 3 deletions(-)
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

DRM_INFO() seem here to be debug messages and I feel they should be removed.
Sometimes we enable INFO level messages and this will overflow the log.

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
> index d3155dc86c07..399037b0d6e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -311,6 +311,9 @@ struct amdgpu_ring {
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
> index ea4a3c66119a..0c9b639b844e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -20,28 +20,60 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> -
> +#include <linux/slab.h>
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
>  static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>  	u64 s_begin, u64 s_end);
> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux);
> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t);
>  
>  int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
>  {
>  	mux->real_ring = ring;
> +
>  	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>  	mux->num_ring_entries = 0;
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
>  	spin_lock_init(&mux->lock);
> +
> +	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
> +
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
> +		e = &mux->ring_entries[i];
> +		list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
> +			list_del(&chunk->entry);
> +			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
> +		}
> +	}
> +	kmem_cache_destroy(amdgpu_mux_chunk_slab);
>  	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>  	mux->num_ring_entries = 0;
>  }
> @@ -64,6 +96,8 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>  	e->sw_rptr = 0;
>  	e->sw_wptr = 0;
>  
> +	INIT_LIST_HEAD(&e->list);
> +
>  	return 0;
>  }
>  
> @@ -180,3 +214,130 @@ static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>  
>  	return 0;
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

Those two DRM_INFO() should be removed.

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
>  	u64 sw_cptr;
>  	u64 sw_rptr;
>  	u64 sw_wptr;
> +
> +	struct list_head list;
>  };
>  
>  struct amdgpu_ring_mux {
>  	struct amdgpu_ring *real_ring;
>  
>  	struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
> -
>  	unsigned num_ring_entries;
>  
>  	spinlock_t			lock;
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
>  };

I'd generally include a comment on struct members--makes it clear what the members
are.

>  
>  int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> @@ -64,4 +74,8 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>  u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>  u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>  
> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> index 452d0ff37758..143a84c18534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> @@ -26,6 +26,7 @@
>  
>  #include "amdgpu_sw_ring.h"
>  #include "amdgpu_ring_mux.h"
> +#include "amdgpu_mcbp.h"
>  
>  #define amdgpu_ring_get_gpu_addr(ring, offset)				\
>  	(ring->is_mes_queue ?						\
> @@ -202,3 +203,28 @@ void amdgpu_sw_ring_fini(struct amdgpu_ring *ring)
>  	ring->adev->rings[ring->idx] = NULL;
>  }
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

Regards,
-- 
Luben
