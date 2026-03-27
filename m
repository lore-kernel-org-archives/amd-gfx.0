Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E00510AB839
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 00:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B864A10E329;
	Fri, 27 Mar 2026 00:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l2gc+Ov0";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356EA10E328
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 00:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDq8kEOHhkr7ubnFnEI3Jy9lKDf31g6CpAKMofJXwBViLPOFu63G6Qoiu+UOvmGDa0w15U8DhLPPWEcb1VfBk93EVCwMPqmLG4kBgCwHeDppMNGDH7tkHnVAz6uOtiSC7dxZcnnDXRQd94HXTvHl3oD4opjPJgCKUw3KXxscDHD4Me49DI5Y12WGC5SWzOeQq2kPh/18nN5Z6S8B8MFRmcIchahrKG94NEBNxDqd9AW15JbKq2rem2uEoUQrmiZ0Kz8EAgjMaR436ttmBexoidBBtnZjEIFjEniQL6RXdM+iEnrKTSZadiSAl9tKz5iXKYMSTDxo2cdypEgnK8gFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU//IkM4bRBxceuU0/cy9rPTnHDZ7nvzaugMI/a41YU=;
 b=ktHr176XuvIvyjj2kWStgYiN55Oaz25tyn56ubXOLxXD8ISiqDo56N+Brap6DMeCIMjjAhyI0hpiZoqP7siZBPydT2dLDVX4WGVdA7hAizfqLQg5O+9z5ngSHG29et3+sejVLREjYiq2ftI5OpgMXDPylNii79bZs1f8uSEQAgcDw0M8hVl4Y8IDcS95Ds4V04w6t2nKNJ6wgVNu5LExx+KX0svsxIiLD/RHkutwS7B4qPuS1kASuImIzRQldJz4WwBwEjhJtAlNcIY1JXy34aMDJ1HETPMNz2DnC8+wc0BPb7urXk4dCCnFxoV2QcZxsAVD45BoxeEaOlWP1nl5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU//IkM4bRBxceuU0/cy9rPTnHDZ7nvzaugMI/a41YU=;
 b=l2gc+Ov08+lyRxvZtPkkZ8h4BXjHhl6Ja0ApMhdkdvQfi2LXwMVXyvU737clYGxGOViaDcaqc81WtlZ45IRyHfMR52Gpbfn0uT5fcXV3I243+N4PrVdKr3Vm0FYAvnb6p9ATuipiJ2ut7McSjm3fc5v78CKAy3ZV+tkWo5SCdI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 27 Mar
 2026 00:58:45 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 00:58:45 +0000
