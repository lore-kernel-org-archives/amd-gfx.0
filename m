Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3E7C61DC6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 08:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA8710E1FF;
	Fri, 28 Aug 2026 08:25:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="maS6tZcJ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA71B10E1FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 08:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imS16CN0eDCTVro71jhGc387aacLmXG8gLRDq8XtY8s7PH43ClQi07gpoEPB4uNdOQao3yXcW/9JytfSoo8hKCnZzq49wYtoROvXCfSULAMqkycCJ0AvuHs8tpcP2eolpEOhGTZ+iqdW3J/9qLe9q4cBntjLgPqERnsaHFZRr6DeUjdnCXNZ5RccnM/qZzePHdrNTIM0quaVwlHG6Cfh8PKRwefgI6jzuWAxTIn+2udbi+b6nWaDbtzqO+iAHLklHyyZ4SYpaIJZkkjF30taPVnqk2EaYiCjTRcmEuSwE72THmBd/ddM+AP9BJG7Mo48ONNmqSZJP/7k//O8SL9jWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOEB72gs3hhy9u6ufwsZrgOIcLvoRm8cyuTiSFp5Dao=;
 b=rhtJQSjYbKq4huDrB0KozzGV65psQEbaCOayGmokbPeKSpiE8aO3QnklJgRG3TGrh0ctclVCBGRpaVjeKnCM12m2EsxnDzmTf2y6pU3rrZs2a/X/97++1FH/77W+WIYQwhFXl/scI+RpW1FZrKGJW0+a0qUqNuqLQ2KPcYVIoQgk06SkNZ5CYQf43/vE3NYlJgOaUxsOCIWPa1tBjI73wlscEI4b//Dawv/sSsymzbfD1TSgvbagy+zZxZy3nWL2qe3yG5HDvD6x+AKRFUczv7nD97YDyesD+J4tXmzbu+m1HDlvhpvr+VRjBKITEdQnRCnT67txqi0F5eQwLvjUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOEB72gs3hhy9u6ufwsZrgOIcLvoRm8cyuTiSFp5Dao=;
 b=maS6tZcJcvDwcD1kxY7UGXrxVDjoLU6Y6/cZNTKSxwAjPe+rKWKtoY15ZI7ZDaUQllziawD5hHaVJAHGP0ifJrzYuKQT0sFM8+P/fjkfBrNSfVHlIeLc1sR2cs9B1t2AWTjktRGj4rfLHFyvqrzdXkgDEpApYDd8OBBomAH0wFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 08:25:29 +0000
