Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0596610AB836
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 01:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8412510E328;
	Fri, 27 Mar 2026 01:02:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGHy/Lu9";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C35710E328
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 01:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpJMUwNvbuycnNt5b2mtgHQXsSC/HkqxowtC5J2M454LxVWbBrw9o5gnPSiN+4pQtLXIDpwMi+SWRcyv3fqZHl/nG3JK6OIK5ZCGrKqmsbjQCYW1e3BbrhKhVvkYoTtRONyd/KgjOWqrOXTR+efpmrIzj0z4piI7ZNCKjYApHBBXVCwNCaFPxpRFkliy6VvVh2WNbH8JsbiJlytS2QS2v7OViviXnko4n/TtAluRzWIijdUSutRf9khd71M6Aiw66IUpJqys1vaC3zoqoRk42Zt9chgSIygZPI18pggQ9dmJUNAH6HKNWef5qsIsYexlFKc/UVCZXHP7NrqPM7oE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cI/6QslcT/MmSoCjRW10I0lMdyZZxi+twMO2/S5vLA=;
 b=GbireyWHGDny69OskwfsGk/HhQGKVpt+Ha72EdHc/DkmOCwH7Hn6BeHyzaUxCjcsMdEeJvFqeMQQbinCTNVSfhUz+GLBQ0SuQ5bbnnyIQ2nA3b4+BbebRe3D8qLgnbKXRShwGknBzv2SMFeBul6fPuadW+CYkF96CfhOBIIEM/z9reOjLYxG984N2pdwbHWK56XxQPo7A++rnWcbN23TWdMwR7lH/72FKlvq7QxDKT1TK4vMDVQUttl921k0LljCa6cH40ERK3jWj4HGJa5xAy4RR6/gs6dMWrHri+/NRXH0pUmQUFHu1Lkr2UKKCe2KWcJGEf8mXjZ2WERvgN486w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cI/6QslcT/MmSoCjRW10I0lMdyZZxi+twMO2/S5vLA=;
 b=GGHy/Lu9n0FfTXAb4JiAjLOCgWLQ4OzBPBtcf+OP40snbKbzpDnk0LJ2d49gmm/dZe9TxP3b4UwjXd/j1MEFL+e/basbIxR09/ZMxOJJmUZ68pjfHaIp9ZEbUvLf6NV5SWTJeuv0poefJvkfFNx7sdd+VC3N1hrKCpt4gg0SKjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 27 Mar
 2026 01:01:58 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 01:01:58 +0000
Message-ID: <d4bc649a-126d-4e5a-8c2c-0f1eb1eda45a@amd.com>
Date: Thu, 26 Mar 2026 19:01:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add NULL check for integrated_info in
 clk_mgr_construct
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20260323045415.2044583-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260323045415.2044583-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: a3010fcc-cb63-4e1e-a942-08de8b9c7231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: PXufNTAPJ7kNSpPexQV3Xuyftb8NwGoZXmkajIvA+A73MSaJwewJ/CUyqbJRuLE3+5vmF1Dzw8EwivK6uDS1Cx2kqhsjJjM9GqCCM2yrKlbQX606HaK0MZudU93wIqeYX90Mf/H1f1geTpI2VOc3Z8Oi6Bs6hu3Z6JAy1iniEzGxdfx8tKrAQawJet4bNTrfzfxQa8XP/9cbQw01KV0Fj6PRJI3faw0hueHRK86jlUqnyGRONXTKOuuG0lzkiXwQOHafwch5EUnoQAZ5qJIkvXX1BAY4qPPFSF6q2kgI17F6ih/dIeq3uiryqC0fFSB0XjjtLyGQOJI2w0pfEZP/tk2hP4xrK4VIgF0KvmnDIEJ7KM5DLOrkmYZM/MEJtLNvxMu4gUr6ZyKlJAeogrW16+sy4208F4N2EmA0d0IaJd+7LpZWXwBn8R5HpoyNyuC5AqOBUVUmRGbaVABzsy+L6TU4JvoWcReknb76bfs1WmPP5gNZP3g/pVcI/soDKTWOD1jT62QVMvL8ROpsjQw9CR3+VvWbblRx+I1Yl4hP1NSX2JSmrPmEe5JzcoJ3xedG1cV1R+zKbFae+K7t1awtvYM9UUnS4AmgQ5avkMbLW8fhai5QtYoav7hM29Qk+PM8C5MFe5n3r71WRTjbmYxhPy5D94nWfi+JS47LBAal3n/On08BoK/IHs+UlxOFpHDNl2I/Tdx8Cet5S2mvkTtBWphwY28k/ZxUbOmdCj/Q62M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhsOGdPUmRDbkVnQUlrYkNaWlBCQXlsSXlYK2ZFcXAyWS95ZENTK0ZlMkRU?=
 =?utf-8?B?N1RRY1hFSWNhWjdmeTViR3puTS81WVoxOEg1bWFaSlpXOWJ2djlUNjg2dFow?=
 =?utf-8?B?K2c1Zit6VkdRRWgzdWtTa0ptdGs0THcwSkZQd1J4UU9Ec1NKdHM1K005WVp4?=
 =?utf-8?B?ZGdVaHBjUnVnaXZMR2dIdHE4SHFpRzFoVzFnTFQycW82TUZIMWRUOHJLUCth?=
 =?utf-8?B?WjFGaGs0QklkQ0NRME5rVGg2MkhhZFNKeXZoZzNhMGlpcVB5V3hLSjM0K3ZH?=
 =?utf-8?B?bnBMZTRtTm1KT3N3SHdPNHQ3Wk9OM25zWFlyUlhTVDRFRDlZbGlRS1VoVXJO?=
 =?utf-8?B?bEoySi91VElTVlhSbHhaY1JGcHYzK05qc1JYYlJKV0tQMGs4b2RqaEZIYm1P?=
 =?utf-8?B?ZlAxbmp1dmRHVmlVOEV1TVMvejNZdHYrVWdpYnpWc213NHRqRUdRMSsrVkhu?=
 =?utf-8?B?MWtIL29GdXl2c293a1BCVUF1U2tUQlV0NGx2OU1FK0VBVHZLNUNMeWVac1g4?=
 =?utf-8?B?Yk1lTkVXZW96WjlDWEo0ZnJnY003UUpaNHZtVzdtTTdVTHpUeHc3a241Y0h3?=
 =?utf-8?B?ZUN0MXJOQVBTZDZPVkVMM0F2dGt5UFJoT1RWbWF4UGUycHAzeEgwY3JFMTE5?=
 =?utf-8?B?anJ2WWFpZG1wcGJxRnVzbHdIem9QbEVKUE5Nb3NBQ053SXdsREJCVnFLUENF?=
 =?utf-8?B?WU1FZmpNZnpoU2ZubFZNVDYrcHFtNitxVWNtQTVoYVB5cXgydXJHMFdvTXVx?=
 =?utf-8?B?TnRVRnQ2SXRnMFo3SVIwQ08rdlAzMlpCZXJWU3JLbjBtbDFaRGdhd0JoaC8z?=
 =?utf-8?B?Qm0yQ05WVkQ4bFdWbnBmaFRUemxaSEl5cGNtelJRNGt4bkRMa00rMVdzbXQ1?=
 =?utf-8?B?SDRzNXovNk1IMzhKU3lKU1B6WkNlcXU4b1pBYW9YZDdWNy9xcnhlOVBIMDRO?=
 =?utf-8?B?MDdIWHpTQjNsd2djdjh4WTVrcVJiTHhwWVRvVGdBM2psTHhvWGRNUnlYZkRm?=
 =?utf-8?B?YUovaGhQUkJ4WHZmTi9PUkFGcFdxcWFQeWdkdG9MUTdPOTZMR0ZDVVhIOWFm?=
 =?utf-8?B?Y2RlWkJxTXhORlJDTmVpQk1ReEh5dmE3SjVoc2UxbktEb0duV3BieFBvdisz?=
 =?utf-8?B?OUtybFU2dmVJcUl3a2VxOGRXelpQRGF2dE5zU01paEZtTlhSZm9tMTJtMU4x?=
 =?utf-8?B?MWdvUFdhb0g3WmttTmpOR1FZNmJNWEtScDZCb2ZMVnVtY2lEYWdjdEN1MXhJ?=
 =?utf-8?B?NG5MMVBLc2Y0UmRzcWpPZk9pSW1NYTUrMytBRVdsVzZySnY3K0xDei80Q2VL?=
 =?utf-8?B?QURoQ0Y1RHA0N2xtcGs4azJ2Sm1SVFNwTkNUU2RnSElzVEhCdXVFQlBTVnpl?=
 =?utf-8?B?d014aGhxZ2ROWVFhazB3bjR2WlpObU1KNVF3cEVJWXNKL0xsTFlNRDNjK2gv?=
 =?utf-8?B?VVNIMjRiOFc5SG02NC9kUDRmMVVHTTFBNFgyYzVCOHRSNUZiZkRIY05lV3B3?=
 =?utf-8?B?Y1MyTmlOVndRU3hPaVpIT1IxUHpxWExWeUhkZnBrb0hsRUxJdWlEaDBmeWdp?=
 =?utf-8?B?T3pPSmlVQWtKMkdqeWVNYTlHbXlOQmpCM1B4OUlKOHJHenFKTTRGM1FzNFg2?=
 =?utf-8?B?YTd6KzNyQ2hnUzhuMkNZUURZTm9wUEJJaFRDRjJ0RjBzNFhBS1FFSE1neGVZ?=
 =?utf-8?B?Nlh3YlZMM3N4b1lsZkhzMzRrTVhidWUrWXJhTVlIdndFRXMwNml4ZktWUm1S?=
 =?utf-8?B?bHBpM0VZM2hnbVVHQ2pHM1lQQURPcHBiU2NVaDhhZGxpRXIvaEp5aVJyYlc5?=
 =?utf-8?B?UldvdG12M3BuNWplc2Q3VUU2S0xXeGdzUlZmM2FYSEU0VVczQ3Y1V1pmVDNZ?=
 =?utf-8?B?c1FHeEM5ZU5JNllHWXNQdFIyVVhXK0dvaDA2aGliQUdtK2dTVjFnaTliSEJS?=
 =?utf-8?B?dGZOM3dyUTJHOFNxcER3cVlCQWU3QW5sRmVxY0FFcjQwekJMd3hKSDJESzZZ?=
 =?utf-8?B?MVZxcHhjY3RyMHJDWkNxSUFIVU9nemVQYTZTRzdlem5Mak9xdGIwYyt5RTBL?=
 =?utf-8?B?dTEwdXVhaWxUT2hrTUpheisySmVFN2ZHWkl3dHZJcW1STThxemVmMmFxR2M1?=
 =?utf-8?B?VERtNEFhYXVqMDBHajMrMUY0ZjFNZUdpenZQQ3RCVVAyb0UyNVdYVWE2RXpi?=
 =?utf-8?B?VVpTRkVNTkUzNVpJTGNidTBNazdEMnYreCsrRzRDdk94b2xKaStMUk1QOE9H?=
 =?utf-8?B?TXlVRGtnMkpRN0xEdDh6Y0RRb3Y4QzJXL20rMmoyanlOSC9XR1RtN0hHa3h5?=
 =?utf-8?B?aEFiTmk3RkxhNzBoUHl5YXlTaUtWR2ZsaVJEdzZlTkl6ZTQwelgwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3010fcc-cb63-4e1e-a942-08de8b9c7231
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 01:01:58.2247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrWTpokpNoDZBxcqFj2dFsAEYn24MoH73qxNxcqHlvfUKFKFpz4dQ9lhdli+L+ATm74MthzeLawvp1JeTNG8Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479
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

