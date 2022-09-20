Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6A5C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 00:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C99D10E22C;
	Tue, 20 Sep 2022 00:34:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1748510E22C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 00:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzN2KXmToYwmSOS7188euOy0ByoHPwbNXlKvumPhmNfqXV2IK3AbCHE0Jp6SyXAydpvy0SPdAROVFPIH28bpgNgWbBAgacb9BgLatOAVsjpEb2poMu19p+25wGNT7t54dwmKsyho0vYxEpDwl2qlFU35Vvr7QXqEek7/VORRTR56cRnMzBYw8omo5VcaJbsVxuz7WrS2tK08mWG6oZbDbQT1odPiWqH7J2b5wpOvE1Vj+kANQDA/5PnuHlESIl3iA56VDp4RDRQHDk9kx3L9tu5i8fa8z/EoOP4AAdsbWyY7LluFspGffLviVcWgSGiXZaJDpVKJlwpgVSaxGWJhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WW09c7iMFcxvFg34CjGdw+IGshVjS77rJoFiw0TmF4=;
 b=URTD0AA36qhij6wtcv3Br5GM5eOrmPP/NV5ArL5MtGvK8gvKE3t+wyLnAn4aYkDN903XRfYpJ1zyaxrVNW/FyLS0SQ7eEZs/GjcSCgYj6i6phGJsz4NZwmkJeb6O3ge2nl4sYdGVFkRh8ljGLOzWI9F1E4HyVwOadldR40AEdEVfTgEtLr4MSm/ytU3Po1wN3P013B7JAf+xyM0hYunMsWQZFhuuCC2r+gj79G35g/UgPcqXa5QUPbzUjMuHGyIFcrO3cc+H8rWVqvoD1S53QmTSCywdDwVveKYG9ibGhJt2sBiFVXZcHJrhYVzXGYKUSlrP2SiOEi9xFGjWoFIUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WW09c7iMFcxvFg34CjGdw+IGshVjS77rJoFiw0TmF4=;
 b=ALNk4zs8J6noNjrqQHGKtsH4/hqPbbWrS47rwYMzk8HgiJRl5BxbCjXZYgPEvNpqaIOifDTviSWRTOT6XDw7ZitCooIiM7K9JsJelT7wqP99JtjV7lPuTcl5AP6IMa3xoTAeadwQodl1FAhtd/78OaYRii6plaIP4/AFedWClKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 00:34:27 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a%3]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 00:34:27 +0000
