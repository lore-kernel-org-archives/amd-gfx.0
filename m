Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C790BCD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 04:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2CF10EC9B;
	Thu, 11 Jun 2026 04:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uVgxazGS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE9CC10EC9B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 04:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+y0Ral2KkdKGMqAjzoiB3QENXc1wNcTPAjlkjWkG7VWTnIPoaXoXLKyTt5tsRZKtBFuUtGgsa4qZ9IbSvc7KkgVlYh059C9ZZlfNye37CzR0y6oh/S2PZF4Im8EvWyV9jO22tM3v9DhfO6ZEcQWJ2/27udyU6cxwCGyNFuJkfnDBs6disstjGZWU66PXpTeOBzpLotITyLduLsruOY5kdDR4BcQY0KvrUhyU/0Xje2Qv61uiXPUE6buvrY1OGd23hmfpKfDZ4ZEcRNMrFfJusfiFog/YHPl44grgtYbAHIcAkrcEK5wiexrmONj9EVdx4wHeZgTDcT1RZ4a+/vivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97/YlCd728F8MpIthKoQyOOIkQyaOyfX9yl3TNdVCk8=;
 b=eSSVmEmCcFHOa816stmONPlinXz0mklFOSeQXxglQIJJO/L/uJrZWOPOzNVtQnEXguKC348Uh4gjmXwvxmoOUbmXwE/A56BTfamOhQfumkWRzpRhbWoHUT+ya9/jCjq8Y1IduniiSVkl5jUIqW1jeWeJc8MbPPcrdn+Au+N77VxFvYakGdPIrw2EY/YV18OMdQox4IQboEShN/b0I7dPGt2eZngcKNmiTEPaAdYDwbEIrf1DHtfuEH5DY68KmdSDpUMkilK+PEfRJJEH0sk1ETBnoqJu4/W7bLxkV/lfln74EDsXbob7E/EFP81GRthNoy2l5j+e2ycfVBHTTZGXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97/YlCd728F8MpIthKoQyOOIkQyaOyfX9yl3TNdVCk8=;
 b=uVgxazGShnv5j76smVhpMgaZlJ1bvfDcZArS0fopYMD4Uvm8QaJtBQTo3DqO963UkzJvMFrrluKdY3/qvkXjI/YEXfxDw1baoREUmVgQ8uMBddGlKwl0AQAixjCbRhnCI97SLzz1SS5Dwr5AaZUqKXwvKURCuhOMnV/LxQAnMnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 04:17:23 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 04:17:22 +0000
