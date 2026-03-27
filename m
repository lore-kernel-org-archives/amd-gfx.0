Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57D910AB83A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 01:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6981610EC38;
	Fri, 27 Mar 2026 01:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jIwLsOg3";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C767D10EC38
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 01:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhQYtddqRDG1/8K+LWUx1tisKTtwaKdCzJ8iUA9KKV3qnO/bC2Yus8+FgHli3IYLWE/MobWL31ZExCU6+WJ4e7TJ5T3GgMg04utKLvLS1/ilqC5uT43Hqq7a8TDVAiuWhHwTbyJ2r57W/QJ/W80NXTWikKb6zXEZk5pU30hfVMRN/5rBYJyPEMbhiAdEksiYky+UxEWqgV46iYelPenpNi7tczksb+Avn6iZCnKyxKzLbQFxlU3mDn8YsStyCFQreRItMKetfxlANoEK+l/o3rFM19b82xqHfgRbQ9A0HKrB2QYANPruUwbJyFVh8ZSH2qVhdL/UOXLQPr0XT29VEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToX59+ol5fESIPXEmIMGOHHlDvUVR8BoHLvkdEK+BAE=;
 b=eA2WV88aESu19qJcRIwZoXczuu6x7w659VOBbBGyD94AZ+uXT4hAmtHpUyeken6FI+5AqZrtRgUmIrZeJvGEdze4afH4hkTb2xZOf3E2uw//fpDsZjLY0Mtj3/UEjU4y1inrVGLP5+KjFJQ6TnRlcPvnfzEPf3Mg1nqHrIKUpmgSHph2v3b5u80TagCJoMJjPvrD44WQ09i1ls/ZMQO8pnFuZ3xhmC0b2LmGJJf8zUyAFNnR5/oTDB8WZ6xRjwFYIoLRhuUERa4B2S6NbaRjPzGt1hFC1tswOZQ1KaIQ07x1L9mH58FWCJaTtljOuo5UjRXiXbOr4LwlHE1wn5l67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToX59+ol5fESIPXEmIMGOHHlDvUVR8BoHLvkdEK+BAE=;
 b=jIwLsOg3W3qH1fyyHqf+kE+v505KN9lNAqKSmnTGPUrBJpMMJ6BDCysWjLgTcfsnXUrFH7OgLFkZvYSmTJiBOpK3fy5Gxmd3izNMC/tYZFUrK7JxWV6yipxypZ4BhJUnV9kmFFhiX8nl9lnJQukwVFZuCOmnRXvMQiH1ry21i/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 01:04:47 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 01:04:47 +0000