Message-ID: <3ef58cd0-f3c3-9220-eea3-fb926aa7be41@amd.com>
Date: Mon, 19 Sep 2022 20:34:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: Introduce gfx software ring(v5)
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220915064821.865541-1-jiadong.zhu@amd.com>
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220915064821.865541-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::11) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BN9PR12MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: 872d98e9-91c6-4b03-f4b6-08da9a9fdfcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GR34ive+8zIRMgqq0cXY4lsv0YwgWIanUFw/pZ5a2sar1pol+ZqYEM83cuIilShiKvDY3dHd4HCGy5yDkyURPn0qtnGSaerkyDntqCGkYLx29GIn+HmFoqJziLh/jnIwLcxkFU7IOZ1GRGNwYURKIEBR+uTJAuDBkeRa5XHeb9yyQM8nI3q6eOgRY3XFgfLAAOEj46i+aPaqaLrUIic8DizdIMYYhZuSSkAM7l+ArfT0o7CnhD09FWexP0yD4wxwYM/lh9vrtqCzEOeYZIc7t9ugLPGdBLoHurIqNy7mu93QuyMJ5sTWKZYnzpsNX9+Tk2dPW3no7oFaGZS2N4hpAlXen3gcKwDTAe3r+vpSbKKjUwMoJNa0BQdrAAtEvDlaXg2hSBeny0nhXpYnJOAcQyj64Vumq/hUM5rjUiR7oqW3QyzE/qhPEU3cCaGJcbFjM4r+LsHee/NOJ+AdIEOYxVDvbg+Pvvz1BZURxl4IsgPUUzqT4tdz36h7IzPDbjC1WpqTu2AdmqNdNF+wp+oZjb8XP1lMsSZyXsgHnLXWstR5J3AsGZCUVvgR6bvS2t8euI4qOR6C0WJ6IqsS6sp+pH6Nd/iX5+9ckyUmlR7nL6lHBsuXQLEsABKcPJcqlgBryJUvgmOUfjeCpoJSWQGNiJaLhrumaZCT3IVMwz75bwII61AgHnkx3uJRvT2lr/q1tmeLJ7h8YoNwKxhtefBohyJBAMxDdFL5Wn0O5Jvv118QoLuSdF0ag0MVcO6NlHKhqF/z44MfBmVMd22X0bl153jQ6SXcqndpSx1ORmZlAV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(2906002)(44832011)(30864003)(66899012)(36756003)(31686004)(316002)(8676002)(38100700002)(66476007)(4326008)(66556008)(5660300002)(66946007)(31696002)(54906003)(8936002)(86362001)(186003)(478600001)(2616005)(6512007)(26005)(6506007)(6666004)(83380400001)(41300700001)(6486002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW0yN21wRGo2Ynk1TU04YTRrL25GZktITGlhczlTVTlkRmoycUxCQzFoY2F2?=
 =?utf-8?B?OUtVZEtZaUlRc3NnNlFRTndoUTVtTUdzMVRFUSt6VWdiUngvZnZkOGlQSC80?=
 =?utf-8?B?U3lMS2t4cVZMT0VzT1cyVElvaVl6ei82eEdSVEJoeWR2N0pqM2VTWXR4c1k2?=
 =?utf-8?B?S0NJVEdYNm95MEMxcVJ2NHNyYmEzV05na0tvdzZUakxQZ1ZHeUREWXZNQWxy?=
 =?utf-8?B?VnFnNG5aNFpnU0haNTlEdytjUzRpL1pMZUNyTlorankrUmxPSXNwTTA4cjl4?=
 =?utf-8?B?RmN1RjBEaXJHV0xoM1lWWnIwTkx4T2lRMUViRFFSRHhoNElBV0U1ZGxlbGg3?=
 =?utf-8?B?SThid1lDa2JhUlloR2ZWSVdMZEUzd1VZMzhVU3FZYVc0RUtORHFpVnE5MHFp?=
 =?utf-8?B?akV1ZzVrb3R0SUlDZXMxOExNY2xqTWRBeUZUU3RGaHpXN2puT1g2UThvZ2Qx?=
 =?utf-8?B?R2M5OFJNMEIrMGVtOW0vSUxtY1pxNzJweGRvOUdsWGtzdXNKMGszSDdVK001?=
 =?utf-8?B?WHREUGN3SGlyZ05YcFFsZC9YQ3ZVaGFLeitkMmVseStlUjFTZkEvRzNqMjZ0?=
 =?utf-8?B?c1pnNWJQNTJ2REhXeGpwT3E1aS9zTEwrQ0puRlN0YzhzVXdhaFBqSzRDUGdo?=
 =?utf-8?B?UjQ4R2E5VzVuNElJSTdRd3pYbHNVRW9EbmpWWGFEc3hEd2IzbVMvRkZ1bS9E?=
 =?utf-8?B?Y2k2ZDRtT21URWFMaENJelBrOGJZd3N1cTQrLzRCZWpIbU1lc21MNER2WndQ?=
 =?utf-8?B?RDRzYitnbkRTblBmaml5ZExTckY4R0U2NkNKWEZXTk1DYkdnaS9XcG03RkdI?=
 =?utf-8?B?L3FrakM4cWsxNXdVNVVFTWhMdlF2ejZZMFBxbktMRlpWWHRUeWxhL1k4QXgz?=
 =?utf-8?B?Z2duaXlpUFZ4VjJ1OE9VR1FPWUF1TjU0SFRhMURNZzEweGdwT2Q3bExRck5E?=
 =?utf-8?B?Uk5PaEwyNXk4bjdMdm9jdm1xek96Q2pQSnlLV2xMcVNHc2JsRjBpYkMyZkdH?=
 =?utf-8?B?dmtEaUlvb05WR0NXT3ZrcWpybFBTczJibWczeFpxaXNJZnQwYW02UFM1T1Fo?=
 =?utf-8?B?REZ5ZEtLYktHWnlQUnc4bVRvNU1IdFBjYXdMb1pPbGUzL2U4RDZLMVIvSkxh?=
 =?utf-8?B?NGpsM1NsM1Z2RUhUYU95TTBjSFV6cWJKMjFPOUNydFZaMTBPSXc3VExHZEE0?=
 =?utf-8?B?TC9tYmVuWnJibStJMUVUaHM4RmdQWDZhSENqQnJRMUtiOFhaYWJRQlZNVzFK?=
 =?utf-8?B?QitFcXl2NVROQVc2dDBnclpZUzdPK1QvcDYwSzJVbi81WWlPdUppNDYyWHEw?=
 =?utf-8?B?SGVOQzdacmtZVFhHZG1LOVlpTjQ1dnFuTGhRK1dsSjFCQm1hbnl2ZFQ2UEcr?=
 =?utf-8?B?ZjJxZGFuNXQxQWJWbG1qeTEvOEI4WS8waHJNVWNGdW1lQ0lXc2ZFOTVwL1Bj?=
 =?utf-8?B?b2cwbHZWUnZ4c25kdjV2Z2YwOTl3ODdheDNrTkFXeEVUYkY0TWQzN0dYQ2xQ?=
 =?utf-8?B?V00zQ2tBQ1BEZ2JmZ2Jmb1pQTUt0MlZtK3NrTW1VK0ZNMjZsdTBsWFV1L0F1?=
 =?utf-8?B?bVVkZjE4S0VaWkVRTUQrVjZ0b3EvNVRGV3RXWFNtTHNFYjhBdGhFY25mSW1Z?=
 =?utf-8?B?M3B2N1RHNWRGRWJON2h3V1R2LzRKYUpLRERMZXVrTGZKaStBcEo0a3BrWitm?=
 =?utf-8?B?MmtEVFBXcVJrVHNham5wNXEwY0FiZmpaL3ZIMmtlTDhIelhIUnNsdjMydlFs?=
 =?utf-8?B?blhEdDdPRmlyeFF0SEU1amZQaXdsVFNlMkZaRTJrTzBrcHhlVDVjWXNqTVJj?=
 =?utf-8?B?NDZVeXhXUHRRbTh4aXB3MUhaZlY4RjVwNnBmN2FTZy90clJ0M2hWdUJhY0Ur?=
 =?utf-8?B?emt1NEZTQVY0WFcwQmh1bHhrSTlNOXBwMVVBSnN4STZlVSt3VU02aE5jNVds?=
 =?utf-8?B?VjE1THlDNVJFRkNGbUQ0UExyYkZrcGtLa2dWdUdBVmdpclVxM2N4VFYxYWpr?=
 =?utf-8?B?RkgydFNQcVUvd2lQSlFaQjUyQzJXcnJwQTdLSG1XM3dTMzBzMjV4bExXd1pk?=
 =?utf-8?B?VHhFZ0JOMGlMU1dKNGkyVXYyWXhKUlZBamxWZUhnaGxWdTdRYWVXRUdFU2Rx?=
 =?utf-8?Q?5n7LgZcZDXuhEvVfxuxjW3Rv0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872d98e9-91c6-4b03-f4b6-08da9a9fdfcc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 00:34:27.2825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5e4OdjbdXM0MtT7xgy/i+xG7cymaTXQ6MSpGApCpRCy2Bgmik+qGz5HyamjoNq/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354
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

Perhaps this patch should be marked with 1/4 and there should be a space
in "ring (v5)".

Also please run your patches through checkpatch.pl with the following options:
"--strict --show-types".

Inlined:

On 2022-09-15 02:48, jiadong.zhu@amd.com wrote:
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
> v5: Allocate ring entry dynamicly in the muxer.

"dynamically"

> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky  <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 176 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  66 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  60 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  43 +++++
>  7 files changed, 354 insertions(+), 1 deletion(-)
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
> index 000000000000..5e9c178f358b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -0,0 +1,176 @@
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
> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
> +
> +static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +	u64 s_begin, u64 s_end);
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +			      unsigned int entry_size)
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
> +static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct amdgpu_ring_mux *mux,
> +				struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e = NULL;
> +
> +	if (ring->entry_index < mux->ring_entry_size)
> +		e = &mux->ring_entry[ring->entry_index];
> +
> +	return e;
> +}