Message-ID: <f721dbda-0804-4ae9-96fd-963eedc7c85d@amd.com>
Date: Thu, 26 Mar 2026 18:58:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Avoid NULL dereference in dc_dmub_srv
 error paths
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20260323073209.2045385-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260323073209.2045385-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: 14119d58-10cb-405c-d830-08de8b9bfef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: UVTlLEzZ6QBwfiQifIYIlGYp8WvzAlPUjajgTZvmKvmsUPxBh5xk3exNTOkBBqwdO6167Pa/acBlXUsOU7CCPAPOOM+17owYiUUT86dB8LCY2NVYaXo+GKsUsEjn4+Tnz2SXng2KzxUa19VBPzaHP8JQyfFimd2XHgtNZky1NH1vgwrhcgcFlX0Q7RDE54Hj7Cc6+OQmZ+yn9jOu3V6yQo+4WtSQnEazdQ9CJIAhOWYEbVrtHcrdcpfSERU2mnhhlkr+Tl6zIi3rXbfwwZCyRdhQwxUUhyYrGZpB/sdgakg1ABgbW12m/Asc/mDOmsHJmBzhZ9V+XxDDyVLC924H35FN6yjXVRSzp+NT5GyQ35rCA1xUnLGFreE/fSiQt6/DTZh4it8yTY6maae4b0XZGdGviKXCStRHnSFL4lRwc+vWyfarNPKBrNjtP4NVYlMBWi4czv/i+b1b4A0qjVUrlUmGsVIHuyOD9mxRG+Rvsg7Zb5xxzqW1YbmLFeUgljvtynddbYdWXxSLsWWFONY/5ggFPrjHsK9RTGbhaZ+ZAwKvtFz2DKHrjZexC0fqP63ScILF2baTjFoYKF9AZI5z2m1Htc5k7ctpx3/7PP7fBnTky8vtlBAhQWH8ikxZNaFt7fuD52ZJQ1FjSy8e9SGGFWBBh2+m+B0aXa/JMabD4UlfSTxhizAw0VoyTbVZN1wkD1k/goQmmYVtePoTnVrtpbYYQoRuXLie0d+FhJehEvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjEyRi8wdDdWazBNL2t1Vi9SQ29rcTVzWlNhc09WZ2Z3ck5qZmRyWnBFTEx5?=
 =?utf-8?B?cXpESlhhaDMzeWh0Z29vc21xckFMcWdXeDJjM3NYS0x5VlQydzNtUEFiWHl4?=
 =?utf-8?B?NXhyQlJYN0ROS2pTYWM0ZUVodnpaMS8zdGV5WWhUZWZDK1RXUFNmSjV4MHVG?=
 =?utf-8?B?YjhqTlczVWJ5ZTZQV1QzY0VxVmc0d1R0ZCtESHB6N3BsaWRPT1QwZUsxbTVF?=
 =?utf-8?B?OWwwSmlyZDl0RzRlbnZWekVoVlVEUU51eWVhZ01kdCtsRTh1aldFZVFjZWh1?=
 =?utf-8?B?S0lxT2xJQmpRRlRDc25oUVNFelltM0t5RE5Td05iRTF5OXhxWGUrTmVib1d2?=
 =?utf-8?B?OC83RWVCeDdQUlkxZjVNUVhVNkdVcHp5NWxvcXVWUWQ3QlRLTUdSVUp5VDBX?=
 =?utf-8?B?Sm5oczN1eEtXTWZ3TlNVQlJ4dUJ0ckw0Qmc5N21xWTJSdnZDYWFRbTVBMEhH?=
 =?utf-8?B?S0hTMmQ3bldGai90N1lTU2tSMU1qY0FXeW5rTkVhVEJoL1JZRkd2WEJKYi9r?=
 =?utf-8?B?T1p5cHd3WnFEZng1LzBkU0JUNmpQSEI4d1BoSzl1RVNtNUNlNWhScXF5bzBl?=
 =?utf-8?B?dDdlZWlselREZkVmVFlEQjZzS0hEOTlnVlIreFBxc0ZkMXB0WVMwRFZjdGhT?=
 =?utf-8?B?cWJKOTlWRFoxZFlzdVRpSzhTeWJCcjZOWEw4OWtZRTNyYjZ6Zk5mczltR1ZT?=
 =?utf-8?B?RWZoZk80dEZsZVpaVnFIUVdzeWdDWmJCbGNocUk0QzgvNnkzWkpsY3BPQjQy?=
 =?utf-8?B?RTl3QWViZCt5eFJPWDRwNy9GMXdtNU9Gak1qVFU2Wk0zd1dqWnBEWXNqWnB5?=
 =?utf-8?B?U0xDbU50b2lFQTNXaTE2TGJwZ0V0QlRjZThmNjgzTmZFNW9jZDRBK0s0QUYy?=
 =?utf-8?B?T1Z4KzNySmRENXNOaDlpaW1reEpTcDJTa3NXSzB3eWpsaTNxWUQ5dkNCZkFh?=
 =?utf-8?B?TCttS2RySVJFcXFSY25uSjY5cEVrYUVaR2p2b2tGSzlTcVNjbGw2aTdlQ1hG?=
 =?utf-8?B?UUN5eWRmanU1a0ZoYW5wdzN2RHBLSTVZdE9YUVV3R2ZoU2JBMHVzYVAzR3ln?=
 =?utf-8?B?b3lRWmZUMklHeEgvSGNjM0hERWozUnFFNCtOZGZEQk9JZ1JzRnJXd1k0bVFq?=
 =?utf-8?B?aVpiYlEwWXRuR2xrRlFiY2cvYVZwV0RtS3lCazZBb3ZaSVVIV0c4N1NYNDdp?=
 =?utf-8?B?MlhIcVdoMG5uaFdWcmg2TEUxSkZBcUlpNFNyS0pnY2VhOVhwTXpFTm9leklU?=
 =?utf-8?B?SzNYM056TWw2eFRmS3Z1NXNsQzQ3TUJwSnVWQjRmV0lZSHFmTStvOXUydy9U?=
 =?utf-8?B?T2lXZkNJYzE3KzNIT2Q1VW5sWWJqNUxyWTVVZ0k3YzV0VUN2MERJUklsYVQv?=
 =?utf-8?B?N2FDU3IwSHFNc1hJNHFXdGo0Qm1Jd01GdkFDa2tpR1IwbU8xaHVEOFZIb05J?=
 =?utf-8?B?SlUxQlNDa1Y2QnpsbmVjOTFzamhEaklhdS9POWtYRnVnZmU3bHRkbUU1UDU5?=
 =?utf-8?B?Wm1DN0hKUDJRbVUrQVBoMDNFeUh0eWNYeHQ2c1VPU2JjMFBITDBDZnY0cWxR?=
 =?utf-8?B?VFRzM2d0UHZUaXNiVHRSbFZSYXNYdSswMExJY1VmS0xIR0QyUHFJUlpaWlBN?=
 =?utf-8?B?TEJaNWZKTDlFaEpzSkllbHBvb1Zld21PU095a0dwSG1HNmUzTk9La0prR1pQ?=
 =?utf-8?B?eVhhNXJ1WUhEbDQyN2NSSXNPb0R4ak9QUmYxeTFoZ3hEeHJKOURjeXZqZDdB?=
 =?utf-8?B?b1FPdzdYbFJDM0FkU3dubGIxWnl4TlBSR0I2NXZZT1ppd1VqcHNKVEV6Y0pm?=
 =?utf-8?B?WFBYaDFueFRZVUJFRzl2Y2lReW41N2doZVYyV3U3bkIyVG1SOWt0Y1VXVldJ?=
 =?utf-8?B?QVkvUWFWOXRIUm4zblhVMUd5Y3pJUWNscXRDL2lxendXQ01EaFFFbjEzSGY5?=
 =?utf-8?B?aUVaUU90cjhhdVdxR3JvK0VXcGZsUlVWM3hKUTN4ZW9oaEdleDFqcFFYSlcv?=
 =?utf-8?B?L3JrTjAvV2dBdTMrMXlNNEdZSEFWSmQ3aUxiNVJxUUdDcXVMK1N0eWtlN3JT?=
 =?utf-8?B?blNROU45bDJOR2V5L1V3MlREZTM2T3BYcjZ2dnhBRVJEaVpMK3ZQOXF1b0pR?=
 =?utf-8?B?U0Z3bGtIN0JRcjllZWo3L1NJMk95MllBeEVyZ2gyVFBBamp4dlhNTW9pMG9M?=
 =?utf-8?B?Ti9EeFM3ekV0NjJpNjFFSlJaM2xVZ3BwRy9aY1ZTQXYrZWZPdkpaNlY3SjBF?=
 =?utf-8?B?TTFoSkFoQ20rcUtMc3BBMW5xQk1rcFh3dWxudFh0a0IwNUVQMG9YZk9tV1Fo?=
 =?utf-8?B?bnE0K3dQY3BvQ0hDRU1TSWNjYTVpbmZGOSt1TmoxTVZLV29mSmZEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14119d58-10cb-405c-d830-08de8b9bfef3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 00:58:44.8731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TLqh/Fd6MQCLeSdISNy6iP7dlDpV5UiBfrEWEGyF00FjjFGWuuoLKHLzeZ65ezH0r0oKn1JbP4et+DrR7RFSQ==
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

