Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56CDF459EE
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 15:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FEC10E13C;
	Fri, 10 Apr 2026 15:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k9DAjFNc";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607C710E13C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 15:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD03rtPKXWjis0DIKX72cII/xMQ7UAtBSdkUygp0XYVUMh77VpE+Z8Tw/1fJF1FYH1ps2AHYx9gRFE+zbBqpxz1tbYi4ogB5p/JFiKjw0aI7nndG8rDb/4t7mGdSXZ/rGRyZOBT2rq2vak202umkWGu9xxVc084fwfN+ugBfeSQifWHB2O9i+DGJoewg5/bSJ9I2LOwngPkicL8xPE/VXBYDPuvG92FCzyvkZrDFytHtohrk79kNaqu90jiDhdWCnxRAQEhJMyGcTacxZu+4wIWcR0ifP7aMMLA/ndB1PXA7kSi5Ggyb+dSrhmpEMY6RRtMJDA4hJqp5yMYFjf9ieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm6xddznFTTt8+DLfvYcjT9rev1LrZmd9xi3Y5MSu3o=;
 b=gt7c2+z5/WRLMXuk6c9/6vfpKFVGt/xafk3+yNURcbioC8Krkqa6WZC4SawrSlmSj9Ia7ICa7BwR0PxC9shP9qeUaA+zOoD4h4Leh9SHmQJGHvz0RtiAD02fMeqFlFGLJyc+X/WaB1MVHf3exK2QxERIWFr+mef1cNMCnn5to4iruIOtvlc1wtJVZZwP5wK4lIXfeyuiKmA295nIxGwW6ptKu+HK4/qddKd1m8tMqK/aVILwK46tgpW/GIKLK0jAmMOeAjNVXT51hkFWfn6ewlcUvzOus1gy5Vw0HFzhMfMMw88Hw5qDkXX/RKHOkwS53fggC/sYiah79wEuLk289Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm6xddznFTTt8+DLfvYcjT9rev1LrZmd9xi3Y5MSu3o=;
 b=k9DAjFNcwuR5GSYghH8TGUjI7RO5fJm7fYyLelwTm5kVHszKK8QNwxCvLG7/LLYizxkYdxj4llOPrQc4t4mspy0qxgioOPrJQqbE8XsIZ/9+CBUsOsTW1R4vHlDsQ3ei6KtTjHdBf70pK4gFoJmZwE+uoZccy+a07pRRf8TXiSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 15:14:51 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 15:14:51 +0000
Message-ID: <a203c78f-6191-4713-b7fc-016ca2a04172@amd.com>
Date: Fri, 10 Apr 2026 09:14:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove redundant includes from DC
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Harry.Wentland@amd.com, Sunpeng.Li@amd.com,
 Aurabindo.Pillai@amd.com, Chuanyu.Tseng@amd.com,
 Linus Probert <linus.probert@gmail.com>
