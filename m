Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FECFC5320E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 21:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F8B10E6F5;
	Wed, 21 Aug 2024 21:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dyPGMhCm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DB610E6F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 21:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXiAmN4eIfEcpRaMjkVtntPNcTKp6Fm906lBqS5uklE04Zq9Wbo3nRGKmm1yw0f1I2DxbdYKLDX1h1lp88eGpTb1liLTEVB8EYunz0uWh7QnECD6Wd9GVGs5696EnO/f9rss+6KIG1FZd3r7zToJIzv7IusOrjpBhvToMntNQf2aF1u4OkvzJ+0kzeVK3KngffRaohkwTkVwxp/nzihV3t9GlEMMnGdOljZ0U4SER20497xSywCoTdEWw9qEELLFLc9yglVbFd8W/ODeWXTLOoCiWiLYK18YStkJe/dFdrE6YUzuhIqJ6BPX6DPEFi9FFeLtp5psSZdCt9H+e8mBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH0r8UqWgVL77d6ypPjllSj6T5LxiFILsdwnqGz3nn8=;
 b=Mrb+koBRz7QNj9hIDx3zZaKJE2/Mm2vZosabd4ITA3WkDusXR3enuL3L4LVhk5rEMUs1i+6vTZbrShzBIouoHinlS1P4TY/cKaXIo+01ColXSrEfzZvFsbeaBEdkcEImYz7GlhTsg/CnEV85lSa+HkJTIyOc2Z9jG4id0etdzTTlwY23v727V5LduWfrRlkv+/Z7lPJcJbNxkLoUF4jjjEi2tM5d+5iyNaEINeCRwEZtUbWm9dPWwRj9O3m5PQYkoV1XT3ZnPYPRaGYBkj/+tbtvxD2agSqjEdriNTNutsbyEpRNYrZZ//mjKcSkoC4MUkRSl85hjlSH9pT1N7s6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH0r8UqWgVL77d6ypPjllSj6T5LxiFILsdwnqGz3nn8=;
 b=dyPGMhCm+A99gc13MovG7ZPCCfqBKhai5YgWOJrXlz9E+Vr19dK/KNQIjdAIhQ03ZuZEkd1k23ULE7JiwxzmYD/ctnr6bBiX/eBfJQFEac6h49lOMSmT5CMpHrPt2YI65Hep8Rw+mjAsrawQPaD+jWQE9jUyY/MzskoYn2qI3h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 21:59:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 21:59:50 +0000
