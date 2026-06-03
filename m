Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBEFCD6E4A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 05:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C5E10F829;
	Wed,  3 Jun 2026 05:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qw6/UeUE";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F3F10F826
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 05:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLRQpjSjQt4UQzDYWXSHGrfGjN1B9y65HZZz4kjyL7xfCItftAekU7DczcGxleU2i68ZBBFZdRIMKZgkOHPRAPqyv8Io0gzczlNtUppkgEYPI1cgqFpEKtW0FhtDQ3488qusDWCeF+v0wcaMKWoaIGx1C4Q4CvEQ5YAg2LT+fehFOkahoMv00GQA6nK5uB2ncCLmkbg3wfuXZaKxtiC0hH/naDyyG9YQK1jn4E5YW6PfpVXdxrTswN0vDfvT/A30E8V9Z/tdgaGubF5ZCR5y86ZRMC+jpeUcw9wQ0cg5NBn1iUJafJmnlcMJAmuE75BT/+RmLozjv2VR5flGtU0lWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2POFPdNa/z+091eEaGsmZ6MgPe6XoVqL19+jjhtbgJw=;
 b=GDUNFo4XeUYl/n+hY1Y6WWHGVRjOq9j5Y/pENNSugX17yFixRlXfV0Iyed06Hj+tP+KWRDrMQ812HWKQvTusXL8n/Mgqx10/6UcJSrpkLTOjkoXo/7Gtcsy4/iUI6b+wywdhNMdLDCuEo2PDiZPxASdr/yYRB7hM31hiCtCh32mE15OMl5v2bxz3KfS3UXn+JmQ3XN8BcY6IxNK+GWQZnhVd+NcgbcJ0/lRt9Ce10t5NeJPvlqWM2naq85lvi9sVo0jonji4Z4pKipxd4xYbDPdw0mqSkYFmCedQpUX17ej80BRBpaqmtFwtkMGTZOB6pspjORuzdbIxelUKIGRDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2POFPdNa/z+091eEaGsmZ6MgPe6XoVqL19+jjhtbgJw=;
 b=qw6/UeUEXP1319jYQDPehFi0FBWS7SOGtj3E4Z34wNYy9QemJQu+FTEOJ8LNDTU9pOqhHG464iVHS6L3eTWEerPk8UaC8AHthD5trrfg5ZyFECtilDo9k9B/1Br40QXclUOmYsNC2ZGRE2ybod3ISD7B7zczHkYPkClNosO88Ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Wed, 3 Jun 2026
 05:03:00 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 05:02:59 +0000
