Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE08F01812
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 09:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6050010ECB8;
	Fri,  6 Mar 2026 09:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lma3smPF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013065.outbound.protection.outlook.com
 [40.107.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D968210ECB8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 09:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gs1KrFDBmzrkHI4ZLI0s4QjDYNpf7I8qPc74mBGdIpRq1kAR1yva8NPpqjY3hc4JN74jwPpfO63vS6GcNlxd1B1TpC+lVIpVEfzzkO+fzFqlHFkYiUtP5Eor5vMZfWvSqZibGuwIRZKRQFnuZE7VYZPwhZONiZTMDplW6KWHxiMjAFODffBtHY8FVtHvm6muAvrql+DHmSFF46njGiju0RfIsMHbrqUaydiSCsBLgZi3EcE7U2G5m7ABTuEVL2hC9cJMjsDcDGNj8l7dkyEBuEwn2cLbhFu6fFqEv3LFEBk32kroF5flHiN0QUJjCDH0yfZAflt6gci6nxfQtEFWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCgPv2wSZjis1f9qhCJ61mwYlAZRUeGZkazq+pRYXpg=;
 b=IZRaTmsKHV7Q9yLGCihvnLX4dqIvVx+Yi2Gdup3EGmdCOR82m/dVTo4ngke2Gd2TuqvfBYqhD6znp0xSzbJNwucZuPStjakyHgZ11KgAmYJS9B4T1o9jNI2NFjM5H8P3m+4FeJca3I6H3sjpc2stQ1dLQkgUHKZeE7nxMY2qLyDIqFZk7zCOPFg3K2PWkEkRMAr+G06wq0n2vuCUXwjk0KuUC9WcaEVIG2ESWabu1FPW74hhDeyXrk/ZRX8w2Qqep6bhWAmk+OpDspYMylgSA5Fh1yqMSF8XJv7i05FzU8TuuUnnf0L/dmGrPC5WvUc87V+a99n6j97Gbz2WnB7XgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCgPv2wSZjis1f9qhCJ61mwYlAZRUeGZkazq+pRYXpg=;
 b=Lma3smPFi/P6rui6E5hzVmtKjoMIgTdoqMmHlPBPPexe1KPJ+J7Do20rPFHuF+bEkGQimGoWOzoTAJBz3mYEuI+76/gfa6oPoz/Z3tLr6Xog+w91yJOGzvo3lRvy1ijxR9cFsuWXkpLTtxFyJbvxZPjLmFTGz+yFDAK2Cz1Lz8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:29:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 09:29:16 +0000
Message-ID: <64e8b9ad-5fc4-4e3d-8b70-8f7664e9a1c1@amd.com>
Date: Fri, 6 Mar 2026 10:29:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdgpu: fix warning for potentially insecure
 string
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306080855.1886520-1-sunil.khatri@amd.com>
 <20260306080855.1886520-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260306080855.1886520-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: f5cd545a-8f22-4827-7349-08de7b62d5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 3AIMZYq+1Xm83X5Du4ERKEJz6/LdyqxrJI9cc0d0F3iNUcEZd/LoA0vQfXvDhCAVpjvqLDlAyzrgKVhm3qwOSe1OF7fep7aTpa0uBE9M2UNEzkusv/+ms4F8d73HlB0mFEvMCIwTI4+DN32qQ5hjhIgMIQ9qaBpDZBskZBH/vwsXWIs/oZeP0xoqdwNNk4RSmKRhFBGIM+YuDmafm8qvItlwFMOMplyb0N2sxNv6kAY+GP+6+sE2ZVJ2PGUuhNNr3wuUiB8W0xipt3DcjfsqDwMoopRKR2d4cGBirwCJKZtSP7nJuhEMAKjhvIGzgkv/xephIj6A1p8mV8ZM71QHsxxByoqMNuI0jROgRmuuERsl9ULudU6tiaBwzjpPGwju/roezHhry3+Rg6Y+ElmgSKWBW6kCmNwwGvxmjSR69RCBE/Ze9naPcXtV+XtULL4xdSuXrlvoHjgh6bPyt3xC5s16grckW2NJhmLAivc0YtYSi69z7s+cDvMP0SuWVxwbW2IsFmVYozYEkb8DkJZnmwT19zkFxTVn/9MrPqpPy70OLAc0JzPV/E2wPwiryOZFyA2YJzRrv4lz/Gbt2tBzzB8grt8jCf7f904zQMID+hXKrtIGPbyftFhv+qCtSQKh8ago19VSqxr/RuNxMOU0oqc5wxQCYQ23zmUkAOMNju0l4gBQ9U93g9UFLXwXdONYnncGDVhdAiV6SfuGJkFmw75K6Rgue4tUMSGtkI+EM04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2pEQjhDeThuSXpRTHZwVW1rR2c5S1B0b25naWpSOWJwUVlKR3F3c3Z0c3dx?=
 =?utf-8?B?U3pZV3FhVHQ5V1BEU1Y3akg5N1g4Tks0djNSUDdyaEtJb0FrRVBtTmI3TlRv?=
 =?utf-8?B?QnlaaDVKR05ScHJ2WVhheUFDeVl4aFB1RW1zdjU1K1BJNHRzeXNZcWQxNEFO?=
 =?utf-8?B?WDc4OUR4QmdXTU5hYnVBeEV4RCtDR2VwbWJaNzd3cXRhOEZ2SzFFMzRUWUJl?=
 =?utf-8?B?UHN1UDF6aEJvOHhjZ3lqc3JOYWFvTzF3a3krZkZ1U3U3bW5XVG9aSm41UXUr?=
 =?utf-8?B?dlp2c2lyRXdsbkVmVXo3QTN3N2YrT2JNb3Y5T25OWXZ0bDBKdW9Mdksrd0Z5?=
 =?utf-8?B?RXdxRkthbzNkSWxaT0NHQVhjbERqMXNSdGV1WE9WUmRwYk1Oalk2QlRoRWRz?=
 =?utf-8?B?cnpoSExJZTdrOC94eWsvclNwY0dCQmwzU0pvYnVFVE04S3FJaTh6WnB2V1Nk?=
 =?utf-8?B?aFFTWE9XL2pTT1Q2QnozTVhLYjRHNlFGOGJsL2tvS2QxUmF3aHJheUZyMzkw?=
 =?utf-8?B?VGx1L29UQytJcDlvVTBmbkI3VEZVczI2QjJLdldOR3ZJd1dmTlprdnZxUTNC?=
 =?utf-8?B?dFY2TTNrT2d1VnUxODZXWWZ6c1lOYkFYV1dNaVRPaFdUZGw1WGRxYlllcFdK?=
 =?utf-8?B?aVovR2Y4Y0dvcmpZV2RwaEtScXpUaXVtT2pkWTRPOGJhbHlURXo0cXRHVmMy?=
 =?utf-8?B?ZmhscjFjbC95dVBUQjNaZU1Ec0tQVGcyWERQV0VZd3ViTTdnbW93R1ZYSG9k?=
 =?utf-8?B?NW1lSTBYaXRJUGJZWGNpb3VqWFl1QW0zc1h4WWc0NzAvVkVhN1l0UlhUNGJI?=
 =?utf-8?B?SUUzMU1GWjFrV0JBdk9hU3hKYTQyVGZNdzZHS1pLaFJXNjQ3djgxTzNMM3kw?=
 =?utf-8?B?UjlMc0NLeVc3T25PeXh6anFlTkJmb2QwYWRyRGFvVWt6NzBtS202UExKMSs4?=
 =?utf-8?B?cmVmOXpvaU03bjExcjk3UzVHV3UxbzFwblJrQVlxdUE2amlld3hCcW12dWM4?=
 =?utf-8?B?bU14Uk85Z1Z0YkRpbG9OOHY2VkZjdEVuNlVZZU5XcXYwdmEzTDR6MWYrSjAv?=
 =?utf-8?B?ZzIyVUpxTXJJUXpGQkwvTlptM2NacEtIbGtEUTdNQnVkTWZNL2N1Rm1DNitX?=
 =?utf-8?B?eUkwQU0vdE9vTTJXRytJM1luNHR1bmRYMi9NeVpabWNpeGlOZjFNWjhsT1Fr?=
 =?utf-8?B?b3Bpa1JtcGhNaURiT1JKNlF1N2VsZDFodXFyMmt6am9vT1pCN1AxTU9aKzh2?=
 =?utf-8?B?TWhTTi9IeHRHUWRSUDlyUjQ0aERoMXJqMzhOQk9vZnRmT1dNK0pwM3RoN0tY?=
 =?utf-8?B?emFKUjlDMm5NcGxyViszYW9wQ3AvbEJ6MmF0L1U1VytDNHppODE3ZW0zY2RS?=
 =?utf-8?B?NDl2K0lsTWFGT1JmQlE5N0NqRVY4ZVg1K2Jmc1FDT2pQc0o4YVFCZUEvNkgv?=
 =?utf-8?B?TzRHMEpRU1ExQVhjVjV5QWpYWFFGb1kyOFN0b1JUZTFwQk5tR0V4ZHJrS2tl?=
 =?utf-8?B?N0ZLbVA3d1FiTXVhV3ZVaFVWSWN0YmpsRS95dk0vcURXbFpCNittN3NOV1Yx?=
 =?utf-8?B?OFdpNml0c0ZiTWp1WVBoUGREY2ZXdlVHVjAzZk9RajZpYklyNGpZRnFWdlZD?=
 =?utf-8?B?aUlQeXAxb1AyYW40M25xc0I0eGZRbTd4VFMwcTE2ZmhYeTJ2RFVPbjFzRWds?=
 =?utf-8?B?UmsyMGJmelRNSEkvZ01MamdZNnU2M202eGJERncyeGJ0QXB4ekVxYXluSXlz?=
 =?utf-8?B?OXM3bWFLV3d3RzZqa1JFY2kwZFRucjJ3TWk1dkljc0FQWGFaZm9NbUplRTdN?=
 =?utf-8?B?RWhPdmJmSlJCQTl6bDIrRHVqVWNSWmtWU1lTZEd0M0J2ZjE4MFF6dnZrYmcr?=
 =?utf-8?B?QnlFc0lRaUNDSTBaS0pSRlV6L0U3S0lkejBPUXhGUnA5THBkTDBab3Y1NWlD?=
 =?utf-8?B?THErcXE2QUxXZEtibVk0TnVrM0hJUFN1YWc0MGpLTjgwdXovSUMva3pRYzVy?=
 =?utf-8?B?UWtURjQzQkpXZ0RaT1VyMGl5Qll0RHdpRmFBZ255WElMZTRxSlYvQUQ2VVp0?=
 =?utf-8?B?VVEyRUZDb1NOY1hTOHhrc0pkbGFTckQwSnhBcHRRek9KdkZWS2lTS2E5QnV0?=
 =?utf-8?B?cmovUWhjTGgrVWo3T2JLL3NsMnV4N0ZoVk1WV2gyQWMvclZ5c1BGdGZvTmZq?=
 =?utf-8?B?eUptRU04bVFxOFJobmdZdWFQL0ZPZU9GRnZ1RkVCa01UaS8ySjVLb2FsajZo?=
 =?utf-8?B?M0xJd08vc2RxNmlnL0w0RkRmS0F5L0dEZm5FRTkrQkM2RVJYcUdrVlVyNElk?=
 =?utf-8?Q?Vj9IDF8zwVxzPyLTDW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cd545a-8f22-4827-7349-08de7b62d5df
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:29:15.9594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Pm9YgP8Xya+Jfl0+yvfZdFAd6Mi9sZCNfxajOODh7sn33OMogPkDTL9dE3vVKPU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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



On 3/6/26 09:08, Sunil Khatri wrote:
> linux/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2358:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
>                         sprintf(ring->name, amdgpu_sw_ring_name(i));
>                                             ^~~~~~~~~~~~~~~~~~~~~~
> linux/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2358:24: note: treat the string as an argument to avoid this
>                         sprintf(ring->name, amdgpu_sw_ring_name(i));
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7e9d753f4a80..280fe7627c98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2355,7 +2355,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
>  			ring = &adev->gfx.sw_gfx_ring[i];
>  			ring->ring_obj = NULL;
> -			sprintf(ring->name, amdgpu_sw_ring_name(i));
> +			sprintf(ring->name, "%s", amdgpu_sw_ring_name(i));

You could use strcpy here instead of sprintf.

Christian.

>  			ring->use_doorbell = true;
>  			ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
>  			ring->is_sw_ring = true;

