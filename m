Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E562D11700
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 16:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB3189F4F;
	Tue,  2 Dec 2025 16:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qfbXm69k";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB5110E689
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 16:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhZc2yiIMLW3kKgATeNM0nrSMs/+c9Rpj3BzG3bBcb006BaDFltcoVtP6n4JguU73Q/b2vFbr0+MIzzB90XCbWzx4MIGIxiDdNYQ/Ixp0iQiCFPov6RZgNX5iuR1wMzIKQyWQS6h32MhjvqUr2CEYnJ4zYgi0PZU7+a8n6ivSnYV3WeDoNqa/Er7anNdfuuVSfrEWGhfMUhY7g/NJzKN/EXENssy6l1JA6nZKeRbSg9zjXqER9hRyCMeuFDICuUG89FCz2OUSZBjChsLuCGzZVGQ1xQArTWqOUzXxsJHcPgSzwm3hhv1g4p5DStrBeHjzInJtytcQAo2tsFCLIXXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGMnUZ6nJUvRaJvOR9s/OaqT+aqwuSOf6VasEt4kf2k=;
 b=FXABLS0p5R2iageKqgRwXcvglBMz5U2GGutxWeawr5WPOYmg1VFerw9gaJe3PvB5Bx9N8YJXdJa1KTfIMDXp0MCDT8Rq0DKGVs3O1RqucCqaaKd/cZ7DBb4nweqN/j4qu0fhrxzqqPDUp9yGzSF93j07dbOCxXD6vhxhLRzTVz1OSU5ti5HPGsQ3C6Cek6LiQEeKnabgxrmWBvDgEqBeztY5EikAhweQw4SAUh2lhojIl1Qg6FqJJm6VwkvtmxREcKSiOnZTBt+7oaQJeKRCWKnWyBVFPj03bVP/TGlulH/DKqT5mwE5IwojibTd7+KJsczwkNrjBHpI6STSQuTa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGMnUZ6nJUvRaJvOR9s/OaqT+aqwuSOf6VasEt4kf2k=;
 b=qfbXm69k6mvxGAHbLZ0eCMRnvPEjvBMYUD63OJZoRhBw2281GjcnN3ujZVG6DcF/+HghYhNCvL3cAlWxaQa6sftKPk2a9YcQdUqUB7EHwhfnVgQjJ+rnTKf9i0w4LIp6vcJkFLN0ud6sDJ0Ef3+z0I19NOD57uFHbL3PEyNh9Kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:29:31 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:29:30 +0000
