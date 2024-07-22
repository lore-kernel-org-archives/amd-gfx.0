Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500F8C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 06:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEACD10E098;
	Mon, 22 Jul 2024 06:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FfiH4INn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA1C10E098
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD6XIhVUZIiGMdlgyVF9Qe9sVyB6do81hhufuCZmIxwEtddds8NgRSDlkI71HYJIqOnrV2gI4ObFZfaecZEG9Vlr/0pOiC0/dGUp5XIr7MC2nCPzmRMNTEjnetdEBuJi9hkfZsFus/lFjDfuJuTrGfVwsO9zE4QbA3KomzE1uBfmcx6aLe60hT8CaMQzbr/EKqrlsvQZ2RJ5+A2Rmz8+uXcX32TV8bZNVoM8OMGneXOcMVscwdo906NwA1TkhkGdeVBaWAGa8RJgqsQ9A5x+wKcxilB3vyBOCATm0RBqgHA0Qa6zLKMgFJ40KM4LD7ia2NFj05AM6NKDySYMtwh6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl8AeTnvrjBxhsEADf1CdMReCFAXdls0Ce4FYFzLdJQ=;
 b=kSbuy5HoLc1i/p12mxjrrDbKiQbxeF3C33FBmtOOP3QglEvGIOEpKyQYz1MKMfepDqX2Y+FjjJITw2Q3nHLFsOAAPA4EH3BiSJYLogHj/+oeMq44rVC2x79qonq0Sj/in3VSXbE0+V7MeU+2LPFhVmOi3uV+uXaTpuSQ9KPZd5QbHxsc77avra0jJLUfi/oBc8Aq2lgZ3vMrnu7c7Z7l+SCgovz9mGl5XF8Zm0JjEQBqUhQDgEusMXXrGGdaLVDQ8TzFqRoYSmh/b+uuzENVu2JTdD6hzYByyYOGWjr+xTWLlhy56IDQMrFQpUF9dCY5ViX46Nz6zAYCHKaiFsjHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl8AeTnvrjBxhsEADf1CdMReCFAXdls0Ce4FYFzLdJQ=;
 b=FfiH4INnBYfypn+sst6MZzSv52kdTgAN8mQDIKpbcfQmdqDylBsl1++5SX0rv/vq2E7bxB9YudYquj+dq1V2/xy+OQM7YvbiL4HB8f9VJ8j/ZMOSuL/YG9D3r7xPLI7nFLRyJeheniPdAuyaVJ4kr+SSWLYGopw1a6fmdkMTExQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 06:34:15 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 06:34:15 +0000
