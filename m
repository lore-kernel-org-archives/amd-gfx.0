Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78CAC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 08:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 264A410F2D9;
	Fri, 28 Aug 2026 08:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yNaARJLO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BBC10F2C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 08:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErpvtYaoGov0QkcxBmb7qJN0y+Q/yWpq1dZKDPYQaWXe1b0rEp+yjspk9jk67KnmSuqyOMGTU7+lxcIXWKZkKWvQGWHqucNdcxuBEWIq6/h1jTsQy/8ZeWfATNBpyrakKWOxSn97EW0EZiSzYeoXqLe1y9L9TKQd9eq+V7eX8KNzJoNPSzVbzyPCSjsMgLTwT5XsFKNRRwzWNcaySKdYyM1On/pARfdS75FmNNcN48rOR0qXuF2nOJSH0gE5GFVTKU5oVXhrcsU/F0pK2G6qcX47uSkkS/bmAhwCw6iTf49s5OEzjz+XjD0WV7M9ifzyrAKwIZZXlZ7IZMf9yO4REw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g44NZyrfEimR6+4mQejYHSCxhgsvLYr85XWF/lzSTQ=;
 b=D4ROiJSFpSjAo+PKU3r6+3H7DkAGf6qTNF9YvkI+vMNucTbxQoPzjD144yAvsqPjPjo82+agQ1UMFAAW/1cjCUTxzVcn33vkZhre4cSCaXeUaLotoquLlHC/7M8NoAFFJfvNkChzaDM++pjv2kVjNbewTwWrqpYOXA8j8oNgSRLfZmwbk7CCUU47y3xlZuM5Fl5pcsegGBjyCSjeCRIv7SyrYV/hbnBqd5G6HzWQ3MJ7BYahKerwr//7lgvFH30HrMoQbBt2sAAAG361/PFV8NMpELJgZaWDMihkwJLwcF8pfUJCfy3YSRHO27rMtsRDBY7l7/lHLGd4d3oKa99oVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g44NZyrfEimR6+4mQejYHSCxhgsvLYr85XWF/lzSTQ=;
 b=yNaARJLOtBFgjWLbGre7EJjdRADxBjuqxL9qTo+rwGPP1B1j8AGEczPbu0oNzu9QRvp2LJQ3l2P/nERiScvRPGTqXbsFlg63FNi618k6Jg6FEPZkKqUluyyKhGLDRTXVN/1dLHvWzzSle/TQn/km53R4TPZejkok1OdjOkIMBNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:08:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 08:08:45 +0000
Message-ID: <5c7d7ba1-58e7-417e-abe1-4fdc64078f2c@amd.com>
Date: Fri, 28 Aug 2026 10:08:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device
 padding for 32bit compile
To: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, sukhatri@amd.com,
 pierre-eric.pelloux-prayer@amd.com