On 3/22/26 22:54, Srinivasan Shanmugam wrote:
> clk_mgr_construct() initializes display clock and memory bandwidth
> settings during driver bring-up.
> 
> As part of this, the driver selects a watermark table based on the
> memory type (DDR4, LPDDR4, LPDDR5) from ctx->dc_bios->integrated_info.
> 
> The display pipeline continuously reads pixel data from memory,
> processes it (such as scaling, color conversion, and blending), and
> sends it to the screen. To keep this pipeline running smoothly, the
> driver must ensure there is enough memory bandwidth and that clocks are
> increased when needed.
> 
> Watermark tables define when the GPU should increase clocks to ensure
> there is enough bandwidth to feed pixel data without underflow.
> 
> However, ctx->dc_bios->integrated_info is dereferenced without checking
> for NULL in multiple clk_mgr_construct() implementations. On some
> platforms, BIOS may not provide this information, and accessing it
> directly can cause a NULL pointer dereference during initialization.
> 
> Fix this by adding a NULL check before accessing integrated_info.
> 
> If integrated_info is not available, the driver safely falls back to
> default watermark tables.
> 
> Fixes:
> ../dcn21/rn_clk_mgr.c:775 rn_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 743)
> ../dcn301/vg_clk_mgr.c:750 vg_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 736)
> ../dcn31/dcn31_clk_mgr.c:789 dcn31_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 728)
> ../dcn314/dcn314_clk_mgr.c:906 dcn314_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 845)
> ../dcn315/dcn315_clk_mgr.c:716 dcn315_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 655)
> ../dcn316/dcn316_clk_mgr.c:660 dcn316_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 639)
> ../dcn35/dcn35_clk_mgr.c:1540 dcn35_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 1467)
> 
> Fixes: 25879d7b4986 ("drm/amd/display: Clean FPGA code in dc")
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I972e6837222f0181bc2c44ca1e31abaf8c64a088
> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 3 ++-
>   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 7 ++++---
>   .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   | 7 ++++---
>   .../gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 3 ++-
>   .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 7 ++++---
>   .../gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c | 7 ++++---
>   .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 7 ++++---
>   7 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> index e18097f82091..09e83097a623 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> @@ -740,7 +740,8 @@ void rn_clk_mgr_construct(
>   	if (clk_mgr->base.dentist_vco_freq_khz == 0)
>   		clk_mgr->base.dentist_vco_freq_khz = 3600000;
>   
> -	if (ctx->dc_bios->integrated_info->memory_type == LpDdr4MemType) {
> +	if (ctx->dc_bios->integrated_info &&
> +	    ctx->dc_bios->integrated_info->memory_type == LpDdr4MemType) {
>   		if (clk_mgr->periodic_retraining_disabled) {
>   			rn_bw_params.wm_table = lpddr4_wm_table_with_disabled_ppt;
>   		} else {
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> index 7aee02d56292..57ba7bc4d16e 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> @@ -733,11 +733,12 @@ void vg_clk_mgr_construct(
>   	if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
>   		clk_mgr->base.base.dentist_vco_freq_khz = 3600000;
>   
> -	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
> +	if (ctx->dc_bios->integrated_info &&
> +	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
>   		vg_bw_params.wm_table = lpddr5_wm_table;
> -	} else {
> +	else
>   		vg_bw_params.wm_table = ddr4_wm_table;
> -	}
> +
>   	/* Saved clocks configured at boot for debug purposes */
>   	vg_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> index 051052bd10c9..44bf48f96183 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> @@ -725,11 +725,12 @@ void dcn31_clk_mgr_construct(
>   	/* TODO: Check we get what we expect during bringup */
>   	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
>   
> -	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
> +	if (ctx->dc_bios->integrated_info &&
> +	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
>   		dcn31_bw_params.wm_table = lpddr5_wm_table;
> -	} else {
> +	else
>   		dcn31_bw_params.wm_table = ddr5_wm_table;
> -	}
> +
>   	/* Saved clocks configured at boot for debug purposes */
>   	dcn31_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
>   				 &clk_mgr->base.base, &log_info);
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
> index 0cb37827a62b..c69ec7a0e0ae 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
> @@ -842,7 +842,8 @@ void dcn314_clk_mgr_construct(
>   	/* TODO: Check we get what we expect during bringup */
>   	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
>   
> -	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
> +	if (ctx->dc_bios->integrated_info &&
> +	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
>   		dcn314_bw_params.wm_table = lpddr5_wm_table;
>   	else
>   		dcn314_bw_params.wm_table = ddr5_wm_table;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> index c49268db85f6..8d6949ad700d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> @@ -652,11 +652,12 @@ void dcn315_clk_mgr_construct(
>   	if (clk_mgr->base.smu_ver > 0)
>   		clk_mgr->base.smu_present = true;
>   
> -	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
> +	if (ctx->dc_bios->integrated_info &&
> +	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
>   		dcn315_bw_params.wm_table = lpddr5_wm_table;
> -	} else {
> +	else
>   		dcn315_bw_params.wm_table = ddr5_wm_table;
> -	}
> +
>   	/* Saved clocks configured at boot for debug purposes */
>   	dcn315_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
>   				  &clk_mgr->base.base, &log_info);
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> index 1769b1f26e75..b858e21ca070 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> @@ -636,11 +636,12 @@ void dcn316_clk_mgr_construct(
>   		clk_mgr->base.base.dentist_vco_freq_khz = 2500000; /* 2400MHz */
>   
>   
> -	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
> +	if (ctx->dc_bios->integrated_info &&
> +	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
>   		dcn316_bw_params.wm_table = lpddr5_wm_table;
> -	} else {
> +	else
>   		dcn316_bw_params.wm_table = ddr4_wm_table;
> -	}
> +
>   	/* Saved clocks configured at boot for debug purposes */
>   	dcn316_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
>   				  &clk_mgr->base.base, &log_info);
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> index 6fc524752613..2798088842f4 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> @@ -1464,11 +1464,12 @@ void dcn35_clk_mgr_construct(
>   	/* TODO: Check we get what we expect during bringup */
>   	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
>   
> -	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
> +	if (ctx->dc_bios->integrated_info &&
> +	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
>   		dcn35_bw_params.wm_table = lpddr5_wm_table;
> -	} else {
> +	else
>   		dcn35_bw_params.wm_table = ddr5_wm_table;
> -	}
> +
>   	/* Saved clocks configured at boot for debug purposes */
>   	dcn35_save_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
>   

