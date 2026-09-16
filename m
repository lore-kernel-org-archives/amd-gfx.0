Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C69BC88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 00:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D86510E20F;
	Wed, 16 Sep 2026 00:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XMLp06GJ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3280110E143
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 00:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydfxJuGApnQ2nr/omCOrqdAN1T6rJozpa5EglqJJbc0R8cg6LJJ8wMmyIIu++6GuHOCh5chYrXcox9V64JlhtxeVgdCOUjoHyClgAUHqAzfw68wQlQByYR+tVQ9ozPaQPn/0Gg81xIuXYn/pYC4TAQrrdNv54tqAJaAlOCkhgom9dbuhn+iKeaxMNFad4C3PzD8PjgXjN6RFT/LbvEdbfvAkYn52icLHuVwT2enBpgHgCjkkZlqsUTbWl+0vYob8EoksqI5p6lUBODO4uwjNfvW76mk7dl44W76eSlItYRJ0p78EpuH9JtX9YRJIFboOQOKb9Yclhf3cBCi5OjWuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/918Itr9O3CovPjstQkypjDPW4HG8TvzB49LKsid/z4=;
 b=Cu6aWmXW/B/Diby0tE1/XTHTAiQG5qBz9kWIwMjdgzf7dKSqkB3Hz4NW0696YCIvuSvdhnDj3mVTbO23wMNryCWONY83f0KxqzAYBKLBSx31nNYd4kFszIjaNjB3UmfGChEN/ccyCqmPPdJXHNx5/A5ePpgDFLsUGpBnOKCvW5LLCm47t/CvcgxGwTERdI++ipF51vse2V2zR62FXBvk73NlLPFEFolAOKVSYEjfI3qnrwCXUEQzUNMkMFbOmtlAQSweWZ6aWqlfzTvTvTr9Se2OyjruD9FOcgZTt0R01q6vuRIBO/nSdzrr8tmt5jLoCGrxZGC0Vq9lzxgMZhuIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/918Itr9O3CovPjstQkypjDPW4HG8TvzB49LKsid/z4=;
 b=XMLp06GJcX9dzdw9ZZUTjzY6qafrJr9MfuTys618gkIpaX773REZHZFX1yejCWTfgzYAXpl4/upuHc8SB9IiE6pYPO4pR4ndjqsphMFqlXyTF621aipVY6mjWw8xim5nvNWt9gfVa/TAGI7ik3jtyLplzsUEwHCeuNjPllwRqNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 00:14:37 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 00:14:37 +0000
Message-ID: <8f38bb21-29f0-4aff-aa89-8a2456488c79@amd.com>
Date: Tue, 15 Sep 2026 18:14:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Fix redundant NULL check on
 dc->clk_mgr in dcn42_prepare_bandwidth
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Leo Chen <leo.chen@amd.com>
References: <20260915071605.456039-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260915071605.456039-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b2c5ea-0de3-4ec3-d14d-08df13877e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: A/T0VrkdJ+VW893UOs3iFXw2GSSereVVfIrNJD66nf2+v6up24ek2zQnqyjT7oPIkHj2Y5qkO/Q+EHcIOQadMENTU/mMjdEtT/XM75XMdiQdyqsluybaYS3HiF7ZQb0rLuPPJGsDo8OnVN+MD3jmOP6d+9rLMHxtRY5CqQQcnosUbWAiGcV6gYorFMTKdZovIZb4xKsqHxnwWJiUliAIgnX2zzxrAe+m/zlUfXXBeEOQLVxG48umIfbJiJa2x+/agwIGhX5Kcsr5LEhNnk5GAKTMnGuf9ZCoRmwSLhucqf5qUm1KBDgMAmIu+0Ecl/Wwr1HxG2lCrdsTA1bMxSK2df+Dm0CXxUn6/WH5shOwveTc2UqdjoeSY0ZqO3i8lFk4DBwimQTyU8nXMxtLv4JZVyV2lwkL9Gqik2Syb0s2Ch63ST4MU/7bVi0FBq1cYpnUjnrYAIDA89Ac3Qo5w25wYlk8MnG5unuRNCR65TuUz8SNVEFm/VD+jUh2NsVPXcjUHubfz0vg5LZgd1tNr+x9cI6AcnHym3U3C9Pxsv+UfM9AOcEhApegtsGdp/70kf6Bwj1vL2KRLuXQ2yJN1jt1USuYM7vP5eIwmrHRZY55Wc930niUdSzglBgl5OIjpfCbLlPv4XqgPtp6jmoZYIdrGJ/DtvPU76G7OekmDpflKMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWswc0F6NjI5SmdKVzZUbkFYUGlkb0dQU0FaVmJMVUdrNVhTR2M2dEs5NWpI?=
 =?utf-8?B?a21oMjFmb0Q3aDYrT1RZQVFCKzhPRGhWc3l2OEgzN0EyYU41eGVGZjNRMGhx?=
 =?utf-8?B?VUlnT0RFSDV0TzkvSXpTb3R1SkNUWXhCdm9CSEFIZkVIZDRsQWMvSll3Ym5N?=
 =?utf-8?B?ei9WNEpNMmpXZkVuVXpleHpoQXkrRmEwMWNNcXNuS01yTVhCdmEvRElDSVdV?=
 =?utf-8?B?bTFPUXJsRWFZWU1iMEVVNS8xVS8zYUl4NHBTWWlIYUt5SjVIZnlTWUpVbWZF?=
 =?utf-8?B?aklXOHpJcWFVYm1QSzJuSVBHbTU5SW5TUUw5NlBORzVQVlh6VTdBbU1YRUg2?=
 =?utf-8?B?Mkx0TitSZ2NQMXFxSDdMeEwwc2N0aGxZazdKWFFjcTZqNXJFMmlqY3llRXZR?=
 =?utf-8?B?ZVJQZE8vWmpCdEtxcC9ndXRJKzJkRmIvV2c0SkxDczVqcFJmYmpjZXlCbndl?=
 =?utf-8?B?SXM2dllMZTRydkxJRHp1elpQcDZTSEY0dDU2Mmx1M0NSKzFwZy9lQ0xrQXZt?=
 =?utf-8?B?Nno0UVZrbERFUHN2aDJEaUJBejhCRGVxMFdVRnRYandlRlRPK1lzL1JCRVpa?=
 =?utf-8?B?MVpjT0dLUG9IZ0wrRGV6YWNwdTlOdE5QUzJuSExqYmFySklWWnVxZU9nMGNF?=
 =?utf-8?B?UEdCZkVEdjM2WVYyZ083cGRpaVFOdlAvR1pPVjNmcXJxOE8xM3NQdFJkcDhF?=
 =?utf-8?B?ejEzVkRhc2Rsb0dUWUl6d3FRa1gyRjNSODBrTDlJTmlWbFQ1OUFXRHpMNjl0?=
 =?utf-8?B?VFFCaWR5S0xJNmlUUm5ZcFRpVnZoUFkvaXJPZWVjVHdSYlo0VG1XeVFXRG5o?=
 =?utf-8?B?ZTRlWlRTQU1qQjV0eDRFUHNiOEpKTW52WFZacE53UldNM0g5cnBDcVJIUWdL?=
 =?utf-8?B?OGo5b1VuUDR4L0Vjei9iSHhkcXl3SXF1RTNUeUJsb0lXelRmeFMvQUtqNkk4?=
 =?utf-8?B?dmVrNG1WMG15bkJxdGVPT24wcTY5VUR4TzNzdEFmTS9xN1lsdFNZR2J4OThY?=
 =?utf-8?B?SXNKTXJ0T1FKYnN5SVEzUFVMRzJhQ1dUY1ZGamw3eUxNVkdWc0gwZGgvZzRi?=
 =?utf-8?B?M0x6YVk4blBTWEV4dHVWdHhXeVRPV2lWMnB4WjNBVS9ibnpSTzVGRmRkYjB4?=
 =?utf-8?B?Y25XUVgzL0t2bGI3aFZKV01KSDFCOUFvbHYvUFVucFFaMmRkMExKcDJSMFZ2?=
 =?utf-8?B?RmlBdGVPR1dyNnFjblo2dU9VZlJmN3hTbmFWVUhFRm9QRWxwOWlWc3MwTG0y?=
 =?utf-8?B?cUxxY0tFdy8yamRia0lUc3R0S2JzQUROQ0ZtWUUrUytNeGdtNHVzdW9RWlVL?=
 =?utf-8?B?Z3N2cGNkNHlFZDc3L0EvY2FySlM1VFdvZ2ZYUm92QnBZdUl5T045S2hReTBJ?=
 =?utf-8?B?ZXpMU282SmVpTE83Q3JibkRtUDlQQ3UrRFVCWnpFb1NRNlZzdEFJMjJKemY5?=
 =?utf-8?B?TjVVRE5OZUl6Zm9VUTJQbUtCeVNRVFA3YTF0VU5VQms4QmwwSGc1SENhVTR2?=
 =?utf-8?B?YmcwZ05PUFQrNUJCZjBTdkVtb0xYazF3clJFUWJyWHBkQ3FDWkFSSFBtODY2?=
 =?utf-8?B?SmlocFF6ZUQraU0zNHc3WVRrc2VIdWh2OGJwcGpBTkZUV096ejdGbE1VTFlD?=
 =?utf-8?B?UjRQY1FtUmRoT0FMV0R5SlhIeFltaktpTkY5eUZxdjF0NTNlTUNnSWs1YmtC?=
 =?utf-8?B?UEJyMzgvNEEyTWZPRnIwdGd3RFhLdzFGQU5kbHBSOUlSVGF6Yng1cDVLTjlH?=
 =?utf-8?B?eWpwNHJZSTVkd05mS1RVaXBGYnNac2d5eEFla01XZGs4OElwcUhPWi95cEJy?=
 =?utf-8?B?a0tUbmUxMG1UME5OUVFzMThlejhweWh6eUJWMDlkeHFiTHd4eWJVNHpwUERl?=
 =?utf-8?B?WXVhZTNQaDliR3pPMTV2b3JkMy90UDkrZzhYTU9IazVKc21qdi93bDBrYXUr?=
 =?utf-8?B?aGQ1bTBQT2U0aGk5TE9XeEtUVTBVN2xPcFdNUmsrRWRGa1RUYitjSVcvWUo5?=
 =?utf-8?B?UDNoNzhNRXZSZEVvcE9WOTh1TUdhL3loMWg1RjRYaUp1OGFLUmRSbS9yNEJT?=
 =?utf-8?B?N0VzVytqS1N5OHg4TU8vc3QxNVZXTG5vTTBDVFdMTCttWWd0SVkrcHhYSmRo?=
 =?utf-8?B?NWRsNjFEZEtBbXYxMXZoT3l4OHk0MmoyaE9rZTcxRXBlU1grdWVCQUp3RXBT?=
 =?utf-8?B?NXprc0RaY2FHb05WSkpKdVRjZjBXc0lnSWtObnVyTWVycTYrcC9iWVo5ZGc2?=
 =?utf-8?B?d1NxWG1Ka0ZiMmRzS0d1NFg5YWN2eWxiTDZSaVZJUEI1QkZ6MWpVSUlzTTR1?=
 =?utf-8?Q?EfQ5Wvr8HkA61jxgpQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b2c5ea-0de3-4ec3-d14d-08df13877e0c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 00:14:36.8544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LFbmWCpW8wbngogz3HTqpON4yqxz4dMwYFc+7BvR4MjB2CJzGJelfEd6edvyIwGA1BFJgbfI9z1+tdOmdL5yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
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

On 9/15/26 01:16, Srinivasan Shanmugam wrote:
> dc->clk_mgr is already dereferenced inside dcn401_prepare_bandwidth(),
> so the dc->clk_mgr NULL check that follows is redundant and misleading.
> Drop it.
> 
> v2: Drop redundant dc->clk_mgr->funcs NULL check as well, since
>      dcn401_prepare_bandwidth() already dereferences it. (Dan)
> 
> Fixes: 080f9655cf2b ("drm/amd/display: Register DCN as a PMFW DF C-state client on DCN42")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Ivan Lipski <ivan.lipski@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Wayne Lin <wayne.lin@amd.com>
> Cc: Dan Wheeler <daniel.wheeler@amd.com>
> Cc: Leo Chen <leo.chen@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> index ee40ee8f62ef..21c3d108abe9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> @@ -783,7 +783,7 @@ void dcn42_prepare_bandwidth(
>   	/* valid C-state watermarks have now been committed to HW, so it
>   	 * is safe to vote "allow" to PMFW.
>   	 */
> -	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_cstate_disable)
> +	if (dc->clk_mgr->funcs->notify_cstate_disable)
>   		dc->clk_mgr->funcs->notify_cstate_disable(dc->clk_mgr, false);
>   }
>   

