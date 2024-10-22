Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D62D1CDC9
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 09:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8368210E305;
	Tue, 22 Oct 2024 09:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="niHsk+dU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D633510E64C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 09:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEnKCqm8BgABPI6g8talN2b3R9m22eAMVO799TbCMcPNGKaMlvvl54DieBiOAhKGu8vik6s7VXWkC/TU2N5zRd4xnlGBHIezm3pagWzL+N/N2TFEcW9CpBhHDRAIugAb1zRgNOKhqNYiLNKDGyDBnEd2LhaLlKyHWz41kNl+OpprLfNgtu1kbVXD7jNKcGFlUxo8+GT2o7tmXVIIpuv0sZwtFs+fEZC26tGSmk2yLoQWgxTpuglejGVQWQUH1OeuR/PGd4B63PDiPWWSUS92XB12V9jY/rru1wcAZ7z/5+hpPMi/B/qmtuyvWPeJZFCBOI3cN1QBBAp5cr9ff4//eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfj8JWUp5lYzFj4WdPpvmotOFPSWp6xHURnLLtDQxDQ=;
 b=VeDXVXZlz/lm1UbrBprmMFzyXpYUEdWsI5J3QD5QR9kC4CdZGbbAUsZ+D3xAMaWYFpB2JQ5czUVUIiRgIoeL0wwQYczvtVNEWeGVWOGixqqNcJWBA8UuIun5tg5EEivwH1OY483uNhrrWPkZ5e4Y/JVBGPDlQUfdDt6T6YmDCImm/ktbv9trsuhtneWTIIN2r1d/mQPQbsJHEQlCKHSK6BNi4rgsupfkwyrJIz3xEZALuvMtIGxmxwClS+kqtldaRl0EtagChejcxJeMqeKpFj+q99Mb+SjbHqRABHVNy6+lcc39ghgO+ssCAa8cTO3LKbSUHt0FZ+ioUjqzI26W4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfj8JWUp5lYzFj4WdPpvmotOFPSWp6xHURnLLtDQxDQ=;
 b=niHsk+dUGpTOAz28xXMqkvKQgIlD+ZZQtji7E+/GAztFJzO95gL29XBVweOxMinDQEkBDnoENwDA3SnTCexodT0XqGrkbNddoJE5axz0Aqf1mxxjecJD8L+9IUBp1XAqFA8LIwJhKWXexmofIM0pcMBm//QiFKQttLa6f4Fa+8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Tue, 22 Oct
 2024 09:28:05 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 09:28:04 +0000
Message-ID: <82b26d2f-637b-4ae9-856c-5bb6a05ee096@amd.com>
Date: Tue, 22 Oct 2024 14:57:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241018192027.622300-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241018192027.622300-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: f6821b1c-e834-448f-06c9-08dcf27bd205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlRla0s4anBVcW9sbzZnRUs2aml1bHpIY0JxbHA2QnhoS0t4NGJJS3RpWCtI?=
 =?utf-8?B?b1pxSVFVdjZHRU42ZVBCRllNOHZNUTdnMXJjQllOVEZQdmxlaVlpVFdFNDd2?=
 =?utf-8?B?ZzVBOVU1a05YKzRiRlU3bDVYamFaTC9aeVlOMytZMFVjOGVlcDJicEhBQ3oy?=
 =?utf-8?B?MkVXbjNBQlJTYkZBT2ZBSGhhMHFmcXpEYmZjMnJ0RU1GK05hNGxFL28zZ3Zo?=
 =?utf-8?B?NlJRK2RhM2phZjRCUDR4elRDVWpBWWo0eDl1S0pSSXU5OFA5WkxWdkU3eXlH?=
 =?utf-8?B?bWFzYUdqbzE1b3ZldXdlR25ZSG5FMTV6azh3MGh5U1krcXdETGRKMVF1MEx4?=
 =?utf-8?B?TXExM1MxUTJLUmdTZ3o4dmNmeVk0d0xFV1pKZE9paTdBZTN2SE9ydHVwN0Iy?=
 =?utf-8?B?TCtiMllIbnhDdW9zNXphRTViUU1ISzNMNzFaYnVVYWc0ck9FQlJ4TzhzcDlo?=
 =?utf-8?B?U09OKzZISlhqWWJza1hzNXY2QVdaZmRpZVM2eXRkRGxUaHE3OUxiamFNeTc2?=
 =?utf-8?B?bU1BRWw1RmE3MVo4WkNZcTlpMEhET1F4bkxUbHJoVklaMHAvVnYwRXNWbThS?=
 =?utf-8?B?c25uU0NxZGxpV05ra2NiNHpMWnF4amVTdzVKbTZZZmtwazRXemZic2Y5MTlZ?=
 =?utf-8?B?bnpsenVkSmhrNlFSWW5JUVB4QjE1R1lRWXp3YWVQRTFsVS9DbjIzUEV4cUpF?=
 =?utf-8?B?Z2Y2VEkyQlpBQm5Xb3FEUVptWDl1THBQS2ljbWlwYnNqQmtpaXhoYkVmOXVD?=
 =?utf-8?B?WVlhMUczUnhXSm8rSjkyYVdYT254ZjV5QUcycGovL2FmR0t0VkFNTG1Ia21w?=
 =?utf-8?B?aXQ3MkZpaW9XQncxNG4wSmwwYTlBam5STVBLcDJvd3djbG45emRxbkdENEp2?=
 =?utf-8?B?Uzd2dnNFcmkrYXo1dFdnVk5jNUhFaExZeTJKYmM4Vi9haXZhamh3bkdMZElC?=
 =?utf-8?B?ZU9kamRlK2QrbGh6L2N5MllibCtmQjNkUmZ3bnZXVEtkMWIyc2paejMrQzd6?=
 =?utf-8?B?MFR5RC9EYWdzR2o1WU1PODNsK3cxS1ZzaGRZQzgwOGtGQlpWa0lDVkVMSHM5?=
 =?utf-8?B?THljakhEa1loM0dBTS9vSWpVdkd6bHZEUVk1aW9Rb1dlU25WcHkyN1p6a0E2?=
 =?utf-8?B?REMxUTRkNlZRSWIxdWY0YmVIbmE0eVNlVmUveGZuZ0ZLMU0ySFZHUitGUnpU?=
 =?utf-8?B?bVl0c0MzNjNFaTRLQUNyMVU0NlBKbkdORXkrV3llS1JsNVNuYlZhaDlrSWZY?=
 =?utf-8?B?c3I2VXBwNjlaQVlJaFpLd2xDQVdKcElnMEVzbnAwVDlNUm5BeDhvRkVjY1VN?=
 =?utf-8?B?Y1BJUWZIWExZUHgwemdXZE1nRzBTTWVXUjdPMUZEMDU2QUJ5aUZYaDdhSWlV?=
 =?utf-8?B?cVg1UUl5UHVWL05mUVRZU0VaM0JXL1pLZnFEci9QOXV5UDBUaG1acGJRRWRx?=
 =?utf-8?B?cmp4NXY5WUc1OUZBa0drVTBLaVVsL0FrNTRQY1VRVUlCbXRkUDNGekplcVEx?=
 =?utf-8?B?L2J0NmozSFRHOE10VktTQW9OZlRLN0lTMnFYRithNDhZalc5R0xkUUZrZTky?=
 =?utf-8?B?MDlJQ1gxbEljYW1jUDYyb2kxRUZ1ZEw0WkNkTHpyOTB0WnRid09uSjRMcUZp?=
 =?utf-8?B?eDVtYWVLSmNXQ21jN2F1R3NTNVAzM255d2tyYVBBOWt0ZlNxWCtlclNRMG9m?=
 =?utf-8?B?eVhWV0pLSWFiZ05kOTdabTZkSXlucWVEdlNLUUV6TGpzRmdtVUIyb1F2dk1Q?=
 =?utf-8?Q?ylr23E+kZV0eW+yJSLQu86+U7MptifjLqwCKEBW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRqVUR4TkpNSEcwbktJU25pbEYxOW96Y3FCQnA2YVJSMTh4ekhWTmZHMFFY?=
 =?utf-8?B?dEhQZCtoeWhvcjBtdTVZeWZuNDlGbTRDSUtmWGM1RjM3SGxzbFVhYjhrSGds?=
 =?utf-8?B?ODAwcGtsYkFXWTQwSjFHdzdUZ1pPSlFRSFZmUTYzdjRhelpXY1Y2TnpKNUdu?=
 =?utf-8?B?R3NwcVRvdWs0RFUzQkhKR3NMaDRoOVRla0R0UzlmTFZjQ0YzMm8xL2dIQkJi?=
 =?utf-8?B?bkkzalJrQ2Z3Q21MbVNYeU96VnVSTXZpb0c2emdOWkFJWmZOZytPdjB0MUx4?=
 =?utf-8?B?Ymw4bDlPSk1vTnZYVk1oV1FrQzhpYjdpZ2tkMzk4VzlLNmlxMGJ2TFdEWTZv?=
 =?utf-8?B?dWVCSTlUaXRWWnR5N3A3R0d3dy9vYU1GbllxbVprQTdCTjVGekZWUXFLeXVa?=
 =?utf-8?B?ODlLZnNlNjBzN2JyM29oRnlHem45NVZMKzBNNFAvd3R2SXJUYjJucFdvQzRY?=
 =?utf-8?B?UTZKYk00SFg1Sm1nSXI5d2RnREcrVFlPNm9JYU9ZREV3VWIzWWFxVHRFd040?=
 =?utf-8?B?TXJicUQwemF1UVBOYXBGdW9XdWxFRVFRZmxsdlFJWjRhUHlBc1pmRVp5NXhx?=
 =?utf-8?B?RndkN3VwakdNakpwWHA5UzJGOGV5alhiVjhnTW0wbTV0MEJ6QVRoRUdqdFZp?=
 =?utf-8?B?NEhBM3NwU1ZSdllHZzdMLzdxQ21tL2trR1B2akZtL01wMnRFZFlSajA2RmVI?=
 =?utf-8?B?M1huaTdwcXFxNmZFbjlFcWFlYmU3OXdBa2pneGJMNWZ5c3JXaGk0OVFzT21p?=
 =?utf-8?B?VUNxRmx4TDdYaFRqbUR6cGF5cStqRllJbXNyRzRNUUFsQ1ZUUVY3TUVLcGZ4?=
 =?utf-8?B?bUJ3ODJ3K0RZSlNCcVJoSDc5bURwdGtwTzV1MGNFdUpBRDBudDNmb1JKckdu?=
 =?utf-8?B?bUkwdHVoekhXN0d1UzIrNEdCSkEvUlhydzZ1NHlqeE1KYllHdUs2ZHhOMWRT?=
 =?utf-8?B?cGE1TWpqSTFJZXFFazNqaFlYK2pGVGZhYmZPZUlsUG9wN0kzMUJlMzA4SkJJ?=
 =?utf-8?B?bWFSMnlVYUxTV0dRazBUSWRZaDYyTEI1WS9uMWdRQ296WWZJMkNHUVJDY25E?=
 =?utf-8?B?ZWw1L2hDRlZuTUxBaSs4R2tBdnNlTEloQVNBbGRyTG80czBqTDVyM0pHVU9O?=
 =?utf-8?B?WnpZRm1ZUjRLZ28xOHJ0TlpLTVh4aUNwc2JJZjduMDJIUGFncHo4aTViS2tJ?=
 =?utf-8?B?TVZ4REZIZmV0TlgwVys4RHkydEpOa3Y1Q0xIVXBLMjhJN0g5SGI4T0owVzEv?=
 =?utf-8?B?RVNQZGpKeFVxRGNQWUxNT3JVbGVzeHgrZEd4b2tMVmJuYVdNbzhoeC96N1dR?=
 =?utf-8?B?YTBIZmtkTDR4S3ZIQVowR3lPV0h3eXBsOVh6bGJ6cHk3RlQ4T1NPNExETUE3?=
 =?utf-8?B?MDN2cEQ2YUc1dkhJT08rZFl2Q3p3aXZLRFlaSndiWVJiMHF5RzZKYktwVkYv?=
 =?utf-8?B?TFpDZGR0OE4rYXdCL3dSdFpoUVZvdzBEN2h1SFEraVN0SFpkYWZIelR0eEZ2?=
 =?utf-8?B?ejhTcHRRczZIMEV0RzJRTWpYWU9TaDZQamQySjVRMmdjRzcyOWFaVWRyb0F0?=
 =?utf-8?B?TExETFMyQk0zeU5hWStoRkVYVjNKYktUSUNwU2JOYWlMZ1ZBVXBKS01wT3ly?=
 =?utf-8?B?ZVF4NnpqcXBNekY1YlFOOXpBTXd2Ymp0UEJVckYwcEtabVpGU25yVUIzajU5?=
 =?utf-8?B?ZE1JNk43a2ZnNENmNjFJaUJiTDBRalFwMk1WdGdOQWFrMmJqZWV5VGdlMmZy?=
 =?utf-8?B?TWFxeUMxSnhLSC91NXZGMCtOR0V1LzRwK3pPbU54Z2doTGt0aWJpOWh4Zmlu?=
 =?utf-8?B?eU42dklFcVRQY3R1RldGNU9SNnpkRjVSdEhTWnRwSjArNFJsK2hiTFBrVVVH?=
 =?utf-8?B?L0ZXN3NwbGUvbVVhbTc2M1VSNU9XK3lucys4NUZTNTRhM2ZkbmJ6cGs1Q3BY?=
 =?utf-8?B?Z2lEeW1tR3R5NW95WWRIQkRnUkJ5Tis5ekd0cjhtakJnTnJ0QmNTNXlObGFG?=
 =?utf-8?B?Vk1Nb0tGejgxYmh1ZVByUk1seG9BdWZxOWFtZm9kaUR5eUsrS0lnLzZkeWc2?=
 =?utf-8?B?UUV0bXNDRitjYkxBbUxRUVRueS91L3dldVd4cHhpM2MyRkt3d2g4dHJEYmM5?=
 =?utf-8?Q?sud/QLCP7nxlM50K8azBOzF5D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6821b1c-e834-448f-06c9-08dcf27bd205
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 09:28:04.4780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6yd2GFvM66fEwdHSeR2ndDu8JAZkJnLphsjqsF+hJPkYxBG7liSRg+H38RleyJ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
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



On 10/19/2024 12:50 AM, Alex Deucher wrote:
> It does not support fullscreen 3D.
> 
> Fixes: 336568de918e ("drm/amdgpu/swsmu: default to fullscreen 3D profile for dGPUs")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index accc96a03bd9..4b816c7e94fe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1267,7 +1267,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
>  	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>  
> -	if (smu->is_apu)
> +	if (smu->is_apu ||
> +	    (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1)))
>  		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];

It's better to make this check generic and check against availability of
3D workload profile.

is_workload_profile_available(profile_index)
 return smu->workload_map && smu->workload_map[index].valid_mapping .

Thanks,
Lijo

>  	else
>  		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