Message-ID: <132f9833-278e-4851-bbc4-ebe8be5b37e7@amd.com>
Date: Mon, 22 Jul 2024 14:34:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: Add null check for head_pipe in
 dcn32_acquire_idle_pipe_for_head_pipe_in_layer
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240722014646.3558293-1-srinivasan.shanmugam@amd.com>
 <20240722014646.3558293-2-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240722014646.3558293-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 74da8fa6-b933-49ca-fd2c-08dcaa184e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0FaSnRtNUdkV2JmZVZaZEhrWG1rbU8vY1A5UkpCN2l3NkR3U3g4Q20yNVAv?=
 =?utf-8?B?cElwQjI4OFJWL3hEWWt2amUxQ0krKzZsZ2tHaGV5S3RYZHFOUFp0US9nTUtk?=
 =?utf-8?B?MG9UbS9YWWRGQlhYejR1ZFJQQ1hMWUVDWlgyWUY3RmE4clBkWkpwdU5XZ1V1?=
 =?utf-8?B?RndzZXF0dVVqL2JtSXV5MHVrWjZBMFlpL3BJbTRKUHBoYysxamRKTGNVekNt?=
 =?utf-8?B?WThteDNWeDFweU11bjFhdHRmSFFhNWR4NUtMQWNjemJVb2dtWCsrSEkrZUpI?=
 =?utf-8?B?cjBqSW5Uc29Pbk1xV0FCNnB1REs3eFBiVWpOVjVDaTlCeGplc0pMaW53QXpr?=
 =?utf-8?B?MFlYczdKN3ZHUlhzc25KSkF3bis2MTJkeDUxdXZDSzZOaHhsV3ZBcUpMT21N?=
 =?utf-8?B?WkFCMU11Y0dLL0pnVmtGOWZMb3NWWTlwaVVTc1ZVWjhoT3h4T1MzdGhxVVV3?=
 =?utf-8?B?cmdwdVJWVUYzd2RENjU3UTkxZ01jcW5hVGVpNi80RG9HK29wN2h0VkZqVU1r?=
 =?utf-8?B?NlJ5QlRTSTFId2ZVVUFMVkF1Sjg0dUQ0c3FEdlRBWVlJV2NIcFlpS2E2NVpR?=
 =?utf-8?B?c09mZThHdU5IOFFHOGd4Qk02TVU3TzFKRUFBQVA1a09ZMWp1ZmxIWUJtSlFI?=
 =?utf-8?B?OHBQSWV5T05Xdm5VQjNkSUdFS2NTdldLQnh0d2FBMVgzNHJMUjBDcVhka0I1?=
 =?utf-8?B?TnIzODhWOWswRTRpUkJQUmVNM05NLzU2UXdGd2lKNVVpT2hsUTJvV0M4eDZp?=
 =?utf-8?B?SUllcDBuMndHcFU0U09YMXowbUJUQWUwMExHZEZiRE95L3JCTlRNdGxJM1Bt?=
 =?utf-8?B?c2sydzlTWHBRQXBPa1Ira254bHRGNVFPUHpwYjRGZ3ZJcmc3ZzdGbzFYaXla?=
 =?utf-8?B?L0pRNCtZNUZzTWdqOFhqVVdiWk5hY0wrNHgxWlZzQmZFd0d1c1RjYVNQOXl6?=
 =?utf-8?B?TE84dmxqS0VUdkJzbk1RNnd0WUtOZCtUTXRaenExdEM3cGxPMjkrWjJhK1NP?=
 =?utf-8?B?T3RVMFdvTkRYMWxOT254WWppa1ErOFF3SzM2R0hVcER3VWEyWUFOTjBaaCtQ?=
 =?utf-8?B?Q3dDUHZVZE9kUnBpaUEyT3g3R1MySXFjS0ZDdGw3STI1ZkhTd0QxaEFLTFJU?=
 =?utf-8?B?NDVwb010akl3MVNoRHpCcDZvOUtwY1cxTFdWQ3JiblIwOHpjZTYzeUlUZDlu?=
 =?utf-8?B?SUE0TUwxc3Voc00vSThoRDZFVFkwa3pxZmtXL0tLbllyUVVwMTR3eVRNQzZ3?=
 =?utf-8?B?RXpsRnFPWjBMbzVHd1g5MzE5Zy8rcWVBYmN5ajg1cDVmY280SSt3UlRRZlNk?=
 =?utf-8?B?ZlV2c0JscVVFb0Vwcm1wRHY3KzE5N0NvVkljRFhwaTN5eGNDbmM2V2JXNGtR?=
 =?utf-8?B?a2hyNm1MRDJZNGVpck9DRlV0Vkd5S0NpSFgzZldJM01EODJ1MVF6NXkrRGZo?=
 =?utf-8?B?clQxSEp0SUhQbnRLZGszRndRai9mWi9MQlFQclJOaEg4L0NDWHcxd2wvZHVW?=
 =?utf-8?B?dXdVTEROdXlxWVY3ZmdLL3o1K2gyMEtxbThIMGtiZk1hTTdlMExrcFZ1a244?=
 =?utf-8?B?Z1VuSkExSDRFTng1Q0tITnBqY1QwKzQ2eGVQYjZFMXNnaEg1dmhhTWNheWI3?=
 =?utf-8?B?Ri9nNVVBUzhMSlI2dkZjSFBxUSsxaGE4Y1hTcEQ4SExVNW1wRXdnNmlrdHk4?=
 =?utf-8?B?SFlISC9yajZhdGpMLy9hZGNjcjRTSmxpc2xjNjZLaWJKL24rTWVqd0xJM2NW?=
 =?utf-8?B?ZVFoZ1EvODBXbWRwZFBmZitKUUtKSHljU3FYbmNQU3Y4V2hsaEFZMzlyc1hS?=
 =?utf-8?B?TFE3YzZ2Z1dJcWZ0RUNEUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVJPZzVNa3ZTanNnUUs5NWo1ZjNNSDhCTFRZMmUrRTNEcFlBWUlRMXNSalRU?=
 =?utf-8?B?aFdWZDd1MUhhN3ZKZ253TTF0RjZBdmEzenczVC9sc1VlaHNzbEVGY3dSTXo0?=
 =?utf-8?B?TzVVZzFNays0VzcvZjdlemUvcytiTFNOVHZPeGtNb0ptc1B4bVF3TVZHSGcw?=
 =?utf-8?B?WHJJeHdUZmRBM25qSVV0bVpmOWdqQU5wV3VJdEgvTGVLSWRhTmlyV01ha3Zs?=
 =?utf-8?B?Nms4S3hEdlgvS0Y5ZzRhUGdUOHBIVDNMRDhaR1M4YmdFeTFJMXVPVnNzbGRX?=
 =?utf-8?B?emFGQ1NvM2sxWHlQTGRPaGRGdDk3UGJ2cEt4OEEva1lreDhzcThWbktjNjJr?=
 =?utf-8?B?dUR6S3c3MDR0VlVqME5Ia1NhRW1mWVptZkVqYWYzaEhmNEdBSjhuZUc1VU45?=
 =?utf-8?B?N3BYTUtqVkxacEdQb3krQzhWdU5OMHBZeTNDMTE0a2RzUzFKSklFYUlJSWlE?=
 =?utf-8?B?Qkx1dlVYQllEQU1GUjV0VHQwTlpoajk5cGszQnhnNHU5ZFdOU284SFdjdVl0?=
 =?utf-8?B?TjA1dHhVbnUxMjdBaXNCTGJrb21oUit3dUtJYU4xTjBjaTJuWTJ5UG9OTHJp?=
 =?utf-8?B?Z2ZBYlZ5U2E5REdFMWw2TlJWQTVlTGNqNS84TUx6cUhRa3NNL0JQWWp5Snpo?=
 =?utf-8?B?N0tsWWgvZXV5QVgwOXlMQnNwNXM1T05FRnBPT2xsRlc1ZjE3ZkZuZWJYVHg3?=
 =?utf-8?B?K0k3MGdETit2bjUybzNYVS9wWXg0UHY3K1hxSlJTWjg0Z0kyUmZ5anZqWHlt?=
 =?utf-8?B?RUxVaG92SHJCRGxyRm44L1lwbTQ3M0pKZDhLUk1NMUhndUNlaWdYNHBQdmRX?=
 =?utf-8?B?TU03T2pFeWdFZlN2K3U0R1FieE1ZY1ZQNVZ0d1VnTi8vQWRuaEV0d0dWZkdX?=
 =?utf-8?B?b2hnUlY1V1ZYTFp3M25kRSt4eGc5SFNrK0JOOGpGekVVWHhSK3JDcFZ3Z0RW?=
 =?utf-8?B?bHN4TGtLMFd4NTJ1SjhDOXZvdEtNWDdXcFVITkdsRi9PSWxhLzZnenNBbVdF?=
 =?utf-8?B?OWxGRkNQU2ZRZzVjaUI0Z1VCSUVBS2ZLQUlEM3BrZ282RGFUTllEODNlRDR1?=
 =?utf-8?B?QTZsL2R1R25hcDk5Q3Fpc3BOUkc0OGx6cDZXTUNuQ2RLS2Mwd3ZFU2dXTGM2?=
 =?utf-8?B?NUpiNmwvMXIxc1VNdVBaRzhkM3Q3M0RMU0IyRkQ3dFcya0NxY0dmL0FOYUpU?=
 =?utf-8?B?ZFpPdk1mZUdadU5EWlMvdEd5UHJTMXp4bDQwL3I0ckVKRHZBeldYM0FYdEN3?=
 =?utf-8?B?MFlETmx2eHdSSEpwWnY2TDBmeDlwbzJ3Zkd2YjFocmVBdmNLczBKcGtlOHZh?=
 =?utf-8?B?S3dsNUhYRnM0NFY4YSs3S01sbmNaUVlPRkpGMFNOK3VHaVNGOWY0RUp0MUJi?=
 =?utf-8?B?YTVscWZHWmEzMUNZdWFLS3N6Ni85Q0NKRk10dHJnMkUzd1ErV1ExZnJvcWo5?=
 =?utf-8?B?ajVXVE9sUndFcmEwRXJFYlp6dTZ4NnZJREJaemIzeDdsYnkvc2NWRzg1K2dp?=
 =?utf-8?B?WWtxdHczUVlxYkgvSElNbzNBRFplYUxYVGFLUnZtekJHeDNpa1dJekovZ2d0?=
 =?utf-8?B?cFdhVzRSYXNHUGV3ME9BUzdmZWxTZmlEdGtpMjVmNU1VOTRmZUVIVE9Ka2px?=
 =?utf-8?B?QWRYMkhXeWNONmZ4c2xwN1pUUHMyQWp2VDZrQW4zcFYvUEJZbGYvQlIxRzNS?=
 =?utf-8?B?UGhzVVpOdlg5aXF0SXRMQ3pQdWZ3amV2YmY1enE5WlRFTTZnUUNjTkd4SmYv?=
 =?utf-8?B?VkFqOUtRZkMvK1dzNEQvQWxQNC90SEZ3WC8xYk5UMjdqV3ZsbTgxc0FVQlA4?=
 =?utf-8?B?Ri9sWlgxMHMvMUo5YTdxYWFMc2RLYkVLbHdSVFExSVo4cHVDR016c3RibGcr?=
 =?utf-8?B?ZUVZWDhET2k1SmlXODRzcHNuOUNWOXc5OTNoNFRPbE1jLytZVG41L1ViN0JD?=
 =?utf-8?B?bktaNXkwWWFLYkFlQTMvQnpaVDZzV292YzRVQSt5QlNjZkVKR2dDZGRmcmhT?=
 =?utf-8?B?NWFRRTlweHE5RTVwNWpJUjZveUNZT3BqY3hLcUN6OWpyMFZyYXdqVVQxVXVN?=
 =?utf-8?B?K3pINllWdE1KTEdLdFNrZjNMU0FEZDQ1cmFZODhZTWtyUEMyQVhpZ0czMVRN?=
 =?utf-8?Q?lsxRocq+9BkAeFSTXEsx2bWxn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74da8fa6-b933-49ca-fd2c-08dcaa184e98
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:34:15.6834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qx/9i54usFkNW8IWLGm0CstIFLplz8/vY7VSqIrg/TGfDXUM3+h32Eta8nN9kZ602nFESynazGrvSwBiO5dGtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/22/2024 9:46 AM, Srinivasan Shanmugam wrote:
> This commit addresses a potential null pointer dereference issue in the
> `dcn32_acquire_idle_pipe_for_head_pipe_in_layer` function. The issue
> could occur when `head_pipe` is null.
>
> The fix adds a check to ensure `head_pipe` is not null before asserting
> it. If `head_pipe` is null, the function returns NULL to prevent a
> potential null pointer dereference.
>
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:2690 dcn32_acquire_idle_pipe_for_head_pipe_in_layer() error: we previously assumed 'head_pipe' could be null (see line 2681)
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 6eaf3cfebcb7..a124ad9bd108 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2678,8 +2678,10 @@ static struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
>   	struct resource_context *old_ctx = &stream->ctx->dc->current_state->res_ctx;
>   	int head_index;
>   
> -	if (!head_pipe)
> +	if (!head_pipe) {
>   		ASSERT(0);
> +		return NULL;
> +	}
>   
>   	/*
>   	 * Modified from dcn20_acquire_idle_pipe_for_layer