On 3/23/26 01:32, Srinivasan Shanmugam wrote:
> In dc_dmub_srv_log_diagnostic_data() and
> dc_dmub_srv_enable_dpia_trace().
> 
> Both functions check:
> 
>    if (!dc_dmub_srv || !dc_dmub_srv->dmub)
> 
> and then call DC_LOG_ERROR() inside that block.
> 
> DC_LOG_ERROR() uses dc_dmub_srv->ctx internally. So if
> dc_dmub_srv is NULL, the logging itself can dereference a
> NULL pointer and cause a crash.
> 
> Fix this by splitting the checks.
> 
> First check if dc_dmub_srv is NULL and return immediately.
> Then check dc_dmub_srv->dmub and log the error only when
> dc_dmub_srv is valid.
> 
> Fixes the below:
> ../display/dc/dc_dmub_srv.c:962 dc_dmub_srv_log_diagnostic_data() error: we previously assumed 'dc_dmub_srv' could be null (see line 961)
> ../display/dc/dc_dmub_srv.c:1167 dc_dmub_srv_enable_dpia_trace() error: we previously assumed 'dc_dmub_srv' could be null (see line 1166)
> 
> Fixes: 2631ac1ac328 ("drm/amd/display: add DMUB registers to crash dump diagnostic data.")
> Fixes: 71ba6b577a35 ("drm/amd/display: Add interface to enable DPIA trace")
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index d6a08064456b..cab8fb4c56d0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -958,7 +958,10 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
>   {
>   	uint32_t i;
>   
> -	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
> +	if (!dc_dmub_srv)
> +		return;
> +
> +	if (!dc_dmub_srv->dmub) {
>   		DC_LOG_ERROR("%s: invalid parameters.", __func__);
>   		return;
>   	}
> @@ -1163,7 +1166,10 @@ void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
>   {
>   	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
>   
> -	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
> +	if (!dc_dmub_srv)
> +		return;
> +
> +	if (!dc_dmub_srv->dmub) {
>   		DC_LOG_ERROR("%s: invalid parameters.", __func__);
>   		return;
>   	}