Message-ID: <bbe9f7de-c1d2-47b0-9367-bbaece174f56@amd.com>
Date: Wed, 3 Jun 2026 10:32:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Validate OD DPM triples before mutating
 tables
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260602180924.726003-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260602180924.726003-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5079a1-56ea-4ee3-6bb5-08dec12d61cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: h+877c6gGGmUDEvl3oV3OaZ7xJodS3OzWlaPCqFcs8kc6RHjOM/Uf1lCzoZ9+gvVCfKEQBPIFA8z9f7KxI7lsW0ElfT6E1xCfZA/ppdVIT3E7qSSufYIIM6HQ9lDuEsEVt9gq019XpSPGiBUzrDNKtJrms9F5lP+R8ggHdd9t/I3RE39JhQsjnMTARCmIq0mwN1h7wYwMmsERbAWH+ZqPtPkok8P434HlYFyYnHiGvtgu5+4eYt5BZRXEmWnNpWPoo+B2fsph0x/0lL86BRIvxR1E2jO3MOEnq3eSR7rmsUF3uBedDgjeKsV32QcO3fThdXGJYe9W05J2YFFkVYOIgHP+j6qT0IcQirsdIKlaj+bdNWAdDqr+cOXZ6H5t69sqah/LCRKnW9N23km+Ikj0jWnJV9o5IDBkS9TxlJtYNOqbV+PjUo3rL3S20yJTm06lyy58YegnD0UIWqU64mVqZItP6Is1doYSjKirtwONnCmNDuVNssugQZfcafAPtkXQnm+dk6JwjsDZabB1Vet7VYl68/R7bjyutZhdNbYulpB4W7HMett+Ik5cbmwu96W55lMQJYnO8sPiXtdksedFaTSWBvtgDP7ileweaIRWZi1n6oDnFa2TwbC8/n3BacpsNiuwhWr0bAjNI46WTVJSqKa7nDuH4R4/L3orIKnoYbYUZcbi4ed0RRi//5/evnR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDZEbTJUMEh4SWYvN2g4blVkOCtIU0x6MTcrVjRmUUF0L2xNMlZkOUlWc1R2?=
 =?utf-8?B?RzhQNHBVTzZoZVNVUUFYUGlmaG91Q3NYdmNmeC9rRnJvMDVnQkhhd1FPK1p6?=
 =?utf-8?B?U25naUJWV3ZYaGRYTUJBVXc0TkVURnFEQUJEMjErMXJyekJmRUlXZm96WEdW?=
 =?utf-8?B?bWJmVExYd2NmT1BtaDYyNXBNK1h6b3V4b1lZdnExSXNHMUIzbFZ0WWswRzFB?=
 =?utf-8?B?Y2NMZGRLMmRCUHN3T21wVUJhM3RsSUNaMEZHWkFJOGlOZENUZFp1WExrSTd5?=
 =?utf-8?B?bmZ3bUZpSEVlNUIydTJ4YzJaN2tDM0ZwMm9hT2d4YWJ2U3dvSllkZ2UwTHdn?=
 =?utf-8?B?ZER6T0c0M1VoamdTaVZFbitYN2ppR1RBeXZPZjJSOWFJbEIyNXBWZEtvNHhD?=
 =?utf-8?B?M2xyYTdDQlI1VnBVTGdTdXBRUXZCU1pLNXI5ZDZPN0dCMXpBRUhmL1lSN3dh?=
 =?utf-8?B?WG93YzFGSDIxaG5mNi9WQyt6bnppLzdVN0IwaXJJMzREOUdzSC9yODc4RnM3?=
 =?utf-8?B?dS9VbEw2M040N2RXckpVY2pqTFJkZElYbERuTXVqbEhlMVVVZUdOa1BMbWhK?=
 =?utf-8?B?bUlSMnRWNlZtY01tb2wxbXpqOUN0dW9yZXkxeHU5MHBIcGRqdzhCVVlFRk5H?=
 =?utf-8?B?RXcvTUV5cmxKK0JZYmhDSHRhczlzT09ibUp2M21lQ1NiemVDdmoyVWFORno0?=
 =?utf-8?B?S0VIWVBnMnJTOWtSVzlYTU5GaThjRzM3SlhKQ0Nsa2RTaThBTkN6YVozZ2xo?=
 =?utf-8?B?bStqV1YySjZKOTFoeHZJMWd4SVI2Q0lycmszbGVxLzFSUDRDNDM5aXE0ZDNW?=
 =?utf-8?B?R2RJWjgybFZKejhqZ2NibUZMQk5HcVRWSmgwQktWQSsvd3ZveHFwa0ZweFFw?=
 =?utf-8?B?WjUzdnFnNjlNblVUWjJ4cUtHc1RGTTVjbmh1cS9FYzc5SzVRYTdDQmRGdTQy?=
 =?utf-8?B?aVk4N3lBcEJNd0xBdWRMRDRzYVdzL3VwVGxvQTVHcjJFOHlCODExS05OYm5i?=
 =?utf-8?B?LzI0M2xzRE14Z2MzUjNzOWxrMGpXRGxLYlc0TlprRkxmcFhjOElzU01oMmxj?=
 =?utf-8?B?R3NXM0srNW50eHJVbnRiUEZUbm5hWVFNSmFaMXl4RVF0ZmR0UUdJTi9mYUIv?=
 =?utf-8?B?ekJyTW8xUmRSbGRzRkRIdjBTSnJKQmFldWY1QTNYemtMSXZTcXhmVzJWcmNZ?=
 =?utf-8?B?T3pLUFBYUFZFcG5OaFlZQ2ErQk1UY3RYbnYwU3ZXQjRlRVhpTE1uWGdiclg3?=
 =?utf-8?B?TG1qTTB1ZGpBUURLdG9zRGFvUXBudU9CbUV1VkkyRmVEQTI5Z0IrSlBPYjIv?=
 =?utf-8?B?SGhuZjBQQSsyM1AwUHF1MzZmaFArTDlxd0RxYzFEU29MVnV0SmtwQ2cyZVl5?=
 =?utf-8?B?d24yNCtndGowWmE2YmZkUWswbXNYK3MxcU1YQWYrZlF0ZGVld1ZVV3dJc29B?=
 =?utf-8?B?TVgrTlV2aDRRZnVUWENBWDJtUHJFMHk3VmdxSWZjamIvOUVXdTlxcXVjMFZq?=
 =?utf-8?B?cmxpd2t0L09QcUFJbWpDenBrNENvWk5sSXlSRDlrS015RlIwc2ZKb29XOFVq?=
 =?utf-8?B?U0dxVlUwdTMyNzIzVHdNd0VyaWJEYkl1TXFHdzlRa0xLNExMN2tadW1ORVZV?=
 =?utf-8?B?ME9OWjNjbE1CZW1DaGVDVUZadjZjVXhLYXNLSU5ZTG9KQ0VmeFRaTDBsT3Rx?=
 =?utf-8?B?MGlGWExGQVptTnJ6VWU1RDNXZ29OUTY5ak5vNmErVzJRcUVMUkIzeHFKQVJX?=
 =?utf-8?B?RW1Vd0VBRkE0bDRuTnRZUGVGcVZYMlpra3NXRkl0WG5zSndoZFR2VVU1YTRo?=
 =?utf-8?B?TVFxeGZTVEpqemUyZmVIMVVYWGFiQlVKUFdicW9WMTdzdXhtaHhmRFJEbzBU?=
 =?utf-8?B?RnFIRE10QVVjZ2FkTVQwTUczM0xLWXIyL2QzU0FVdzN2THgxQXlSVlhBN1U1?=
 =?utf-8?B?ZzdDaVZiN2hjWmNZd2pudDNZNHZaNHZuamFDSVd2Nit5VVJFUVFOeERPa2Nu?=
 =?utf-8?B?cEtOM1pldDlPZ1JmRXhhY3NzTFlNWDhEOHROYnFDV2c5SG8rOUltOE8zMGJW?=
 =?utf-8?B?M09kUmpYYVRlQlE5Z2xmK2c1WmR3eW82M21jSW5LcHJ6UkdBUUl6RWNKczdh?=
 =?utf-8?B?dFJMdll5WjlFTmpGR0dZSzBrN0xCRXRJcGpDekpSVmE5ZkQ1ZWNyMCtNaHJ4?=
 =?utf-8?B?aDdZanpaVFhCTlZVK3hQaFFPRTRmWXQwWTJERlVYRStoQm5TdW9ZWHBpVlF4?=
 =?utf-8?B?RlVSOUdTWTNBWU0zL01DZWZtNlN5cjE5TjlRVXJmVUFnbEI1SVZqR1BjWVpW?=
 =?utf-8?B?SzZpNXhjL21VZ2FlQlZENDdqQTdmRGhDQXpCMUZGSmREWnpMaUJHUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5079a1-56ea-4ee3-6bb5-08dec12d61cc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 05:02:59.3272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi20RCEUOXk4gRrcw5FbFa0OZYw0X584T5E9EBOShbt1Igo4adPuoOBGgJxMOpsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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