References: <20260409180654.1628589-1-Roman.Li@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260409180654.1628589-1-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:303:87::12) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1c9c80-1043-4336-7f45-08de9713e98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 58q3oyMDSZ/Mf3ii3tcdfcI9lnryiDmOrax8m4kwH6nJSj41GQrMlVC/oES9hQafERgS0eIARTF7J9eiS5te02WfpodgMqQJPt+JGavysGMAC0Nf43M+R/0ZQ4Gjb00ZlmkSRE3QI5oH7UG+F648yNkbz7/kuMXJdjT+QykGdWAi8efOLX8jFhSBTzI57TxO7h+WmebQhTmMbsn4iEkOZL0aQKOEt6gBince36UySNbprk1JwvNQecRnsV8xy9g3z8zPluLX9uKlNjs77hDXpjLSbRDSmHPAJwRVUM2MxniwwsiMqesrFXgFtvv5eq7HUsy5AF2cs8UwT9iBfMgia0KmhWZI4hpx/tLLhZyvWfyVyjxQv5CrbFQ0sLKUy7TB/5oQgAfNhkoA93m5muDY2yOJAr47V5k91OeJW3gA2lEgDmArIeMe1TXUaTBcY0XVI17Xx/hf7/FQ+p5cKxcpdNLFBy1mujCle2V+tmt7++D9acQmH72c11CyFtSI1ee7HJaaf4cKJSKDh9UtkZraORCNKnFipd5zVRjo74f1lYLnzlRQHHm2w70VvWSlDYCRLWxZ6IwkKf8HiQXtoWWb08GVdqo+9wz0hcpRqDGy3N9SwobkGvBfBWmhVfBngkQ/1V4jJ0rX6GM8LB8vvKXraohGO8Xt0XHhuJUs2NF2v2nGhEs4gH5K2XY0P3jsGHt1oOEQb33VoeygB7Gj0lpk0PBweCpMR+2nhtI1X5gAb48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUthRVcvenpDZmo4aEFlSkl0STc4eXZSS1RHVEhlRkhPdm1DS0RTYVVnSWlw?=
 =?utf-8?B?VlBMRzRTb1JEaVp2YXcyTGRtOTZpK3I3eWhyTWkraUxSWERKSWdwbXluQjU5?=
 =?utf-8?B?RkRRclViWGN0SEZqcGhFQUJDTWxJeW5QbjVpN1kyMmgrR2lHbzFFRlZ3Njdo?=
 =?utf-8?B?azVSYUVqczF0aVZNbExqajhCc0hRcEIrR3Ftd05LY0dydlcvT1pKTFdpWTJy?=
 =?utf-8?B?bGF0aEJvYkV5MjlBTkYxbjgxSE9XMSt2d3RnSm5aT05GQ01NWnNIWU92T3l3?=
 =?utf-8?B?MXRZbnljdFRoY2xUMnlRQTkwc0huMGZ0SVI1emE1V0Nxb3RVeEdoWnk1QjJY?=
 =?utf-8?B?ejg1bWdTUGxxMlNyd1BxVENHa05mdWo1N3RKS2VCb1VvNE95bDVoanNnckpv?=
 =?utf-8?B?Ykk0MXI0bkh4em1RdnBzNCtmendTcVhYWmtKYS84czJHclZpUEEvT3RieUpt?=
 =?utf-8?B?RHl5K0Z6NHBmNjh0Q09hRHhwRTh1QXR6NUlzR3N1dFV0azlEc0ZTWUdFOFhX?=
 =?utf-8?B?U2NHdzh4Q2NqZklQN1AzVnpNa21YWEpCKzVVZytZQUg5UzFHcHkvUFBET0lJ?=
 =?utf-8?B?RHRHZEhaUkF0UCtJeVZlQzNERG5SSSt4UitLNTcrU2FSOTk4ZTg3bEdxWm81?=
 =?utf-8?B?VzFNbGdxVzZEK1pIMVBtN0w0Slg2eDF3emphS3RaYnNGRGg5Sm5YMy8vK05k?=
 =?utf-8?B?SjJtK3B2SVZQUzJ5d0FwYWs4WUtPQW1wQ240bEtOZ1BWMlh3MTVOQjUwaFVY?=
 =?utf-8?B?S0ZhS0tjV1FFZ2hDTmVqVC85QWlIa0FnZnZIcm5XVEdwc2dETEJZOHFUVFkw?=
 =?utf-8?B?dGJ6YTdNKzlXbkhVVGhITW11RzRiTXloRkxvOEcraDhPSGUxaWlBcGprQ3pW?=
 =?utf-8?B?dWJCcisrMzFFN1FEMDlRbjFkOW1FOXpZMEFYZ3c2TTIwQ2paOTBpbWtOUFpn?=
 =?utf-8?B?RnpGb1c1Q3JpQ3ZkMDFmUFIyNWIwY3R5K0pSK0kwQjFtdWh2Z2dZeUI4aS83?=
 =?utf-8?B?c1Z3VnIxdC9yVUNzSHVpL0dMSmowdGNHY0dPM1M4RVdEcmZnZ2RGdGY0ZGM5?=
 =?utf-8?B?dGR2ZG1HdnJjckFZVjBSUUY5UlFtcXFWMGJINUQyTUFWOTlpRTl5N1NsSStJ?=
 =?utf-8?B?b2lEUmIyZUZYeFVEdUJhTDZ5WmFOKzIwOVJsbXpCN3h1aW5LRzZHbkR4bWE1?=
 =?utf-8?B?djlzUVRCam1VSXZTdlN6Qy84Wi9BR1Z0cEUrS1k0MTFEeVJQL0dTVy9EbUU5?=
 =?utf-8?B?aXpJRC9jQS9VWmJtWDc2alNxYkVGV1dEVHBXQ0pRNi8zU01iU2JjNUdSRVV5?=
 =?utf-8?B?Tnkva0RqVDA2NmRveG9Bay9TNmFLeTUrcUVSVUQ4Z2xNYXJFWFJmaUdOd0cy?=
 =?utf-8?B?c05pL2p5OGhvSlNxTnFGZWx3bE56UTVRTkh4LzNDYVpjSlpDNXlaUTByRE5m?=
 =?utf-8?B?S00reG1MdzE4R2tnV2IrcFJEUHNzOGlwWXhldzk2NmlWTitSZDJFWnA2djVS?=
 =?utf-8?B?QWtLZG1vSEpiNWV1Szl3WE54V0Y2L3U3N0xtdGFxbjAwb2dpRlc3Y3ZiZ21P?=
 =?utf-8?B?a2phcjdySnJJcnZJZGd5cnYxTVBhRGZrN3F4QktkbVczdUpHQ2NZeUVQOUFH?=
 =?utf-8?B?cG93bHlBVUd0MnNnN1FqdEM5ejNxSVZ6Qlc0aGpYbnYrYmNYcjhwWFU1WDV3?=
 =?utf-8?B?aFVBMTFTNWRWWk5mZXVId2libXllUHF2QTJJQWdMNDBXaXZhYzBCUkhmaXBw?=
 =?utf-8?B?dG5ZdGhLZDNDUWFPRzNkUWxXM3J6elRNcWVUekw3b1ZCaUNSM3RBYjR0Y0ZK?=
 =?utf-8?B?ekhsS0VUSDBHTmloU2RzWmszMGllcmxJZDZxWm5mUDNMS3VpNnhmS0lwd2tB?=
 =?utf-8?B?blp5RVErZm1iMjVoTWlMN1lLVWpmdWxOZEVCdW9iTCtYWFhkamY4bVRnUGZN?=
 =?utf-8?B?akhaL1JJd3pyVGcrRCtqci9Ha0lMdkpUcld0eGRPRmxxb1BIQVpOU3ZXdUUz?=
 =?utf-8?B?RTBiUDBtaU5iZldaTWpXc1U3cTUzaDJNQksyRnZXQndSY1YyU0pnMWRqQVlt?=
 =?utf-8?B?WE5JUHhvOW1HYmRIa1k3MUUzTCtpcTdydTd5ZGk1QmxRdGNFV1E1NWpqa0dD?=
 =?utf-8?B?Zlpxb0ZvMlRkVVhwdjB3d1RuQkY2ZEw2MkFSZWtGZFROelQvUDd0blhpVVQ2?=
 =?utf-8?B?dnNjVXA3ZVFUVDE3YVNFeHlud3M3V1RITllDa1E5d1pmQ0poeFlndzVZd0pH?=
 =?utf-8?B?c0NuQW1tWGl3YVBXZG9BNndMTkhBVnYyYzJHOFgzRVU4d0E0em9IY0Q3QXNK?=
 =?utf-8?B?dTMrak5EaWhmVVM3R0lYZngxQ1RpamVtSngvU3N1YzR3ejBnYzV3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1c9c80-1043-4336-7f45-08de9713e98e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 15:14:51.3458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 843nkOHbbMSRmL/kzpeAqeSKfU0pd5JIGYQU5CEfGk/88RiCaKCqBWsMEbXCN9v2y/fSC/4DQPmIcpDvKGzmlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 4/9/26 12:06, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> The explicit include of linux/array_size.h in Display Core (DC) is
> redundant. The ARRAY_SIZE macro is already provided by dm_services.h
> (via os_types.h) which DC includes.
> 
> [How]
> Remove the unnecessary #include <linux/array_size.h> from
> dc_hw_sequencer.c and dce_clock_source.c.
> 
> Fixes: 1e29080bfb8a ("drm/amd/display: Replace inline NUM_ELEMENTS macro with ARRAY_SIZE")
> CC: Linus Probert <linus.probert@gmail.com>
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 2 --
>   drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 --
>   2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index 952968ecd46e..7333f5905330 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -23,8 +23,6 @@
>    *
>    */
>   
> -#include <linux/array_size.h>
> -
>   #include "dm_services.h"
>   #include "core_types.h"
>   #include "timing_generator.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index eaeca4b4a042..321a012268b0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -23,8 +23,6 @@
>    *
>    */
>   
> -#include <linux/array_size.h>
> -
>   #include "dm_services.h"
>   
>   