So this function could be as simple as:

{
	return ring->entry_index < mux->ring_entry_size ?
                &mux->ring_entry[ring->entry_index] :
		NULL;
}

Make it so. You could also make it inline in this file.

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
> +	copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
> +	e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +	amdgpu_ring_commit(mux->real_ring);
> +
> +	spin_unlock(&mux->lock);
> +}

So I'm not sure if we might need something like a (w)mb() in this function here after
the amdgpu_ring_commit()--I don't know how the above would play out on ARM, as we've seen
recently that some such needs memory barriers (patches from Daniel). It might be fine, it might not--not sure.
Just something to watch out for. There is a large precedent that we're fine, but I've seen one instance
of doing this before an IRQ spinlock, which does include a memory barrier of sorts.

I assume this has been tested.

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

This function needs a proper kernel doc. Perhaps something like:
------
This function updates the read pointer in the mux entry with the following
value:
If the readptr is between start and end, then we return the copy pointer
plus the distance from start to readptr. If the readptr is before start,
we return the copy pointer. Lastly, if the readptr is past end, we return
the write pointer.
-----

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
> +	if (readp <= end && readp >= start) {

I'd probably write this as "start <= readp && readp <= end", to make it
clear that we mean "start <= readptr <= end".

> +		offset = readp - start;
> +		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;

Here "offset" is positive, but less that the size of the ring.

> +	} else if (readp < start) {
> +		e->sw_rptr = e->sw_cptr;

Here "offset" would've been negative, i.e. readptr < start.

> +	} else {
> +		e->sw_rptr = e->sw_wptr;

Here, "offset" would've been larger than the ring size, i.e. readptr > end.
I'd include this as a comment after the closing brace like this: { /* end < readptr */

Perhaps there's a simpler way to express all this, but I'm okay leaving it like
this if you add comments.

> +	}
> +
> +	return e->sw_rptr;
> +}
> +
> +/* copy packages on sw ring range[begin, end) */
> +static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +	u64 s_begin, u64 s_end)
> +{
> +	u64 begin, end;
> +	struct amdgpu_ring *real_ring = mux->real_ring;
> +
> +	begin = s_begin & ring->buf_mask;
> +	end = s_end & ring->buf_mask;

Use "start" NOT "begin" as you did above. It also has a better
meaning in this context.

> +
> +	if (begin == end) {

"start == end" and so on below.

> +		DRM_ERROR("no more data copied from sw ring\n");
> +		return;
> +	}
> +	if (begin > end) {
> +		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin],
> +			(ring->ring_size >> 2) - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
> +	} else {
> +		amdgpu_ring_alloc(real_ring, end - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin], end - begin);
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> new file mode 100644
> index 000000000000..0f6430fe16b3
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
> + * sw_cptr -- the begin of copy pointer in sw ring

Just say "the copy pointer in the sw ring" or if you'd like
"the position of the copy pointer in the sw ring".

The closest to what you have above is "the beginning of the copy pointer",
but pointers in themselves have no beginning (or end) unlike time intervals, etc.

Regards,
Luben

> + * sw_rptr -- the read pointer in software ring
> + * sw_wptr -- the write pointer in software ring
> + */
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
> +
> +	spinlock_t              lock;
> +};
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +			      unsigned int entry_size);
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
