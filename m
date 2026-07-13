Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2538C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 11:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5591410E5BD;
	Mon, 13 Jul 2026 11:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i0PkiaLX";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421D210E5BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 11:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJkWtTiENzyvh4zWGGcxm8grud2Wq8AsnR65Ig7YErmyrgX12YZV/pLyJnQXQYQTpM+R6S+LQ3qtH5VjVb2U6A6fhQE3PyycTWlK0bUAFy1z9jV+zayZDeUCv9eHNdck6fmvKKm407VaCI+Eoky4PWKR3Z88oME2j9aAaLsi66rlin/JxxK/Avv153ZWwNj8zUS6JTfHkLx8SAut1E/nmv+zwp/1JG1UyVznjDb0jjBGkYM+ipEJbBovByN07p/CY20mgzeOL1C8+TCqVbxClZyU9CQbnN855WorQaS+t1t7sRw5qdqeSJbCW/koe4okFFpiiSjYFpyqfLn6oEbzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc0BOUcv7FOzJghYMmk2l5xlNXOtTxvSg1KZgt1cDuc=;
 b=aE5H2AmOfw9dAlEJNZAiXvcR2eBHiYeCJV+u3nb9oEMU6yDz91yDe4rY3NfzY6Gr9DVPmDjXjPqWOehxV/5wCq0R9q2Yxj+vKwrHnvjwpHcrFgy5ELiDE80xKhICwCGq8p2+zl2jDP526qS44zeilVlylD+ihEf5en+USw6IdC6qzLYFhS4zyj3fuGHBgyin7ZePtO4lEorY7RjP9qAi3O5+OIezoRTOYldzQTFfBSLagVsW6cgTlfgt3OmnoCKp6Akqfo2IBPTBr0jhWQ3gIe980+4/Ul2zgj5NgxJ4Fzpc/SCePT0ooAnR935tpZKvlK4bk9JrQ5Uol5zwoeZNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc0BOUcv7FOzJghYMmk2l5xlNXOtTxvSg1KZgt1cDuc=;
 b=i0PkiaLXj3xqY5DpvJHy7pMOjPDsNwdEjuSQUJBKH1v7Vqo2q+ygJrLUbsPrz70L8T6CVsJv7De+nED7qEXfUTS7zgLUjgN9qAFcfSDUy3DXl3xoipCY6wqkDGVx1os5gP8zbzeuuD/X5zienOO4E/KwSVlnwwnjZLlOpQY1dWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 11:29:30 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 11:29:29 +0000