Message-ID: <7755e287-6572-4b7d-96c1-98521702c2c9@amd.com>
Date: Wed, 21 Aug 2024 17:59:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx9: put queue resets behind a debug
 option
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240820202518.2110483-1-alexander.deucher@amd.com>
 <20240820202518.2110483-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240820202518.2110483-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 2881608e-558b-45f4-7f7b-08dcc22c9475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVFzVy94M2xrVTdPMHh0MWwrc2pSTjdhRzJHMmN6VjRtcXFQaC9xTDRtVVRI?=
 =?utf-8?B?TjRjYnM0NzlhVmEvMTEyZkNnWllVeWM1WER0aFNRdXVMU0VXOS91L29jR1h6?=
 =?utf-8?B?emI2dTlraWJTNm10UkdvWHFOVTZYZmtxSFJBVnY5VW9kZTZ3RWduZ1R1WUVP?=
 =?utf-8?B?OHdyeVIxaDFXdHBkMU5vK2RJTHZ6K1VaNWVmK1k1NmordUtMUit2ZWF4aXFU?=
 =?utf-8?B?czkxWlY1clNzVFkrVEZwL1AxZURlS1ZzSjVEQ2ZldzFJY3R3bmdZWWdNVDNW?=
 =?utf-8?B?b1VHV0kwSU8xci84WElzZTFYbHJJemNsVzhwR3BSekIwVUFzUEZGOTlQelNR?=
 =?utf-8?B?UUtaRno3MEpFTDVZYWtMZHRoRTl5alBqWjJCalFyQVB4ckJiWk1jdlA2L0lm?=
 =?utf-8?B?T2V1MS9LT0FrVDB1T25RSFpBQkhtUGZ4aUFWWXRiRGpMbXJOMFRaMEhDN3hv?=
 =?utf-8?B?dEZobmJUT0d4eTFwdTBERmhrSzdKY0lSM25yQUIzZmgyM2VCbHlFdHFFZ0cz?=
 =?utf-8?B?eWdZTExvOTcvRmVheEJaUnZsRzN3OG1kT29TcklKejVNZit0a003QnlTQjFl?=
 =?utf-8?B?WWgyVDdZWVVycVlDZEtrVldkNVB3b2NoZDNCU0tKeWRVREFEMkJISzRKWnpD?=
 =?utf-8?B?NUlSYTdaazdVbjlmWmlXYnRvOHN4c3paNC9HSmgvQ2M1bG1TYlBPZllsWk9l?=
 =?utf-8?B?ZnYzdEpPOGxRWHBFYXZ5TTZQR2Ura2tqYTk3WExCKzB0Q3BXOHVKTmY0SXpK?=
 =?utf-8?B?aC95d25KS3MvbS9hL3JvKzh1WjU3TXlsdEFhSTRGemRLQlhwd3ZvVmNOMEZj?=
 =?utf-8?B?MW54Mkk2SEdNMTltdndidUFVb0tSN0k4STNtTTV6cG1GRzlBWnQ1NFBrWVZk?=
 =?utf-8?B?aWJsdzUzemZtNEd2TTRNVGJueU40ditabndtb0t1N0I5Y2RQdkdJRW0wR2tu?=
 =?utf-8?B?L1pQTklsUkhYWjQvUEd0TE91RHlESGxzSmV1Ky8xeVE4Ym9nQnErVytQVTJN?=
 =?utf-8?B?alI5b1M3clJuVDh4dTF4THhtZDJWMmhjNGE2MnhxTHN5cjk2YUpFYVNndFda?=
 =?utf-8?B?L3hmQTlKc3FoVkJNTGJ2NEUybTFocmcxTWZRWmZkNVVadnNQMnQ5b3FZOXkw?=
 =?utf-8?B?SGZkTVo4TExPcHlVLzI0OEZrTXYvdDA2Umh1cTFoU1RlQXdkUiswbkpaa0lM?=
 =?utf-8?B?VTA3MWpHS2NwcGsxRm5NMmRqNzVQTjZta0cxNWZKYTdyYVc1TG5mUWZVZjI0?=
 =?utf-8?B?ZlVjazJYVWp0SFFrTUpiS0Q1Sm5MUzZGUTdoL1Q0Umc5dGc5NjI4Yk4yQm1M?=
 =?utf-8?B?OEdlYThKUmlVdHRSTGk1c0NWYnZLM0lvM0F1aU5xMTNHTGZIWmxkN3FzY2R5?=
 =?utf-8?B?REpYYzNsVXUrODZ5bmdhVlZDM1o4cForMXoxV2tmUU82V01QNjhzaC9kVkFW?=
 =?utf-8?B?S00yWXVRVmgxa3dxUUVPMDhKYTVaUllTNkdHYzZPVHdENHBwZkdBZFc4VVlz?=
 =?utf-8?B?WEtlSlNscDRVQ05KL1NVMk5ERnJrZzdFVUxXTWZIYTZlUTN0NjU3bnp0RUZ6?=
 =?utf-8?B?NzJlZC9OR2dFSVpVV3o2YXlBSFRpZWEvWXlLb3lVUVZ5VmFHblNXdTRpVzMw?=
 =?utf-8?B?RWdpRm8xcFBmRk84MTRSZ1VsSGd5VG9oOHArbVlobzFrL3lqbG5kdkNzYVJK?=
 =?utf-8?B?dWdZMGNsenMzcFpINXVSOFRhMjJuelpuRG9nd3NObUJlRkNaQXBxRjhNV3Vv?=
 =?utf-8?B?NStJRks4dkR3ekhrZHRveHlvamxaUTNoZlZEVkVrYSt3OWJRbnEzNkdsbllw?=
 =?utf-8?B?YnVCUDdWQkVkUG04SzZPQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhZUWZEQy95VEJmUXVCQ2Z4QXozVGlxYUttV3l1a1dsYkxWUmlJRXFtaEN2?=
 =?utf-8?B?NjJVTk1wallZRk1tZ2NvQlBpRnFscmVGeDNZbnRRS3ZweG9BL2pZM2lmWUpH?=
 =?utf-8?B?VUdybkx4NVRWT3AybVNqa3V4c3lnNDZ6TzBqVGJOM2VPakEyRW5JWnQ3RVF1?=
 =?utf-8?B?ck9vRmsvaFdoM0xpSEZYTGlKMDFOellzUVdrUzFRVVpmVlJnTU5LbW1DbTlo?=
 =?utf-8?B?SnNEc1F1ZEpvbExheU5YdmFKenNvL1dMUDh6VE9FbTBXcS9hN2piYm9rb1NC?=
 =?utf-8?B?dzNaVkFISGYxYm9yelh4bzl5TkJxMVB2aittb242cEN6Z3NFdTdsOC9TY29u?=
 =?utf-8?B?MzkzQXd2RmE1amlBZldyUmJxQWdWNmF5bXhZVzdEN1R3SkFRN2NpMURNT1dJ?=
 =?utf-8?B?S093TEsyU201cHNZWFF2d1plSEVTN3MvTldTTFRrTlM4SGpKQlMxZDJnZjYx?=
 =?utf-8?B?ZW0zWjdQRjRXOGxxVVJKaUQrc2FoVElKb2E1NzEvMXhNaUlCb0NqMEZWd3dq?=
 =?utf-8?B?aUhmSEZlTEJFQlVVR1VseERBVFNqTzdSRmlFK3czVjIwQlI3THFua0pOaGNj?=
 =?utf-8?B?TDFsVU5Ib0RJYmNUZURTT1N5aHp3ekV0N1drajllNVllRnJONUo5Lzd4R1Zj?=
 =?utf-8?B?cUxXK3FoYUc1K3FuRENJNnRJcEo4bG0waFJNdG4zdFhjVGhyY0xVK29RcUoz?=
 =?utf-8?B?Y3BOczRoamYyaWpud1Fqd1NkQjJzZk5DLzZlMSsxUEI0QVZ5RGNjMDV1TGx5?=
 =?utf-8?B?YUdBNnpmT3EySDhlVC9MV3lDNnQvcnJadDU2Y3FnU1dadGN0UzdTcGdKVGdR?=
 =?utf-8?B?a2NIVllCcXhuaG1QOVZuSVN4T2xPWUkvNU9UYlVjZzltbm4rbzF0TkVpUlBU?=
 =?utf-8?B?VU5CUWJCSnBpU3FVaDVwVTE3STdzdmsrTmdTNDhRNmlTdFpkRU56d3ZOTGRa?=
 =?utf-8?B?bEZtL2pTVWFIWUNveG5URGRrZitORmlJVTJ2a0dVd0V4Z1hPOUEwRVFXekhW?=
 =?utf-8?B?SjJyNi9FVXRxNkpoeng5ck43dGx4Q0h2bTBadGpUT21semVOdUl6SFYvR0h6?=
 =?utf-8?B?NjViRHBKbDdwRXlOb2FVaG1aZU1ucmdvdHpTT3VDdElpTEpoQ3RuQndRZXdh?=
 =?utf-8?B?aTVGOUcrR3RBaVZINFcvZWVDNjZqd3Q1SmNkc2N5ZnpncnRLVDhEbUtoWFFm?=
 =?utf-8?B?Mi9JQzBaOVNjcVowbGp2K2hQN3hHRVJDN2lVaDZjK1NRdmFnaE56V1B2eXJz?=
 =?utf-8?B?OXlFQ2tmRWdFMkM0ZjBSVU11VjRaS20yc2xEWHJlRFdzVDZRV2lOTlpzdHlM?=
 =?utf-8?B?cWszbHV1UnBPb1JleVlQRXMxQmpZaDgwTjFVb1RiM0pHRStzK3R4ai9DY3pT?=
 =?utf-8?B?cEl1cXhaWXZPKzFDeDRtTWc2dlRvd3llZlZKTEx5bi9oZER6N3QzeGpKTUIv?=
 =?utf-8?B?YXNZVERZVDBMaTBwNVhzY0FXNC9WYzliei9XdndQaEdyckVhVG1uREx2RzJL?=
 =?utf-8?B?ZXI1Vm1SZFhWbUdiYUlySWkzbWFlUHQxVnc1dGpCbC9Fa0NoN3dYTkhmUEwz?=
 =?utf-8?B?SkJZVkxUOEpCN3BWMXBxZ1c0a013UUc1TldBSzU1NzE1MEwwcExzV1RiRzI2?=
 =?utf-8?B?a0tlZlQ4bDhGL2FXaEFUdXpGQzJDM0IxTFhwMW1JZ0piTWkyL1hyTzRMTDBT?=
 =?utf-8?B?cWYzR0xtR0gwUHV1VERmbXRHcHl5VWxEY1hiZE1VZVVQUlViblV5REdYenVv?=
 =?utf-8?B?K2Rkb2haVFYxanM0LzRHZW9Ya2l0Mmg3SFVuRUdFdWl4MGwrVmh1TGtpbWdR?=
 =?utf-8?B?emNTbFY5RVBJdm1kSWJ6Vmx4WUlhUjRmMnFxZjg4SzFlMVV6SGE1Z3BuSFgz?=
 =?utf-8?B?TUJ3RVhncjB6WGdPcU91VVNtbzRueldzejh4NnovbHVyNWVYR3h1b2xUdTVT?=
 =?utf-8?B?VHVRV2pZOGI5TWlLaitqTXhuY2VFVmM0RlorSlF1VHo4ZVZEOFlmL2pUL0gx?=
 =?utf-8?B?NUp0bjJ5YkNnMkQwM3IwM2JqMkFTU051dzBOaTIrRjhYcjBzTjZvdjBGZHhj?=
 =?utf-8?B?SjdzejNaZ1g4MVpjNTdDY0pXRkhzQkJZdWJJVCtwMjBwcmlKU2lEbzlCeUIx?=
 =?utf-8?Q?qDBvmOvm22ug5MOjRLGWhoE+8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2881608e-558b-45f4-7f7b-08dcc22c9475
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:59:50.5948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHZLMPTCYCMFLdp3dcRpX7NvpTDsYq/yC1SOr9r8fmPxXI0IhMhmzuYbL/0A9Pvtq3dZfQK5AweH1y5fsIfXKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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


