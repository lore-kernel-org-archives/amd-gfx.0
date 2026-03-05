Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BBAEDEC07
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 05:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8598C10E038;
	Thu,  5 Mar 2026 05:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lkyQcuLe";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B106310E038
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 05:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol3JY6SrEwIfkbufJCCTZUkvFCOieyZUI7ApZSOfD03ww8VKU9KgyWGiBxKWwXe+q15wdIUQ07OV40xHJM6DhfpsNecPmhm37cIVLpTVha9dczfzov9ri5OhIFlI/cet3TkkR5PLxRnxkI56Bv8o/tTVf6lwFRPr88eKAS+AFrqlWnnUfNuVCcx8QApfjTeg7Jj9cqwBUnzUdzF+V/fHOUy+wYZ2jt9Y3/oQnYyjkfp45/haDnuHt0syAUfNOjP0db+/pjsAtif6hniPQSsCTWi8G1lZyZgprXi3LvpaMSL/yDaQtMr5uvm4z0JkwG97TgqMFHxu3xzrjTvQ5/bU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L717g7wIb47WCgQ5YsMoHfC/NoEJ0G2kqZFzosrkjoM=;
 b=Enxd2he+cWvV2j3TmrOsWehI4Cq/UXZjihX4Qr+pxX3YB2dQYH9XUuowmAjP3stABkLa05WifIuXx4KU5iIIR6iblrQ/Wd2nfdOZHx6lv7p6FPAS1AoIa6a6sR5QnQkMHGykCsxTndaPm6IisZ3q8nv1u9cuHrRMWeVBGXCCMZhpxxvdX/35+7bcSvPkC7txsmwP0eMJXzj6J+u+Hw3I6CQGkhNWswLGKY4tHSmsHO3Rm+uF2cC1M3zTvOVHBZ1vuYRxFV6PQhIaTXxGn4Noo/OraDWb/X1M4bL6GmBn3YAryXifovo7C09Tqr8obaHKpzDFheYyjB5CfQ41BKOukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L717g7wIb47WCgQ5YsMoHfC/NoEJ0G2kqZFzosrkjoM=;
 b=lkyQcuLefsvKNf6RsidwKMNJ1S2UrnUZqYG+IpglgOQMAvAyjGotUlSYW74HVe1LH3jc8zJo4o7FRY5pGrq539Kh3uEXiW88li019Yl1tTzJLDkbsLi8UHWpsIq7rEyLSRmX1oPkbfQhyQZquK+J2fomn/e1GEuuNXpdqaDdB28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH1PR12MB9719.namprd12.prod.outlook.com (2603:10b6:610:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.23; Thu, 5 Mar
 2026 05:24:34 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 05:24:34 +0000
Message-ID: <d0159abb-586e-4fcf-905e-2782dae0c629@amd.com>
Date: Thu, 5 Mar 2026 10:54:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amd/pm: Add aid/xcd/hbm temperatures
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260304081904.3132877-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260304081904.3132877-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::22) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH1PR12MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f98bcd1-734f-4098-ba37-08de7a777c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: WZXAeT++dk6OPS82dJqx+JlQEb7as5Faxk/an3tinQzeyDDM9/sIdrBn3AKaXMALjjhS+VKV0UXQaOEkfHEOo4K3V91EHqFU5LdgSGfukD7K+LTQzVNDjfUfvXbZLzE7uWqdJdbynQQaF/7E060Bgp8OzpLUYIr2s4R9nkHvJe/uoL4JL9Q9Jga7GwUbsyo9VHFIcM718TZxGpYM5qoPoRatQA/WnN1RdeECQvER4AiZq6ybxBliKExKT7XnT96+roPUWIfyQfrC2kXu1/FDBOeYBVyfL1c4xhTCXuOltP6H69P70+n1S80VIbd1qmnRseZ+1XB/PZ2JA3hoDLLnuyzqdm38ntvkPxZpW2YSDSJ9MP4zgUq9B9HjnaPwYLtDZw4sm4dHAupkt3sOMXDo5R0dM6Fl8neTgs9stmfxKVMNXvZYg4DrUDku7E8wld4+K2N/xvPjJKHkIeuydh5hS9UE0hrXmp8UH46acIkhmEHHn+17s44bhyB9rLgYGYXxmuKt2t4OnysGTfEIULrnpGlPYbEDlKxq7S6nlcD7g2bx1pyutsEe6Qr8r++6GfHzlSSg2Qb8tgmmHAT5kGnjmK30NFit+IkefZ5lNjVlSGUJiHwu3w6l6dbqiFk+B2kUtZm/bjZept2EdTuS1CiYCxLjbnzzKNAe4IVwCSG0lW0Yn7XdXkpKjJUZJyLt0gLn8OaCaV2sg8g/qnrSKK9mA0BdGKCrHaGxS3s8fJjIGlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0ZONURXaXo4N1VlWk1mUDR3cEFGYzFnODcxM3RLalNSdit1Z0Z1ZGkycFhK?=
 =?utf-8?B?czdFTGlsK1lzS1ZhZTJRTGlBR042TTk1TkJoNkhLZm03a3FiRVhRTnVKZXRp?=
 =?utf-8?B?Qk5COUZGd0JRa1hONkdvcjRPVzBZeHJvZFNNWVJoWGJDd2xWTzlMRFEzTHNU?=
 =?utf-8?B?ZlFmRnZJbzh1TXd0Y3lrRE9JU3Q0N0c0WmQvZHlTTUpKdXZNa3B5NG1ZWXhy?=
 =?utf-8?B?RDNyQmlnRTVWU3lvYUZRZjQxOG0zUmllUXJ5U0JCN0lGN1RTb3p6b3ZoT2Zs?=
 =?utf-8?B?UVRwMFhtRXJHVGxwYmxxSXRWbUdEWlRrd2RwMjJyb2gwQS9wNFFPdTNRZnVo?=
 =?utf-8?B?MzV5a1dyV3JFWjRQOW9jUmQxNm9VVFRFR21IR0pJTlloaFBoWU83cTZocnFk?=
 =?utf-8?B?OXhQeSt2M2RZaUdrdVNva2Rnd3ZoUWlqWDN6UGs0aTl2cElXRm9CQlJjMEtu?=
 =?utf-8?B?djBkL1dyZThsc1JzUjVaUkttNDdtQ1pzVWozRkVzdEI1aE9RR3FSTDRBcTFN?=
 =?utf-8?B?NEExZUxWbUhlUXlkQVpJSzhud1ZzNXB2N0tzNkhyem40VkJFcEZ6S1JQQlBm?=
 =?utf-8?B?WDEzM1A1bVpHMjZ5cVRGYjFybHVDa2Nha2N4OXQ0MlhlbHI4OHp4R25WVWtu?=
 =?utf-8?B?QXNzVXg5LzZGY085K0VsK2V1Y01iNkZYd3JPUEZNdzdoSzJsaHovTFhaVWVV?=
 =?utf-8?B?Q1E5NlVLb2VxUlo0VXhLem1CUDd0eExpNllRbWRFQWV2dThkcTVhVCtRaUVO?=
 =?utf-8?B?Y1NTc2xmRGp4MHNySkNLdjJXanNGcFk2VlU2UUZvRU1MYjlLekt1TEY5Uk9s?=
 =?utf-8?B?bCtzbFE4bGw3TCtJa0NLSWhpLzhwYUdZMTk3QlFrMGhFTldFcFFiVVNTbjlt?=
 =?utf-8?B?Z09maXB4WjBLR1BkeFA4UjhDYzNsaElPSmlPbi9tQzB1V0VNZkNheHdJNzNz?=
 =?utf-8?B?OXhNUlNrUlNjZzlUK1dGdTdMZVI4R3Z1b0NwQjU1eHlqQ1YvV1NSUHhhN0l4?=
 =?utf-8?B?ckJoY0ZvNXZLejJKcHA2VmVVQ3lqTEFvSmJzSHRMbUJMVkFrLzhqQUNYQzJC?=
 =?utf-8?B?b2U4SU51MUJlRjFFVjBkZlpaa2NVWDcxeDIvVkkxa2hPZzNnZ0dYb0pEbmh6?=
 =?utf-8?B?SzN3aVFkZy94VnRFSVFyOFYwSWZCLzZoRzlUYWlIZHZDT2pXK0NVOWdCMlFV?=
 =?utf-8?B?NFhCTUtwS1FRN0JpTHNMM2NIQ3hpN3M5V1JKd2lVRi9TK05rZElTYjUzVG5I?=
 =?utf-8?B?TUhzd1B6emN3OExLcGNQUjJqUllmRjJmckJCZUMwblpob2hLMklNQ2ZLSHJn?=
 =?utf-8?B?bnlFSHdrQk9TdTl3aVpsWGZpcUNtUDNoTTcvSUhVanZDQVZNb05Wc3FleGNZ?=
 =?utf-8?B?ckl0QWtYdnhHNzNtdW1DZkVtL2EvRjliNG1RSFJic2tTV2VLUWFJNzhMbUxB?=
 =?utf-8?B?dG1TSG1RcUc3ZjJXMFdNMlY1L0lWeVBpMktGNnNIQVB1S1RITVdYR3V1UWkx?=
 =?utf-8?B?eHFaa1FzUXF6OUxBdks2R2NBdDBHandrL3U1NGxhRlNMZWxiWExGZyt5ZzVt?=
 =?utf-8?B?Y1N3ek1VS2tzbEtnOXRWUkxncy9zcFVEN0srWUgxdGVTb2pvTFJHcWNhNzBo?=
 =?utf-8?B?UGM0YlN0eG04dmxESEtSREpOMHQ4SWhyUDNsNmNMY2VzWFJITGZ0QkdYSzdj?=
 =?utf-8?B?QmxGS1hsVW9oRktVU096b0VIRkY2OUllZ3JpZDgyYkg1Ry9leS93aEh5NjMw?=
 =?utf-8?B?WmFpV055Z0xlaTN4QWtzTXlVTXd1ZXcvSmtRU0xTUzFGdlVLQnJFTUtrUUpj?=
 =?utf-8?B?dlpzUEk0V3YzU0hBOWFWaUR2aFVTSHhnNkJWeW5CNmtXdzRWUFAzT3JtMDRi?=
 =?utf-8?B?Z0RkL3I1NGhnSUwvdXZkcXdYSEx1bXNaNzkxRENZUzM3amlic1NQY1g0MkJW?=
 =?utf-8?B?QVhVQUI4cU5xRTRiYlNET21hWUwzV3haTlVFOW5oZStUVzdLclNDZUlzOXlG?=
 =?utf-8?B?Yi8yN2VwT2xBN3RtdEpkWXM4di8rVFBHYTViQ0FkbllIbkU4R0N4L3B6enBV?=
 =?utf-8?B?QzBSWDlhaUJvRFZ6Q09uaVhYVXFWcDZaeGNJUWE2MjltbHlKZ09xa25oZUU5?=
 =?utf-8?B?eEVSQ2JzeCtqKzRKOHZaUEtPNVMyc3ZMSWFndU0vNm5VallCdkt4Rm9FVXY3?=
 =?utf-8?B?SGQwOEVvcEM1cFFjRnAzMDN6SWQ0RTZpMW0zNGFzeXh0U0UwbkFqRzdKZ2dh?=
 =?utf-8?B?VFNZdHFpYlBpa25sMmJFVUwyWHJYdWtnbFI1eWFZdG1MSmdON0J2Sk9rQjNC?=
 =?utf-8?B?amRYRnZ2aHgwek1vVU5NS3U4Umdmd3BKbkR1NXBQeWgxZm1VbHl5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f98bcd1-734f-4098-ba37-08de7a777c8d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 05:24:34.6915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w41VzaBrvpE69CJ79CcvkI3z7BV7zGrmkR/6+EfGiK6GxEpdvQALT0NmlFAivyGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9719
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



On 04-Mar-26 1:49 PM, Asad Kamal wrote:
> Add aid, xcd & hbm temperatures to gpu metrics for smu_v13_0_12
> 
> v2: Use correct umc control per stack (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  3 ++
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 37 ++++++++++++++++++-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 13 ++++++-
>   3 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index bdf8e6ff556c..a9b73f4fd466 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -584,6 +584,9 @@ enum amdgpu_metrics_attr_id {
>   	AMDGPU_METRICS_ATTR_ID_GFX_BELOW_HOST_LIMIT_THM_ACC,
>   	AMDGPU_METRICS_ATTR_ID_GFX_LOW_UTILIZATION_ACC,
>   	AMDGPU_METRICS_ATTR_ID_GFX_BELOW_HOST_LIMIT_TOTAL_ACC,
> +	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_HBM,
> +	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_AID,
> +	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_XCD,
>   	AMDGPU_METRICS_ATTR_ID_MAX,
>   };
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index f2a6ecb64c03..96a58d43db53 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -49,6 +49,13 @@
>   #undef pr_info
>   #undef pr_debug
>   
> +#define hbm_stack_mask_valid(umc_mask) \
> +	(((umc_mask) & 0x3) == 0x3)
> +
> +#define for_each_hbm_stack(stack_idx, umc_mask) \
> +	for ((stack_idx) = 0; (umc_mask); \
> +	     (umc_mask) >>= 2, (stack_idx)++) \
> +
>   #define SMU_13_0_12_FEA_MAP(smu_feature, smu_13_0_12_feature)                    \
>   	[smu_feature] = { 1, (smu_13_0_12_feature) }
>   
> @@ -834,7 +841,7 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
>   				  struct smu_v13_0_6_gpu_metrics *gpu_metrics)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	int ret = 0, xcc_id, inst, i, j;
> +	int ret = 0, xcc_id, inst, i, j, idx;
>   	u8 num_jpeg_rings_gpu_metrics;
>   	MetricsTable_t *metrics;
>   
> @@ -849,6 +856,31 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
>   	gpu_metrics->temperature_vrsoc =
>   		SMUQ10_ROUND(metrics->MaxVrTemperature);
>   
> +	if (smu_v13_0_6_cap_supported(smu,
> +				      SMU_CAP(TEMP_AID_XCD_HBM))) {
> +		if (adev->umc.active_mask) {
> +			u64 mask = adev->umc.active_mask;
> +			int out_idx = 0;
> +			int stack_idx;
> +
> +			if (unlikely(hweight64(mask) / 2 > SMU_13_0_6_MAX_HBM_STACKS)) {
> +				dev_warn(adev->dev, "Invalid umc mask %lld\n", mask);
> +			} else  {
> +				for_each_hbm_stack(stack_idx, mask) {
> +					if (!hbm_stack_mask_valid(mask))
> +						continue;
> +					gpu_metrics->temperature_hbm[out_idx++] =
> +						metrics->HbmTemperature[stack_idx];
> +				}
> +			}
> +		}
> +		idx = 0;
> +		for_each_inst(i, adev->aid_mask) {
> +			gpu_metrics->temperature_aid[idx] = metrics->AidTemperature[i];
> +			idx++;
> +		}
> +	}
> +
>   	gpu_metrics->average_gfx_activity =
>   		SMUQ10_ROUND(metrics->SocketGfxBusy);
>   	gpu_metrics->average_umc_activity =
> @@ -964,6 +996,9 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
>   				[i] = SMUQ10_ROUND(
>   				metrics->GfxclkBelowHostLimitTotalAcc[inst]);
>   		}
> +		if (smu_v13_0_6_cap_supported(smu,
> +					      SMU_CAP(TEMP_AID_XCD_HBM)))
> +			gpu_metrics->temperature_xcd[i] = metrics->XcdTemperature[inst];
>   	}
>   
>   	gpu_metrics->xgmi_link_width = metrics->XgmiWidth;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index ffb06564f830..a150fc88902c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -78,6 +78,7 @@ enum smu_v13_0_6_caps {
>   	SMU_CAP(RAS_EEPROM),
>   	SMU_CAP(FAST_PPT),
>   	SMU_CAP(SYSTEM_POWER_METRICS),
> +	SMU_CAP(TEMP_AID_XCD_HBM),
>   	SMU_CAP(ALL),
>   };
>   
> @@ -87,6 +88,8 @@ enum smu_v13_0_6_caps {
>   #define SMU_13_0_6_MAX_XCC 8
>   #define SMU_13_0_6_MAX_VCN 4
>   #define SMU_13_0_6_MAX_JPEG 40
> +#define SMU_13_0_6_MAX_AID 4
> +#define SMU_13_0_6_MAX_HBM_STACKS 8
>   
>   extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
>   bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
> @@ -222,7 +225,15 @@ extern const struct ras_smu_drv smu_v13_0_12_ras_smu_drv;
>   		  SMU_13_0_6_MAX_XCC);                                         \
>   	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
>   		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
> -		  SMU_13_0_6_MAX_XCC);
> +		  SMU_13_0_6_MAX_XCC);					       \
> +	SMU_ARRAY(SMU_MATTR(TEMPERATURE_HBM), SMU_MUNIT(TEMP_1),               \
> +		  SMU_MTYPE(U16), temperature_hbm,                             \
> +		  SMU_13_0_6_MAX_HBM_STACKS);                                  \
> +	SMU_ARRAY(SMU_MATTR(TEMPERATURE_AID), SMU_MUNIT(TEMP_1),               \
> +		  SMU_MTYPE(U16), temperature_aid, SMU_13_0_6_MAX_AID);        \
> +	SMU_ARRAY(SMU_MATTR(TEMPERATURE_XCD), SMU_MUNIT(TEMP_1),               \
> +		  SMU_MTYPE(U16), temperature_xcd, SMU_13_0_6_MAX_XCC);        \
> +
>   
>   DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_gpu_metrics, SMU_13_0_6_METRICS_FIELDS);
>   void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,

