Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7289FC02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 15:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2347E10E6A8;
	Tue,  4 Feb 2025 15:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="An0un/9n";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B923A10E6A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 15:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8DJ3KTV2o6Dqs3TzVlknAQeRxxHyiQuB628SCxC/JMzj2fJVAUpQ4QzMfg4t6jMndv4LGp8GjJ81GvH+3iPZY2OlQB2IWnhJ3mlZS55f4d0WTdDrtnXOuTtn+pJveGbY/OwiLh/2dy0ghfIKYctsHlC+5C5bnMnmggQWSnm8locZHDDkvv+TemjLdx4KQXDpYUi7mWXFNDLHKHqMKGYYdyPw9t37Kfd737teSR64g/AQLlJ9hcKwhZvRy4A1xfW2vcCUXvE0d/5o6YsPpVZoBXS4K2yQOPeBQB47tChRAOHBV3fVQjIphRKyzlYxbSSrbm4VQm74O27HEEpFNwWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jeu0Kh1U8BTJy18YJ6xHzF5tIzXdntfbksRvlhiFVMI=;
 b=qhlcQfjrFN3fGU9F2elatNpk0ntfFOAQw/bjYSb796fxXFJJ/H75+b41YKKfSeZ1sv96eU05wsmniNtjlIpXEke9uOGd6cM1sFIwQ/dd/dxRCDDj9QG48UzdAhLhXE0g9hWBSLu0Qhmsf7j0bv3hLPZAowYkp+Jdm4WRoKMsyQ7gU7vPYbTcvAYphjeRRFYVERt3Mmt4gUs6OXIjTs+qn8jpJr1+1cVzWkK2XB0U7zlFihRL7oe1ZLhq5/vg6ly/ZeCcWtEHo8oXBNqv2u5yt+iChNQbodrfCK6V2Ycn1F1Jjz8X5bk8rwKDRZLhYXrzydbLy133gC574T8wYJ/RoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jeu0Kh1U8BTJy18YJ6xHzF5tIzXdntfbksRvlhiFVMI=;
 b=An0un/9n8bYe4/g7HJ8083djPiPl8XTaK8v7eR6CL7Mj1YuNeLh+PCiCbBD82TmGsiTgC3OfWwluEEM80lNfTZc8goFixy3A/YjQrLZ+rB4UoBepSv0evZdSKtNk5+3VPSnxqUk8fmxte/kIjWG87K05SbbwP369TNK5aVb/UVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 15:51:00 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:51:00 +0000
Content-Type: multipart/alternative;
 boundary="------------w34KAMOc084V01mR0s0FALcg"