On 2024-08-20 16:25, Alex Deucher wrote:
> Pending extended validation.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 6 ++++++
>   3 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index c63528a4e8941..1254a43ec96b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1151,6 +1151,10 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
>   	uint32_t low, high;
>   	uint64_t queue_addr = 0;
>   
> +	if (!adev->debug_exp_resets &&
> +	    !adev->gfx.num_gfx_rings)
> +		return 0;
> +

Did you put this in the HW-specific code path intentionally? If you want 
this check to apply to all ASICs, you should put it into 
detect_queue_hang in kfd_device_queue_manager.c. But maybe the extended 
validation is HW-specific.

Either way, the patch is

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


>   	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>   	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 21089aadbb7b4..8cf5d7925b51c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7233,6 +7233,10 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>   	unsigned long flags;
>   	int i, r;
>   
> +	if (!adev->debug_exp_resets &&
> +	    !adev->gfx.num_gfx_rings)
> +		return -EINVAL;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		return -EINVAL;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2067f26d3a9d8..f8649546b9c4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3052,6 +3052,9 @@ static void gfx_v9_4_3_ring_soft_recovery(struct amdgpu_ring *ring,
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t value = 0;
>   
> +	if (!adev->debug_exp_resets)
> +		return;
> +
>   	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
>   	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
>   	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> @@ -3475,6 +3478,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>   	unsigned long flags;
>   	int r, i;
>   
> +	if (!adev->debug_exp_resets)
> +		return -EINVAL;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		return -EINVAL;
>   