On 02-Jun-26 11:39 PM, Asad Kamal wrote:
> vega10_odn_edit_dpm_table() and smu7_odn_edit_dpm_table() could mutate
> the live ODN table for valid triples, then return 0 after detecting a
> truncated buffer or out-of-range index. Validate all (index, clock,
> voltage) triples first and return -EINVAL on any failure; only then
> apply updates.
> 
> v2: Use distinct message for different error case, removed unused
> input_level from validation loop (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 34 +++++++++++--------
>   .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 30 +++++++++-------
>   2 files changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 416b9380a70e..fb38247da8fc 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -5648,23 +5648,29 @@ static int smu7_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
>   	}
>   
>   	for (i = 0; i < size; i += 3) {
> -		if (i + 3 > size || input[i] >= podn_dpm_table_in_backend->num_of_pl) {
> -			pr_info("invalid clock voltage input \n");
> -			return 0;
> +		if (i + 3 > size) {
> +			pr_info("truncated clock/voltage input\n");
> +			return -EINVAL;
>   		}
> -		input_level = input[i];
> -		input_clk = input[i+1] * 100;
> -		input_vol = input[i+2];
> -
> -		if (smu7_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol)) {
> -			podn_dpm_table_in_backend->entries[input_level].clock = input_clk;
> -			podn_vdd_dep_in_backend->entries[input_level].clk = input_clk;
> -			podn_dpm_table_in_backend->entries[input_level].vddc = input_vol;
> -			podn_vdd_dep_in_backend->entries[input_level].vddc = input_vol;
> -			podn_vdd_dep_in_backend->entries[input_level].vddgfx = input_vol;
> -		} else {
> +		if (input[i] >= podn_dpm_table_in_backend->num_of_pl) {
> +			pr_info("invalid clock/voltage level\n");
>   			return -EINVAL;
>   		}
> +		input_clk = input[i + 1] * 100;
> +		input_vol = input[i + 2];
> +		if (!smu7_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol))
> +			return -EINVAL;
> +	}
> +
> +	for (i = 0; i < size; i += 3) {
> +		input_level = input[i];
> +		input_clk = input[i + 1] * 100;
> +		input_vol = input[i + 2];
> +		podn_dpm_table_in_backend->entries[input_level].clock = input_clk;
> +		podn_vdd_dep_in_backend->entries[input_level].clk = input_clk;
> +		podn_dpm_table_in_backend->entries[input_level].vddc = input_vol;
> +		podn_vdd_dep_in_backend->entries[input_level].vddc = input_vol;
> +		podn_vdd_dep_in_backend->entries[input_level].vddgfx = input_vol;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 8b8c4e899878..0bcba317a358 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -5477,21 +5477,27 @@ static int vega10_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
>   	}
>   
>   	for (i = 0; i < size; i += 3) {
> -		if (i + 3 > size || input[i] >= podn_vdd_dep_table->count) {
> -			pr_info("invalid clock voltage input\n");
> -			return 0;
> +		if (i + 3 > size) {
> +			pr_info("truncated clock/voltage input\n");
> +			return -EINVAL;
>   		}
> -		input_level = input[i];
> -		input_clk = input[i+1] * 100;
> -		input_vol = input[i+2];
> -
> -		if (vega10_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol)) {
> -			dpm_table->dpm_levels[input_level].value = input_clk;
> -			podn_vdd_dep_table->entries[input_level].clk = input_clk;
> -			podn_vdd_dep_table->entries[input_level].vddc = input_vol;
> -		} else {
> +		if (input[i] >= podn_vdd_dep_table->count) {
> +			pr_info("invalid clock/voltage level\n");
>   			return -EINVAL;
>   		}
> +		input_clk = input[i + 1] * 100;
> +		input_vol = input[i + 2];
> +		if (!vega10_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol))
> +			return -EINVAL;
> +	}
> +
> +	for (i = 0; i < size; i += 3) {
> +		input_level = input[i];
> +		input_clk = input[i + 1] * 100;
> +		input_vol = input[i + 2];
> +		dpm_table->dpm_levels[input_level].value = input_clk;
> +		podn_vdd_dep_table->entries[input_level].clk = input_clk;
> +		podn_vdd_dep_table->entries[input_level].vddc = input_vol;
>   	}
>   	vega10_odn_update_soc_table(hwmgr, type);
>   	return 0;