Message-ID: <f2b95506-6daf-4235-ba6d-2a0d00970daf@amd.com>
Date: Mon, 13 Jul 2026 16:59:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amd/pm: update smu_v13_0_6 acc gpu metrics
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260709122633.1788432-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260709122633.1788432-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0134.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9c9905-5cea-43cd-d78d-08dee0d1fcdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qr2P99cXONmyye10Pqk/siVgtU6VcDP8jmetZKSbu2iPNyWpZ3rm9U/sL+NaTIojXcyi4/YP9Pp3XRYZFP+A5xwIpxe2Zob5nx0mgBJv9zIwDVkX0/TeEvIJVDVK8Uqm/7crKEYy7ZcOAIEQ14vHsLEx2N9QjlO6rc58iItR/R4BE8Blt6B70QdYESSqymI12gpBDHo7nbuCI5xh8jVfwgQt2oNawYic7dc9h8AdEPhIWT4M9XrLha5mvGa2g1NBAMrpMP5xW/Zsp6JxmFy3e/DipBnZft5HMkNOrwrLUocrMlvsRdtccY3bUP7K0JJh2NuiwAXR/nqiLcqiyh3lUlYg84ieC+amHCm0hE8ghX5NcCNTNJb08z3F7EUMiAvbf0L3RVUrED38KLqDZ94gHqzr4+LYgkmn7jq7Pd4HHt9wPDpCptlGiXtpkVJEA1dWBoXhYZls9LedDLVvAvL6hnO4q69gupaK6G3q8T+DhzebxK4W0wwSsywso1qbSAte+g3sh7OAV2MoauXbg/gZUgDUB+ObzVPBnZ0cKbS4JLuX7eIQp5MikKTi+QigjvZ/4VHJnQ/A6ZQUtHhSlTx4bJM+jrz9EQibcam9aVFoIgggEygdxmRUkP4dc7D/jZCvn9OXCewe8g5UsFAzAUOIB24IgHT/1YKoKHwNHw2TdBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3dXVlVtaGxnNVptY1ZYVFpzRGpYM09zcTlINGVjaUo0Z2NCNFdpQUZUOC9X?=
 =?utf-8?B?RTRGVExaZEszc2Zjc0dZdzZsOEtiRkw2ZWZ6azJCQUcvQ3pOOWZRVkk3TDZj?=
 =?utf-8?B?TXQ2RWRiWU92Ny9rSlZWeTdXdWovN0hZc3Y5K0RSWGlrRUwvZmFDVHJKSUJw?=
 =?utf-8?B?WWJnVy9FcXJjNTZzam1QaDFneTZSNGx4OGRpZ1lMbElzRGNzTm4yQU11bXhU?=
 =?utf-8?B?WjJQU2o5TWEvUU9ZbVlXVUxyTXRsQVhCTnU1MXA2WHpoTDJxendEcHdvNVht?=
 =?utf-8?B?MExCenpJcm1CZHBDTExPaTJYdkQ0cVhQU0JEQzUvNHlLanFuWTAyZHE3RG1y?=
 =?utf-8?B?allVT21aYk1CMi83blJqSC9tOVFnOGJRd0U1M3JVWklWVEtyYkRvTFJidzV0?=
 =?utf-8?B?UHVvb0JlOSs2QUd2M1JKeHlvaXF4VmY2MkZ1bjVTZS9SQ3RQQm9kcURoWnlF?=
 =?utf-8?B?WE5nZCtZaW1tVUZ6TmZ5M0xTcVZZUkJTelpRbXh0SzdkVHVheTJUaCtmVmps?=
 =?utf-8?B?czVsVVNHdUJNRWlFRDNJMGRrYVI2NzNaU0FBOGE0NS9wbFh2dVVJT1VoSjNk?=
 =?utf-8?B?RE8wcE9hTHpxRGFZNGVHR2RheUluUlMrTWpTNGNxbzhQQUFYYmFjME50VjBm?=
 =?utf-8?B?cFMyRW04cDRiT1Y3cThvUFYxZm1kOFZrZ0VPcmFZaUlLU0R3TVBsVnBNcTM3?=
 =?utf-8?B?cDhnVzVXTkluSmF6VC9xNzhWV0lNRWsxN2J6dXNaaHFEaFo0bTVMcFFGU3pR?=
 =?utf-8?B?ejhtWG9ibWdCWUVRUTJiYTE5WW1OOS8rN081eVRDa0tpYWtORG9TdC9vNnJ5?=
 =?utf-8?B?eHZBc200NWJFeXE1TXMwSmE4V2dBM1FrME0yNDBlSFA0WFp6TFQ4Z3dkNUpl?=
 =?utf-8?B?MEV2cFhkdGhhZzh6Y0RFUU55ekZFSU5oRHdTOUVrRnEyRWZURUVKU3lyblBP?=
 =?utf-8?B?Wm1pQW5EWW43Q2p1NnVKdS9rRERpU2wvZnlOWjdLeE1BM0gvaGIyZVYzVUhP?=
 =?utf-8?B?Qm40cXQ0ckN1bEluQUE3cHNiY0VVcks4cTVXTGZxQkV6R2NhYWUyZjEvOFBD?=
 =?utf-8?B?RjU5VEpxRTg0NDB0MDEweFgxQW1oV3RKL3l0VEd5dFcvd3ZQWk9USlI2eCtx?=
 =?utf-8?B?Q0dUOHFCTm44YzhCSGUvUFlmd3N6N2ZPL2tseU5hZXJ2UGc5d0tVQkE5RWxG?=
 =?utf-8?B?YVYvbkd5SUJXZGZqWWw4Z1J1bGdBbVRGMWJkUlJLMnVSaWxHa0JnQ2o3NkI1?=
 =?utf-8?B?ZHZLWTRDU0ZhRkZpKy9pUC9wc3dieWlacCtWZ052T3hHZnh2L1lsRnhuL3Q5?=
 =?utf-8?B?TnRLVlEzeHc2VG9OY0hTdTIxdStvM1FzNEpuc3V1OWFwa2JhZ0h6aG9aaUh6?=
 =?utf-8?B?WEdaUHZ1LzlrclBLYnlwZ1NqZUtET1B2ZXU4WDVkM29yRU9RTlYvQTdLUEtP?=
 =?utf-8?B?Uy8zYnBkbWxhSHN3b3JhSDd5cDNYN0JIckR0alBvS2tWcFNkRVRRMFl6TmRn?=
 =?utf-8?B?T0xtQ2F3enFnRnU1dWczbm1rbXQ0UFdtUC9TNVJyQjZ3STlHd1A5TDV5QlJY?=
 =?utf-8?B?M3p4bm90YUN5TUtJZnpJaGR4b1RWTGMxUGtXemhBek9GZm5XVTRYSjRSRVo1?=
 =?utf-8?B?V2tPY1pCM1p5MFJvYmFBQTlnL3AvSDNZUklkRDg5bjhjUDdWS0xqeHBHUHZJ?=
 =?utf-8?B?M3MzQ3JGbzFrUDczZ1EvcmRLcWNmNFpzUU15ZVdzQnR3RDBJc1V2NnAzbjBE?=
 =?utf-8?B?bzFWYVM0dGZrdFQxb3k3a2ZUWHZmYnhQY3ZiUnpsSERzMzhYUFh0Y213Zlgz?=
 =?utf-8?B?dzlJNGQxYnBRSTBhcElTNEFmYnhTbUVkVW40YnJETnhwZlVTNEhVK0pENnBa?=
 =?utf-8?B?MXJWL3lxRTFEWTk3cmVGczQ2VWNxcnZHbXFJdkx3cGhhbEd4dHZjSHgycnU5?=
 =?utf-8?B?N2Z1a1RyWGpRQ3d1TTBBZVZ2SG9VRXZBMDBOWkFxQnp4VytWOTJZalNoVCsz?=
 =?utf-8?B?ZGFGa3M2VG1DTzRXa0YrejZFZ1ArZjJwaTc2NzkvdVZHa2tzaUM3VTBORWtL?=
 =?utf-8?B?eGQyaHlicStYWUdic0FENDVVRnlVcFNRUkVrRmNCdUUrVTVZMUo0RU15c2tF?=
 =?utf-8?B?ckNXMURJeWMzSTJFSFVrY241Vk5TRGFGUHZkcncrQXl3azI2T09JeUJsOU9K?=
 =?utf-8?B?bk8wNGVTMXJTTmlEVWcyZGhOYzZxc2xyVFN6WDY0eFJickRNYUkrNjYxNDJx?=
 =?utf-8?B?Qkdieks1Wi9ad0NSUUs4b0xuQ0ZZYnB2ZVA3ZjVneWhOdFRtMVEzMXhsU0xR?=
 =?utf-8?B?QTFuNVF3aHM2Q056L21Ha1dtRUN0N0V2K0lyUzArUmxTSFo5bXJlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9c9905-5cea-43cd-d78d-08dee0d1fcdc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:29:29.0635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGhq+On/nE2FCU/VS0PPrVEH8wD7o6+Zx9vnub8kZcvAIeY+btgEvqAK6O8IhGgQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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



