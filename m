Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD70EFCBBB
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 07:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D1610E243;
	Mon, 16 Mar 2026 07:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2BNMyF5l";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A4A10E243
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 07:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+AFEmjLaoVWge4GGuaLruO5mRXo4FNcG06VDrZ0BwvPWbdY1lkHqGKcX1c4qslV1+vrBXEvpdfRV7I5p6DAFvtzJWAY3E6VwPHM9qVzTAIYdmtN6dxMw/4hBfVnNVTDAlfV0Dzi983Qg+HcEAZ/3l0cC+FopahjmSoCdzD2Puh7v0FS96dQh9UKVHkudjItG8JBoHxVwJmAvAxc7T7ZzokN/3h/qrWi/gbeaEVKjLuirQLNu8E/VHv48ewdXf3fvVrSjAC5e3H+uREkG8WCIR3Rhs3AFG8RznQasg/VwIscAhI0pslU2+Wn0z96LzfkbmE3H2Q1gS9l3GE/t9IZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWeG1xRIukUdCkodnW5SPISehLqs/KdjnX9Jrl1pw1E=;
 b=eU7nlTv6//rKajywzrv9CpWSptG0oYxK3ropWr05R7pszx7UEOYYFf2qrZAsbgBqNcscEaUofH/ypOwd+3oPX9rvfiNoPQ2fv5QIrDVFoDJFTcb0y0aMaZGkY5KFUW+kpJ8ACeWoBPI+2MC+zOBo759BKTj9thxI0yT5nIqYObooQ5eaosetg/fqBJz0QT5LAR0cl6N31/+uEO5prEBCgWNYBUtU6ko++/AapGZJmyBvzsokzYpkeIIa8TdNWBZnaTC1Esj1LU7rbCctIVmgNPLFNyYrNCaenw2FKO6bfrjWhMehovny2acsGQkeqLpWph4kwFOTOWUr7tYifTJP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWeG1xRIukUdCkodnW5SPISehLqs/KdjnX9Jrl1pw1E=;
 b=2BNMyF5lIYbWiNq1uoqAL10YEZDVADwEEaHoecYmrDgdTUD6r5Fzffu2Flh9tw/nuvPWbv4RtDlcqOTj3tDKz8ITurRhPgM/bl/rwBwShNopxJ0uPFB8PgqQb1aH4kC3ZWetNLLN/gB7UulZR/nZpV7xDhJKkOVHDEMHEUjji0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 07:08:00 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 07:08:00 +0000
Message-ID: <d9bb1d08-27ba-434b-a584-8decc2aa5ad6@amd.com>
Date: Mon, 16 Mar 2026 12:37:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/ras: Fix NULL deref in
 ras_core_get_utc_second_timestamp()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, YiPeng Chai <YiPeng.Chai@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