References: <20260828062159.34669-1-yogesh.mohanmarimuthu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260828062159.34669-1-yogesh.mohanmarimuthu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9f1ff2-ba36-4931-7203-08df04db9526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: XmkrStTtq3pDwancxqI8O2hmyAGTP5b5udZjNOEBOAtTf1xQzeSGsHvLt7uyOjyxH6iNNpR6YsdfFBRscYKa4ndANDJZv6ccQgsfV1noXOzZNFcZoTTk/zV0Jb1RMWHa8enyOFi1J9ZPQSH1Vwa3z4GRmGI+4Z+r/t2WrrLfzLu0CWeeUmpkQrzWFGuMcJL21iKU9YC7HDRVzHzfvFx/HOzbZsSSEezP6NWTOGDSVt+L26Zf94aAamg9VTDCW1kamSvU43XYvFcOmc5Nl4T3oXBAeSIAoq467wpyVq4/W5iUJrXni+f76UcW4VuWS3HbJFdIBfeCFnOJzWteCe6ctXwROc8dMUa9RPN7AAiRafQBBFW5hgpPtMNAHcSxJtREh4EmP7YBJOlYTKo19t9tz/WKt4cCdFugvY/mQMQ7wqK8qKar87i/hwOoV8LmoQDWceGfs0Zr2tFqeAeNgsO4WqiZaS5VgQweK3rAYqtfGQVYW3SHhG5LYe1JUEjXFQHJgT5djsUmZsMFvQFA40kIYztNAweJWtjdBrEAYoAjyCfpx8FaJNqlsYkHLAtf6AKC/o2WV9kSCQVVPrzoSTXyL8YxBe2Dgcnz1vZkQKcSm/FMxdd/Mhf9y+gcWRWGSOHcBa1WgdtZUMK6fptcBUUv8IdrcR3U9Gd/I0tyVaGFK8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmI0QjBJTkRPYTAvQXpseVhmU09UT0NDOXU2cVNCd2xOc012MGovcENETmE1?=
 =?utf-8?B?TVhiNVdGS1dpZWcyblZoNDFwdjViT0EyVmJyS0lmSWhmN3VZOEtDdHM4NzIw?=
 =?utf-8?B?dGtWMGtUakRqQ3pXYXFnU1VVZm5PZDlMVHYyQ0dyOVZEUXN4a092T0ZIOTdi?=
 =?utf-8?B?L1N4cmJiZGxCSmdJQXIwVmVQQ0N4SDRXUS9Ia0FjQnhzSStBNmNBV1RCRUxS?=
 =?utf-8?B?cEx5Rm5jZFZ5TnpvSExwbm80aVNoSW9nbDhQSTFlczVqUjFVdHVIbzRwZVZW?=
 =?utf-8?B?TDN3MUlQRnBqN1B1N2pqUkQwMjNjVi82WUFFSVptNG9CUmZlSHRzYzVpaStD?=
 =?utf-8?B?L291ODNMYnpFeG10djJKUFV2OEIvTVdsZ2FjMEJTQ2krN3hWRGVCcjNVbUht?=
 =?utf-8?B?QlY3Y0NidG1nQ1p5RXplUTZ2SzdFejJvSHhFbXZGZk5iK1ljZzdKZVdISWdj?=
 =?utf-8?B?YjRPKzA2M1N6L0NiZnpxdEs3NEErMVQ3NkVGSmZzR0dTMG5CbWgrc0tEZ3U2?=
 =?utf-8?B?NmUzSmZCdnBINEZ0ejBibnVQSEJWWGRxZmRRaU93MGtXSHM3T2p4L2s5aGJZ?=
 =?utf-8?B?WVJ2eXBQbW02cVFIWUViQkxhL25VZHlTNzZtOWljcDh4emN2cEhLZHRKekUy?=
 =?utf-8?B?c2RSamJwQnUyUDB4WU9YVHgwSWluVm1mUCtVQTBkQTFhQ2c5Q1diemdERHN6?=
 =?utf-8?B?cXFtVXZpcVcyeUx3ZVdWVXRPV0RCVUdlOXdoQzVGUzhxR2VpeEhpdkk2eVpC?=
 =?utf-8?B?aU1zWU1vaTA4N3FDNitYT1BiWCt0eHZQNDJVQmdJMjRlYVplaHVOcVZHNGpz?=
 =?utf-8?B?ZE45VWtGeFc3NU4xa2lTOVZ2eEJoa3Jxei9sUjdIaE0zUEpIN3NyWENXUGYr?=
 =?utf-8?B?ZFdoQmtSU1dSZVAwakZzVS9JWHNaTHNDRXlpZHE3bWVNbWVteGRXSXk1STRT?=
 =?utf-8?B?cEVaajFtd2gvU0ZXZXRZaUQ0WVZlR2U2RkJ4Mm5CdHJ1WGRhRUpvWk1sN3NX?=
 =?utf-8?B?YjJFalhXMFlVWCtPTk0rcnVPaVdxZk8wSWhaMi9Td0cvVzBLSlNMUE90bXlq?=
 =?utf-8?B?ZHJEaEk2SW5iYVd4aHJHZXQvdFhsUnp0bUJ5NGVWcmhXb0RaRDNYcjFMMHJi?=
 =?utf-8?B?Y1VwTExkblhhLzVUZEo4UXlLZGk0SG9EMXVFSGE1VEhyeFQvNWU1a1N1TTZT?=
 =?utf-8?B?ZlpOQ1p1TDE5WEpBdnVNZW8zRE5RMjdvWmw4dUk4Y1ZhY2dTcmR0RVdjQWl0?=
 =?utf-8?B?M1dYTkdBdDdsM3NJZjAwZnZvQVVycUJGUG10aWlYeWowK2NuanYxalF6RzdC?=
 =?utf-8?B?T0tWMmh4RHVEOElQUldxYko4Tk5wdFV5WXh0cG1vdEJpR09jRnJHUHNpaGxu?=
 =?utf-8?B?dksvaW9iQktVb1BrRTVoVWtMNzlQOFJsRkxKQzc0MmlXVHNqd1NvQmFyc1Q4?=
 =?utf-8?B?VGQ2OVpZcVd0b1RaVW8wdlpGdlNwakJIQlJldkVMa2c0RG9BWEd0cXJvS2dH?=
 =?utf-8?B?c0oxNTdYcXNFa2VQTFRreGJUMWVKWnR2dzVDajlmT2k0dk5YWXE4cC9uMUx0?=
 =?utf-8?B?RU8yVVRUaTVNd1BlREFJNkRqQ3BIRVZ0VnAvby9mazhTQ3VzeXloaitaWnNn?=
 =?utf-8?B?ZnMrbzZKa2l2aVY4Tm9VUjBlVHdLbUFHeUxTd1ZBSjJQcWJpakgzUngvSWxz?=
 =?utf-8?B?VDl0anh3cVZRR1pma2FTM1BTaGF4ei9BNFdCTzhJZ00rNFo5QmNOLzMvUCtq?=
 =?utf-8?B?ZzVOc2tiL1BqaTZuZmhVUy9CbzVxZzdSMkVDOFhlMGVKZ2NiYXhaL0huRnRw?=
 =?utf-8?B?bHU0VmwrUVM1SENXblRvUUZ6LzVPbWgxWkRrWk1DRGR3VEtPQ3ZSV3A3M3Yr?=
 =?utf-8?B?ODJGSm16QnpxM214bWJCcTIrRVJWWFBtVGtoQXRHdzF3VnBXTHAzLy96ZWts?=
 =?utf-8?B?Myt4RlF2SGpraHNZdWZ6dzBpN1IvY2d0UUdtNnJJa056UkdGSFBNQmk0Vkhi?=
 =?utf-8?B?SlE0ZHdVSG1wUE80NklRZm1TVlZvdjYxOE5PMityTG5xdVp3SEdacVl5ajh6?=
 =?utf-8?B?NDNLWkZyM3BYU3hsNTd4eWtSZjhEODdjbHhYbG1wWlYwQzR0ZHpPT0dscDJF?=
 =?utf-8?B?THZLeEdsMHIwT1Z3SnZvcjF3TUkxOFRuQnVNa3NlMnh6bEUrQ3djSUZyLzlI?=
 =?utf-8?B?WUlqMlpiWGJ6M0cySXhzQVoySmpSdnJlaTNTSWdUV3h3ZVV5Szh2YWU0RHF4?=
 =?utf-8?B?Y0pXM2ZDaFgzN2ZPRWwxb0xkbVFXalg0VytrZElaUlo3VlVPekxpeDFJSi9m?=
 =?utf-8?Q?OFwzxd2DiZzZDDECEI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9f1ff2-ba36-4931-7203-08df04db9526
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 08:08:45.8166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5jTKPLO73RDiE57G+/qOoyfcKUnIXm5h/V8YTFE++JuRIoKWCNwvtQVDuguk65f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
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