Message-ID: <38b6e3e5-fcee-48c4-bcac-5aee8feb289f@amd.com>
Date: Tue, 2 Dec 2025 09:29:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amd/display: Refactor dml_core_mode_support to
 reduce stack frame
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Austin Zheng <austin.zheng@amd.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
 <20251202102437.3126523-5-chen-yu.chen@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20251202102437.3126523-5-chen-yu.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 649109de-0e32-4e89-359a-08de31bff7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MytJbmV6bHNtd0syRGtLdDFoblpqVEVlV2ZPa1VHVVl2UnZuc2NWZmoyb0FY?=
 =?utf-8?B?T2VhbUpVL3R6YmxMZ3VnWVdwS2JTUEJGZEVUNUxlQVNwcy8yT3dXUDB1NXRu?=
 =?utf-8?B?aHQwdmlHYkZpYkFDVWRQU0tOVEZuVTlwRHhSU0F0cUlzSTBsWDR6MTBVTWhr?=
 =?utf-8?B?eHNRY0J2Z2J5OVZUSjZxOHVxd2d5TlltOElKUUxaVlNUK3ROQVFHTVE1dTZZ?=
 =?utf-8?B?WmNFVE9teWlhYkwxNXFVY3BPcFFSUFduem91VG5lTVJ4cWxESDh1c3JGeEZ2?=
 =?utf-8?B?NGFjeHR3dENNMU1Ed2JDVjd2WXpNWW1nTWdYVk82MG5KQmlONlc0eWxONDh5?=
 =?utf-8?B?L2JEQzRvTEFmK2FmaCsrTVo3SEh3amhJMU5uYTQ5VjRQRmJmZ29NUWxzTVdv?=
 =?utf-8?B?c0d3TWJwZUFsUUdlS3FycFgwdGFpNnowclJMRzhUcFlwUk9HRitOYW9FMmVY?=
 =?utf-8?B?czh5YnFCS2RZcWpoakNIY0htU21JS0NFMWxPY2krVi9wT2dYNzhudmxzU3BM?=
 =?utf-8?B?c1R3b2dHYWFiYkFzRWdyN1oxVE5CZytrWkRrME5nSFBjT3A5cWZCdGk5OHFO?=
 =?utf-8?B?MExpK1N1Z3htKzlTbi8vSEFhdFlIVkc1SE5iOENYODd0OHNKYjBaUEFjV0s5?=
 =?utf-8?B?cEZ3YTh3cjB2QlBNRWxNZWo0WjRnNUxVb2JjZUJvWmNzVGh6ejFUSVBhYTB1?=
 =?utf-8?B?VmhxOGsyejV0WW5QUnBzVDZhVW9nL2JYdGRtVGxGakUzY1BIendwbjA0Qk80?=
 =?utf-8?B?RDJuaHJjL1VMaVd4YU5FZGRSR1pBZEV2ek9SZVl5Z2IyRWZkRFcyQTBteG9X?=
 =?utf-8?B?NlBYM2hQZXFXU3IrWkMrOFFRTDhqMDVSbFZuc0p3VWZUUmpmQ3RwNENnM3Zq?=
 =?utf-8?B?SDlzeWpaYWgxbnMxdk5EaHg3czNEZ1ZHejE2YUE0R0ZyUWNuUzJJVFhoTUJv?=
 =?utf-8?B?WndYbFhQUTV4N1dUcm1LVzV1VXZFWHllQ2ZnTEtiRHFkYzlDTzNLNzdqZ1hK?=
 =?utf-8?B?VDFJdmRRNXprVnN0d1hvQ00za0NhZUpzOVE5WlEzK3Z2Y0F5S2NXQjZmZU14?=
 =?utf-8?B?TjJlMTZyTHNwTGZEcllJd0V3VFBOdzhsL3ExVjRBNW9HNmtmeWViY3JxdzMv?=
 =?utf-8?B?ekU0RzV6UE4xSEtKN0NZbUxLZ3RwTmsveDk4ZkZmUGxYM1M5R09ra01ERCti?=
 =?utf-8?B?dlM5M0RqY3FHVXZxSjQwTXBnVHJlNzg1L0ZabGJIeXR3eGtJM043MU1Yekdn?=
 =?utf-8?B?emRoaW5WSkFhQ1YyTUxoR3ZqWmtQVlVjd1A3dmhMNVY3MC93Z2dtNjhvZ0FC?=
 =?utf-8?B?bHlFcGZ2QmFnaG1tTDRQTDZXNXovdm5vVXc5ZE9xRlMwNjBlQUZYY1A5TnZL?=
 =?utf-8?B?WksvQVptV09yZzhtNXBnTzArVXZodWxqekQ1clppbVdmNjZmY3djOUU2WUsy?=
 =?utf-8?B?ZkFDM1BoSmc4eVUxalJCTE5tZnF0TlpOMVE3RUJoRHJ3MnRpanVSSzRUV2Nx?=
 =?utf-8?B?elB3Y29RWTgyNXRDZWJvU2FGeHV6VVB0VXFDd2lYVnFWQVNOWUQ0Ylh6dnMy?=
 =?utf-8?B?WVlINm5zYXNXemFNdUJRRjVaV1FLeCttOEhNTngzalBqTDBJem40elJLRXRu?=
 =?utf-8?B?K2g0UC9mN0dmVFJBTFJwOWYwTWJLUEdsN0w4K05wRmNYUjV3YW1Jc3AxNnNv?=
 =?utf-8?B?NXdJdWg0a2x3YnlRcUlnUzdiNWlLK1owdUhTdXR3MUhreW9iYUJGMWZ5R21U?=
 =?utf-8?B?MDdMY25hVTRQQjdla3o5OGxJQXVjbmJ2bk85U1llM0I4R2VmbXBNbXVaQlNs?=
 =?utf-8?B?b3ZOSzFENHJGcWFvdDI3OUZBbVRnc0hpV2FKQ1QwaWVyWVdiYUgzeldLMEhl?=
 =?utf-8?B?YWtSQjhKN3VKSHIwRmF1R3liQkxjWHE0VloyRXp0eTE3U3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHFvcEhCcHZ3dnZITmRRbHhtWThjYWZPelE5VU5IL2ZmYUErQlVWTVhTa3d3?=
 =?utf-8?B?cFlxVGh3MDNITktHckQ2RVJ4bng5aDBWM0hSb2xvQ1R2ZDRrQkxubUtVNGJL?=
 =?utf-8?B?SmduaFJtekdyVjN1MWFkZGZQbGNMYWpncUlXN0VMakZNcUpKOENTZytRVXV5?=
 =?utf-8?B?Q1l3QVpKcldPOTJ5UXFZQzN6ZzVkQlZWZXFTN1p2YTczdVdNVXp3Uk4vVHpZ?=
 =?utf-8?B?T1lpWjl2YUJYUXdrTE1tcVMzd3l2WDF6bVFOZTVpazNtUVpMMHhRVTYxRHQx?=
 =?utf-8?B?YVcrNHhOVGdVdG1jcVNUclFhbm1EVzduRndqRlYvU2lKUGVLOTZqOGhPbXYr?=
 =?utf-8?B?VGx4Vnh5YVVRR01XZ3BjdUhnaU1RZGE0UHdNcGdkQ2hQbkRlUERlQytCRzV0?=
 =?utf-8?B?NGFHMUVpeUFvWmJacjdESDdHa2F5S2l1MzA4WUY3S0xkV2grcjNpMWRWbzBa?=
 =?utf-8?B?NDM3cFAyWlcxWmdsNGJsSWpJcXFUTTdXWG53b0hGR2YrUXpiTFNKcU1TSFdi?=
 =?utf-8?B?d1lxT1pJSVZNN3I0WHJPYyt4Wlk5U1N2SEtrY1VkeG5aayt5WjFlNk9uci9u?=
 =?utf-8?B?RzJ4N05ETW9WaGVxbG9CZ3V5c09jMWVRTDBxTG9VeFViSHA1UGxNZ29ZNzBQ?=
 =?utf-8?B?ZTdNS0pMRmp4aWd4NjR2M0MyK050em9aa2tsd3BzUEdQTlRiSk5pWkZLaWFp?=
 =?utf-8?B?bVVuNTBDQVQvbmcxR241OGpNZnJRUTFNMW93WjNXRFJHait2MzZJdmtFZmNM?=
 =?utf-8?B?Mi8zUVlWOFhkbThjRDhuZ0lWM1huR3k2bFZubHFiVktNbHc2WFJJN2RiWVVN?=
 =?utf-8?B?OFYxcmR5ajh0OEFKNVlxQ0NTUzdJS1Q5TWlqTWlKRzdzYktDV1NObWVTRWFQ?=
 =?utf-8?B?Mml4VVZodFlLcVdCRHhVUnlPbUFsWGl6Tmw3NktPUTdMTG01Y0U0QnVjdkpM?=
 =?utf-8?B?aFNkTkdSb1EyWi9FTG43R3VWODdIMzR6ZFJvMGgvYUZadjgrazVsWUd6VW1I?=
 =?utf-8?B?K2JUaWxtbW8wcU1WL2Y4cmhiN2tRRHp2a0V0Slh2czNyWGhuMGw5TUhoNDVH?=
 =?utf-8?B?RDBOeENEYkxhMU9nVlhneWZYQjVUb0JrVUwrNEs4djJyN0IxRDMxbjVsK3NK?=
 =?utf-8?B?V0N6TGtjY21Tb2xMVlFSbGZpeXViTWkzbXdmMjZkUVRNR0xxekl2VmNpdjdL?=
 =?utf-8?B?ZkV1cWp1bmN1VUFXbkVMbXBKdUIrU0FPbjkrTTlJQVNVODQ0aG5vR25mc2JV?=
 =?utf-8?B?Ym1lcWdCNjJYZU5xRXVnNW5adXVxb3M4RkVKMFZVZkFRUEZmd2pOU2tKRTBO?=
 =?utf-8?B?NFk2UXNEdmN1R0dZN1dlekdPd05vRnUvL0NLa0E1OGJzUUFET0FHWCsvYnd2?=
 =?utf-8?B?U2pWV0dEYm9paG9WcENtU1lIWE8wZ1RZeEUyVGhvMjJHeGpHUTRTSEtzNExV?=
 =?utf-8?B?ZXg1Um14V040NU5rMnA4ZlFtSmxZN1U3ZjZCQzEzOU0xLzVVbFNaOW5CMGNG?=
 =?utf-8?B?MzE5ME95M2dmNWc0NXNxbzhOV2ZyYTJ5bkJmOGZKNWx2bnJKS3NNUzFuVk8z?=
 =?utf-8?B?WmdhR0EwVmVhKy9rVHpESkFEQUhESkI4S2syWXB0U1hlaUE2T1VNWXI2S0VI?=
 =?utf-8?B?cjRBbTJ3VnhObWI2VG5zeGRqelpHWmd2OGUva092MEU5azRKemVuQlkrWU41?=
 =?utf-8?B?eTBYdnZYb1ZudVJpN1BLUERRaG5TL1NGdXZKV2dZaU1ESmI5dHd0ZUhpMlZL?=
 =?utf-8?B?ZlRlUk1TekNKZGo1WTR2Y3ROUnFieGVrd3U2a0xPYnlYblBqcTU5MmUwdmpn?=
 =?utf-8?B?cUducjd1ZTlKeXAzL3RmeW1DODJCTGpyenJObWxqWC9lYysweUxSZkQ2d29L?=
 =?utf-8?B?eUZzclJ0WVBGUTFKaDhuUXB6TWNEK2Rxbmh5S25TdTFMejRNUFFYSjhteDdy?=
 =?utf-8?B?Ym5WMUhHSkcyNFpQZklWSFpRR2MvUzRzZis0SlR5ajNYdlh2Q3FFZG9GYUJv?=
 =?utf-8?B?Y09WdXlLVDBCcFZzUUhiZEJSaWR0aHlkYk5kVFRIY0ZuUDFKcXFDaVhSNEFi?=
 =?utf-8?B?L0l3R1NjTVlZMndtbnJ0VGdlM29CMkQ1VWo3Y2svSXRJNDc5VUhmNVV5ai9w?=
 =?utf-8?Q?zXyIBHUnhMYgGX7lwhwEQFaty?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649109de-0e32-4e89-359a-08de31bff7f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:29:30.5330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvebeiI5R252MFkXryAfuFGJ8MyI9I7FXeKY1A2zzzTCEwqFYZPZMhRLfKmOpISt+MXZaUGE94BDU5eko8V4zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
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



On 12/2/25 03:21, Chenyu Chen wrote:
> From: Alex Hung <alex.hung@amd.com>
> 
> [WHAT]
> When compiling Linux kernel with clang, the following warning / error
> messages pops up:
> 
> drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dml2_0/display_mode_core.c:6853:12:
> error: stack frame size (2120) exceeds limit (2056) in
> 'dml_core_mode_support' [-Werror,-Wframe-larger-than]
>   6853 | dml_bool_t dml_core_mode_support(struct display_mode_lib_st
> *mode_lib)
> 
> [HOW]
> Refactoring CalculateVMRowAndSwath_params assignments to a new function
> helps reduce the stack frame size in dml_core_mode_support.
> 
Hi Chenyu,

A bug seems to be related. Can you add a buglink? Thanks.

Buglink: https://gitlab.freedesktop.org/drm/amd/-/issues/4733

> Reviewed-by: Austin Zheng <austin.zheng@amd.com>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
> ---
>   .../amd/display/dc/dml2_0/display_mode_core.c | 134 ++++++++++--------
>   1 file changed, 71 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
> index c468f492b876..09303c282495 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
> @@ -6711,6 +6711,76 @@ static noinline_for_stack void dml_prefetch_check(struct display_mode_lib_st *mo
>   	} // for j
>   }
>   
> +static noinline_for_stack void set_vm_row_and_swath_parameters(struct display_mode_lib_st *mode_lib)
> +{
> +	struct CalculateVMRowAndSwath_params_st *CalculateVMRowAndSwath_params = &mode_lib->scratch.CalculateVMRowAndSwath_params;
> +	struct dml_core_mode_support_locals_st *s = &mode_lib->scratch.dml_core_mode_support_locals;
> +
> +	CalculateVMRowAndSwath_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
> +	CalculateVMRowAndSwath_params->myPipe = s->SurfParameters;
> +	CalculateVMRowAndSwath_params->SurfaceSizeInMALL = mode_lib->ms.SurfaceSizeInMALL;
> +	CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsLuma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_luma;
> +	CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsChroma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_chroma;
> +	CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = mode_lib->ms.ip.dcc_meta_buffer_size_bytes;
> +	CalculateVMRowAndSwath_params->UseMALLForStaticScreen = mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen;
> +	CalculateVMRowAndSwath_params->UseMALLForPStateChange = mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
> +	CalculateVMRowAndSwath_params->MALLAllocatedForDCN = mode_lib->ms.soc.mall_allocated_for_dcn_mbytes;
> +	CalculateVMRowAndSwath_params->SwathWidthY = mode_lib->ms.SwathWidthYThisState;
> +	CalculateVMRowAndSwath_params->SwathWidthC = mode_lib->ms.SwathWidthCThisState;
> +	CalculateVMRowAndSwath_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
> +	CalculateVMRowAndSwath_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
> +	CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
> +	CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
> +	CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
> +	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
> +	CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
> +	CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
> +	CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = mode_lib->ms.PTEBufferSizeNotExceededPerState;
> +	CalculateVMRowAndSwath_params->DCCMetaBufferSizeNotExceeded = mode_lib->ms.DCCMetaBufferSizeNotExceededPerState;
> +	CalculateVMRowAndSwath_params->dpte_row_width_luma_ub = s->dummy_integer_array[0];
> +	CalculateVMRowAndSwath_params->dpte_row_width_chroma_ub = s->dummy_integer_array[1];
> +	CalculateVMRowAndSwath_params->dpte_row_height_luma = mode_lib->ms.dpte_row_height;
> +	CalculateVMRowAndSwath_params->dpte_row_height_chroma = mode_lib->ms.dpte_row_height_chroma;
> +	CalculateVMRowAndSwath_params->dpte_row_height_linear_luma = s->dummy_integer_array[2]; // VBA_DELTA
> +	CalculateVMRowAndSwath_params->dpte_row_height_linear_chroma = s->dummy_integer_array[3]; // VBA_DELTA
> +	CalculateVMRowAndSwath_params->meta_req_width = s->dummy_integer_array[4];
> +	CalculateVMRowAndSwath_params->meta_req_width_chroma = s->dummy_integer_array[5];
> +	CalculateVMRowAndSwath_params->meta_req_height = s->dummy_integer_array[6];
> +	CalculateVMRowAndSwath_params->meta_req_height_chroma = s->dummy_integer_array[7];
> +	CalculateVMRowAndSwath_params->meta_row_width = s->dummy_integer_array[8];
> +	CalculateVMRowAndSwath_params->meta_row_width_chroma = s->dummy_integer_array[9];
> +	CalculateVMRowAndSwath_params->meta_row_height = mode_lib->ms.meta_row_height;
> +	CalculateVMRowAndSwath_params->meta_row_height_chroma = mode_lib->ms.meta_row_height_chroma;
> +	CalculateVMRowAndSwath_params->vm_group_bytes = s->dummy_integer_array[10];
> +	CalculateVMRowAndSwath_params->dpte_group_bytes = mode_lib->ms.dpte_group_bytes;
> +	CalculateVMRowAndSwath_params->PixelPTEReqWidthY = s->dummy_integer_array[11];
> +	CalculateVMRowAndSwath_params->PixelPTEReqHeightY = s->dummy_integer_array[12];
> +	CalculateVMRowAndSwath_params->PTERequestSizeY = s->dummy_integer_array[13];
> +	CalculateVMRowAndSwath_params->PixelPTEReqWidthC = s->dummy_integer_array[14];
> +	CalculateVMRowAndSwath_params->PixelPTEReqHeightC = s->dummy_integer_array[15];
> +	CalculateVMRowAndSwath_params->PTERequestSizeC = s->dummy_integer_array[16];
> +	CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_l = s->dummy_integer_array[17];
> +	CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_l = s->dummy_integer_array[18];
> +	CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_c = s->dummy_integer_array[19];
> +	CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_c = s->dummy_integer_array[20];
> +	CalculateVMRowAndSwath_params->PrefetchSourceLinesY = mode_lib->ms.PrefetchLinesYThisState;
> +	CalculateVMRowAndSwath_params->PrefetchSourceLinesC = mode_lib->ms.PrefetchLinesCThisState;
> +	CalculateVMRowAndSwath_params->VInitPreFillY = mode_lib->ms.PrefillY;
> +	CalculateVMRowAndSwath_params->VInitPreFillC = mode_lib->ms.PrefillC;
> +	CalculateVMRowAndSwath_params->MaxNumSwathY = mode_lib->ms.MaxNumSwY;
> +	CalculateVMRowAndSwath_params->MaxNumSwathC = mode_lib->ms.MaxNumSwC;
> +	CalculateVMRowAndSwath_params->meta_row_bw = mode_lib->ms.meta_row_bandwidth_this_state;
> +	CalculateVMRowAndSwath_params->dpte_row_bw = mode_lib->ms.dpte_row_bandwidth_this_state;
> +	CalculateVMRowAndSwath_params->PixelPTEBytesPerRow = mode_lib->ms.DPTEBytesPerRowThisState;
> +	CalculateVMRowAndSwath_params->PDEAndMetaPTEBytesFrame = mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState;
> +	CalculateVMRowAndSwath_params->MetaRowByte = mode_lib->ms.MetaRowBytesThisState;
> +	CalculateVMRowAndSwath_params->use_one_row_for_frame = mode_lib->ms.use_one_row_for_frame_this_state;
> +	CalculateVMRowAndSwath_params->use_one_row_for_frame_flip = mode_lib->ms.use_one_row_for_frame_flip_this_state;
> +	CalculateVMRowAndSwath_params->UsesMALLForStaticScreen = s->dummy_boolean_array[0];
> +	CalculateVMRowAndSwath_params->PTE_BUFFER_MODE = s->dummy_boolean_array[1];
> +	CalculateVMRowAndSwath_params->BIGK_FRAGMENT_SIZE = s->dummy_integer_array[21];
> +}
> +
>   /// @brief The Mode Support function.
>   dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
>   {
> @@ -7683,69 +7753,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
>   			s->SurfParameters[k].SwathHeightC = mode_lib->ms.SwathHeightCThisState[k];
>   		}
>   
> -		CalculateVMRowAndSwath_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
> -		CalculateVMRowAndSwath_params->myPipe = s->SurfParameters;
> -		CalculateVMRowAndSwath_params->SurfaceSizeInMALL = mode_lib->ms.SurfaceSizeInMALL;
> -		CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsLuma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_luma;
> -		CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsChroma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_chroma;
> -		CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = mode_lib->ms.ip.dcc_meta_buffer_size_bytes;
> -		CalculateVMRowAndSwath_params->UseMALLForStaticScreen = mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen;
> -		CalculateVMRowAndSwath_params->UseMALLForPStateChange = mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
> -		CalculateVMRowAndSwath_params->MALLAllocatedForDCN = mode_lib->ms.soc.mall_allocated_for_dcn_mbytes;
> -		CalculateVMRowAndSwath_params->SwathWidthY = mode_lib->ms.SwathWidthYThisState;
> -		CalculateVMRowAndSwath_params->SwathWidthC = mode_lib->ms.SwathWidthCThisState;
> -		CalculateVMRowAndSwath_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
> -		CalculateVMRowAndSwath_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
> -		CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
> -		CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
> -		CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
> -		CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
> -		CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
> -		CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
> -		CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = mode_lib->ms.PTEBufferSizeNotExceededPerState;
> -		CalculateVMRowAndSwath_params->DCCMetaBufferSizeNotExceeded = mode_lib->ms.DCCMetaBufferSizeNotExceededPerState;
> -		CalculateVMRowAndSwath_params->dpte_row_width_luma_ub = s->dummy_integer_array[0];
> -		CalculateVMRowAndSwath_params->dpte_row_width_chroma_ub = s->dummy_integer_array[1];
> -		CalculateVMRowAndSwath_params->dpte_row_height_luma = mode_lib->ms.dpte_row_height;
> -		CalculateVMRowAndSwath_params->dpte_row_height_chroma = mode_lib->ms.dpte_row_height_chroma;
> -		CalculateVMRowAndSwath_params->dpte_row_height_linear_luma = s->dummy_integer_array[2]; // VBA_DELTA
> -		CalculateVMRowAndSwath_params->dpte_row_height_linear_chroma = s->dummy_integer_array[3]; // VBA_DELTA
> -		CalculateVMRowAndSwath_params->meta_req_width = s->dummy_integer_array[4];
> -		CalculateVMRowAndSwath_params->meta_req_width_chroma = s->dummy_integer_array[5];
> -		CalculateVMRowAndSwath_params->meta_req_height = s->dummy_integer_array[6];
> -		CalculateVMRowAndSwath_params->meta_req_height_chroma = s->dummy_integer_array[7];
> -		CalculateVMRowAndSwath_params->meta_row_width = s->dummy_integer_array[8];
> -		CalculateVMRowAndSwath_params->meta_row_width_chroma = s->dummy_integer_array[9];
> -		CalculateVMRowAndSwath_params->meta_row_height = mode_lib->ms.meta_row_height;
> -		CalculateVMRowAndSwath_params->meta_row_height_chroma = mode_lib->ms.meta_row_height_chroma;
> -		CalculateVMRowAndSwath_params->vm_group_bytes = s->dummy_integer_array[10];
> -		CalculateVMRowAndSwath_params->dpte_group_bytes = mode_lib->ms.dpte_group_bytes;
> -		CalculateVMRowAndSwath_params->PixelPTEReqWidthY = s->dummy_integer_array[11];
> -		CalculateVMRowAndSwath_params->PixelPTEReqHeightY = s->dummy_integer_array[12];
> -		CalculateVMRowAndSwath_params->PTERequestSizeY = s->dummy_integer_array[13];
> -		CalculateVMRowAndSwath_params->PixelPTEReqWidthC = s->dummy_integer_array[14];
> -		CalculateVMRowAndSwath_params->PixelPTEReqHeightC = s->dummy_integer_array[15];
> -		CalculateVMRowAndSwath_params->PTERequestSizeC = s->dummy_integer_array[16];
> -		CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_l = s->dummy_integer_array[17];
> -		CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_l = s->dummy_integer_array[18];
> -		CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_c = s->dummy_integer_array[19];
> -		CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_c = s->dummy_integer_array[20];
> -		CalculateVMRowAndSwath_params->PrefetchSourceLinesY = mode_lib->ms.PrefetchLinesYThisState;
> -		CalculateVMRowAndSwath_params->PrefetchSourceLinesC = mode_lib->ms.PrefetchLinesCThisState;
> -		CalculateVMRowAndSwath_params->VInitPreFillY = mode_lib->ms.PrefillY;
> -		CalculateVMRowAndSwath_params->VInitPreFillC = mode_lib->ms.PrefillC;
> -		CalculateVMRowAndSwath_params->MaxNumSwathY = mode_lib->ms.MaxNumSwY;
> -		CalculateVMRowAndSwath_params->MaxNumSwathC = mode_lib->ms.MaxNumSwC;
> -		CalculateVMRowAndSwath_params->meta_row_bw = mode_lib->ms.meta_row_bandwidth_this_state;
> -		CalculateVMRowAndSwath_params->dpte_row_bw = mode_lib->ms.dpte_row_bandwidth_this_state;
> -		CalculateVMRowAndSwath_params->PixelPTEBytesPerRow = mode_lib->ms.DPTEBytesPerRowThisState;
> -		CalculateVMRowAndSwath_params->PDEAndMetaPTEBytesFrame = mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState;
> -		CalculateVMRowAndSwath_params->MetaRowByte = mode_lib->ms.MetaRowBytesThisState;
> -		CalculateVMRowAndSwath_params->use_one_row_for_frame = mode_lib->ms.use_one_row_for_frame_this_state;
> -		CalculateVMRowAndSwath_params->use_one_row_for_frame_flip = mode_lib->ms.use_one_row_for_frame_flip_this_state;
> -		CalculateVMRowAndSwath_params->UsesMALLForStaticScreen = s->dummy_boolean_array[0];
> -		CalculateVMRowAndSwath_params->PTE_BUFFER_MODE = s->dummy_boolean_array[1];
> -		CalculateVMRowAndSwath_params->BIGK_FRAGMENT_SIZE = s->dummy_integer_array[21];
> +		set_vm_row_and_swath_parameters(mode_lib);
>   
>   		CalculateVMRowAndSwath(&mode_lib->scratch,
>   			CalculateVMRowAndSwath_params);

