Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06E1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FAA911ACA6;
	Tue, 12 Jul 2022 14:03:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA87112B1B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhvNNhmvoaPTc/4EJ0i6UqeBhlLmGxEbTsMbHuvCifOfXrDkKtLhklcF0hgL2SFCXTFvQRh8yMIuzkE76FzWiFc3j6eCRBs9oskVB86qj3UlkVdeBEmnR5y+MjpfqqbdKiQhWlD3H/nCHFCT2qNX0HlBFLyARBmKC7F1rcfnweGeIjJq+zlWNKIoauN1FtTbSHyt+Rofc3ZYIpTVo5tDpiqC/+Lyze1td9p0EcK6PLTWwTKsMsFfJXTIUtBQEG2Dkto4hEgPmLDkmI8EkvKIx5tefqGZiInlOy3oxqCrbwScC1QjWz+KCkx2Lya+W1sq64dgUrssQL/NK5fnDS9yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTbhyiRKh5lq3qCoRmcdtw9vnVQBYzOLBELLGZXfD1Q=;
 b=WWwDQh/VWhXDhZCBc4p62qd7Ga6X+ZBpWxlPrlj0v5z4vmrDrjEvvZ/b1e57X8HBqS6DMREi9X21e9biLxXzHMKMAimxZ4+HfLYQhmznOK2x3WyWg56lUSHGiE7SiWGPVTN5VBTU/kUSpotE1uYRlcOWBHao0jZieU6OUKgNx8ZZCpHXgxe3YAoD/T81dxbwmpD+7vf2qSjlY2ygRFgkQ28FvqT1fn3bxGFuBBjp1Oanjqyk+rr5Ct/LxApN9bXwxBRFlUvAlOkwch8lVVYfAKNSiyaeBmGlOf+K2guTDhgcvnyiHr8OiDl1sZ1qCQJTtC6iYvAVPlIDGhq72+QCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTbhyiRKh5lq3qCoRmcdtw9vnVQBYzOLBELLGZXfD1Q=;
 b=I9oKBVKv49OtsHt6j2EXyiHXd9m2zhTjVFJfTkVDpTmrLEdX6tCwUuqhaa6Y5FStSOB1wZJnSRrV4BI2i9NFRK0GD6fIRPwsCaAqTm0CF2NugXPsIhgYy3BsNV0BPolnuGvo6CFJYzUE2mgxQgYkmu2KXmrryUybmxEUHsaopKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 14:03:14 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:03:14 +0000
Message-ID: <7d4096ec-9c64-1186-8b9f-e3320bb49f1e@amd.com>
Date: Tue, 12 Jul 2022 10:03:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: remove duplicate dcn314 includes
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712135543.2639877-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220712135543.2639877-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: debf99a5-b02d-4a11-5f87-08da640f4378
X-MS-TrafficTypeDiagnostic: CO6PR12MB5489:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSB5eu+X0CGPWSQGddHiuA0M0fQ9X7lUi5ujccPLiaGe7vAkbap/QcNdHeP1XhOK22c7ROt+Cyy1TIbSLa/c7qOM8C8ju08GDEY1gxhcwwwXqp09rFgRXbc7HwBipycpv3MMvK8vZFxpKMu89Y+cHcUtqr682PZlJlaG/2Dsagdwg4SyI7qJQZM8DT/89BoqBjR2VOeTyQGMyjlTYXPD7pLw/Xztr7Noo+7V89vNdjsZgrjBA9EXKQLMWG2ExdtllUOr09v4l/6Fx7O3fOCoVjqCbOCAJtTPVUUnP7REC3U8yS2xCbZbMEA2Oh9Ph3gTqTnbBOC/XuHxAWbbqIrUg0AX3v9J0rnQx1/4aFsjMbVLW7QqET+yMfW5POyefPZ/xHe5hbAFVtuLnM1Fw86rKk2scq3AbXDA0UiGJ+4r/YMJ8TWOvoj8nmV3s5McF3opqX2wUEJIoZX2HZrATfLi+pEgVl0M5M8B2Apx+yBQd67jjK7cTm7B+f2qh3IG92y1avDX6SM+1LtBXhOvURZ01m2H2pviCP5Nmb3eTTKks1AwyYTUONISdv6UmtX2vwtismZOExYauGiLS/jq0+j0l5Pw1YXDPkIQrtj5iG5GWBvmxonKFRmIQ954dZ9qtB6pe+kRowQwh54QFFiRK67mWlMALHUI/EyWIASpivtCMkKnqmUnjfw4wSyLp4o6MvF8raKyNmXStOQoj8jhsJtzB042H/PFnUrTe77lzT7FQz1hyJpz6s5mMF7XNHqKeIOJmPkBe4Dh0d41jr18vra2XZkuMwR/r7JJExoappYBe10qeiHURp2h4iPejoAOn8Pw6ilYLtv1ibJxASMDgOu42OFaqt9PmBMqm3iBL+mVXt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(66946007)(478600001)(38100700002)(31686004)(66556008)(6486002)(8936002)(36756003)(2616005)(8676002)(41300700001)(4326008)(186003)(44832011)(83380400001)(66476007)(26005)(6512007)(53546011)(6666004)(86362001)(5660300002)(31696002)(6506007)(2906002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1pWOFZGaUd4TGV0YWcvUjhwcmhGd2NpYVhHK1JiQlFZb3hjTVdsamdqK2t0?=
 =?utf-8?B?a2ZFa3BDb2RaeUdXU1JhQldQQjQ0eEhnYXR0TGFRQkcvclhxT0tNTDFGVE5J?=
 =?utf-8?B?NFRKYmltenBibFo3c25nZzNXSGpWZ2VidzB0bVJEeVJlcWdDVENVNVYwazBS?=
 =?utf-8?B?M3NEVEl1a2htdGlVaGdJbDdQN3ZzV2dZNGc0SmtPZnN6UzBFWnVNYStzUjhp?=
 =?utf-8?B?OFVFVmJaSkNLaHRLbjRvV01OOHdMb2FMVDJMVHp6ZTcrMTQ5RXJDa3BxTUVr?=
 =?utf-8?B?VExwZGVnNEtFMHdtSElxUkh2WWVrSlF5OHh2NXluajd3VDVlK1ZHVkxSTXFI?=
 =?utf-8?B?Z01MZmdZOUUwWEtBcWZwdTN6NStBQjR4b2VJR1MzSk9vRFpnWWtKcHlLR1J6?=
 =?utf-8?B?VWtQQ0xiQy90TFRNcW9NTHg2UjZWckhKd1Rsd1U0VVAySDM2dmxOcm1PcUdt?=
 =?utf-8?B?ckFzVjBPVUNKZ1A0dXlJQ093VXdMbmhGRGlhVlFCVUJaQ0d3and4bnpDMUhv?=
 =?utf-8?B?Q25jQjl5dWJiZS9ESHNJUVFJQUhGQkFqWVNWQkMxcUJoTkl5SVBiSEpHVUl3?=
 =?utf-8?B?cWxFVGFDbUc3N3dTZS90TjBBWnNjOHBpaGFOWkJwVEVwOWVod1BSUHBBTHo3?=
 =?utf-8?B?bUVIRnNYYmRRbHl0aTNoMWllUm0yRTBHOTRqNytiSXJ5ZjdQVzFSWHJiZHZJ?=
 =?utf-8?B?emw3OC9FMmREUlowWWF1OENwS2pQU0JjeUVEOUZxQS9DcTNpSXBpOW81NFIz?=
 =?utf-8?B?ZElZaFBFa2lzeld3UGZXWG56RUhYTmx4WVZlWnVTMWtaU3Bac2drTko0WXpj?=
 =?utf-8?B?eEJHY2JmUk1ZMFBaOTNjcG5FMStoaW9WUGFZa3FKWHd0dlN1aXZGL1FYbEZT?=
 =?utf-8?B?WWhzT1FJMXJ4cCt1L0p3MEc4ZUxqVy9pM0tMaHcvTnR5c09iaVdFRjFmeGZC?=
 =?utf-8?B?b29oa0hleU0yaVJqdFRYNG1za1lEcnRwajhuUkxySFNpTisyR25jK1NiVnJx?=
 =?utf-8?B?YWFMdGhIeWw5Z0V5RkJydk01K0dsVkpIbmRRWW9iRE9kQktZUnBBYXRQQ1Zx?=
 =?utf-8?B?Q2tFb2N3MHFHYjVjc0pnQWY4QWZOaFJGY0dnV3lJRUl4KzI3WjBROFZWRjJW?=
 =?utf-8?B?V3pzSWlua2tSWGkxZDF2cWxoNVJRZlNCY2RZVzVVWVhmcUV0R1k2K0thaUVZ?=
 =?utf-8?B?MEdPLzdLZjFwd3BjRjNxSmQzN1RYUUtYZTNzdjFsbjlUVUNzL3NVeW5Zbmlr?=
 =?utf-8?B?UzZNTDlWK244L3hxUVhYZzVmSjQ0bEZTeE5QeDNsdXhOZVBneGRrS0FzOURP?=
 =?utf-8?B?eDl4MXZPaC9QS0t6c2pKSjZGY2o3MkRuWVNFVWIxbXB5OGJOd1FIay9VMFNj?=
 =?utf-8?B?VmR2VW0yOVJpbHZrdVhHOWU0V3U4TzhIUkFEV1RsYldOUWMxaFdOQTd5TmY3?=
 =?utf-8?B?YVFiN2NrYTVvT0E3RWphK2VqZlVLSFYrYXQ5Y2xpdVFlT25mS3YyMktEWktN?=
 =?utf-8?B?a2g0dUtORkh0OWlHNVJrazRvNlI5ZkU5SzZpdXF1ZzdMa1JTSkVuakZTbldm?=
 =?utf-8?B?cW9DQW4rdGZsYUQ3TTNsWGpML2FtRnhlNmg1N1Z1bGJFZExYRW9xV0xYaVZo?=
 =?utf-8?B?SWxhNm1HcUk4SkVoaHovTzlTbTBxcVU4VERnV3k3bGI1dmFDZENaVnlPYzFO?=
 =?utf-8?B?cTgvbUJNM1hXY2ZHeUd6alV5em1rSWRDYzBRaHk4VTJWZDl4aXFsRFBHUjRI?=
 =?utf-8?B?V0gzdmdoejd2SGtDZysrZ0dJMmdGakNTeEg0TDFqYXNPSHJrS2hJRU90dFgw?=
 =?utf-8?B?NDhJdlllMjVQcy9PM2x5ckprMThXaTlKL0tnbThIeGR5c3Uzb1NvWFJGUXZq?=
 =?utf-8?B?MUJOZDNSMVhnT2V5aGg5eEpReE1UcmNsbU1KTTZSeVlSZWlFd21KbGZ6cjE3?=
 =?utf-8?B?VHhsYlRCajh0cFF3SVZBeTFyYW1UZkRpc1YzNDJnUldKWVpFbTJGR2hzenJo?=
 =?utf-8?B?OUNmM25BeGgreVhoS3VuR2UzZ3Fyc0tiZGVxYjVaRVNxVnRYWU1aVWhRdWFH?=
 =?utf-8?B?QWRVOExuNHJzQ3RlNDAzdldJZDVZV3haaGg1a3oxQlBEMVB4ZWZNYnNlNTNj?=
 =?utf-8?Q?qRmsgL3gYE1b+6MbBA++RaCCH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debf99a5-b02d-4a11-5f87-08da640f4378
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:03:14.7314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eb0Ss8RdOhfGeg9wlCGY+y+xfjsrMFtvWwug0WmPDSAiorhHUeT6rNbt1FoBySADshFYXMgfSv+7qJUuvGwgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
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
Cc: kernel test robot <yujie.liu@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-12 09:55, Alex Deucher wrote:
> Several headers were included twice.  Fix that.
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c    | 1 -
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c     | 1 -
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
> index a0c132666b5f..90ec76487264 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
> @@ -34,7 +34,6 @@
>  #include "clk_mgr.h"
>  #include "reg_helper.h"
>  #include "abm.h"
> -#include "clk_mgr.h"
>  #include "hubp.h"
>  #include "dchubbub.h"
>  #include "timing_generator.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> index 4ed6e24b8231..c4a5f8198209 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> @@ -25,7 +25,6 @@
>   */
>  
>  #include "dcn314_optc.h"
> -#include "dcn314_optc.h"
>  
>  #include "dcn30/dcn30_optc.h"
>  #include "dcn31/dcn31_optc.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> index 053a06b2fff9..ba371769dc3e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> @@ -60,7 +60,6 @@
>  #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
>  #include "dcn31/dcn31_hpo_dp_link_encoder.h"
>  #include "dcn31/dcn31_apg.h"
> -#include "dcn31/dcn31_dio_link_encoder.h"
>  #include "dcn31/dcn31_vpg.h"
>  #include "dcn31/dcn31_afmt.h"
>  #include "dce/dce_clock_source.h"

