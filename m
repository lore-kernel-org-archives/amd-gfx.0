Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62AE10987B0
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E3710EB6B;
	Fri, 20 Mar 2026 16:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XHEP3CYj";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E8410EB86
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 16:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD+83aTn9f/7BWX2gc7au9UY8X7jp6EeRRIfQqMFLpCo0aOhAPfjStVpBSWOCtmLedqUQBd5X5ZR6uX+RJN3RaZ8oTTupJXoJySgayjG72Y8NyfX9BnbZH6b4PAczs7WvEniG8o5CLb+lhqLT7Ff0sXvKWGgLhKzGfDa+8fapotj3+JcFqqa2JzUYHb+rYzMdcdIn+T9JU3P7Geu3p9pSPu4njRwnYOIy3y+BJFPf4c/InrAp0UNhKKG3Y/NmcbbLDmI/JSMr9C6i7QjPpLXT3Dbsp6UG08i7H75rRkiIjVbMEbUbP9ZTTClScIor6I92HURtMhKAIMILcsHCws4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seBvZl2mXZhvYb98nnh4HCTP2nnYDdRxkLV3w0oUd3g=;
 b=EPzYe8cp0sQtBjZ3jG17DyQXqeswdm4hRd4JKJUAMr2af0Q8Tv6yqqRFDtH00IISBRNPD/txeAR5CkTyJM6cNcPCEFwenjMw7G/Ni2dAeMsQ8c0Vgu2SRgS/Nt72iNNNnbuHZ1ocn8sXcVc1A7PquzbFvA/PSttEHKS0gZP4v741Mh0SUhYKixDU8cNIp7XLcipLxRuz/Oi8Tv//vFHZHyFr+F7sewNEkPemZCAgQbHpqCij7RpNvPIRee2lRRECOKZWcp8xBq/LTrT5jU2JOVkhI33vmQSZgBAvMrLc4BkJbXE7pWdL070Mog4l47rih33QN9a0ohT0DRguwFz3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seBvZl2mXZhvYb98nnh4HCTP2nnYDdRxkLV3w0oUd3g=;
 b=XHEP3CYjUQ6CFwauu38ArfzcrKScMvRiMHWjPLjSttdoSQXRmPOjbzkKRYiFQ1yh/dpLhabiXDyRp6il9VkAkarQYRzXihf3wizmSziJjdLe8LAIvrk0TNc7DNbQlstJ4e2BNsODnYeiHISSZXwnlFO/7nOFoGGKUs/786L/CJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 16:41:58 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 16:41:58 +0000
Message-ID: <3a82cd93-6fe9-4efb-9e2b-84dc5f136dc7@amd.com>
Date: Fri, 20 Mar 2026 10:41:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add clk_mgr NULL checks in
 dcn32_initialize_min_clocks()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Jerry Zuo <jerry.zuo@amd.com>, Sun peng Li <sunpeng.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20260315144154.1935224-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260315144154.1935224-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::26) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 51243e88-c59e-403e-ed14-08de869f9a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: rlTxbaElVlWdhFXmxqdMefH6wkt4upjtv582wl8k582IdRv4gyi9v25DboRasQt5ai0HIz9zqUoI8/LnPAgwHMU7Mvzh5m7cGGHfjzSfbR9hW/0v/LPOJpDRNwSMRCHd1IsVQ85bWJSEur5XVQ2tqVcdnTXUyPCfpRld7Ow1BmmS3JlfEh7OhIWFv30WhA2LCRKh8qO/T4gXvO+V96r+upPl+ohw8dF56n87Dkj2y/pzYcvHYBZj7Ij1IB1PAiROBcc5nEtk1fyctFlh5/vf5t6OIeiy1V4UwUJF1wlZ9AnKTJ2y4+wby42UV1kYcPmxAlxIRH6B5dgTL8yAy1CB/EtqH6Y4mbXAewx/C3bk37HZTj8M0JpZLogKmq4V51gr7VrrhXh8JZFeNIU+g7sqWcRu6Nvc97moqqU6o5n+Ai13QOJ5RdhFLSPdUHEQmZejN/Uej39oU0d7vJDQvYzZLT581u8pSJRThdDXaCDYeqb7BFfhn1cL8/4NqZ1XRnTP5Mvp4ZbYlL4JY08jW65lXITJYx6qc6C96c54nGSaUKCfRGQ8Z66RU/pH0DCPO8onWDlY0YQxrnvSzv8HJrcDKDgFRWoiewAlKC5lZAA7SbuKHwjdh3kpsGR5oEvnuqsmaaA8Alh/kvBR/Y4Eie07C+SNVZfY0owkkqwBhoaZrPpK9LBSmtQAT1ozcHP5m+pOENkBLM98qlb5clQ2CMFmiUWT05U8//yF/ufqyrfeQ4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWpOazlvUlRjQVpjZ2k2eUxBdEIzZWpUQzBhZUI0Kzd6SDltU0J6Y0k2WEZ3?=
 =?utf-8?B?aGxKQkRXd2JRZGJ5OXVnak5hS2JaT3pydWtHazVQWXpvYzNHRjVxS1RKTEJw?=
 =?utf-8?B?UVNEeHROdDF1M3JNSUtJZGlPdEpkWlkrdW9SOHVEdldPZXlHaW9uY1kzZ0Fv?=
 =?utf-8?B?WVVqNXJxbHhrQVEwb3ZDcnkyc3hZaE4vM0srbnZVL2hDVlE3eWEyWHk0RHNq?=
 =?utf-8?B?NkZJbG1vQS9nVkEzc3NuL2U5TnFBZnloTis4cExBWUpaR2JFOU1GZUdzaVRZ?=
 =?utf-8?B?MnYwQ2Qwd1RKZktRUkdQaEI3c0ZCb0FMaTRWeHVSUlNZSFVMMUVlN0UwTEN3?=
 =?utf-8?B?SGVMSXY0bkxDVk9rd0tyOUcybklJb3I2bUpqaWZuaXpVdDMxQmc5bG9MZzNJ?=
 =?utf-8?B?MVlTbW9IckplRVY0VUNkNC9qL2V1MzdKbnVlS1VFMFZibkwyTnVVQ3d4Z1Q1?=
 =?utf-8?B?b3NDMTZmbUk4TnJnSFY2b1N2NmhVQmlMU2RFWnVOajZFZXRzRW01RXBwS1Fm?=
 =?utf-8?B?YTAzNXhLb2xwVTFydzZZcEdBeUVvMzVrQlFQSUZnTzRtcHNaaTVhME5pbS9m?=
 =?utf-8?B?QmpWZ3U2QzVDZFF0czI0YnpSWExndGZpOUNtdzVyWFExRUYyRmdPTjZRdkVl?=
 =?utf-8?B?SGhqdlFpQTZXVVZiYWt3c2x4S3VvOG1mRkQ0ZnBmWHo5cGRFMVdEd2NxQ3ZE?=
 =?utf-8?B?UG94UW5WOUZGZXYyM29DL3ZUUXdkTjIvTDM5aXB0VGl4a0Rwc050cHBkbHNM?=
 =?utf-8?B?Q3pXWUhabXFLMXlEMWxWaEhYdVNRZ2sraGQ0ajlrTEZQWFpJb21OZGZ6NDZk?=
 =?utf-8?B?K2FqQXhtUmRLUzdBeFJhRFo5dGtXQjQ2WTZQYzRkZ3JqeTRkSXNGcUo5MDU2?=
 =?utf-8?B?bGpvWjdKOTRYV25ScnhZanh0YWo3RFh1VlQ0V0IxVFkxT0FocEV3dVhVNmpP?=
 =?utf-8?B?Y2pxMmV1SFdaV1h6L2YwcVpjek9hVDBRZkJQWFU2Skt4b3VDbzRKak5xTUtP?=
 =?utf-8?B?U3U5Smk5cFphUk9Pa0JjS1FLekN2Qmg0end0RTVRcWEzTWNBeEFOdlRGTmU1?=
 =?utf-8?B?YjA4ZklDZUFXcmFRUHRERERrekRieWw3NWtQKzk0ZDJURERrTjVUWTNlR1dk?=
 =?utf-8?B?N1ZpR3lnZjM2M1NmK0VISjZYUUg2SlZxZ3A2MGFmNzA5VVFxUHZEbUpXWEs2?=
 =?utf-8?B?ZUs3UHovRkpIS04yZWRXZlNqaG1JelViakozODFwUy9JSExBV0E2V3phQzdP?=
 =?utf-8?B?Nm1jWUIvN3dhbWxUWmZOa3VTUUlGYnhmKzNudUhsNmZyQmlyMFpWays4OGI4?=
 =?utf-8?B?ZjU5VXhJMVkwQ1FtaVVBVmJueFZrT093UFVwYkFCdzJNKzJmdW90N2NVWWI4?=
 =?utf-8?B?RzhNeE5nYVBVeGIyeWNPL3FiaXNPSGxHZmFNbFlWcHRLU3FZVCtXbVNPbCsx?=
 =?utf-8?B?ZG1BN0g2RllMeVl2dzIxODQ1TDVFNzEvUi9ocktvV1U3d0hWMnVRc2NkVTNB?=
 =?utf-8?B?b2pyU2NteDIxZzgyS1VzZ0FBeVprWjg1cFBoeDdFL3pRaWNQOFkwNVFIb1V4?=
 =?utf-8?B?SnFoNHBVNndhYWtURzdNbEVSWW9JVGVlU1VTRE05dG5qcHQwRVdNNWx0TXJv?=
 =?utf-8?B?amNHeGNNSE5acEFXa2wxNDZITi81S1pnTkNnLzZFR041cHBtU2tKTlJlMGl4?=
 =?utf-8?B?MHZmdlFxaXc5UnBYdGZsdmhvSjdmYW9sOVJtZk9KZ3FEMEplL2ROS0dndTNL?=
 =?utf-8?B?NzR6d0dQS1I5ZWp5amJhaXNjbjhCRDdSK0c5T3h3V2NIWTNhUlhJaUFsOEd6?=
 =?utf-8?B?RXdkSDdEWjVpMlNKNExPUjV3S1A3TXlmeU42ZVREL1h1YUs4NVU0VTBXdzhq?=
 =?utf-8?B?UGpNeWUwTnZIcGF1ek5BVXpNOXBMME80bXhab2VWWmJ2dVNYT0wzcnlodEZE?=
 =?utf-8?B?UlBJc0hlR0xkdW9EQU9VYVdGU1gzYk13VmdURGE2aUR1a0dTYUo5Mm1pbXgy?=
 =?utf-8?B?VlhlY25wc0MvL2tvR1IxcVVGYjkzbUUwemRlK2tzdG1UbGVLOWRNUUdDZTQz?=
 =?utf-8?B?ejlMSWJ5ZUs1SHNrSHBsS3NFRTE2cFdVWTgxWjNsVU5WZy9GcmVpem94enR3?=
 =?utf-8?B?MjhRNVVFSG5uWXdUVWs3RFNGM3lvbjlaY0JBZFFTbG9jajlEMGVVWWdpU3Vp?=
 =?utf-8?B?amZoajN3THpGRDBJV29pMC9qOVJ6WVFWYUtSNzloK1VDakFhZjlTNTlmdERO?=
 =?utf-8?B?aFdEZzNEOXlUdWJFZi9GNzQrSjBiRU9FRHlOenVjMzJUeVZoVW1yWk54bVlT?=
 =?utf-8?B?OE9UZXFoL3lSVlRsYjE4eThZTnRRM0NTS2xxUEVyd1VaMGNTRGxVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51243e88-c59e-403e-ed14-08de869f9a89
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:41:58.5887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtsrH80FpF7w42ViJ/5kMxuquXnBWlFPezHg94XZaNtYi4yVHZkqep0upCqkaqDF2JYaXmlEiuhTtON7AvPWEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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

On 3/15/26 08:41, Srinivasan Shanmugam wrote:
> dcn32_init_hw() checks dc->clk_mgr before calling init_clocks(), so the
> clock manager is not treated as unconditionally present on this path.
> However, dcn32_initialize_min_clocks() later dereferences dc->clk_mgr,
> bw_params, and clk_mgr callbacks without validating them.
> 
> Add the required guards in dcn32_initialize_min_clocks() before
> accessing clk_mgr-dependent state, and check callback presence before
> calling get_dispclk_from_dentist() and update_clocks().
> 
> Also guard the later update_bw_bounding_box() call in the FAMS2-disabled
> path since it also dereferences dc->clk_mgr->bw_params.
> 
> This keeps clk_mgr handling consistent in the DCN32 HW init flow and
> avoids possible NULL pointer dereferences reported by Smatch.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:1012 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 978)
> 
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Jerry Zuo <jerry.zuo@amd.com>
> Cc: Sun peng Li <sunpeng.li@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index a0aaa727e9fa..e5d93dd348dd 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -757,6 +757,9 @@ static void dcn32_initialize_min_clocks(struct dc *dc)
>   {
>   	struct dc_clocks *clocks = &dc->current_state->bw_ctx.bw.dcn.clk;
>   
> +	if (!dc->clk_mgr || !dc->clk_mgr->bw_params || !dc->clk_mgr->funcs)
> +		return;
> +
>   	clocks->dcfclk_deep_sleep_khz = DCN3_2_DCFCLK_DS_INIT_KHZ;
>   	clocks->dcfclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz * 1000;
>   	clocks->socclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].socclk_mhz * 1000;
> @@ -765,9 +768,10 @@ static void dcn32_initialize_min_clocks(struct dc *dc)
>   	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
>   	clocks->fclk_p_state_change_support = true;
>   	clocks->p_state_change_support = true;
> +
>   	if (dc->debug.disable_boot_optimizations) {
>   		clocks->dispclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz * 1000;
> -	} else {
> +	} else if (dc->clk_mgr->funcs->get_dispclk_from_dentist) {
>   		/* Even though DPG_EN = 1 for the connected display, it still requires the
>   		 * correct timing so we cannot set DISPCLK to min freq or it could cause
>   		 * audio corruption. Read current DISPCLK from DENTIST and request the same
> @@ -776,10 +780,10 @@ static void dcn32_initialize_min_clocks(struct dc *dc)
>   		clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
>   	}
>   
> -	dc->clk_mgr->funcs->update_clocks(
> -			dc->clk_mgr,
> -			dc->current_state,
> -			true);
> +	if (dc->clk_mgr->funcs->update_clocks)
> +		dc->clk_mgr->funcs->update_clocks(dc->clk_mgr,
> +						  dc->current_state,
> +						  true);
>   }
>   
>   void dcn32_init_hw(struct dc *dc)
> @@ -1007,7 +1011,8 @@ void dcn32_init_hw(struct dc *dc)
>   				DMUB_FW_VERSION(7, 0, 35)) {
>   			/* FAMS2 is disabled */
>   			dc->debug.fams2_config.bits.enable = false;
> -			if (dc->debug.using_dml2 && dc->res_pool->funcs->update_bw_bounding_box) {
> +			if (dc->debug.using_dml2 && dc->res_pool->funcs->update_bw_bounding_box &&
> +			    dc->clk_mgr && dc->clk_mgr->bw_params) {
>   				/* update bounding box if FAMS2 disabled */
>   				dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
>   			}