References: <20260315062559.1931470-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260315062559.1931470-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0174.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 77acb782-828f-4ec7-f4d2-08de832ab989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: akdtaSnwhcAry90hqIVmDv7CyA6stlOgl5fQloPQAbbg7dI7ix7sqCQkGHcShbCFUYjX4OR3scYAjeAmOUHomILa1iDSDDJ6zZA/l+/TGxVSX8X9wnA1igqh12DlhtVrjGhWJupKFCp9gDt/Q9u5ow5oup8iK/tT1HSg8mqDCvIjjWrxm6e0aF47yUUiuBKxHuYgKa+dxszTUWZfhwlOOsNKlQ+rRKJS76ao3mcuztEaqnOb2Nj1SPGWYqAbtaviu5Z3S03vG2wPt+KA7CCEFyR9nsHRbndjpwAOeaXGu7orW2AN73r7kupmYzYqhxlERfKy97HzGMXEGseJR07/J4gVh6GEOG5f1VfvlELGdBoOg9Pzw6W3brS81MkZNHN4FwV8IxUmiPUEf81A6g4mS1mII2/v+T8cC/J6ElCeZ9a1LyOaA+XcTFmz1l5Z6u++jcQcc4Aq8G8PyI/NdzLZL9Kn+k4SoIGGUzgPmOPrvA8POSDzNIrb/Iq/6go5NwS/t8kY8FSkdIH30l1iwLeAWnMn7+HVaemHdWMhtaIId3GFUGf+hrZCEwp4TzfgE/2Jywa+LDcauzkYFN/nBL49T7N0zM/ItE10a5gx19caZ9F32hZVrrRoIhLDUvZEHjS92vhZxhr6gS6ASJt1E+tCS6q8b0KbDF5WVMQRFlTFOgTomVPj6W+QDSi108xbdzLx7yJAKSxnfhNJXdRFwgA9dZ/fW9jIBn7FP9utN1y8dbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d05WeWFlN2kxVGR6UnAzNCtQSXhEMCt5WkxRK3VqZTZMQktuWmo0RlIvZzQ0?=
 =?utf-8?B?alBIRlpGdkFQOHB4WlZxMmtBL3FXc2x5Z3h4QjhzYUE0U3Z4R1paUDA3bUJC?=
 =?utf-8?B?dlhOQS9Qb3h2emxSbDEwaStSRWVYNHRaZWpjL1FiVVZHbUdEaXhNT1dnSkVi?=
 =?utf-8?B?eTBRVVNPV29XaVhaaHQrZW9LT1lzYlBLblJrdUVCdk50SmJlYXZhRVYza1h1?=
 =?utf-8?B?eWRyMmswZzg3UHpxZWJoTVU0Sk5GT0MyTytWRXlEeFdNTkYyeHRjc3pHM0hS?=
 =?utf-8?B?TnBQQTdJVmFMLzFwYXVCeThZNWkvLzR3U0IzbURlV0FnTzk1aUZJTGcrOVRS?=
 =?utf-8?B?V05HOG9uTENiSzlQUGtkZDFLN1l3Q2YxckF1NjdIRFhHbE5YUE0wOEVIK3pT?=
 =?utf-8?B?WGFJT1pOQXlMb0FjQUtIVEg0RW53d2hvQjlSMHNPbDA4Y1JXRG5rZHhVMmtk?=
 =?utf-8?B?blpRNGd5bTBJS2FkUE5iT2R3UmZyc2F6eFRqOVV2ZVQ4OXdFWkFEU293VC9K?=
 =?utf-8?B?Y0JGK0ZvckZOR0hFMmZNVWdrZHZubjNyYXh6d3d3REdlQ1REM1VzNlhJbXhy?=
 =?utf-8?B?NXVMOCtGUEdRNXVjekdlVUxnS2hZUHdTN1VxVmlzVjlmODN1S21BdHZBR3ZR?=
 =?utf-8?B?N1V5b1g0WExGWU5QSit2NHZJQU5BMWJEdDZLRXJTUWRCdjVmbVpqRFIxdnV0?=
 =?utf-8?B?SjlOcFdNRmtxcG9oUktvSklQNG03UDZrcWFmNXhWVTd0V05CTk1aQm1ZQy9J?=
 =?utf-8?B?c0RFM2p2NXBndjF0UTAxbERnSm9XbHZUdmtZN0V2c1R1bEkza1QvZHZQSCtQ?=
 =?utf-8?B?c3dkUEdmMktXbHIwQk5EVXFLTTRlNXk2NkxWQTNBZDNCNjFQWmRYNE9GVkor?=
 =?utf-8?B?emFLK2RUYXV0OHUyb1d6TllzWXJVSmt2d21nVS9ubUFIbm1haFd4a0tHTHVk?=
 =?utf-8?B?SnFYYkRiMTNqZTdGVTlxZkJ5aU9IdlpCOTFJSFBqTEVBcEhrUmRReWxXOUJy?=
 =?utf-8?B?Y0pJU0svbFV4NU95UDVTWW1PRzlxWHRPTzd5NUg5Nm9QR3p6L0RoaHNzeU9q?=
 =?utf-8?B?dG5QL2FOVWRjc2l0b3YveGpQK2lLQ1krSHd1OXB0azdsQ0xJODhVNVJUMHUz?=
 =?utf-8?B?bEFYcUZNcHdKL2paM3pDdmlNNERsNzNhZXVnZGNZYmRiUUpvOXdIYldLR0tJ?=
 =?utf-8?B?OXhBaEpJZXoyT3oyb2FWdkpPWU5zTm1FaFlqSldkbW5TRVNRN0FnUDQwb08v?=
 =?utf-8?B?OGFOZU15MG9SVDluS29HZ05XOWlsRWc1aEJXS3JMMGpaZnRLOTV3WWhvZ1pj?=
 =?utf-8?B?a1V0WXJ2MUZkSWM2MklGUFM1ZVZaRDR1Y1puZlVQUUQ3YWpVbVk2bDJYaTZX?=
 =?utf-8?B?c1Zib2M4aXI2L2lFamZrUncyZXU2UFVJcHZrS2lrZXpvZm80TjhZWmtMdzBM?=
 =?utf-8?B?eXM5dGVJVzRCWDVET0RYYmRKRStBdVZxbm4zOFNEbHJBNWdsU290RkxyZ1Q5?=
 =?utf-8?B?elFjeFE4TXRxV29MWStHZG5LaUt3Nyt6dkE5VmxIN2d6VGNBZmh3OUM3MW4w?=
 =?utf-8?B?dmlGRXlEcjN2VXVOTUpFdjUvSGhnRG1KTVU3VmVFaWljK1ZBNTIwUTk2YWdX?=
 =?utf-8?B?TVdUQ1BKZktMK0xHVGZVMVRDclE1dVNzMER4OUVFT3pOdVVzb2swclFlWmVP?=
 =?utf-8?B?MzRKVGFJSzJ0SWluSGdTalFxTFlwNHNieVpYc0xGYjRHUmNrRGFMUzQ5NUVu?=
 =?utf-8?B?Sm5KdDhteVJQWWFGMTg1QVlpa1NCVWxtWDBIemNwT05FM0xjOUQ3bktVSkZu?=
 =?utf-8?B?WmV3OUQ4SzdYZUc0MHc2RG03UHZKUWdBZUl0Q201ZWJNakY0bUtYS2RvRTly?=
 =?utf-8?B?dHRpaDBHandqdFV3Q08vc29PWGJJZlp4emNUNDg1ckZHT2FDNkhFTGF5a0NE?=
 =?utf-8?B?RnhCUktWUkpXRVl2SDRyd0ZZUVhBZUs0S01GQ2tDZjNXSmNkY2c3T0dOSXp0?=
 =?utf-8?B?ZENBTVFoelpINmgwejhnQ1hOcFNZQzZCTnZSclRHNldERm10NmhUc1RadkRp?=
 =?utf-8?B?TlZpdGR4Zm5yb3FYdWpQek52cU56UGpCZDBUZm50MlcwK1F5Ylh6UVVRYVkz?=
 =?utf-8?B?a1NkWldBbDNFMzdaQUN2K09DWUtKdVNQTUNzdE00dmZ4cWhiRnpZNEM4d0N1?=
 =?utf-8?B?UGNsc2s3dngvMkRjdnlyM2h4ajc4WTlSQkRKeWFoN21GbjlhMlB5Z3Z3bFpE?=
 =?utf-8?B?OGZJWXl5SWxsV3dGRk1DSHZoWm1NL0xEb3YvZEFhUk1kNTd1bXNDbkJrTllz?=
 =?utf-8?B?SXF2dXcvVHBRQ3NGcVpqMVIweUhVbzZoT1htT1o2UXBWSFh4NkdEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77acb782-828f-4ec7-f4d2-08de832ab989
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 07:08:00.6081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wK3Elygiu/5KwizcvI7qgxNbanbFTSrWqry+5o+1QdhYnsDH0MgKMfPcYQ255azx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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



On 15-Mar-26 11:55 AM, Srinivasan Shanmugam wrote:
> ras_core_get_utc_second_timestamp() retrieves the current UTC timestamp
> (in seconds since the Unix epoch) through a platform-specific RAS system
> callback and is used for timestamping RAS error events.
> 
> The function checks ras_core in the conditional statement before calling
> the sys_fn callback. However, when the condition fails, the function
> prints an error message using ras_core->dev.
> 
> If ras_core is NULL, this can lead to a potential NULL pointer
> dereference when accessing ras_core->dev.
> 
> Add an early NULL check for ras_core at the beginning of the function
> and return 0 when the pointer is not valid. This prevents the
> dereference and makes the control flow clearer.
> 
> Fixes: 13c91b5b4378 ("drm/amd/ras: Add rascore unified interface function")
> Cc: YiPeng Chai <YiPeng.Chai@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/ras/rascore/ras_core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 10cd398d4ae2..844720e4a275 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -527,6 +527,9 @@ bool ras_core_is_enabled(struct ras_core_context *ras_core)
>   
>   uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_core)
>   {
> +	if (!ras_core)
> +		return 0;
> +
>   	if (ras_core && ras_core->sys_fn &&

This ras_core check is redundant now.

Thanks,
Lijo

>   		ras_core->sys_fn->get_utc_second_timestamp)
>   		return ras_core->sys_fn->get_utc_second_timestamp(ras_core);