Message-ID: <1cedfb14-ad71-4753-906a-652711960402@amd.com>
Date: Tue, 4 Feb 2025 10:50:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/44] drm/amdgpu/vcn4.0.3: split code along instances
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-5-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-5-alexander.deucher@amd.com>
X-ClientProxiedBy: YQXP288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::20) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 79373465-f7b5-4653-9d9e-08dd4533b8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anhaY0F2b1RvVVI4N2tOL3l3OW8wVVVrbUlQRHdIc1ZlVkxZeDRPSUp4YTJt?=
 =?utf-8?B?S0NybysyUW03K2FjTWlseGROcGVwamF1MEZvV0pCY0dzMFJHdlRma0dBOWFp?=
 =?utf-8?B?dHFlRTFSQzlrZGRydXZiQXlqY3hJbE52UjNPeFVPYjdVZnBTbllNTHVhR3ov?=
 =?utf-8?B?RHRNeis3ckNUQXNJSVQvb2F6SVVETC9GVG9VZXl5NjExTEJQUmVsVU1OUng3?=
 =?utf-8?B?Wlg5ZUthMzRrWG9xNVdzcjFUcjBqM3BPeHZrb2l3ZFU2bE12N0x0ZmpNMzBk?=
 =?utf-8?B?d1lBY25jSE5aRTBrYzhIdG5ZelZiZUJkbDlwVWgrMGJQNUpqT0xtc252ekV5?=
 =?utf-8?B?RERpNHNBN0dHc3poZ2J6NEZ5ekpmbW5HYlVTQzBFZnJNZG9NQ3JudkdVMExV?=
 =?utf-8?B?RGY5clRDY2d5WVYycng5alRxVDJVbk10aWliTm1DUTRwRkhZVzY4VnQzYjJS?=
 =?utf-8?B?dkdybVlHZEVuZDJmVklKVjlZL3RYUmdKOFdnWmp2WlhxUE80anozU29PWEtR?=
 =?utf-8?B?ZjlUVkp3QkVSRjRYRzZYZ0ZmczRRaFF2RXhQVnM5ZWVNcDMweGNVTHZqTThz?=
 =?utf-8?B?MHFCZXk4S0FCRTN2Q3ZXYjhFK1JULzJVNWZmZlFsdmpKQUcyMDBpanV5QVJZ?=
 =?utf-8?B?dlJEaWZIajVvbjF6d2lpaHdKNnJicDBVaXhZN0xCL1AvbE16dVRVY0txUm8w?=
 =?utf-8?B?Rm9heTNzamhHK2ZOdm5XWFc1aUthdGtieVBqRGlCSHN4c3BjS3hHTnhNazh1?=
 =?utf-8?B?eFl1U1dTNlE3NUNRODlqNW5PdEJlNTNyZ1BaSVFXRlZIVXdsRHRpNGNjNmRM?=
 =?utf-8?B?RTU4d1ZoNXlsc2xjUlJ0dlV3ekdVR1NWWVB6aERhc0h5ZklIUlQxdGVHMzRE?=
 =?utf-8?B?Z1FRdUhqOVJXNE9vb2RSZ253N2FqR2k5Q2dOZndDWXJUd2JVazhDWi9vcDk3?=
 =?utf-8?B?RDl4anZ4aDlFZFJBYjFsTHMyU2ltc2FyN2xLUWxqSDZGUmRLYjllYm8xTkQ0?=
 =?utf-8?B?QXQyeUR5K1czeHptYk81cTI4Tk5KdUNIc3JxWjA1Nk0zZnJBU2hpdFpxUmxv?=
 =?utf-8?B?Qm1ZZ2ZweCtielRTSmdRMkQ5UE9pQjNzaXl5VDRtSWxDdGpja2c2eEJDdUkw?=
 =?utf-8?B?Uy9ydmg2K09JSVBMbFNDVHd2WGEwc2xSSDY4dG0xQ25zaTAwb0gwczd6Yi9L?=
 =?utf-8?B?TE9GakVEaCtRYlVQRVFDczNaRGIwenZBempDbjVPUWJoWjhLdzhkeWg0Vnp5?=
 =?utf-8?B?U3hEa2xWOFkrVG9pVDl0WjhYQzVDcGt3d04zMXpEMlNTYVQrUXh0Q1VQSVdG?=
 =?utf-8?B?QXNrbElWNWEyZ1g3Vmp6V2ZnTFdDdURsOTZKR2NoY1c5M25LeG1YcHJCakY0?=
 =?utf-8?B?S0JLS1g0R3lVczhlY0thYWdDbWwrNDBoYmJRZFRVQzdzd0JldHkzS3NFYVc3?=
 =?utf-8?B?dU0zM2NHRkJzMERuMHVYeTArTGJmNTRKZDdCaWVDZkF2UlNuYWpMMmxHUTli?=
 =?utf-8?B?anF1NmVMQXFFNElIRWhES1JxQ2lQRmxnY09ROUl6ZWFhVzlyOEdHVkQrVnVl?=
 =?utf-8?B?eDJLNTJXN0JzMlVMODZCZWhjUEh5SjN6OHU3NUY2d3MwMUs4TzZOajJTUS9s?=
 =?utf-8?B?dHlPcjNldHY4M2F2UVVheUxyMldiSFVLTkg2dElpK0dhTkxUNWVwRjZVWFpz?=
 =?utf-8?B?S2JZUlB6bllYWSs4dXdBVVgwVFh2ZjZIcE83VXl6djdDTmxCY1dSTVRIV1BJ?=
 =?utf-8?B?ZU9GditHLzVLUXFwYTBqaytJbnNWNm4yRWsyUHpHcG0raEJWL2liM3hHbDU3?=
 =?utf-8?B?blVoWFNtMU1maUFwN3BMdmZaUlluV05iY3RMWTE3bjBDS2tJTW81anltTG01?=
 =?utf-8?Q?dc3j8TW5jPjZk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V205eUV0VG9ZeXlENmpuS1QwUk5xT1FHcWpiVjUwQzlnQzk5Z1ZzTmpEMEFw?=
 =?utf-8?B?VTVWM2liTis3c1ZWbDhONTBUdU9BcDE0bExWa1l0RGxub1cyNXVjRHAwU2F2?=
 =?utf-8?B?OGI1NkJBS21lK3IweU00ZW9jcGJ2M0UvNGJHNGZndmh4d0pYTERsQ1BTQk9F?=
 =?utf-8?B?THRQZk1zdlYyenlhOVYrQkVNUDdJdHpKYm5IWWNzSVEvWGE4RFZaWHh1ei9m?=
 =?utf-8?B?bnA4MlpGbnVHYmJFNmNjdG5nV3dmR05vUDIrRlFkVTB0VmErNDVCbzhGb1lR?=
 =?utf-8?B?WE1saEVHeno2ZUhocWhhUi83eGNpdEhEZDMzdmlEQmFCenFJQ2F3Wnpwc0Nz?=
 =?utf-8?B?VDhCUm03RUVvWGxocEdUNCtub1ZGN0pLM1ZEY01tODdJVWNrdHV4ZlpFdUR1?=
 =?utf-8?B?TGVqSDQ5Y3JHaDBURVZhNFd4NzhxS3RHMGxVbExDRkhrMGpUM2xlcXUveHBt?=
 =?utf-8?B?QTQ3dW9ybFNIejhpZVhzaFpkNG9rWWlkZGxKeUxUdTh2a2N4WWs5WHRTZkww?=
 =?utf-8?B?Sjc4bmxYM1FnRHYxRmxiUlNtZ1V0L0dMU0k2dGd2OVpLU1NTRVc4MXVtWmNI?=
 =?utf-8?B?ZndFMnZ1Sm9TanVnUDFXd0VVeiswZmg1YThZZ3V2aEJWcjk0Wkp2bTVOelBn?=
 =?utf-8?B?QmRhRG1na2c2T3UrczNHOXNiTHV6bVR5Szl2Q2YvZVhFZWNYdmJLcThSSkV6?=
 =?utf-8?B?ZjZMRU9WK1d0a1hIMENkTmZBeURLQ2VDR2VxdTBPcUd3VGd2TTR1RFIreW1h?=
 =?utf-8?B?RFQwR1Z4Z0xSYm5DWlQvZDU0c24xTnJ4eUxrUGFRRjg0YVlXK0RERHZEdjFL?=
 =?utf-8?B?NDRianppeUs4T2VkUFBZVm9Zc1ViSzUrZmtsUEMxeWplRmNVdW8xcHk0WGVW?=
 =?utf-8?B?YWdSL0g5UXFUTHAxUVFpZWVMT3dnKyt0MEdOd3FYZU1TVnV6cUI3TDR2Y2hB?=
 =?utf-8?B?bmFlUHllaHMrRlpRQllDZzlNbDdzSVlQRkVXa0p2cU13Y3lLeXZQdldpMTZa?=
 =?utf-8?B?VFR0cm8rdGFxNXhCVnlhdmE4ZTdwa1V5Z21ickREb1JnYUhQeUJwdnlWZ0VF?=
 =?utf-8?B?UERaVVJpaThTMTJQRHhCZVF4SUR5eEVtUis4cVR6Y3FhazdMUmcyUWRvZE1z?=
 =?utf-8?B?RGxZMU1PcUlVclU4ZG8wQUVDNkZxcFNpaTVTWTArMnhwWVhhTTRwOE13TlBS?=
 =?utf-8?B?MS92OFVRbU8rZ1lOK3BYQjZWaUNzcFhvU05xZ2wrOFkydjBFdzVwOTZlblpa?=
 =?utf-8?B?MllhZWIxcWt2N3JyQ1dzN0xxNlNlNi9LSnFibHVuWjVueXpNWXRjWHdkNnRD?=
 =?utf-8?B?QUpvWWo5eUdDcVdWNEF4RFp0YWNjODhsU0svamlHZm5rQVlncjBCbXpZZTZp?=
 =?utf-8?B?YXJxWEV6Z21QQzcwbUV1L0RjRU5MeEpRM1k2S0FwbmMvQlNjZWpWL3VQNDUr?=
 =?utf-8?B?TnFWRVVJRFd0R2trU01EY2R0RGlrUHhSNUx3RktrSmV5VzFmRVdTcFJMK1k3?=
 =?utf-8?B?QlNlYjBUY3B6Nk9BbWNxY041VjVPYXdMdDgrWU94MTdLYWVhUXp1eXNsTndZ?=
 =?utf-8?B?Ty9TeHVaZjBwVnN0emFRcU95UWx1Ym02OVJXb2tXejRuYVBTclZ2OGFmYnl3?=
 =?utf-8?B?OXJ0UUV0c0dMQjdldlBDdlkrV3c2Rk5zYTQ3bFlGdjdHejdpcjB5TlF6dnQw?=
 =?utf-8?B?OU9IMHh6MW85YzgzQjZ4OUErNDUwOVVaUTVUWjRsN0E0cjc4OEU5RmZIZ2RD?=
 =?utf-8?B?N29kZkxkSUFhd2JWRUtHQWd0VUVVM1paSUszTXExekgzVjMwaFRaQVQwaDJF?=
 =?utf-8?B?ZWh3b0VITE5rTG5tQXhhWktRNEQrR2J5QnhXSjFkOU13SkhZcUdTczVJWVBH?=
 =?utf-8?B?MHFpeTF6ZUJqMHFJeGdMS0l3dytQOU1YdFl5Q2pXbHhpNmZad1B4Skg1L25E?=
 =?utf-8?B?dzZjNFo5V2MrT1k1NUlWR2ZWVTJCRkd2MHN4S2VqTWwxaWRVdnp1R0loODlK?=
 =?utf-8?B?aXhuN2w3MjFhK29TVHp4NFJ3VmYyU21YYjVyenVMMVJTMCtuQ1EvRFFNbGVC?=
 =?utf-8?B?dldRTERIL3cvWFE3RkVGdDY0Z3R3UmRnV0NFM2tBcUIrT0FMcW9PUTZoWW84?=
 =?utf-8?Q?zpT+w9WMnN+JqJJcO3PmSk6zL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79373465-f7b5-4653-9d9e-08dd4533b8c6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:51:00.4062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq1Izq1ovrJ5lA+3u4F31uE5AwF3WyksfyhjtdfEpwxwsNKVqrGFTdcCUrpTqk8g+BIAO0t3t7VUNt/SIQgj1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
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

--------------w34KAMOc084V01mR0s0FALcg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Split the code on a per instance basis.  This will allow
> us to use the per instance functions in the future to
> handle more things per instance.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 417 ++++++++++++------------
>   1 file changed, 206 insertions(+), 211 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index f0716c10f23e4..6293d1dc02fec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1117,177 +1117,172 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
>    * vcn_v4_0_3_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to start
>    *
>    * Start VCN block
>    */
> -static int vcn_v4_0_3_start(struct amdgpu_device *adev)
> +static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
> -	int i, j, k, r, vcn_inst;
> +	int j, k, r, vcn_inst;
>   	uint32_t tmp;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, true, i);
> -	}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, true, i);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>   
> -		vcn_inst = GET_INST(VCN, i);
> -		/* set VCN status busy */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
> -		      UVD_STATUS__UVD_BUSY;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
> -
> -		/*SW clock gating */
> -		vcn_v4_0_3_disable_clock_gating(adev, i);
> -
> -		/* enable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> -			 UVD_VCPU_CNTL__CLK_EN_MASK,
> -			 ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -		/* disable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
> -			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -		/* enable LMI MC and UMC channels */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
> -			 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> -
> -		/* setup regUVD_LMI_CTRL */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
> -			     tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -				     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -				     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -				     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -		/* setup regUVD_MPC_CNTL */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
> -		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
> -
> -		/* setup UVD_MPC_SET_MUXA0 */
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
> -			     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -			      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -			      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -			      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUXB0 */
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
> -			     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -			      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -			      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -			      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUX */
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
> -			     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -			      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -			      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -		vcn_v4_0_3_mc_resume(adev, i);
> -
> -		/* VCN global tiling registers */
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
> -			     adev->gfx.config.gb_addr_config);
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
> -			     adev->gfx.config.gb_addr_config);
> -
> -		/* unblock VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
> -			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -		/* release VCPU reset to boot */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> -			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	vcn_inst = GET_INST(VCN, i);
> +	/* set VCN status busy */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
> +		UVD_STATUS__UVD_BUSY;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
>   
> -		for (j = 0; j < 10; ++j) {
> -			uint32_t status;
> +	/* SW clock gating */
> +	vcn_v4_0_3_disable_clock_gating(adev, i);
>   
> -			for (k = 0; k < 100; ++k) {
> -				status = RREG32_SOC15(VCN, vcn_inst,
> -						      regUVD_STATUS);
> -				if (status & 2)
> -					break;
> -				mdelay(10);
> -			}
> -			r = 0;
> -			if (status & 2)
> -				break;
> +	/* enable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__CLK_EN_MASK,
> +		 ~UVD_VCPU_CNTL__CLK_EN_MASK);
>   
> -			DRM_DEV_ERROR(adev->dev,
> -				"VCN decode not responding, trying to reset the VCPU!!!\n");
> -			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> -						  regUVD_VCPU_CNTL),
> -				 UVD_VCPU_CNTL__BLK_RST_MASK,
> -				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> -			mdelay(10);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> -						  regUVD_VCPU_CNTL),
> -				 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	/* disable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +	/* enable LMI MC and UMC channels */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
> +		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +
> +	/* setup regUVD_LMI_CTRL */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
> +		     tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +	/* setup regUVD_MPC_CNTL */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
> +	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
> +
> +	/* setup UVD_MPC_SET_MUXA0 */
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
> +		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUXB0 */
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
> +		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUX */
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
> +		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +	vcn_v4_0_3_mc_resume(adev, i);
> +
> +	/* VCN global tiling registers */
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
>   
> +	/* unblock VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +	/* release VCPU reset to boot */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	for (j = 0; j < 10; ++j) {
> +		uint32_t status;
> +
> +		for (k = 0; k < 100; ++k) {
> +			status = RREG32_SOC15(VCN, vcn_inst,
> +					      regUVD_STATUS);
> +			if (status & 2)
> +				break;
>   			mdelay(10);
> -			r = -1;
>   		}
> +		r = 0;
> +		if (status & 2)
> +			break;
>   
> -		if (r) {
> -			DRM_DEV_ERROR(adev->dev, "VCN decode not responding, giving up!!!\n");
> -			return r;
> -		}
> +		DRM_DEV_ERROR(adev->dev,
> +			      "VCN decode not responding, trying to reset the VCPU!!!\n");
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> +					  regUVD_VCPU_CNTL),
> +			 UVD_VCPU_CNTL__BLK_RST_MASK,
> +			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		mdelay(10);
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> +					  regUVD_VCPU_CNTL),
> +			 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		/* enable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
> -			 UVD_MASTINT_EN__VCPU_EN_MASK,
> -			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +		mdelay(10);
> +		r = -1;
> +	}
>   
> -		/* clear the busy bit of VCN_STATUS */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
> -			 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +	if (r) {
> +		DRM_DEV_ERROR(adev->dev, "VCN decode not responding, giving up!!!\n");
> +		return r;
> +	}
>   
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	/* enable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
> +		 UVD_MASTINT_EN__VCPU_EN_MASK,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -		/* program the RB_BASE for ring buffer */
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
> -			     lower_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
> -			     upper_32_bits(ring->gpu_addr));
> +	/* clear the busy bit of VCN_STATUS */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
> +		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
> -			     ring->ring_size / sizeof(uint32_t));
> +	ring = &adev->vcn.inst[i].ring_enc[0];
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
> -		/* resetting ring, fw should not check RB ring */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> -		tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
> -		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +	/* program the RB_BASE for ring buffer */
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
> +		     lower_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
> +		     upper_32_bits(ring->gpu_addr));
> +
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
> +		     ring->ring_size / sizeof(uint32_t));
> +
> +	/* resetting ring, fw should not check RB ring */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> +	tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
> +	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>   
> -		/* Initialize the ring buffer's read and write pointers */
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
> +	/* Initialize the ring buffer's read and write pointers */
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
>   
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> -		tmp |= VCN_RB_ENABLE__RB_EN_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> +	tmp |= VCN_RB_ENABLE__RB_EN_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>   
> -		ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
> -		fw_shared->sq.queue_mode &=
> -			cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
> +	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
> +	fw_shared->sq.queue_mode &=
> +		cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
>   
> -	}
>   	return 0;
>   }
>   
> @@ -1327,86 +1322,84 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v4_0_3_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to stop
>    *
>    * Stop VCN block
>    */
> -static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
> +static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -	int i, r = 0, vcn_inst;
> +	int r = 0, vcn_inst;
>   	uint32_t tmp;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		vcn_inst = GET_INST(VCN, i);
> +	vcn_inst = GET_INST(VCN, i);
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			vcn_v4_0_3_stop_dpg_mode(adev, i);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		vcn_v4_0_3_stop_dpg_mode(adev, i);
> +		return 0;
> +	}
>   
> -		/* wait for vcn idle */
> -		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
> -				       UVD_STATUS__IDLE, 0x7);
> -		if (r)
> -			goto Done;
> -
> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__READ_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> -				       tmp);
> -		if (r)
> -			goto Done;
> -
> -		/* stall UMC channel */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> -				       tmp);
> -		if (r)
> -			goto Done;
> +	/* wait for vcn idle */
> +	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
> +			       UVD_STATUS__IDLE, 0x7);
> +	if (r)
> +		goto Done;
> +
> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> +			       tmp);
> +	if (r)
> +		goto Done;
> +
> +	/* stall UMC channel */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> +			       tmp);
> +	if (r)
> +		goto Done;
>   
> -		/* Unblock VCPU Register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
> -			 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	/* Unblock VCPU Register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
> +		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -		/* release VCPU reset to boot */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> -			 UVD_VCPU_CNTL__BLK_RST_MASK,
> -			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	/* release VCPU reset to boot */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__BLK_RST_MASK,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		/* disable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> -			 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +	/* disable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> +		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -		/* reset LMI UMC/LMI/VCPU */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +	/* reset LMI UMC/LMI/VCPU */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
>   
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
>   
> -		/* clear VCN status */
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
> +	/* clear VCN status */
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
> +
> +	/* apply HW clock gating */
> +	vcn_v4_0_3_enable_clock_gating(adev, i);
>   
> -		/* apply HW clock gating */
> -		vcn_v4_0_3_enable_clock_gating(adev, i);
> -	}
>   Done:
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, false, i);
> -	}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, false, i);
>   
>   	return 0;
>   }
> @@ -1663,7 +1656,7 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret;
> +	int ret = 0, i;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
>   	 * MMSCH FW should control Power-gating and clock-gating
> @@ -1677,10 +1670,12 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	if (state == adev->vcn.cur_state)
>   		return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_3_stop(adev);
> -	else
> -		ret = vcn_v4_0_3_start(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == AMD_PG_STATE_GATE)
> +			ret |= vcn_v4_0_3_stop(adev, i);
> +		else
> +			ret |= vcn_v4_0_3_start(adev, i);
> +	}
>   
>   	if (!ret)
>   		adev->vcn.cur_state = state;
--------------w34KAMOc084V01mR0s0FALcg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-5-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark1tk8wrane" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-5-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 417 ++++++++++++------------
 1 file changed, 206 insertions(+), 211 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index f0716c10f23e4..6293d1dc02fec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1117,177 +1117,172 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
  * vcn_v4_0_3_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to start
  *
  * Start VCN block
  */
-static int vcn_v4_0_3_start(struct amdgpu_device *adev)
+static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
-	int i, j, k, r, vcn_inst;
+	int j, k, r, vcn_inst;
 	uint32_t tmp;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_3_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v4_0_3_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
 
-		vcn_inst = GET_INST(VCN, i);
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
-		      UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v4_0_3_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			 UVD_VCPU_CNTL__CLK_EN_MASK,
-			 ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
-			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
-			 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
-			     tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-				     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-				     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-				     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup regUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
-		tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
-			     ((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			      (0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			      (0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			      (0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
-			     ((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			      (0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			      (0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			      (0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
-			     ((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v4_0_3_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
-			     adev-&gt;gfx.config.gb_addr_config);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
-			     adev-&gt;gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
-			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+	vcn_inst = GET_INST(VCN, i);
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
+		UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
 
-		for (j = 0; j &lt; 10; ++j) {
-			uint32_t status;
+	/* SW clock gating */
+	vcn_v4_0_3_disable_clock_gating(adev, i);
 
-			for (k = 0; k &lt; 100; ++k) {
-				status = RREG32_SOC15(VCN, vcn_inst,
-						      regUVD_STATUS);
-				if (status &amp; 2)
-					break;
-				mdelay(10);
-			}
-			r = 0;
-			if (status &amp; 2)
-				break;
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK,
+		 ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-			DRM_DEV_ERROR(adev-&gt;dev,
-				&quot;VCN decode not responding, trying to reset the VCPU!!!\n&quot;);
-			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
-						  regUVD_VCPU_CNTL),
-				 UVD_VCPU_CNTL__BLK_RST_MASK,
-				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
-						  regUVD_VCPU_CNTL),
-				 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
+		     tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup regUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
+	tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
+		     ((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v4_0_3_mc_resume(adev, i);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
+		     adev-&gt;gfx.config.gb_addr_config);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
+		     adev-&gt;gfx.config.gb_addr_config);
 
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j &lt; 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k &lt; 100; ++k) {
+			status = RREG32_SOC15(VCN, vcn_inst,
+					      regUVD_STATUS);
+			if (status &amp; 2)
+				break;
 			mdelay(10);
-			r = -1;
 		}
+		r = 0;
+		if (status &amp; 2)
+			break;
 
-		if (r) {
-			DRM_DEV_ERROR(adev-&gt;dev, &quot;VCN decode not responding, giving up!!!\n&quot;);
-			return r;
-		}
+		DRM_DEV_ERROR(adev-&gt;dev,
+			      &quot;VCN decode not responding, trying to reset the VCPU!!!\n&quot;);
+		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
+					  regUVD_VCPU_CNTL),
+			 UVD_VCPU_CNTL__BLK_RST_MASK,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
+					  regUVD_VCPU_CNTL),
+			 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
-			 UVD_MASTINT_EN__VCPU_EN_MASK,
-			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+		mdelay(10);
+		r = -1;
+	}
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
-			 ~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
+	if (r) {
+		DRM_DEV_ERROR(adev-&gt;dev, &quot;VCN decode not responding, giving up!!!\n&quot;);
+		return r;
+	}
 
-		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
-			     lower_32_bits(ring-&gt;gpu_addr));
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
-			     upper_32_bits(ring-&gt;gpu_addr));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
+		 ~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
-			     ring-&gt;ring_size / sizeof(uint32_t));
+	ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 
-		/* resetting ring, fw should not check RB ring */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp &amp;= ~(VCN_RB_ENABLE__RB_EN_MASK);
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	/* program the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
+		     lower_32_bits(ring-&gt;gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
+		     upper_32_bits(ring-&gt;gpu_addr));
+
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
+		     ring-&gt;ring_size / sizeof(uint32_t));
+
+	/* resetting ring, fw should not check RB ring */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp &amp;= ~(VCN_RB_ENABLE__RB_EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB_EN_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB_EN_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 
-		ring-&gt;wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
-		fw_shared-&gt;sq.queue_mode &amp;=
-			cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
+	ring-&gt;wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+	fw_shared-&gt;sq.queue_mode &amp;=
+		cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
 
-	}
 	return 0;
 }
 
@@ -1327,86 +1322,84 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_3_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to stop
  *
  * Stop VCN block
  */
-static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
+static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-	int i, r = 0, vcn_inst;
+	int r = 0, vcn_inst;
 	uint32_t tmp;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		vcn_inst = GET_INST(VCN, i);
+	vcn_inst = GET_INST(VCN, i);
 
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v4_0_3_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v4_0_3_stop_dpg_mode(adev, i);
+		return 0;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
-				       UVD_STATUS__IDLE, 0x7);
-		if (r)
-			goto Done;
-
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
-				       tmp);
-		if (r)
-			goto Done;
-
-		/* stall UMC channel */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
-				       tmp);
-		if (r)
-			goto Done;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
+			       UVD_STATUS__IDLE, 0x7);
+	if (r)
+		goto Done;
+
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
+			       tmp);
+	if (r)
+		goto Done;
+
+	/* stall UMC channel */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
+			       tmp);
+	if (r)
+		goto Done;
 
-		/* Unblock VCPU Register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
-			 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* Unblock VCPU Register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			 UVD_VCPU_CNTL__BLK_RST_MASK,
-			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* reset LMI UMC/LMI/VCPU */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	/* reset LMI UMC/LMI/VCPU */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
 
-		/* clear VCN status */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
+	/* clear VCN status */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
+
+	/* apply HW clock gating */
+	vcn_v4_0_3_enable_clock_gating(adev, i);
 
-		/* apply HW clock gating */
-		vcn_v4_0_3_enable_clock_gating(adev, i);
-	}
 Done:
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -1663,7 +1656,7 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret;
+	int ret = 0, i;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
@@ -1677,10 +1670,12 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	if (state == adev-&gt;vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_3_stop(adev);
-	else
-		ret = vcn_v4_0_3_start(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v4_0_3_stop(adev, i);
+		else
+			ret |= vcn_v4_0_3_start(adev, i);
+	}
 
 	if (!ret)
 		adev-&gt;vcn.cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------w34KAMOc084V01mR0s0FALcg--