Message-ID: <589bb7c5-3efa-4e37-99db-685fbf1b8d12@amd.com>
Date: Thu, 26 Mar 2026 19:04:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add update_descriptor param info in
 'update_planes_and_stream_state'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20260323043857.2043958-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260323043857.2043958-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e8b4ec-b19b-43e8-941c-08de8b9cd71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: cSWIuFxCkCFky9rkeN+lz9XHpB/1voTIx3bp1Bmnr8Qc1OyY2h+CgiylV9P8DK26fmw/6FkPFhIDnKpsGEKW4Yy5C/Lq68svBUimidrP0LCk2xw1tAQgLLFs31BB/K07HvW0ocnb0Q+BBCVry5PFguhN44Ehms1+9Vkf3T3mqkZZfnJaG1dL/eyXBy4wdv5jqhCqMcln5uevrPWrx5ojdBf+JUFfer7LKAykRwXPyIBA4CYnn59Bq5spcYesV9r1FTitxbo9qqsWYoFSYTdd5GjmPxDZ30ZIfnm7RBQRwWaVHIobP6PYBKL8VS/3ayhlPiUPKjNZGLMBX5/tgZru1I2r1D7zGBW9e+X6IUkSQjN9S7OcS9EdgNuM0Yga577KhJU4ftpe1x0zX4LXzwLzCqpqalFIWOz6q9g/XcK9YmQc+q+HK9VZ2q0ZKlSJ7hghAvUIfyUm+si9djxnxpt2Cpren6Sf7M7PLf5Dd32vKJ/+O/p9mqppeW0+1dwJuK4dytcgixui3yZDX5ziPM625c7ADjPZbkjCs9Na/RdU1AiqbcJxbvpPRYf23HWBVDQUTXJ3mpY3htaPoKma0cz2/Itd6L4nOC/hQciNsfTyPHlhSoCFzrnIBTyzFcEeENanencrYgARsNFMWT0GlsUvi+/JBeBu51AnvbyCXBE36SgLBrOABzopRcHyb0BT4vx1Ry3j3jR/4POL0oOdQMBDq69InrAWI1Lt6LWf25jG/Gw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxuWVNpUnQ0Wk5rSnJwUGMwRmUyVVlZdUp3YWtDdXJKQzRzNjkwV0ZuMkY3?=
 =?utf-8?B?b1VXQU15bzNad2ZSaEtFTkx3Um1PUnBDL3RIRUNuNEMzeTJwV2ZJdlZkMVcy?=
 =?utf-8?B?WXJpMjVlMnFIdWZuUmZsUjlaY2daMUNxZVNnK1NSYlZuY3hDaVBjdkZBcytW?=
 =?utf-8?B?eCs3TEhSMFF3Ny9KUGczbFJRM0NmZGRyc1VBRm9weXQzOVFwUFFIblFUemlN?=
 =?utf-8?B?TmFBMmRxV2x4bkhvV2FpWXA2c0JnTGl6bks3a1lmUUJiMWRIUzB0cUVobWhr?=
 =?utf-8?B?Z0VDNHJhWU5vdzV0cHF1ZStPOW1iWkVSM0dsL3JUODlHWERENmgrUnF3Rkhl?=
 =?utf-8?B?UmJrcUtKVU1vRzRmYzhKclVKWVhMT3FyVXNjdXY3dzJUcGQwT1pab2Y4d0pH?=
 =?utf-8?B?V3VZQ0VnTFRTekRkandQSnEzdlBrc0h3WHNHQmdRYnFYZzhZRnNmc3Mzajd6?=
 =?utf-8?B?b2laeElUU0VLd0szczlZWFJMeFhQYklHNmJOMjNLMDhxRlh3UHRadk9DWkxW?=
 =?utf-8?B?T21XMUYxUlN1dXRzZWlTTy9qV2RYdGw5am5JeHB4TENhSDExd0VlWkNuNG5l?=
 =?utf-8?B?SXB0YnMxTXRMOWpqQzkvLzM0S2hvTkxlZWE4NWhzUHdhamx6NDltYTQ2YVhv?=
 =?utf-8?B?SG5KRG9HZEVpQ25GMzR0VHFwdWVpYm4rQ1RqWTJ3dVZzYW9GNVhRa0p6cDQr?=
 =?utf-8?B?cEZBTW5uNno4NjZTc3BVY1BwS1pTQk9KWk9GazhydW5VTTZuVjNUeUtGRGYr?=
 =?utf-8?B?RG1XSE9RT2kvdjJhNmRNcEhMSnNoM2dLa1F3NENRQlJnVGZKWlNLczJwTk44?=
 =?utf-8?B?ZkcvNUtlV2dib3RKaDQ0SUNmcUJJdU9CTWtuTlB5TG1JWGMyb3ZuRzI2UzdM?=
 =?utf-8?B?NllHUkE2Q3IwM0xPS1JHajhpenNaRjk2NHRwR2NobmQ3L3F1NU5wekRCNUYy?=
 =?utf-8?B?Tm9sQS9XT29KazJBbC8yZUxFalZsVFNmcXp3RzRnYVBHcEs1cjB5MGJta0Fl?=
 =?utf-8?B?WkRuaHB5UkhQYlY4TjdWVjFhUTFjN0F3RTlST2lqcEw4ZnhUR0MwSjBLSzlC?=
 =?utf-8?B?c2FnYWhTTDdISkRiK0N4YlV1OE0xd3RoOWVMbi9taWhiOFBtL25qcEw5RnF2?=
 =?utf-8?B?V3grcXB0bTZOMithMzhXSVd2NWtpdmg4cjlSK0xGN2hSeTk1MHpJRjJtcENs?=
 =?utf-8?B?aXBGY1AwaWJkYUhHc2ZRVm5lQ1o2TnUwS0ZMUkdWNUs0WllWcXdPZGZhckkw?=
 =?utf-8?B?ZkIxOFpRRUJSdWhqQVh3cEZrMXRNb2dGWGk5T1YwTnhjZkVLOVhFeWZYRnNH?=
 =?utf-8?B?YTVIT3dUOVlGR2U2U2huRnVkNzdBakZBa3FWV1JQaytCVUxUMmV5ak93WTZ6?=
 =?utf-8?B?Y0lZRFNRU0NPeEZyUHZGT0xWMSsrY05Sczg1STZDWUZVM2diU29FZEZFS0tV?=
 =?utf-8?B?WWZnK0cveGxzOG5KQ1MxdHRWOGZFZGw3djlIRmZ0WjBlNFE4UllZSmk1eXBN?=
 =?utf-8?B?S0ppLzA5TGtYblB1b20zY05XRmJ2THY3bG8zTTFrQUxQdTIxM25GbHp1ai9E?=
 =?utf-8?B?MGZMZlBSak9VT0prMmVsQ0xYd1Njb0x1UEVkaDNweGJVeUh5MFFCcjg0MWQy?=
 =?utf-8?B?bkp0N3FIbjFUWWEvWS93eWp5djhtblpWK2RjSUJad1JFcG9qL2RxTXA1VDdp?=
 =?utf-8?B?aG1tU3U5T3UrdVRKNFhSZWhLV2I3WHNRQ2swZmtBdUtsRHRXMHF2VmcyaFNL?=
 =?utf-8?B?WTdtWU1YQy80MFdxQm5tN1BLSUQ1YzR4NVJ4UG9oaXpES29uYUhkb3VjRURn?=
 =?utf-8?B?ZDZQbmhneitORE1Ia2svemxrZ3JtVDQrQ0J0SmcxZEVST2ROMWs3WFpsR0lM?=
 =?utf-8?B?V1EzQll0K1JYMHM4OXVDWjNPeStJc0ovNnA2aUZrcjVuazh6YUdJY0ZtSC8w?=
 =?utf-8?B?QS9MdTd3czBCNmtod2JMVW15UjZjRFZHaDJzUTY3MGY1WTBNL3JoQmwvMFFV?=
 =?utf-8?B?UTZyTUw3TWRpWVBSQUVWd2kzaldVVGl2VVJ3SmtGWXNHejNVWHdTK3Q3ZXhR?=
 =?utf-8?B?VGtBSVRla3E2RmpENk9YT3RxMjFHTXlLSnZSbXJXS0w2UUd6TlYyVEdjOHFx?=
 =?utf-8?B?V3NXM0MvejNzNUhDOXFKa3VjRllabER5OERiTTJQWnBhcDFob3dpZlZUVE1v?=
 =?utf-8?B?V2hIditOTFZaamdWcTlqUSt6REpjWmFxNUt5eVBZZnJTN2R6YWVtci9aQ0RP?=
 =?utf-8?B?ZnZxTGVBcEk2eElxTVNob1RJTFZFcnNBTys5WkhiaGJWWVd1cENjdWlsaWdO?=
 =?utf-8?B?MG4rTUh4bjVzd0tpTEljWWR6L3NSSDd5SDd1c2tsTWVaUUdLVTI1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e8b4ec-b19b-43e8-941c-08de8b9cd71d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 01:04:47.5001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3l5hyEAUPYmkXN3EmywlgTL681e/Ce/0nOv/mDif3OjHh/IHMgVtPTKkFMsJ5meLIAvcsW4y0xrxLV4fb6nRlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423
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

On 3/22/26 22:38, Srinivasan Shanmugam wrote:
> Add missing info for the update_descriptor parameter in
> update_planes_and_stream_state().
> 
> Fixes the below with gcc W=1:
> ../display/dc/core/dc.c:3630 function parameter 'update_descriptor' not described in 'update_planes_and_stream_state'
> 
> Fixes: 90fe5f44136d ("drm/amd/display: Refactor DC update checks")
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Dillon Varone <Dillon.Varone@amd.com>
> Cc: Chuanyu Tseng <chuanyu.tseng@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 8b21816cf7c8..e3992ca43c8d 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3615,6 +3615,7 @@ static void restore_minimal_pipe_split_policy(struct dc *dc,
>    * @surface_count: surface update count
>    * @stream: Corresponding stream to be updated
>    * @stream_update: stream update
> + * @update_descriptor: describes what plane and stream changes to apply
>    * @new_update_type: [out] determined update type by the function
>    * @new_context: [out] new context allocated and validated if update type is
>    * FULL, reference to current context if update type is less than FULL.