On 8/28/26 08:21, Yogesh Mohan Marimuthu wrote:
> need to pad before __u64 tcc_disabled_mask variable.
> 
> This patch fixes 64bit Kernel + 32 bit mesa combination. But at the same
> time it will break 32bit Kernel(using this patch) + older 32bit mesa(not
> using this patch).
> 
> This issue was discussd with alexander.deucher@amd.com,
> christian.koenig@amd.com and pierre-eric.pelloux-prayer@amd.com.
> Currently today 32 bit kernel + 32 bit userspace and 64 bit kernel and
> 64 bit userspace work.  Mixed 64 bit kernel and 32 bit userspace is
> currently broken.  Since 32 bit kernel and userspace is probably pretty
> rare these days and the data affected by this is not critical, Hence
> we can go ahead with this patch.
> 
> Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>

We need CC: stable and a Fixes tag.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  include/uapi/drm/amdgpu_drm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 0a113529b..5beef3eaa 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1517,6 +1517,7 @@ struct drm_amdgpu_info_device {
>  	__u64 high_va_max;
>  	/* gfx10 pa_sc_tile_steering_override */
>  	__u32 pa_sc_tile_steering_override;
> +	__u32 pad;
>  	/* disabled TCCs */
>  	__u64 tcc_disabled_mask;
>  	__u64 min_engine_clock;
> @@ -1541,7 +1542,6 @@ struct drm_amdgpu_info_device {
>  	__u32 csa_alignment;
>  	/* Userq IP mask (1 << AMDGPU_HW_IP_*) */
>  	__u32 userq_ip_mask;
> -	__u32 pad;
>  };
>  
>  struct drm_amdgpu_info_hw_ip {