Message-ID: <6c63f0ef-7cc5-41cb-8b5a-e4fcb21684b7@amd.com>
Date: Thu, 11 Jun 2026 09:47:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amd/pm: smu_v14_0_0: add closest-match
 fallback for DPM level marking
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Mario.Limonciello@amd.com, Kenneth.Feng@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260610182333.3922-1-Priya.Hosur@amd.com>
 <20260610182333.3922-5-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260610182333.3922-5-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::24) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e82ece6-83d0-4154-29a4-08dec7705605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|6133799003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: pxfpMNL1y/jRv0tq/8CieMIVOs8Um9IYXg9QzOOXGw+a985uPIB3nbPIqhzFO4Z2S0HJDZWQSx8ebLPSDK3ZvEK2AHefjFuWz/JVv5yiD50xRHl720a1KJIQwMb96j6999ITsnNICH6H/WDiPjw0V2qh78SgDrnGELZfhFFl6iKeQxeeUAW/dxbBBpMBXlhQizPQsqYmVHPSybblvgvexYnr3Fws3mdp7e94vYAtqUSNmZchGK/GdUU73eel8yYL7CmvcL9fwRBs01C5Tmz1BGQdZ0qT5x4A9+OoXhyDZ8pN3gPo+5y9VqRDRi9qY7b9DfhdQHo/CRuFpwa7ismMPbVWB23uTAVL7IaeZ0LTJVtGS0ZrSeRXuhlftXAG6bKxEFX4y97QtUsdAehsVQt+XZdOp1yPlADUDypR3AfCq8FH89U26qn+w5zg0Ig6YuE2aHjGP9NFbGdyPKCz3iZGxFjG8O0FHDhz7nlUP1v6Kbkr0DIxW7xJPrc1sPkqeDTs5W/DOTtIFSAVaQwNUtIxCmBN2eUeh7d7hSp1RYDcb1ujEBPbNXDmoSFv24aS+l13lZdFNW07weuMBVf+yEeEBQ+1cgDYd6M/J740uYIzFtMN7aFbHB0w1Vo3DstTWQxu+fp05ESc5tOZvs2YR+JEegvFfDG72jW0bZ1M3mvYb3VfurEciB7l4YVWb2nRXxO3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(6133799003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlRGT3FpbnN1c0ovTFdNaTBvcUVDZWlQQXNHYk9YVGFVZTdIWG1URkdvV2hx?=
 =?utf-8?B?aSt6bzlOTGpXeTZJSG1IREl2eUpXYzZpc1hwWmxHVG9yZCtKUlRlVjhURnR4?=
 =?utf-8?B?YmpObWxZSG9DZ2U1bndSaWNpaVI2UkhFdHpIS2NINmRmRE5DQWZ6QzNxU25L?=
 =?utf-8?B?MWlra0hyM1FrQktOY2twbktvVDBYb2UxL3JUSWo5QTdQb0tmK0RCVFlmKzU3?=
 =?utf-8?B?bVdnWFd0d1gwVjBNVXNFUldTT0pIZ0F2VFBVL3o3UnhRb25lM0dNMXZvNmsv?=
 =?utf-8?B?M3doRldZd1p4NVhsQWRBSE1hRzZyN1BIWXBjVUhicTBzTXVtZ3lITWVSa21u?=
 =?utf-8?B?WlFwY2Jkd3pGbUdlaThOQ3JJNnpXeVU4Z2FjY0lLczVJVHI5cW1iWWVmSjZ5?=
 =?utf-8?B?d0FRVTVRMTVzYk02TFV2K1J1a2I0YTkxdE0vcTJzeVR2N2o1YlN6ekRQdVh2?=
 =?utf-8?B?MThHWHlWalFIWDFhVmJIUzVXZVA5RHVwaDZqK3hTU0w5dzVQcEMzNmdjWm1q?=
 =?utf-8?B?a0w0Y0xha0tYdEJBUitTTjJINVg5djZYS3ZHQ3hiRi9EcXF1aC8vM1FVRHlj?=
 =?utf-8?B?L3drdDhsRFA4bTdrNE92elI0cUlHRWlwbDlFUFRLTWFtdWo4K3NnTDRUNTE5?=
 =?utf-8?B?RXRjSGNEUjFva0VyQllTYWI3TU1acHdHd3lBbmU4ODdzVkdQN013S29iS0h2?=
 =?utf-8?B?U2lZbEJqMDN4Y1R5VDdaNEFlaStNODhjcHVZOWF5TjJHOHlZNHFXWW93TEpS?=
 =?utf-8?B?UWNtbmNCbXRseTR2bEQrV3hhT3dUWVZlQ01KbzFybnRiS2ZHMHJDMnBsYStZ?=
 =?utf-8?B?M1JNdndVSXFGWkdIbDVrQU5ITi9NSng1SjY2Y3NsSmtDMldBbW5wNVFYbkw3?=
 =?utf-8?B?L1ZpbzB1SWhuT1RJLzZZOVN1U3VFSiswdGNtV0tGd0RMMjhkRFIwSUpTRzcv?=
 =?utf-8?B?TnZGcUNxZXVxUTJIaDdhUnZYSEsyTjBaY05lQmRkZTdkSDdNTTF6SFc0Sk9F?=
 =?utf-8?B?TGk1V3VSbTIwZnF4NjRlenpCTjZVQkFQZW9HMzhZd0RHNkhaSUd0MUdrSndP?=
 =?utf-8?B?QVhiTGZEUzZIL3M0Ti9DaThORVQ5bWVJUW9OcVA2YzRxait4aS9YeS9RKzhZ?=
 =?utf-8?B?Y2xWcDdHZ1BnaWtNK2RsUytRN3E1NFFYdUZIUStoOXV2Q2YrREc5M05QcWJQ?=
 =?utf-8?B?NWJ4ZGUrUTlVRW5iM3ZQME16UFJoZlhMM0k5WWpxZVpvWFJ6Ly9QL1g4YkUz?=
 =?utf-8?B?QXB1cFdLU1ZpUkN6NzNmMm1SS1hGZE1WQS9zZVcvMWp5aGhOUU41NHRRdUpo?=
 =?utf-8?B?b3E0a2hUYUZNOWZEMlhYeW96eXJvMUEzQmdNSUsyY2pNQVBqN1krZmtaT3NW?=
 =?utf-8?B?UFlGVWExSTlLMThjRE9VVUo1MWdNdGM5M3REeHdZbU42bzBUSjVZS1BFUFpH?=
 =?utf-8?B?WDVGZHF3aXQwSFh6Z3NHbS9HeHA3S3hmekRxSUwwS1VNQXVKSDdyTjJsY0JP?=
 =?utf-8?B?UmtCL0FUVkRhL3B4OSs0V2l5WEMrakZ3WlZoSnM3VXRXUnNJRFpFTmQxNUtT?=
 =?utf-8?B?eVJ0REIvVGNLYmxDTTRBY3BQR0wwMFBNV2VkNEhpUDdIRHM2SVU4UTBHWmVu?=
 =?utf-8?B?dVJkM2xSMWtNb0hsOWRBN0ZnNFQzb3hVUzVISnAranByejJUMTFEdllhUW13?=
 =?utf-8?B?cGVzTlQ0RXB5N1JXR0xWZHJiL2JBR0dORS9leDlvOUZFM2V2eEVtOVhDTjRZ?=
 =?utf-8?B?djJxb1d6ZFVDL3B0RlIzZzdRK0l3RXNoL0FoOWNEWWQwWDhzSm1oaEVLSUlM?=
 =?utf-8?B?dVQxSHRLcUdSdGt4cDZwVTZOcm5ZZFlNY1doZ2IrRVgzdllNdFN1YkcwUER0?=
 =?utf-8?B?a0tSYzJiMFNacW8vMStRUjE5MzU2SlhQeTh6WXQvTXZxaEFqd01CT2R6TjhV?=
 =?utf-8?B?RVB1TWFsK3ZxY2t4Yk1WbjN0K2tpSFpmbVowWDdzWUNaMUlZeHVsVVBuR3Q5?=
 =?utf-8?B?cmJKTmNCR3ZndUIwbkZ6ckw5UlZuTWl2N2lnd2MvUWFWN0dwbnJpU3FOaUN1?=
 =?utf-8?B?UTJ3VjRHWW5qMmhCQnl5MER2a0tRZFhMMHdacmJmMHp3THJRQnZEY2NmTnBQ?=
 =?utf-8?B?UVZRZS9Mb3ZQc2xWeW1KUmxoYUthYk9KZ05IMXlDVytsdDlwVS9KalZudzBS?=
 =?utf-8?B?VWY3TW9taXdtWUdPVTB6dVQ3NkY2WW9TdUE4RXNJSTRxSHFrS3RtSFNLYWw5?=
 =?utf-8?B?QndTWlU5ekwyT2h5S0RoMEZCbnBvS3BuNzZuNkNQODJuRHUvRzNyWTlNbG44?=
 =?utf-8?Q?nXVycurk/WFtJPwrOO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e82ece6-83d0-4154-29a4-08dec7705605
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 04:17:22.8083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eQnl2g1kn/QvUg0CbiDq30N/qVcynUGyzFfsSQnDZHy2PL04AjGrg5dIA62YOjq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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



On 10-Jun-26 11:53 PM, Priya Hosur wrote:
> Replace the simple exact-match loop in emit_clk_levels with a
> two-pass approach: the first pass checks whether the current
> frequency matches any DPM level exactly and also tracks the closest
> level by absolute frequency difference. The second pass emits the
> levels, marking the exact match if found, otherwise the closest
> level.
> 
> The SMU reports time-filtered average frequencies that often do not
> match any DPM table entry exactly. Without this fallback, MCLK,
> FCLK and other clocks show DPM levels but never display the *
> marker, breaking userspace tools that rely on it to identify the
> active frequency.
> 
> Also uses reverse DPM index for SMU_MCLK since MemPstateTable
> stores levels high-to-low.
> 
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 53 ++++++++++++++++---
>   1 file changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 1be8d1a8da19..c01c71acbe3f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1190,14 +1190,53 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
>   		if (ret)
>   			return ret;
>   
> -		for (i = 0; i < count; i++) {
> -			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
> -			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
> -			if (ret)
> -				return ret;
> +		/*
> +		 * Try exact match first. If the SMU reports a time-averaged
> +		 * frequency that doesn't match any DPM level exactly, fall
> +		 * back to marking the closest DPM level.
> +		 */
> +		{
> +			int closest_idx = 0;
> +			uint32_t closest_diff = U32_MAX;
> +			uint32_t diff;
> +			bool exact_match = false;
> +
> +			for (i = 0; i < count; i++) {
> +				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
> +				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
> +				if (ret)
> +					return ret;
> +
> +				if (cur_value == value) {
> +					closest_idx = i;
> +					exact_match = true;
> +					break;
> +				}
> +
> +				diff = abs((int)cur_value - (int)value);
> +				if (diff < closest_diff) {
> +					closest_diff = diff;
> +					closest_idx = i;
> +				} else if (diff > closest_diff) {
> +					break;
> +				}
> +			}
>   
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
> -					      cur_value == value ? "*" : "");
> +			for (i = 0; i < count; i++) {
> +				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
> +				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
> +				if (ret)
> +					return ret;
> +
> +				if (exact_match)

exact_match is redundant now. It only needs closest_idx check.

Thanks,
Lijo

> +					size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +							      i, value,
> +							      cur_value == value ? "*" : "");
> +				else
> +					size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +							      i, value,
> +							      i == closest_idx ? "*" : "");
> +			}
>   		}
>   		break;
>   	case SMU_DCEFCLK:

