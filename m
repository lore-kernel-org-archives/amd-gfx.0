Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4BB103E163
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 11:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A8910E7C6;
	Wed, 18 Mar 2026 11:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gie+yUS2";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235B110E7C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 11:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWAGHg7wDhS9bYoDU7xjCxCVz/CgL1mbFb62bGbae4VKdsXpXW6N80HelFraKTKPyg9lF0kqjuLZXTYzSNlk6PPz9tGmoBBuo+oz9psLU1Ru8tCPSELv2HcOipsnbxZEXsvud+hBrepZL0XRHyE/GscHHxVAiYjK1j9dw36y9kKaQnhmLg0WVaSf+Sw/ZQej0AbE6ftjVVpNLKhWJTa3T4xwyqJDTn2rT+vGrKSq7hLwcNw+USCaZXHXp5D6wRUs4i1pzIvyibsdW1u4r8SM5Rt4vFfW6mfydTjvSCbT3NWVZwuUo9i4fyc+2w+ZfhF+chyMaIn0GGWa5DH9hrCHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7loHEmAz8TI4OSUh3YwPsOzgHHSNCZsIpIZ6NqCseE=;
 b=Gsr14dFMs4f4yX7dDkLqW/rVLgDUF+tUETgVhqyh0hJOMQI3mw70vqYTXX7Yh77Hvh0+q8YQnS5i08h6DaQBhH1qqwDCmFTWQOeZnACdpOzz/XORENFbgxpw09i6niODA0Big2GNCFWdiJH2ZUvNsjjS73MWDkkg1QSWhZGZ0rvobQvR7FhKcy0aRWGKS3cFr5yHY04nbyiOZboo0R/kkEyDgVZ/EwHzU8T0hAOSm/xhHrM0s9DozhaMoMVkqJwvIbXNROePJNaslTgjC/F0JKJMzGY9MnlebAAx3dVPV4UuwhRt24uhxThDEZ8DiPx0Vj+LWG2GoplZgA7U9b+tYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7loHEmAz8TI4OSUh3YwPsOzgHHSNCZsIpIZ6NqCseE=;
 b=gie+yUS2zfNwzYo820a28zbJ+ExBOLPOw+iJEcIGMFGZdo5MRBl1UyaNFdc6WqPAeQdf4gFuuRqzQujNp1Ufr4wxJJoaQWT+0OKN/BFltzhaqyl2YkbisoSGSSMWwQaFqmMrZ/7rk7ApF5kWX4XWQMmzw1vkgZNBwdxVFcgWLBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 11:00:24 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:00:23 +0000
Message-ID: <32ac1923-c3ec-4c4e-81c2-60e5fef7551e@amd.com>
Date: Wed, 18 Mar 2026 16:30:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/amd/pm: Add OD_FCLK interface
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260318103906.3107670-1-asad.kamal@amd.com>
 <20260318103906.3107670-3-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260318103906.3107670-3-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: e4770877-0278-4e01-88fe-08de84dd8daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: PDh1iSFMky8x2zoxhgthoP0mWyKJadys8GI4wrHzEXh8q0+hQIGEE+g6UytFNTfbrETM42C7J6Idpy/zpLM5yv6YiIResx0cUzDKmeP1h4K/2MAE9GUGWlDNkiekwBP4bnKzQbGixKnfsthSGTSMEaEAN+JeOt8CkIxRIHvdxpKqu9e5q58UCdgMxHNKFxVYHCiKOKrrwgtn8Uw5cDQ42ikd5TOnOo2EwkbmGJQ4lM1hZaFt1Zh91aibuIMkFqV9ina8SVTDievTc+vfyVVzY7e8y+JvCGW7H+v04XCdWjaPlVR0Fd90iBQp9a2OyMwyZmlWjahcY8pqu1Yq6H9N+M/MhB4ybwUDvDtPSGh/OHvKOtVuxMLWuv+OTSMMURLV2wfMaMRdG2fERM/HILmg/hrt57/rign3kQJoRNVbvgycODVZg0ieSybpm4BlETUKLdUNw2V85p0Q1knDiDughPqmRIWRTa9MXjm9kdIkMh/ZBsnjImtIfFG7LqC/ob9e5xtAOSK5Qo6rmeVmP1iGkOI+58Q+PRxfEU6Yai0aaIhNZmf+CHV5LBjayQBAVFzPp2cYiRcmEu3XeXZ0uxJ5VLtcMaAPCNCb+va+guavDles0T0+b4aNrOq5xeHSo0JILGk9afqrNVrUYnc0XRQ0d/LGs2nivwcrAMG7CbzoFI35btK3SFH+IgIOXviV8RQTq5J73AW4sS4J/be4ykocd6FgsBGEIQ582lVp3KgiOcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmNOVUQwNVZwNjNIdGdWeFlyTDFjdVpFajRNdjNma1FEVDZFOFVvWHNra2xQ?=
 =?utf-8?B?QTNoODZqamdDa084eUtYcVViYy9lWGw0Z0NmZ1ZOS2Q3MThqbERDTmorRjh6?=
 =?utf-8?B?aVhjaDVlZVJtb3BNUmFsdjVvQnV3UTMzbS9wVTROUVdQWG52ZFlSem5VL25r?=
 =?utf-8?B?YzVKMW5QTG9CWjduUnVZc0c5UXFGeXE4eXpycmsrNGtLaHlsMXBMRnpvNUFT?=
 =?utf-8?B?SVE5N1d4dndzZDVCRG5iUFNzRHYwS1dWWk1MNGRROVhHaHI3dklCaDhjbGk4?=
 =?utf-8?B?UHlidnY2TG8zYXZpcUV1VHJncTJ3NEowNnQ2bEtscG9DRGQ4R0JaSjBQeEMx?=
 =?utf-8?B?amIvSWI2TmFndkY3TmoxRnBKMU9SWDNhdCtmNUdPalBXb3lLc3hUR3hmN0FM?=
 =?utf-8?B?cGprdnlJQnM4RTIzY0t5UFliMm4yVUJwVENSOFhDcEZrRDBkUW5yZ21qKy9t?=
 =?utf-8?B?OUk5UUtncldoZUl4SXhHZHBLNTRvdi9EOTNBT1F6MTc2QjFiQVlacFc3Z0wr?=
 =?utf-8?B?Y2hsSGhIMlNsNVllQVoxc3k2T0VUMFhnUTY5ME84NGx5aXQwSUJHc3pod0hD?=
 =?utf-8?B?bzZqRWdXTVlMYnQ0RmlCcDVMbTQrMUVqZGUwTGpBSTRNOWcvelBxbUJWUzhN?=
 =?utf-8?B?WWlXVzJieVJBOUl0bTY0NUF5R3hkOE5YdnJyZUJic0d2YXpOQlp6MllwODRv?=
 =?utf-8?B?Q0oxWG8vQjAzcWV6T01IbU1DUFZsaHVVb2xFTnYzVzJQMWFNbjlCQlNzdEVS?=
 =?utf-8?B?T3pZNktRRm9ONExhR3l0dm43QjNBcmdOcUc1c1BiUmw3WkMva0RvejZadDNz?=
 =?utf-8?B?cG9wMFRLR2RxZVJJRWNrbm8vUElqYzYrRXk3bUwyeE5wR1pRWEp3R2VZcmtK?=
 =?utf-8?B?WlVYSUs1R293UTI3ZHdTdGdmemc2UVUrWWtPOG1wRW04NWd0MGhWdTVHblR1?=
 =?utf-8?B?engrVWtJNzllWlZwbFYzUlZ6VjljWmI4SDJhVnNIUVBEb2Vaa2s2Snkxcjlv?=
 =?utf-8?B?RUxjVHR4dmVUS1hPQ3B3ckY2T0RRb09FK3ZnRHZxdStZTzZkVkQrd3RJTUdV?=
 =?utf-8?B?SUhTRHlKbkhHc01GaFpVZWZXNHh5SzU3eHltTEc1MmxrOVM2bXVZVHc0UDMr?=
 =?utf-8?B?a1BCUkN0M09KV2o1QXhXVjg5RXE0d3FaQjBPYTFNeU0vRHljYlFocmI1aVBU?=
 =?utf-8?B?QWpCQTVXaS9PTnoxMlVpVHU1WXdudFF1SUMrUUhlMFlxNXNlUitYYjc3cmVL?=
 =?utf-8?B?S2tPM3ZEektGbnZlZDBpNCt1Y0NDSHczVFUyWklrYmx3dWpvZ1huY0IvcS9a?=
 =?utf-8?B?TGdrUFM2MDZYNnR6eHQ4b3NmVktKT0VHdHlpanVKZEJmakpDaUt6UzZKVC9l?=
 =?utf-8?B?Zk1kblZWaG9JYWlWNTVZam9SMEp2RWxXdmJBbDIwOXM0Nm1DTjdnblViTzVC?=
 =?utf-8?B?dm03aUZMSXk3c3Q2ZU40R2VaVFAvL21OZ2ErZCtnWldzV0ovdXlUUWM4Z2p5?=
 =?utf-8?B?SmpSbGZsRmI5TXIxbEoyMVRiMGxyTURaL25QcnJKWVZUTlhkK0VPZW80QXNJ?=
 =?utf-8?B?NUVwUGY5QWd1SU9EcjR2OFNCQUtJMUJ5LzZjaFpjdXdMbENTOTRrbUUwUHJZ?=
 =?utf-8?B?SDZYV1dLS0pEMXQ3UUlkcllJSEtkT096YnBmU3hrK2ZlODIrRHJXTW1yU1NX?=
 =?utf-8?B?Wmx3K1l6ZEhWQkgzTGtpQTNiTVBSQ3pEVTBkb0VZQjJZcitXcVN3L2VTV2VC?=
 =?utf-8?B?YjkvYnM5Y3FCZmx1VnJBSmYrVWVqOTh1angzSW9hMGFhQTJPWFI2VlQ0b1Bl?=
 =?utf-8?B?MXhPdjNEVkFVanlrczNCZ0hUZjFielFKbGhXekl1MENvdk1iUkRJTUZuUFJL?=
 =?utf-8?B?a29JZ0dJYmNhcDJLc3BRYUxsQlJFcEJWOWtjODdiK3RVYXQ4YThCdmJ1emtT?=
 =?utf-8?B?RTBNNklSQ0tiT1FBWjh1WjBjRUVFVmF1OVROOWNXSUNESU15bVVlK0NxeDZ4?=
 =?utf-8?B?SHpuTjI3bjZGSUFHWUlmUXh6SkM0T0VRL0QwZEN5ejJCWDZaVWlEWlJjaCs4?=
 =?utf-8?B?V2lNYmFPRUtjd1RLTWMrbWZtYU9PeTY5MlBHQmNiZXRuRVNPNC9oTVhQMVRt?=
 =?utf-8?B?NGYxcnBZRU5HVER2RndDNXhLRTJ6dDhxZ2VQdjVXRUxFQ3RYSG5oOHpBZk5X?=
 =?utf-8?B?bWl1dnhUaXhsTlZpb3dMdXdKaHdwRWF4eVp5TzV0Y0drWmJlVU13dlVsUks3?=
 =?utf-8?B?WDJiNlpYV2E0OHVZRlZhQU9jeENpR0hsZ2V5N3Z0dk1xY3NhQlQ3MXpLYWNQ?=
 =?utf-8?B?cGZjMDYwbm44cVpvUzR4Z1NsTVRjZGhKWE5CNW9maGF6VWJLbTBJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4770877-0278-4e01-88fe-08de84dd8daf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:00:23.8528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/l+TRcjaGkAn16tktxeW1unauHdOZWWHmjWTPwgEBpgblhc2nFPjdDIWIwdmKT1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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



On 18-Mar-26 4:09 PM, Asad Kamal wrote:
> Add OD_FCLK interface to set customa fclk max
> 
> v2: Merge patch1 & 3, check EOPNOTSUPP for all clks (Lijo)
> 
> v3: Remove redundant check (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/include/kgd_pp_interface.h |  2 ++
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 18 +++++++++++-------
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  2 ++
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h   |  1 +
>   4 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index a9b73f4fd466..33a1404bb666 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -119,6 +119,7 @@ enum pp_clock_type {
>   	PP_ISPXCLK,
>   	OD_SCLK,
>   	OD_MCLK,
> +	OD_FCLK,
>   	OD_VDDC_CURVE,
>   	OD_RANGE,
>   	OD_VDDGFX_OFFSET,
> @@ -208,6 +209,7 @@ enum {
>   enum PP_OD_DPM_TABLE_COMMAND {
>   	PP_OD_EDIT_SCLK_VDDC_TABLE,
>   	PP_OD_EDIT_MCLK_VDDC_TABLE,
> +	PP_OD_EDIT_FCLK_TABLE,
>   	PP_OD_EDIT_CCLK_VDDC_TABLE,
>   	PP_OD_EDIT_VDDC_CURVE,
>   	PP_OD_RESTORE_DEFAULT_TABLE,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 938361ecae05..01ff24880fe2 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -680,6 +680,8 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>    * - minimum(not available for Vega20 and Navi1x) and maximum memory
>    *   clock labeled OD_MCLK
>    *
> + * - minimum and maximum fabric clock labeled OD_FCLK (SMU13)
> + *
>    * - three <frequency, voltage> points labeled OD_VDDC_CURVE.
>    *   They can be used to calibrate the sclk voltage curve. This is
>    *   available for Vega20 and NV1X.
> @@ -715,10 +717,11 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>    * - First select manual using power_dpm_force_performance_level
>    *
>    * - For clock frequency setting, enter a new value by writing a
> - *   string that contains "s/m index clock" to the file. The index
> + *   string that contains "s/m/f index clock" to the file. The index
>    *   should be 0 if to set minimum clock. And 1 if to set maximum
>    *   clock. E.g., "s 0 500" will update minimum sclk to be 500 MHz.
> - *   "m 1 800" will update maximum mclk to be 800Mhz. For core
> + *   "m 1 800" will update maximum mclk to be 800Mhz. "f 1 1600" will
> + *   update maximum fabric clock to be 1600Mhz. For core
>    *   clocks on VanGogh, the string contains "p core index clock".
>    *   E.g., "p 2 0 800" would set the minimum core clock on core
>    *   2 to 800Mhz.
> @@ -768,6 +771,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>   		type = PP_OD_EDIT_CCLK_VDDC_TABLE;
>   	else if (*buf == 'm')
>   		type = PP_OD_EDIT_MCLK_VDDC_TABLE;
> +	else if (*buf == 'f')
> +		type = PP_OD_EDIT_FCLK_TABLE;
>   	else if (*buf == 'r')
>   		type = PP_OD_RESTORE_DEFAULT_TABLE;
>   	else if (*buf == 'c')
> @@ -843,9 +848,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	int size = 0;
>   	int ret;
> -	enum pp_clock_type od_clocks[6] = {
> +	enum pp_clock_type od_clocks[] = {
>   		OD_SCLK,
>   		OD_MCLK,
> +		OD_FCLK,
>   		OD_VDDC_CURVE,
>   		OD_RANGE,
>   		OD_VDDGFX_OFFSET,
> @@ -857,10 +863,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>   	if (ret)
>   		return ret;
>   
> -	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
> -		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
> -		if (ret)
> -			break;
> +	for (clk_index = 0 ; clk_index < ARRAY_SIZE(od_clocks) ; clk_index++) {
> +		amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
>   	}
>   
>   	if (size == 0)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 3dc917194154..a2bc1c753e0e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3056,6 +3056,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
>   		clk_type = SMU_OD_SCLK; break;
>   	case OD_MCLK:
>   		clk_type = SMU_OD_MCLK; break;
> +	case OD_FCLK:
> +		clk_type = SMU_OD_FCLK; break;
>   	case OD_VDDC_CURVE:
>   		clk_type = SMU_OD_VDDC_CURVE; break;
>   	case OD_RANGE:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 584c4cfd0c16..8cdbaf32492e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -324,6 +324,7 @@ enum smu_clk_type {
>   	SMU_OD_CCLK,
>   	SMU_OD_SCLK,
>   	SMU_OD_MCLK,
> +	SMU_OD_FCLK,
>   	SMU_OD_VDDC_CURVE,
>   	SMU_OD_RANGE,
>   	SMU_OD_VDDGFX_OFFSET,

