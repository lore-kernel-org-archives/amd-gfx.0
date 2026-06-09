Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C85CD8CA7
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 08:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BBC10E17F;
	Tue,  9 Jun 2026 08:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZaEjgunT";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013045.outbound.protection.outlook.com
 [40.93.196.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C2A10E17F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 08:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geQ9pPgKldBr4YiKzjLfQlN55L1Awre1tM85uvUpw7NJxkZ55jeOOKS0n2CZS44vbbfafZqHGwQIv1iX2ltkQrVSCMvAHOaT8rJAxmHC/T7zSSY6jj1AlEDbFnqrWbw8hHE5dObRFS32RykruY8SjldMUkbhvhZZFz2QsKeaBA4vr6rn0zli+y55ckZCs7JSv5t+woMNrIQz7z4al+e4xTE5G1bKBKuzI91EDqg3Bj8IO59pqGuAtxdDJhuzE2OUlCSxZRSk/KVArPHY2SlM039Tzh3E0P70DQrLX1151P7rVi7KMMtaxqytuVOBny6Y8Iy61szltEKYN3YsAgeHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyythL7IXDHR+acZMGcaYOHQMGOdCSnkuyRwmpKaLj4=;
 b=wPL4Ee3egky5JgbeEI/SixwB9W36I17MoBeecCdlmu6gR4C/cQNDVN/fktYozURRc7+VXRbo3qaQXall7dSHPSIlaM0oAP9ZYKtlwf7b7Vv37VLShWjUR6hddMS6Wr5BA/6ECEmrlAya6nUVjlwXRMsQkjCkBINpnJukg9piHdDhONRdZAUsVbLURatxJlp4WHY9+PmkKWEIq5svgzjnnqE7Gm5tffF21N4oqPV0sK3Y9BBB1ALHx1dGBoyONYM7jfv+YLtzlMhCbr34u1t6IgKfyb88Y/vWOSl9RAIeTMaYv280Lcg5oepmxobONXjTmbxEDah8reng8TmdJNDaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyythL7IXDHR+acZMGcaYOHQMGOdCSnkuyRwmpKaLj4=;
 b=ZaEjgunTxbg2AS5ba1Iowtw4u17JHZeNdiaeVPlyIkH5o18e7+HNUxbD5Kd7wpj8s3t+G/5c2OPM0W9/BGg7+rCiVeHc/uc2IWSnrg/s/XvszJAKh3PizDtxqaIvK1zoMOKVmr5FgkTJ7U/1S4QCAkzNNGMQpI9Jlg7CmSRHGyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:10:50 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:10:50 +0000
Message-ID: <6cb5a3be-8cf1-4ce5-8ce9-a6fb363b12fa@amd.com>
Date: Tue, 9 Jun 2026 13:40:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260609065123.215816-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260609065123.215816-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PPFA19DE7612:EE_
X-MS-Office365-Filtering-Correlation-Id: b85177bc-cfd6-4cb5-24c0-08dec5fe9e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|6133799003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +XkJK1EDbyWNijwO4++Ja792jwLN2mrqY4AY3XgtVofSpXogtpBPzTLCRgNNZBkSp+qhQ6iJ0eB7U0ON4BJWS4n5/MzaDm29QQmKw0Ts7YTV9lOqsYLSU/ttqcq2oOnbtAe8gWNhI13ykQ1fwA5gVoV/9NbseB1YLagkCtlZXm6PZLHQIkxsX2VOfjkmZbu5exJbD/iZy40iUwJp12GUHkVdfVc9lX7qE9PSRgHmNCdFAKw3nyo/h5l2+4zrEPSxtrfz7IMDE/Oc/UTTP7aa8q0Q20lrgHipAbsQnPlUqBAZ5/EW7WfRWE0z0m/iG6P/Nu1cT560UmzxYiN5WSh5YMuWWmnrqaUXsIMK5B/LROOSB0RwcG9TXgHLD+24Z8iam1iP6z568WPWiK+M6qO7aPQu+UDIMylvLbZFBeKCk03efN0A1uD+Ae6MBDRSJnX+lvjKtL6UgJB8G+riAjd6Bl/rsquJl/cYKRgkrL8Bp+0EZNuba3WJkLkcjVyc9dZ3IwZcErg+gVRj/8IvwxAnnOT51d521D5ovbnoYbc0PU17lR1Qvm9tGJI8Wc0YcYewUK3VTt9ahCdgjBCxCaUjL6Gg5qHToeeXt7PEjrc79J/3w9t01llkYqEztwtqSuhQjMiw3HCdqX2C4ssTCKhC5wHEmXXAw54zeGPtLOwiNqvW/tnOt0pUxI9g31bCPvzQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(6133799003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1JkQ2o0QjdtVE5oWjd2SUFzT1crM1Qvek85dy9Xc2pXbUdUTlpVZ2FuNU5s?=
 =?utf-8?B?NlJRZmJ0Yk8wSENCa0F3cWl6c3Rmem9od3YveVJwMGVGT0t4SEQwK3Fxdzd3?=
 =?utf-8?B?ZHZvck1SYVpVVFNiLzFJVmJQUGpFbFZKTWtuSmdVMEptNU05K3F4c0ZYYlJn?=
 =?utf-8?B?ZkJ3TFlSSUFvWGdONlhhWEFscEcvOENIVitDOTMvMExoMVNJYkV4TzE5S3Nl?=
 =?utf-8?B?UGhqay83alZrR2xsOHRIM1Q4d2xRb3IwM0dERk5aUkFScXZyL2d0UVptVjQ3?=
 =?utf-8?B?U1k5dHlwenRhdFlZWTFBdXJFZTRZOFpnSlB1K3Z6Q1BlVm9JQTdSSFlEQ0pm?=
 =?utf-8?B?bWNnTVJmWEVOZlp5OTUyLzl6aEFmWWJIRUJXVXdjQ3Y4c0thcm9qbTl5djdw?=
 =?utf-8?B?S0ZFT05RMGdHTjc3OWZMMk5USmsyaThZSUowdHVkZ0JKcEJvbENIcHF5aHYv?=
 =?utf-8?B?Qyt0cmMxRXg3NHlDaXJqNGtVRUt0OXNvNythd1QzZkxnWXNHVmdYNitOcXdw?=
 =?utf-8?B?RDdMaFJDNVdsQWRHdFFmZ01lRSt5bnFhZm5GVUUxMDE2MjVtSG9RK3J4ZjhS?=
 =?utf-8?B?eUlQdGlWLytqOGRwNGJTN2RISjVCSGF5UWxzTDMzVTZTaFZMdUZORkRyc05i?=
 =?utf-8?B?OW9mVmhMT21XTnY3VXgvc3NTWUFUTVgxMFkxcnB1SzY5aDVSWEk1a1l6eUxV?=
 =?utf-8?B?bnpWdk5aNElOR3VVRDVWa0YyTHE3elhuRnlTcFVQa2NlRVJMQU5LOWFuTjRF?=
 =?utf-8?B?QThjTmhrOHY1NG5QWFNGQ0MrTkNUVFBSSnhzSUdTTW5qSHFlTk9UbVZOSkhv?=
 =?utf-8?B?NjJpenFsbVN5L1o1UjdyRWtobC85QXZiVlVMdVhJOFFpdm1aUE5TcjI2T1NV?=
 =?utf-8?B?azMxN3JPSHoxUUpUSU82NGN4VVJqeFlFRGJDa3ZoZE9xdUpodEV4TVVxQUE2?=
 =?utf-8?B?M2R1MkJibHUyRFNyblM4ZUhzcXpWVEhkZS8xVnRpT3VWNVRrV09GdUQ0dWJk?=
 =?utf-8?B?eHJvb2VGQVJlcUlpWlZTcnRBYWZ5V1prZXJnY2JNSzdSR09TSUE0T3hoYWRL?=
 =?utf-8?B?Q0R2TnNMcUQ2cll6dzh2c1BqVmxJVVVMNEsraS9oNDRjQXo3eldGSlI0dHZh?=
 =?utf-8?B?VElhZWxlN05zczRuMEVwUktUTzZmRXJ1b0JVVjh2T2JNZTdUZ0xYUDl2T0dP?=
 =?utf-8?B?dFJBRTlGVzZsOVFJSHZtQmlUZUZtNnZuVzVXYU52bktBZlVJTmFKZGU5TDRE?=
 =?utf-8?B?SEJjRlZscjd0dHdOWjhua3IyUXQ0TUhBanRDTERNeWNzYlRuUk42NFpzY1hB?=
 =?utf-8?B?SzMrQkxYUmF1emJTNG9vV2o0Z0IwQk1Xb0RCaXFrWEZlYXRzaHh1dXpwcDRI?=
 =?utf-8?B?R1FLVHI4aitBOFdwUTBGQys4dmtqWGwvaTFjQzQ0c2tudWZtVXd3VVU4Q012?=
 =?utf-8?B?SGRIeFR4d3lSK3AvTkorOEFwcWx0d0kxbGVTN0twZk1ISEZFYSsxMS9zQ1Q2?=
 =?utf-8?B?dHBZTGJwU1FPZlYrY0xROHpldW9KZlFka24xbHNCWjRzMWQwdUc1bFRNU1hx?=
 =?utf-8?B?a1ppampDaW05NVNFQnNRMm1YUnJDS0Z2VXBkVjFlN216eW52aEF0enhuUk1T?=
 =?utf-8?B?Tk1FZi9qeUNZeVN6eVJjZ0tMR3lja3UrUy9aUGVJb08zSWxKcS9LWTdTWWVC?=
 =?utf-8?B?UndRS0R2eUx4a1puUHZvL2J6RFdzYXN4eEQ5V1BtR2Q2eXVlU051aGNrVkhU?=
 =?utf-8?B?K3NWWWVRL25uVmJBK3JWUWlBd05tcVZsR2tOWlBwbWIwakRSTFErV1FRR3hZ?=
 =?utf-8?B?N0hRWFpBaHhQbXFobjY2UkRwN3FYWEVkcmJWL3crY1JUYjJadXFjTVVobXVD?=
 =?utf-8?B?Ti82VTR1YzVYMnhiM0hhQTdpUWJkcmNtYnNzcXpQMmpnblJETFlEUTBVZXJ0?=
 =?utf-8?B?ZmdDZ2ZlcGhUTzBpTUk1WVFKUm5mb3FxNmZQT2tCbThPY0U5eGVJd3JQQ1lR?=
 =?utf-8?B?MktJN29qTzc5cnE5WXA2bHF1bFFWdEtIR01DWEJpKzJYZGdTWUFSNzdHaVFs?=
 =?utf-8?B?YWF5Z2RIdTJCbGw1cDBYazU1cENQVWtlOE9jb3FkbUlJMGs0K1dYd1huTnRM?=
 =?utf-8?B?a1JPV3NBaTZCb0svQXRnV1p5S1psVWozV2FleUpRc1dtK3l4TmQ0MGNrWnpn?=
 =?utf-8?B?K0M1ZHI5c1U2VmlFOXF4ZWk2VjUydEdnNVVCM1lJUEh3RkZ4ckJGWU8rS0x1?=
 =?utf-8?B?T1NhNUZTR3RYNlZtMklUcnNka20ray9OM1J5TGhONnArYUcza1pRNFJtRGEz?=
 =?utf-8?B?YUdyVlY3OVpIL0IxZXlPUHZwY0RKaThIODltOWNvVjFReXBxQWQrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85177bc-cfd6-4cb5-24c0-08dec5fe9e41
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:50.2187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wft7Obpu1/SCAtL/AsUh/BNqgwPB1eAz7vRnfMneJW7paiTxqQP5ORZy+e9PTblv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612
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



On 09-Jun-26 12:21 PM, Yang Wang wrote:
> Refactor smu_cmn_print_dpm_clk_levels() to build clock entries before
> emitting sysfs output.
> 
> For discrete DPM tables, mark the level closest to the reported current
> clock. This avoids losing the active '*' marker when the SMU-reported
> clock does not fall within the previous fixed tolerance.
> 
> Keep fine-grained output explicit by reporting the current clock on an
> 'F' line, and keep deep sleep represented by the 'S' line without marking
> a discrete level.
> 
> Active marker placement:
> 
> | Mode         | '*' marker location       | Reason                    |
> | ------------ | ------------------------- | ------------------------- |
> | discrete     | closest/current DPM level | entries are real levels   |
> | fine-grained | 'F:' current clock line   | min/max are range bounds  |
> | deep sleep   | 'S:' line                 | outside normal DPM range  |
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5295
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 148 +++++++++++++++++--------
>   1 file changed, 101 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index d365f06ac1ac..872c0328f290 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1376,77 +1376,131 @@ void smu_cmn_reset_custom_level(struct smu_context *smu)
>   	pstate_table->uclk_pstate.custom.max = 0;
>   }
>   
> -static inline bool smu_cmn_freqs_match(uint32_t freq1, uint32_t freq2)
> +struct smu_clk_print_entry {
> +	uint32_t freq;
> +	bool selected;
> +};
> +
> +static inline uint32_t smu_cmn_freq_distance(uint32_t freq1, uint32_t freq2)
> +{
> +	return freq1 > freq2 ? freq1 - freq2 : freq2 - freq1;
> +}
> +
> +static inline uint32_t smu_cmn_get_dpm_level_count(struct smu_dpm_table *dpm_table)
> +{
> +	return min_t(uint32_t, dpm_table->count, SMU_MAX_DPM_LEVELS);
> +}
> +
> +static uint32_t smu_cmn_get_closest_clk_level(struct smu_dpm_table *dpm_table, uint32_t cur_clk)
> +{
> +	uint32_t min_distance, distance;
> +	uint32_t closest_level = 0;
> +	uint32_t count;
> +	uint32_t i;
> +
> +	count = smu_cmn_get_dpm_level_count(dpm_table);
> +	if (!count)
> +		return SMU_MAX_DPM_LEVELS;
> +
> +	min_distance = smu_cmn_freq_distance(cur_clk, dpm_table->dpm_levels[0].value);
> +	for (i = 1; i < count; i++) {
> +		distance = smu_cmn_freq_distance(cur_clk, dpm_table->dpm_levels[i].value);
> +		if (distance < min_distance) {
> +			min_distance = distance;
> +			closest_level = i;
> +		}
> +	}
> +
> +	return closest_level;
> +}
> +
> +static inline int smu_cmn_emit_clk_line(char *buf, int size,
> +					int level_index, uint32_t freq, bool selected)
> +{
> +	return sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			     level_index, freq, selected ? "*" : "");
> +}
> +
> +static void smu_cmn_build_fine_grained_levels(uint32_t min_clk, uint32_t max_clk,
> +					      struct smu_clk_print_entry *entries,
> +					      uint32_t *entry_count)
> +{
> +	*entry_count = 2;
> +	entries[0].freq = min_clk;
> +	entries[0].selected = false;
> +	entries[1].freq = max_clk;
> +	entries[1].selected = false;
> +}
> +
> +static void smu_cmn_build_discrete_levels(struct smu_dpm_table *dpm_table,
> +					  uint32_t selected_level,
> +					  struct smu_clk_print_entry *entries,
> +					  uint32_t *entry_count)
> +{
> +	uint32_t i;
> +
> +	*entry_count = smu_cmn_get_dpm_level_count(dpm_table);
> +
> +	for (i = 0; i < *entry_count; i++) {
> +		entries[i].freq = dpm_table->dpm_levels[i].value;
> +		entries[i].selected = (i == selected_level);
> +	}
> +}
> +
> +static int smu_cmn_emit_clk_prefix(char *buf, int size,
> +				   bool is_fine_grained, bool is_deep_sleep,
> +				   uint32_t cur_clk)
>   {
> -	/* Frequencies within 25 MHz are considered equal */
> -	return (abs((int)freq1 - (int)freq2) <= 25);
> +	if (is_deep_sleep)
> +		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
> +	else if (is_fine_grained)
> +		size += sysfs_emit_at(buf, size, "F: %uMhz *\n", cur_clk);

What about keeping the else part as C: <cur_clk> in all cases - instead 
of just fine grained? * indicates the closest level matched and cur_clk 
will give the exact frequency.

Thanks,
Lijo

> +
> +	return size;
>   }
>   
>   int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>   				 struct smu_dpm_table *dpm_table,
>   				 uint32_t cur_clk, char *buf, int *offset)
>   {
> -	uint32_t min_clk, max_clk, level_index, count;
> -	uint32_t freq_values[3];
> -	int size, lvl, i;
> +	struct smu_clk_print_entry entries[SMU_MAX_DPM_LEVELS];
> +	uint32_t min_clk, max_clk, count, entry_count = 0;
> +	uint32_t selected_level = SMU_MAX_DPM_LEVELS;
> +	int size, i;
>   	bool is_fine_grained;
>   	bool is_deep_sleep;
> -	bool freq_match;
>   
>   	if (!dpm_table || !buf)
>   		return -EINVAL;
>   
> -	level_index = 0;
>   	size = *offset;
> -	count = dpm_table->count;
>   	is_fine_grained = dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED;
> -	min_clk = SMU_DPM_TABLE_MIN(dpm_table);
> -	max_clk = SMU_DPM_TABLE_MAX(dpm_table);
> +	count = smu_cmn_get_dpm_level_count(dpm_table);
> +	min_clk = count ? dpm_table->dpm_levels[0].value : 0;
> +	max_clk = count ? dpm_table->dpm_levels[count - 1].value : 0;
>   
>   	/* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as GFXOFF */
>   	is_deep_sleep = cur_clk < min_clk / 2;
> -	if (is_deep_sleep) {
> -		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
> -		level_index = 1;
> -	}
>   
>   	if (!is_fine_grained || count == 1) {
> -		for (i = 0; i < count; i++) {
> -			freq_match = !is_deep_sleep &&
> -				     smu_cmn_freqs_match(
> -					     cur_clk,
> -					     dpm_table->dpm_levels[i].value);
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> -					      level_index + i,
> -					      dpm_table->dpm_levels[i].value,
> -					      freq_match ? "*" : "");
> +		if (!is_deep_sleep) {
> +			selected_level =
> +				smu_cmn_get_closest_clk_level(dpm_table, cur_clk);
>   		}
> +		smu_cmn_build_discrete_levels(dpm_table, selected_level,
> +						      entries, &entry_count);
>   	} else {
> -		count = 2;
> -		freq_values[0] = min_clk;
> -		freq_values[1] = max_clk;
> +		smu_cmn_build_fine_grained_levels(min_clk, max_clk,
> +						  entries, &entry_count);
> +	}
>   
> -		if (!is_deep_sleep) {
> -			if (smu_cmn_freqs_match(cur_clk, min_clk)) {
> -				lvl = 0;
> -			} else if (smu_cmn_freqs_match(cur_clk, max_clk)) {
> -				lvl = 1;
> -			} else {
> -				/* NOTE: use index '1' to show current clock value */
> -				lvl = 1;
> -				count = 3;
> -				freq_values[1] = cur_clk;
> -				freq_values[2] = max_clk;
> -			}
> -		}
> +	size = smu_cmn_emit_clk_prefix(buf, size, is_fine_grained,
> +				       is_deep_sleep, cur_clk);
>   
> -		for (i = 0; i < count; i++) {
> -			size += sysfs_emit_at(
> -				buf, size, "%d: %uMhz %s\n", level_index + i,
> -				freq_values[i],
> -				(!is_deep_sleep && i == lvl) ? "*" : "");
> -		}
> -	}
> +	for (i = 0; i < entry_count; i++)
> +		size += smu_cmn_emit_clk_line(buf, size, i,
> +					     entries[i].freq,
> +					     entries[i].selected);
>   
>   	*offset = size;
>   