Received: from SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3]) by SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 08:25:29 +0000
Message-ID: <05f31596-69b2-498e-99b2-32c086698660@amd.com>
Date: Fri, 28 Aug 2026 13:55:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: fix byte/dword unit mismatch in coredump
 IB dump
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Prosyak Vitaly <Vitaly.Prosyak@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260827163746.1085495-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260827163746.1085495-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0130.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::12) To SA3PR12MB7782.namprd12.prod.outlook.com
 (2603:10b6:806:31c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7782:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc48ce4-445a-40a0-3cd8-08df04ddeacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: E8REBZSIxxOyREIxDhJNLOh5ARuo62b4x/XT7TjCc9VrdvH/drfviEHzF7F7Pb8GdRWrWhEYimePb155dlZ9T6i8hOhdUSq4HSBa6vXMDhv8sximEuTGAft0xUnnlmk400qeWH0i+cJq76fed9l2D63xpwJrCw3A6d/wB1v1+TlZwDYfbA5N6/9seAQe5PwBpHRI/mN5pQyGqN4OS7TE4EfYFAJ85dusxBCeAW4IBQ5Lz5lqOyLy9ptV02iW+zy5F0G6sIR1yzBN18w5s1GjTeo70s0ksXgkM6BGGJ20eKKC8b4v6gbQt1ymLdvKtv93JzSbNUIKsIDMYzywhXAdfL35JBWHHZEmSTni064ZoJXq6hHu9V86JJ1Od4HXCEFLL1ipFgORoqXERK1iJKRew7NF7DkrcKPgcH+ZrkF2ripNtlyAz83/sWXicsce5BFZZuzBx9P39wZ59bZ869s6Ul1GhQDkMXOOttOSpuyFlc5varqSu7Uy6T/i+FbzSE4yJtU1UUajsugVW+g+WAMD2PkTynohiy9mn+//L/biMVniUHkPc1TkdQHwOn/xw+/fJ0j/EmNvRi0vpJfdcCC1cJCcIntlk5oWanwtxqk1GgSjm3SGAqwDBdepscaFoQcbjeywHl5MT/W+b5UbD7iF65H2EpOPDpkBGWlW3MOcHfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7782.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGlER3RLT2J2ME9sdEJIYTg0SmZzVjZDS3p1VFFkeXFCWlR4SGszY3BKVVpm?=
 =?utf-8?B?VWwvS09CWW0rRFFPWFh5WHVTTkRvWXpxelRCczh1c3p4VFA4VlVuUkZHT2RT?=
 =?utf-8?B?ajBXVjZaM3hTNUxtWm9rbUZXYjFydjBnTXFhTC9kM1VySXhseThFZSszck9P?=
 =?utf-8?B?Y1JJcXdidkY5c0wyREtIdndZSlp6QXBZZTBEczhYWGZ5dnk3M0xwdW42Qmps?=
 =?utf-8?B?U3VZMksxeStsdjE2Umk2dE1QbjFEUUQraUovdXhIdjl2aVk1V3hNeUNYWmd4?=
 =?utf-8?B?L1d5T1V6NSsxOWNqRFZkNmRjakJuNlF6NXpDclVyd3dOQXdnYk9WRlA3T3RO?=
 =?utf-8?B?WUh6K2l5OG5odWxNdXZBb3MzckpDTE90Nm9TbzlzQVF4N3hWbVJ5b2Y1dENp?=
 =?utf-8?B?ZFJZWmNrSC80K3FqelcxSE02aUpDM05GSVZIOE1Vcitvdk43dUR3dksvVW5t?=
 =?utf-8?B?L2djcitHQzRja0ptT1NkdEJNNFlXWlB4N1F1bXAwRGpNdjBseVFsOVoyS052?=
 =?utf-8?B?NjREeTAxNnh1SS94Z2prZFpwVkVWUlhtcFB5b1VrZUVEbUlxenNlU3J2RmUz?=
 =?utf-8?B?QVJzTEZqU0pTQWxaM2pSdnBtdVpFQk1nLzR1RVc5bnN1RDZqbi9aSGgycmF2?=
 =?utf-8?B?UDFLdXRBQ1NmSklGdlp0dWV2UlBlaFp3a3BlblZvQmIvbnBXb2puYWd0Z3Uy?=
 =?utf-8?B?SEJxZ0lHOTZHSmx5bGU4UGthZURkWDRFOWtpeVV1YlJJMmJsZTU5V3o1Y3Jv?=
 =?utf-8?B?VDc4NExMelFCdHorUjRqdjdnNGZzRHcxV2hzQ01MZlFPS1Q2RHF0bHBtcDRi?=
 =?utf-8?B?ZER4aU80WXRXN3FpRzk4WmNGQ2hwM3NvWWhSZ09XSDREd1YvZUJUY0MwYzFt?=
 =?utf-8?B?eCszaEU4QmxRdWM2cUNTRzdlQ1liZnltQkl5dE40Qy9JaGlKZVgzYzFsYVV4?=
 =?utf-8?B?c3FYWnFiYWV5dTVPY3FDUzNtSnJmb1BERFpoMXl4RElXOEFObGZSc0lNbjJ6?=
 =?utf-8?B?bG1QRS9vVVV1Y3V4UldkZzVqTm1PeDlIS3V3WnUzcGRINW5BVDZZd3ZwSTBC?=
 =?utf-8?B?QzI2R3NhcmtZMnRtblVMKzdGR0pyMmFsTzRQMjJJWnVlK1U5L3NHeXF3TnB5?=
 =?utf-8?B?N2N5amVqOG1KMmJqNWNaWVVsVlN5ZEhRWDE4MWFvdDdYM2cwVHVFT3g3NFRx?=
 =?utf-8?B?dnl5bmJBa2tFdUlrYVZOeUU5TFNEbG8zbUloZTlVbFR3ckNmTWlNVUZ6Njht?=
 =?utf-8?B?WXBnMDdlR2tQVDJ3TnpyL3hocDhjWDVpdHVHSTJJZFZCSmhNV3kxOGdGTU9F?=
 =?utf-8?B?OWh5UkNKYVNKT2k0VjhNRUxKVjZXbWVLSm8rZHJ1M0h5dUtzSk9YWGVjMXBZ?=
 =?utf-8?B?Mk83ZnpMaGQ4K0NUUHNJMjZRZ3B0UE9aMVgyS2MvNStFT2NNeHBtdnBKMXFX?=
 =?utf-8?B?NHlGcytqbjdoTVRUa2VJTjI5TEhxdFRkcExKVzlqNWZiNGt3bEowL3gzNGFj?=
 =?utf-8?B?SjM0eEEvbVJPUTNkdVpMc3VUbVIvVS9jcHovN3BvWjlCN0hObjExRDB3QWpR?=
 =?utf-8?B?Wmk3TkJUZnlQdWtNcGVKWm8rL0p2Y2pzaDJsZGJrRFdLajNJdUxyTU5RV3Jz?=
 =?utf-8?B?R0loY3B4TElSMFVtWDE1VktGQXJVWWxHTm9iQ0MzQTZKRUgrL29TbnZDUE03?=
 =?utf-8?B?ck9xL1dXaFZVMWxSa1JvdEV6cUhLWXZmY0trS2o4b3N1RlljRGViV3E2K3hu?=
 =?utf-8?B?ZDh2T1VIbzdDVWh0Y09zM1hHaHFJVTRscU02MGxuY0ExTG10MlJoRFBmK1JD?=
 =?utf-8?B?R1BVekFVUjdOTFBNc01FR0JKRHVPMTlTckU1bHR1T2ZOUXA1SXRqelNuL2hT?=
 =?utf-8?B?bG5kU0w2QXhUVWlEbGo0RkdySkRWaTNRV3JlTUJvbGR1MEhBem1Vb0lxVEdR?=
 =?utf-8?B?K3B3eHBOYlRwZ0JMVjhWczhSR2pLa2xDSkdLdEI3RFRHVE12SHJxRFRvYTBG?=
 =?utf-8?B?cDh3ZGVuN05sYVJmRE1oOFZyZncrbGJkbGZxdVl5cjkvMHBiMzJLK0d6NmRH?=
 =?utf-8?B?RWovd08yc1crZkF4d01LS2VNRk93Q2puYm4zVGVMdTdpUENrZnpadXdtQnJM?=
 =?utf-8?B?bkhXejZ5RWo2cEhOeEZkUEw2Z1d4bUdoSUIzNEpUZTZSRjA2QmVpc1NXWElS?=
 =?utf-8?B?Y2Y2Y3pjWGJtVnlLbmRQMkFOZXd3UkJHaHk0RzYvcXNZK1UxZ0sxcnFabEJy?=
 =?utf-8?B?Nit1WDMzSGY0SjQ3YTVPd1JTQUtIKzZQSjZCNEZheC90NzFyVHFiSzV0a0N6?=
 =?utf-8?B?RENhN25OS0RPZS9PQmtrMWdZNXpiMHl6UTM5M2hwSHZNUm5DTFQzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc48ce4-445a-40a0-3cd8-08df04ddeacc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 08:25:28.9148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHz0R+JN1/08gNQu9FngScDFySPllP567Jl+K4Vx9NHgtl9PomJE+QUV1Sxr13Rzw+SoacGVTbLon+JnpA1i/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

+ pierre-eric

On 27-08-2026 10:07 pm, Sunil Khatri wrote:
> In amdgpu_devcoredump_print_ibs(), the NO_CPU_ACCESS VRAM path passed
> cursor.start/4 and cursor.size/4 to amdgpu_device_mm_access(), but that
> function's pos/size parameters are byte offsets/lengths (confirmed by
> amdgpu_ttm_vram_mm_access() and leading to wrong size calculation.
>
> Similarly with that change the off index needs to be calculated
> based on dword since that is a u32 type.
>
> Fixes: 7b15fc2d1f1a ("drm/amdgpu: dump job ibs in the devcoredump")
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 76771ad30c41..2d3fb87af00a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -297,10 +297,10 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
>   			amdgpu_res_first(abo->tbo.resource, offset,
>   					 coredump->ibs[i].ib_size_dw * 4, &cursor);
>   			while (cursor.remaining) {
> -				amdgpu_device_mm_access(adev, cursor.start / 4,
> -							&ib_content[off], cursor.size / 4,
> +				amdgpu_device_mm_access(adev, cursor.start,
> +							&ib_content[off], cursor.size,
>   							false);
> -				off += cursor.size;
> +				off += cursor.size / 4;
>   				amdgpu_res_next(&cursor, cursor.size);
>   			}
>   			emit_content = true;