On 09-Jul-26 5:56 PM, Asad Kamal wrote:
> Update two cases in the smu_v13_0_6 GPU metrics accumulated
> counter field definition
> 
> Widen the following fields from U32 to U64 to prevent counter
> wrap-around and match smu_v15_0_8 field sizes:
> 
>    - prochot_residency_acc
>    - ppt_residency_acc
>    - socket_thm_residency_acc
>    - vr_thm_residency_acc
>    - hbm_thm_residency_acc
>    - gfx_activity_acc
>    - mem_activity_acc
>    - pcie_nak_sent_count_acc
>    - pcie_nak_rcvd_count_acc
>    - pcie_lc_perf_other_end_recovery
> 
> Correct the unit annotation from PERCENT to NONE for accumulated
> counter fields which are dimensionless hardware counters and carry
> no inherent unit:
> 
>    - gfx_activity_acc
>    - mem_activity_acc
>    - pcie_bandwidth_acc
>    - gfx_busy_acc
> v2: remove percent unit (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Series is -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 30 +++++++++----------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index a66bf33dbb58..6554780afff7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -144,15 +144,15 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
>   	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
>   		   SMU_MTYPE(U64), accumulation_counter);                      \
>   	SMU_SCALAR(SMU_MATTR(PROCHOT_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
> -		   SMU_MTYPE(U32), prochot_residency_acc);                     \
> +		   SMU_MTYPE(U64), prochot_residency_acc);                     \
>   	SMU_SCALAR(SMU_MATTR(PPT_RESIDENCY_ACC), SMU_MUNIT(NONE),              \
> -		   SMU_MTYPE(U32), ppt_residency_acc);                         \
> +		   SMU_MTYPE(U64), ppt_residency_acc);                         \
>   	SMU_SCALAR(SMU_MATTR(SOCKET_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),       \
> -		   SMU_MTYPE(U32), socket_thm_residency_acc);                  \
> +		   SMU_MTYPE(U64), socket_thm_residency_acc);                  \
>   	SMU_SCALAR(SMU_MATTR(VR_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),           \
> -		   SMU_MTYPE(U32), vr_thm_residency_acc);                      \
> +		   SMU_MTYPE(U64), vr_thm_residency_acc);                      \
>   	SMU_SCALAR(SMU_MATTR(HBM_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
> -		   SMU_MTYPE(U32), hbm_thm_residency_acc);                     \
> +		   SMU_MTYPE(U64), hbm_thm_residency_acc);                     \
>   	SMU_SCALAR(SMU_MATTR(GFXCLK_LOCK_STATUS), SMU_MUNIT(NONE),             \
>   		   SMU_MTYPE(U32), gfxclk_lock_status);                        \
>   	SMU_SCALAR(SMU_MATTR(PCIE_LINK_WIDTH), SMU_MUNIT(NONE),                \
> @@ -163,11 +163,11 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
>   		   SMU_MTYPE(U16), xgmi_link_width);                           \
>   	SMU_SCALAR(SMU_MATTR(XGMI_LINK_SPEED), SMU_MUNIT(SPEED_1),             \
>   		   SMU_MTYPE(U16), xgmi_link_speed);                           \
> -	SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(PERCENT),            \
> -		   SMU_MTYPE(U32), gfx_activity_acc);                          \
> -	SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(PERCENT),            \
> -		   SMU_MTYPE(U32), mem_activity_acc);                          \
> -	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(PERCENT),          \
> +	SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(NONE),            \
> +		   SMU_MTYPE(U64), gfx_activity_acc);                          \
> +	SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(NONE),            \
> +		   SMU_MTYPE(U64), mem_activity_acc);                          \
> +	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(NONE),          \
>   		   SMU_MTYPE(U64), pcie_bandwidth_acc);                        \
>   	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_INST), SMU_MUNIT(BW_1),            \
>   		   SMU_MTYPE(U64), pcie_bandwidth_inst);                       \
> @@ -178,9 +178,9 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
>   	SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_ROVER_COUNT_ACC), SMU_MUNIT(NONE),    \
>   		   SMU_MTYPE(U64), pcie_replay_rover_count_acc);               \
>   	SMU_SCALAR(SMU_MATTR(PCIE_NAK_SENT_COUNT_ACC), SMU_MUNIT(NONE),        \
> -		   SMU_MTYPE(U32), pcie_nak_sent_count_acc);                   \
> +		   SMU_MTYPE(U64), pcie_nak_sent_count_acc);                   \
>   	SMU_SCALAR(SMU_MATTR(PCIE_NAK_RCVD_COUNT_ACC), SMU_MUNIT(NONE),        \
> -		   SMU_MTYPE(U32), pcie_nak_rcvd_count_acc);                   \
> +		   SMU_MTYPE(U64), pcie_nak_rcvd_count_acc);                   \
>   	SMU_ARRAY(SMU_MATTR(XGMI_READ_DATA_ACC), SMU_MUNIT(DATA_1),            \
>   		  SMU_MTYPE(U64), xgmi_read_data_acc,                          \
>   		  SMU_13_0_6_NUM_XGMI_LINKS);                                  \
> @@ -203,7 +203,7 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
>   	SMU_SCALAR(SMU_MATTR(CURRENT_UCLK), SMU_MUNIT(CLOCK_1),                \
>   		   SMU_MTYPE(U16), current_uclk);                              \
>   	SMU_SCALAR(SMU_MATTR(PCIE_LC_PERF_OTHER_END_RECOVERY),                 \
> -		   SMU_MUNIT(NONE), SMU_MTYPE(U32),                            \
> +		   SMU_MUNIT(NONE), SMU_MTYPE(U64),                            \
>   		   pcie_lc_perf_other_end_recovery);                           \
>   	SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),                \
>   		  SMU_MTYPE(U32), gfx_busy_inst, SMU_13_0_6_MAX_XCC);          \
> @@ -211,7 +211,7 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
>   		  jpeg_busy, SMU_13_0_6_MAX_JPEG);                             \
>   	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
>   		  vcn_busy, SMU_13_0_6_MAX_VCN);                               \
> -	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64), \
> +	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(NONE), SMU_MTYPE(U64), \
>   		  gfx_busy_acc, SMU_13_0_6_MAX_XCC);                           \
>   	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
>   		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
> @@ -256,7 +256,7 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
>   		  jpeg_busy, SMU_13_0_6_MAX_JPEG);                             \
>   	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
>   		  vcn_busy, SMU_13_0_6_MAX_VCN);                               \
> -	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64), \
> +	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(NONE), SMU_MTYPE(U64), \
>   		  gfx_busy_acc, SMU_13_0_6_MAX_XCC);                           \
>   	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
>   		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \

