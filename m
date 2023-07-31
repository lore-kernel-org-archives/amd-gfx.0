Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B517BC001DF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 12:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFD610E27F;
	Mon, 31 Jul 2023 12:26:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8AA10E27F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 12:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtMq2sOs1xQxHzHjAk3cGFxARoDWFV7KV42X+zo9ZElbGRjGkAWGcIMrfp6VHe/lWTMgOVqzCcQdOCBjD8rEf7Zs4L2oeO4hm+5Vaou/GTLexYPFgHb+KRVO5FNI5ZY9jhE1ljr3PevfR5m3Z6Xp1VB3ZS3oAyB7IFeZ1NDApEfbSASqQe2gWpLEzuM879a+tI8OlOg5zck1ezgYm8foFotNMPvN6G6PdWR3Fybcx0BVujSr2yrvASCfr1ppRQ7++cexcFATiC+SqVAMKbWD1IpdQs2cyUlpf+sFWoWc2XDtIy8XYVZQIWQNWaqtQJRj2JPUoJIKskGuf0TlntGYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTZle9shTV1wRzMFCwF6JtsD1l39LSNbyFWVflTJmDo=;
 b=PNjlgDD8rhiTFvA7LUHcK80w/0IznCIqZQIHJiexIalA1YGnxDARKRsk1JFv6BVfCjbQtCzM8IoggxUAjJ2bXT++GPI2GybiTjBM/jbkl7UdHuu/yzE/abB50qFo3UZ0cAWpi9zX7AEvV/oouRmF21w0J6yrdLpRU/ysw/xMmRTI8PQEdvaxasq2rjgdychyVaqmawfInhRo3TVqrlfmjBlNdcIhhATCTjdVxh+bEruxs3qKd96Y5tSeLA3lfA3di5iCRbpHDM1q7oJp9xAnFpdieciJA7wN/9PpZWPqyQ9dgDIkAeY2ZeytECbkVlUxhBjA+z7c0zMbzDKrP507DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTZle9shTV1wRzMFCwF6JtsD1l39LSNbyFWVflTJmDo=;
 b=N4If98wuOqjqDyV9tWsPhxRO63Do7aozF7IDH/aEr+SN3Qe31vxWztB+/tY6WSKOBG8xjCTABvajTNyOkHH8lDfQwgirkjTRZMblOWpNtMw1gbkaX3YMihpyJwtp1w87Y+Tvc52A28HqkyqW6D19tlybhLRXpLwBKWfJitlTb2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 12:26:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 12:26:26 +0000
Message-ID: <8a62a2d3-739b-321c-ade3-32528f1bc063@amd.com>
Date: Mon, 31 Jul 2023 07:26:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdgpu: Sort the includes in amdgpu/amdgpu_drv.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230728041615.2670398-1-srinivasan.shanmugam@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230728041615.2670398-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f1208e-45a3-4ce3-d3c7-08db91c15c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyoE5kB538vrX9EIHRBOlGQDTSTha5w+xXcJxUBt7g9gjNXQ0OAOu1EWVmNb1TpgFRVgilxGav2L8IwGf/tZZ8aSPYgJAjwUn4k9j7fwobR+o4T6B0R2LjxpdpOVpP4sa+bjs5z9JuyjtaZqletXkNqdDFZg69B9rMk3xM/cuTOdbKzOY8mMHbUuERDUaRaxSfa6Jgd9JDHj5j7Aod1Zp0ESE0IUG7oVbeElP50Ljs7ze7vqDZ34PeiBN15WLs7qdn4+Pr1sKi6pDAhrvmosG7bc+RKzAjLeWHe5N+MFo23LZscfZQFAiTv+Hi017AnB/1RQjZPGNAvi/YV1ZF0nNj0ZCErH8rGvXdoNDH6pEy6WbD0WpcJW3NNw/Xxr/hDpeoAXLmGSy8OiqvMvmZiXP3Psak0TuH1q4rTPCHCrY6yIjwhK3zq95R9JZfGCnSXD19wfDWE+v+d0Hxn8LlpC/HkXpQn6JoNqVy+yR+quX9NUaRnAu4JkFdpN94TvMcjMS5/MRsMs8gRFncM5sr0g+yv6DGfn0HsJ2ExTjq5Y++C++rhpohJqDvoIC00o2SVGtJ2zPBvqo9ZBVm1fyObDOARGkzqLxT89a/T3DkjF0zkEhb+QAVmzdQiTnYjRP6kRQzFNZsAX5eXGC9NHtmZtQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(478600001)(6486002)(83380400001)(6506007)(53546011)(6512007)(6636002)(4326008)(66476007)(66556008)(110136005)(66946007)(186003)(38100700002)(66574015)(2616005)(31686004)(316002)(8676002)(8936002)(41300700001)(2906002)(86362001)(31696002)(44832011)(5660300002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG0xSGNucWhvbnZTaElwTHVZU1dxeks5QkUxR2JFcUlvYnM4WUJZdmVXcWJv?=
 =?utf-8?B?QUtMN1JuOTNndDk3dUpKekxHNmFtcDZBbCt0ckpxWUZZL3pjQktOcmJWOGxa?=
 =?utf-8?B?Zlk2N0Y1VldFb0haWE5xWmJaVEFzcndOcVNVQ1BmM3kweFYxQ3lWUjMyQlhp?=
 =?utf-8?B?Z204NTJRODlpVXpOSGZ3VVI0a3BQcXhvY1VaN1pHMzM4L1lKUU10bGZGQVZT?=
 =?utf-8?B?cUU5VTlJeCttOVAzUXF3RVpHUGhBYXV5L2t3cEl4dlRtTnVXQy84SmcvNTRD?=
 =?utf-8?B?WGFZM0dRWVN6Z2VMQWlhbnpPR0VqYW40Q2cyL1FtVGh6bU9qdUZpQkV2QVhp?=
 =?utf-8?B?T2xwMFdkMnVxMUR1OG8xSkMvY3pnTHBKQ1RmUGxrZTJGS3ZDMlBEYzY4S0p2?=
 =?utf-8?B?b1BaTHFjbHd0NFhyeUFBMGpValZLY0lMV2tNUU9GSzIrNkpmTVpaUkJ5dkNX?=
 =?utf-8?B?bXVlbUFUcGhubWtxLzJiNFU5VTl2bENDMkJyQ0h2SUJzTGdQSmZuNjlwOUpp?=
 =?utf-8?B?ejBGeUdtallZZTVEbWhVMFV4UjM3MWh2aDJrc3lMNk5DZVZ0RExPaG9KYXNm?=
 =?utf-8?B?cXQ0SXNZTDA3cjRua25lN1FCVkhLcUJqbEJwK01uc25RaWw5cWJDb2R0ZTZL?=
 =?utf-8?B?YmNaNWI1dCttenNhNWoyQ2k5SWZ5cUFIOWdUeC9rTHF3cTV5S3NxdG53cDh5?=
 =?utf-8?B?VHh2MXdtRk1jYmpFN1FvcVlUL2VMWHYvbnpUVk40eHBVMVpYL0RJYjN3NjFo?=
 =?utf-8?B?YTVORTVYeVpWTWhhM1V5WjJMNml1c0QzTGNpa0xRdVBtcG9JS2pRRkdPRCt5?=
 =?utf-8?B?Y1RucmRiYmdxeUtOMzBRV2VPTVN6T1Y1SitERlY2K0F2RlhZWnNseThEYmVB?=
 =?utf-8?B?akJTOUxTVWtVemYrNmZFOEs2ZkxSdFVPTlFMalFqcG1XRjRLdGdkV2h6c3A4?=
 =?utf-8?B?TTJJd2o3U2p1VS9RaDFseW1OSnZQekp0TEt5cHR4Q3gvRVUzOWNaN0docTVN?=
 =?utf-8?B?b2ZURjZIRUx6MGFSNE5UUmZnUzU0ZWVoeDhFQTV1dVI4WUMvTEZLZ2VNRk8z?=
 =?utf-8?B?QnR0QTNpdnJDSWFQK2lrNnFWYVlRZStMcEpBLzdjNmhYMjFxZ2hyWVp3WU5x?=
 =?utf-8?B?NW03UWJlQTI2MDVZSUUrcTlrdW9WZmtFVzFwWS9zaS9EZWpZTEdEV1lEcGRO?=
 =?utf-8?B?S3pnVDF6ZmFpdEM2dm85eGdGeEhFUXEvd0d6eEhMdnc4TERRMk1pd05JblRV?=
 =?utf-8?B?OHNDcGtJQ0hya0diWXhjZ05XdG5Ia2ZkaDVpUmpKSW5kaWhHM0tGRlZVcTRn?=
 =?utf-8?B?cnpERldGb05GU3F5N01naGFRUFcvMERxd3FiOXJic0ZGRkt6UjcybnZxYkhP?=
 =?utf-8?B?RlJtazZseStPN0EvbEo2Z2psL0lQd242bHlwY3pNR2I3aDZMeFhJTDcwNXVV?=
 =?utf-8?B?U01QeDNhelhFTWxoOEZ6UHR0SUdNdjVhMTdua0c2bGhQOHRFU0ZINWp6SDd4?=
 =?utf-8?B?OHQ3TFdNNzRxS2VCV3lZM1ZNRFJjNHhjTnIzNXczQ01Tdi9BejVjR2lFd25o?=
 =?utf-8?B?Q2RXd043WTFnUGUxdUxwNkxIVUJha3d4VHF1RktJV1J1VG8xOEVxNFh5aENi?=
 =?utf-8?B?ZFJJL05tQk1ZNWtXRDVLYzJkd0JiMUlhVE1vUnRKVlEza0paVVZuZE9wY0E4?=
 =?utf-8?B?Z1V5LzNreWIwTjJYZTJhYlR0VzRSU0Q4Y0syblVKeUVIZXE5bk9kUVZqbFJ2?=
 =?utf-8?B?emx2ZEVIYklsYkw1UzlNNjlydmFjbW9qQUNuMUlWU1BXOUpUeTg0WWZoejIw?=
 =?utf-8?B?MTM4QW5sR1dCMk45b3BFeFRIWUVXWDg2RUFsMzc4ZjlFNmkya20wN3ptNHB1?=
 =?utf-8?B?cHIxaGNINVM2ZWJuWFJPQ2hjdEFvVDlwNUY5OUpYTmx6c2RPd09razRyanZC?=
 =?utf-8?B?WlpPSkNnMkM5YlNVMlY1U3NLZkdJemtYRHc5dFlSSWJTRDNXdzl3ODRwbVY2?=
 =?utf-8?B?RmZsZytwS1AwWVFkbHpySUExTlVBbFhSRCs3Z1FORm9uSlJoTGR2VVZqRDJB?=
 =?utf-8?B?WEorOGJON0Q5ZWxmT09NQ2wxUlNDN1hsdGMrTkhJdmNLK0RGb1lyc2Z0cm9I?=
 =?utf-8?B?YWRpcTk0TkFEcmpPZSsrSVZzQkszc2Q5YnRXRmFsaTh3QWs1L0p6Q0E0TDNN?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f1208e-45a3-4ce3-d3c7-08db91c15c38
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:26:26.6487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHWuB37Plz0eWxguf/evpsxzbzHvBdpTsb1j8/D/FQkGXSiJZSCqAgzVb4VaC/rAbBzAktsYsvxsQHaTat4A+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/27/23 23:16, Srinivasan Shanmugam wrote:
> Sort the include files that are included in amdgpu_drv.c alphabetically.
> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 900be3a62cdc..90faaf1eadcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -26,30 +26,29 @@
>   #include <drm/drm_drv.h>
>   #include <drm/drm_fbdev_generic.h>
>   #include <drm/drm_gem.h>
> -#include <drm/drm_vblank.h>
>   #include <drm/drm_managed.h>
> -#include "amdgpu_drv.h"
> -
>   #include <drm/drm_pciids.h>
> -#include <linux/module.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/vga_switcheroo.h>
>   #include <drm/drm_probe_helper.h>
> -#include <linux/mmu_notifier.h>
> -#include <linux/suspend.h>
> +#include <drm/drm_vblank.h>
> +
>   #include <linux/cc_platform.h>
>   #include <linux/dynamic_debug.h>
> +#include <linux/module.h>
> +#include <linux/mmu_notifier.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/suspend.h>
> +#include <linux/vga_switcheroo.h>
>   
>   #include "amdgpu.h"
> -#include "amdgpu_irq.h"
> +#include "amdgpu_amdkfd.h"
>   #include "amdgpu_dma_buf.h"
> -#include "amdgpu_sched.h"
> +#include "amdgpu_drv.h"
>   #include "amdgpu_fdinfo.h"
> -#include "amdgpu_amdkfd.h"
> -
> +#include "amdgpu_irq.h"
>   #include "amdgpu_ras.h"
> -#include "amdgpu_xgmi.h"
>   #include "amdgpu_reset.h"
> +#include "amdgpu_sched.h"
> +#include "amdgpu_xgmi.h"
>   #include "../amdxcp/amdgpu_xcp_drv.h"
>   
>   /*

