Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B12CDDE6E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 11:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF02810E13D;
	Wed, 23 Oct 2024 11:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="APbikrUm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945E410E13D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 11:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee0MeOZLKW96eJhanyG5B4P7RHOkBO8DXyUIXK/UWTsSMz5V6fvMxTubAFv7kJUANXrVZmYlh5x8PftzYvfOXA6KhtZz6c55gttraSoi4cG0qvLPCmSMApcmWO37/g+SoW3+tQ3/nCsbu42yVdsNW6B2zwMQebxfKklF4uh7841xJ4HiN84ekYXgYHjFjxCn0tk2MEjO+2kSpqOA+OEiE9HPGZSolHnivKZ2r74pXrclpyliDQc/lgTzhZNA7OKnVLcLVEvBMcRau+3Fw7BG1T37xmw4bksmkAIdVZWCeTEsrhX0/Jyamfoz1eL4Iqb0/JD+sdDdjvJTeJnaFtBhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9f7o8IN6eWXd7R1ZHTzHinRJwwOiih/FdGwD7CzEig=;
 b=ks9bP4Z6gliOLWSKN9mMS1FtJlu9DqtTijDV6ZKstJ6w/kZmrNh257HyMTENvvX4v7f+Vrk9tej2G2VG+Ihe9en7O9WpE084BTvQJiWDCsiv756Ky0V6ON8pqDKeHUJFnTyXjbN0h6B0jbeVNVKEaMTs0KLiIMWfmGIQ5MuomxU8z/vJegs42HPzFW9gI/alecJkvZViP1AgL/8EWV18z+24L8sT+acxdssArhISUGq6UcZQ6Ajh0YV0ioRrPV70KeHD+gcNoTlo4MZ/zkCvXzvFStfZZRlYwCqNodvVjYopLSXXq3ByOYkGWAMeEvEg3rcH5T6KBObEyiNldVLnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9f7o8IN6eWXd7R1ZHTzHinRJwwOiih/FdGwD7CzEig=;
 b=APbikrUmAQoGbPWNjDHMPQvMztU82wGw3LDUU0F7+uaQFXqwE+8Ge3OJm5i7HDHzHcIoUrCfNwf1WyKXtZUQRVwegx/9e6PVDlZ53kOIEs2izc/Do2pk3v61bcNFrS8zZkfAXiz2AL43DqLBXKB0GqNdWAh9qTFM9Wfr9VogETQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 23 Oct
 2024 11:33:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 11:33:40 +0000
Message-ID: <fbad3a97-10a9-4f40-b2f8-e9ead3fa352e@amd.com>
Date: Wed, 23 Oct 2024 17:03:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: correct the workload setting
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241023031257.14238-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241023031257.14238-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 97965953-93a5-4f5f-817a-08dcf3568ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk9RSWZMMXVpcEJwZDM4ZnZnRmsweGYvaTBqZDlKWEVuL21SdW10aSt2OU1v?=
 =?utf-8?B?aE5BVHhtSWJYSFZFUU5RMW9CSlRMdi9VTnExQTUwNFFnRFdMUVdUUms2NEFl?=
 =?utf-8?B?aURzT3FTUzIzU2FsRUwraS84M2N0V1pHOFg1Z25xRzNJamlxZW9leEtZSUNu?=
 =?utf-8?B?Sm5hNkZ1QUFQMGZlTERadE12aDlZRXlpRTFIQjdSVlpqbTM4T0s5d1ZyRjRk?=
 =?utf-8?B?Tm82TTFuQ1ZGdzJ0ZEZiTTArNTBqK0l0TkRucldCSVYxS3J6UXd3Wi85aGVx?=
 =?utf-8?B?Q00vRkVmZTd5TXppZXBGYlZLRlFLNUw5ZmFoUDg2Q0FwUXdnN0xXbVZqWW8w?=
 =?utf-8?B?NFpLNWlZeHU0TXM3YkFMRGJncFpWajcrY2hxUmlQQ1lHbS96c3Y0SUpWK2pn?=
 =?utf-8?B?cUlsNmdkYjlrZlZpdnpJclM4TVBDMEU0aXJsQzQyMnR3cFBTNnN2cHZsS2Uv?=
 =?utf-8?B?S0VldWxTbERMT0YxZHFwcGladkxYWXB1U3NyZ3lMU1ZCN0VGSEtWNkFnMncv?=
 =?utf-8?B?MUFjUlBqQW1iZ1ZIUk5laVR5czNqSTN1cWZsVjd6TExQc3dibVNWemgxaVN5?=
 =?utf-8?B?VW9YNmM5U3IwSGw5YjRob25ZenZ0eG5FU1M0VU15Y2JrMjExRjJxNHhpa2R5?=
 =?utf-8?B?QzFPcUZjQ0svdEhiUTJ4RVJnSkdTVXR1VEdHVldsZGxlbU9sRTFjTFJXbzdX?=
 =?utf-8?B?M3dFTkcvTURhTTd4Qm9IcDVkMHo3czNhRXRHTTRlVUp3dDFsd2FUOFhMQ1cz?=
 =?utf-8?B?ekF1OVV4R0RRejJid0ZOanVDS0xxUFN6WlFsTmJNVnFJc3JqZmhxU2tIYkRX?=
 =?utf-8?B?OVY1Y0J0YjBDbE52T3V3dG5HSlNBSGNMbGdwdnAzLy9ub3NzVDh4SlFKUjh2?=
 =?utf-8?B?THZpNG5wdlgvWHIybk5OWFVoQ0dKb3Z4TytuaHliRGNQNDc4c1hmVlVqYnZt?=
 =?utf-8?B?UElVV3hoUVVpL1g0WEttWWFGc0MrR0dhNTBwYmhmUEVsRUtTbU83dWp0RnRz?=
 =?utf-8?B?MXJyWDl4WnN0NUJtM1h0Mk1Wenk2WHJjZU05cFExSXFaSGlEUTlzSUQ1TGZh?=
 =?utf-8?B?VmQxNGVuWGpoU1FkYlNoN3JvQ0lTU0ZvekFWeHA2OVRkN0ZQUEs3NXQ5RUxh?=
 =?utf-8?B?YThYVTIrTHF3M1BJRXNWOXFmbzFhUjJLUG5WVjFRMGZGaTA1SFY3Wjc2SGZS?=
 =?utf-8?B?Nk1HNldGSVlkV0c0WTRvSlh0ZmNHRWNjRTdaUy9EWGtublU0c0dQUlFhY21P?=
 =?utf-8?B?ZWdjWUV3RVFmSGx2Z2ljcTJrakdKN3NiaHhVUGRXd244WENpbTF2ZXc2V3JS?=
 =?utf-8?B?NXZYaVBPblVwZ2RBckt3MWJyN2NWK1JXYlBRL2dmemJJcWpDdXNzQ254Y2Vx?=
 =?utf-8?B?MDVRVmJJV2FWNjBEZ1loNUpRR3c2YmVobHRsRWI2d2VoZWdWUlM4Szl2RER2?=
 =?utf-8?B?MC9kNWFSSHJsRWpia01QK1RYNGx2WnNJZ0ZsWlpzVy83aDREV2E2NkdMWWFM?=
 =?utf-8?B?ZWh5TnFTTXFxT2x6cWxPN01NOXpYOHJSa3VudGlBVFIrTkFUMWw3d3pVUzU0?=
 =?utf-8?B?SFh1YU0yMVdldkpDN2NvTUFpTTMvU1ArejZIdWtxZGc3TkhPeGpkYWVTWEJM?=
 =?utf-8?B?UjdaODM2NUFrUnJuSThyUDJIWW5HaUs5NWpYbW9nZFJ4bVdoMDNpbkZFODUx?=
 =?utf-8?B?c2FUai9BMHBSYlRTTHJ2b1d3QkVlOVppTWhsR0sydUs1QWJxdjVLY3ltTmQ0?=
 =?utf-8?Q?6nZoc+8/YEYi4FL/9iM7+FVWdLKhEvVYHYvs5oj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VOM3Y4WmxkaW0wR0twd04xSDhZTGlSTWhqbmJ1TWZHTmhhZ0Y3N1QzT0x3?=
 =?utf-8?B?UGgvYnF3UzJuOGNybzBTcFFMWjljQkU0a3RnWkdDTEZnd3Frakxya3F4NGVR?=
 =?utf-8?B?V0dwSytEM0tBbGdBYmxEd1o0WGx6RUVmbmRTSDdrcVhHY0oyMU4wdERVMkV4?=
 =?utf-8?B?U0RObHIrRUdQTmw4cERIeXNtMVRyczdPcnBIcUFKK053SEx4NVpwZkhpRDEv?=
 =?utf-8?B?Q01VMmNsMVhndy8yOW84NXhxV0s4b1pDVDY4Wm9wM1MzS1gzQ2tCOTNEcG5C?=
 =?utf-8?B?a0d6Wm52dkJDaXVVNVJscnczbXZOelc5ZW5JeG9kc240aGpPTkFxZzBRdi9m?=
 =?utf-8?B?SnBQTDF3Rm5UVDNnUEs4eTJiK0hnY080STZMVGJaMzRKM1NHb1hzUDhoRXF3?=
 =?utf-8?B?cDZScHgwMHFjcEJKRVBFODFTWGIrVUtqd3diSTdEMDcwUzN2MFU1dS8zSnVh?=
 =?utf-8?B?dkVOZkplTHNlL2Rkb2ZzZ1lUZGsrN1BpS2FJOFZvMDRNams5RUU2eWRlWDlS?=
 =?utf-8?B?NjVCR2dzc1hoejFtMXVNMXhwOCt3L21ZTjhqdXFqNk12TTZxVWRVSE1wUzAv?=
 =?utf-8?B?U25DTkdIS0w5ZVhMQjJiZWY1VjFEMDBPRjJkajRFWFJrVWZpVXliVEVKaWJO?=
 =?utf-8?B?cEhmb1kzczdoNHlYY282MnVGQWs5MHJJNTFDUXQ1VnJxL0JBaWxQbTdOVC9n?=
 =?utf-8?B?eUEwajZTZ3JIUVZYNVBjUmtFRmtEazhXK1lReHFyc2JNWm1rc1pESCs1ejBX?=
 =?utf-8?B?alJzRGh1V2FQWUFPbzZvM2xyN3hSZnlQRTZFQU1rZU1WLzNPYTFiSVRmY2VE?=
 =?utf-8?B?M1FHaXNyNkdvbS9GQlBNWWJudXJZOUR1alhmc2Z5VVkrR3VZbytYeWtXU1k0?=
 =?utf-8?B?Y1Zhc2VXbTNSRm5PRjFNRlI2SDdXenEyWUdZMVllMm43SHAwQi9xandhams5?=
 =?utf-8?B?ZkY5d09lWmVjNENUY2ZNaHlHcGN2K0dDMmNlN0dVallhV0R6RGtKcmtiMU1j?=
 =?utf-8?B?aDdMQXR3V2dVUG5tOW5CVHpoR09qbC9xWEpvaXVFOVRzWFRkOHVnZ1paYzh1?=
 =?utf-8?B?R05EWUg3eHF3VlY4YnJzejNFMFFRWlIwOUFrQlBVSVRPZ0tRbTh3UTVscHJW?=
 =?utf-8?B?TERySmdTOEt6M3dQRDA3OHN5MysvQjNOdjlXRzAxRkl0M2FnMkVnL0ZycDVM?=
 =?utf-8?B?bmpiYTE3Q3Z0WmhWRURzZlJET1VNS1JDaWRkODBPSTBrZGJlbzZ2eWJBMWUx?=
 =?utf-8?B?enRFeEloQVIvNzZhV3ZRUTBtUlVqbTZtNUNjNHNvWjBoRUs3eDh5VHkzOER5?=
 =?utf-8?B?bWt1SWY0cklwT2gybW9OY0Z5aHlLYVA5SGtseU9TTEFNcXcvajl4SWxjN29O?=
 =?utf-8?B?bTBPbUZjWWt6TWl4UUFaRllMVXowRUtJQys3M281RG54WlI2N3Zvbll5bWtK?=
 =?utf-8?B?OVFKMWRlK2poZGc0MFc2TWJNbU40d0pPUStlNnM0Z0hYLzZ5bjBxQThPQ0Vr?=
 =?utf-8?B?UElucXo3d0RLZ0tQRDhhYnlVQU1SZHN6QnhtVCtJQVQwL3V6UlpOTHpUbnpX?=
 =?utf-8?B?eWRaMnl1N2VLdzVaZXRWTGlkK0MzNEhqejNQTy9SM1pnV29VakFiS2ZZOW1N?=
 =?utf-8?B?empmK3hFY25Pc050b05NdDZWMkR4R0c2eHRUb3oyYncxcTcwbmdXT21EUjhj?=
 =?utf-8?B?M1FWcnljSzdaa29XMmpla0lFZVBqcVRoVGQ1eWI4UW54VmJyKzJiREpNNDZJ?=
 =?utf-8?B?cDlNaW1MNit6dVZEYjNScVF5QjN2bERzNVlFakIwZU5xRkxGVWdTbDdCVnlQ?=
 =?utf-8?B?VFlRWENGZktlTks3VGhudGJRRmw4YmNrd0hUdkR4M3EvdmlpVHdVaE5xM054?=
 =?utf-8?B?QTUzTEFFZjlMTmZWZ0FCUjBHQlFiKy9pZEk2SlVIYjI5bytOeVp5OFlyTUEy?=
 =?utf-8?B?SXVNbWF5ZS9GQzZ3RkdUT0Q5RGJySVNrWC92QU5OMDlQZldXaUE2MmJOdE1G?=
 =?utf-8?B?ZXd6cUhwK0hwTjQ4TC9TQlE1QWUzOXJtbHErUzVmeVpUb1ZDRlB4aTVtYm54?=
 =?utf-8?B?cmVTcDFvS00vVEVTN2Fibkp4MHhEcFlydmovYTMzcm5wTVV0ckZ1VmUydEs3?=
 =?utf-8?Q?dJInU49DjzY6ngefBxzmAEE9f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97965953-93a5-4f5f-817a-08dcf3568ad5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 11:33:40.5105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/0JV1AEYHqDpOm9bEh7KA/sIy9DAjqBrn3jXnxod5HFzkvhBQSiQ5k+4vi+RQkG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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



On 10/23/2024 8:42 AM, Kenneth Feng wrote:
> Correct the workload setting in order not to mix the setting
> with the end user. Update the workload mask accordingly.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 ++++++--
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 39 +++++++++++++++--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 ++++++++++++---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 42 ++++++++++++++++---
>  5 files changed, 115 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index accc96a03bd9..f1984736ff4a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1252,7 +1252,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	atomic64_set(&smu->throttle_int_counter, 0);
>  	smu->watermarks_bitmap = 0;
>  	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +	smu->user_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +	smu->driver_workload_mask = 0;
>  
>  	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
> @@ -1267,10 +1268,12 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
>  	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>  
> -	if (smu->is_apu)
> +	if (smu->is_apu) {
>  		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> -	else
> +	} else {
>  		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> +		smu->user_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;

This is driver decided, not user decided. Keeping it as user decided is
confusing.

Also, ideally user settings is preferred to be kept here -
smu_user_dpm_profile

> +	}
>  
>  	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>  	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> @@ -2346,11 +2349,13 @@ static int smu_switch_power_profile(void *handle,
>  
>  	if (!en) {
>  		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
> +		smu->driver_workload_mask &= ~(1 << smu->workload_prority[type]);
>  		index = fls(smu->workload_mask);
>  		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>  		workload[0] = smu->workload_setting[index];
>  	} else {
>  		smu->workload_mask |= (1 << smu->workload_prority[type]);
> +		smu->driver_workload_mask |= (1 << smu->workload_prority[type]);
>  		index = fls(smu->workload_mask);
>  		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>  		workload[0] = smu->workload_setting[index];
> @@ -3045,12 +3050,16 @@ static int smu_set_power_profile_mode(void *handle,
>  				      uint32_t param_size)
>  {
>  	struct smu_context *smu = handle;
> +	int ret;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>  	    !smu->ppt_funcs->set_power_profile_mode)
>  		return -EOPNOTSUPP;
> +	smu->user_profile_mode_setting = true;
> +	ret = smu_bump_power_profile_mode(smu, param, param_size);
> +	smu->user_profile_mode_setting = false;

Instead of doing this way, I think it's better to save the user
preference as a mask here. Later decide what to be applied whenever
workload mask is applied.

if (user_profile = default or unknown) // No user preference
	user_mask = 0 ; // user driver default mask
else if (user_profile = xyz)
	user_mask = xyz_workload_mask;

Save user_mask to user_dpm profile.

Whenever workload mask is applied, select user_mask if non-zero or
driver_mask, or a combination of both.

Thanks,
Lijo

>  
> -	return smu_bump_power_profile_mode(smu, param, param_size);
> +	return ret;
>  }
>  
>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 8bb32b3f0d9c..e43b23dd3457 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -557,10 +557,11 @@ struct smu_context {
>  	bool disable_uclk_switch;
>  
>  	uint32_t workload_mask;
> +	uint32_t driver_workload_mask;
>  	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
>  	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>  	uint32_t power_profile_mode;
> -	uint32_t default_power_profile_mode;
> +	uint32_t user_profile_mode;
>  	bool pm_enabled;
>  	bool is_apu;
>  
> @@ -572,6 +573,7 @@ struct smu_context {
>  
>  	bool uploading_custom_pp_table;
>  	bool dc_controlled_by_gpio;
> +	bool user_profile_mode_setting;
>  
>  	struct work_struct throttling_logging_work;
>  	atomic64_t throttle_int_counter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 3e2277abc754..7250b2bad198 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2433,7 +2433,7 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>  		}
>  
>  		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
> -			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> +			i, amdgpu_pp_profile_name[i], (i == smu->user_profile_mode) ? "*" : " ");
>  
>  		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d\n",
>  			" ",
> @@ -2474,9 +2474,27 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
>  	u32 workload_mask;
> +	uint32_t current_user_profile_mode;
> +	uint32_t index;
> +
> +	if (smu->user_profile_mode_setting && smu->user_profile_mode == input[size])
> +		return 0;
>  
>  	smu->power_profile_mode = input[size];
>  
> +	if (smu->user_profile_mode_setting) {
> +		current_user_profile_mode = smu->user_profile_mode;
> +		smu->user_profile_mode = input[size];
> +		workload_type = smu_cmn_to_asic_specific_index(smu,
> +						       CMN2ASIC_MAPPING_WORKLOAD,
> +						       current_user_profile_mode);
> +		if (workload_type < 0)
> +			return -EINVAL;
> +
> +		if (!(smu->driver_workload_mask & (1 << workload_type)))
> +			smu->workload_mask &= ~(1 << workload_type);
> +	}
> +
>  	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>  		return -EINVAL;
> @@ -2555,12 +2573,25 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  			workload_mask |= 1 << workload_type;
>  	}
>  
> +	smu->workload_mask |= workload_mask;
> +
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					       SMU_MSG_SetWorkloadMask,
> -					       workload_mask,
> +					       smu->workload_mask,
>  					       NULL);
> -	if (!ret)
> -		smu->workload_mask = workload_mask;
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
> +			workload_type = smu_cmn_to_asic_specific_index(smu,
> +							       CMN2ASIC_MAPPING_WORKLOAD,
> +							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
> +			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
> +										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> +										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +		}
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 23f13388455f..8afd43e78ebc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2367,7 +2367,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
>  	size += sysfs_emit_at(buf, size, "                              ");
>  	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
>  		size += sysfs_emit_at(buf, size, "%d %-14s%s", i, amdgpu_pp_profile_name[i],
> -			(i == smu->power_profile_mode) ? "* " : "  ");
> +			(i == smu->user_profile_mode) ? "* " : "  ");
>  
>  	size += sysfs_emit_at(buf, size, "\n");
>  
> @@ -2429,9 +2429,27 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> +	uint32_t current_user_profile_mode;
> +	uint32_t index;
> +
> +	if (smu->user_profile_mode_setting && smu->user_profile_mode == input[size])
> +		return 0;
>  
>  	smu->power_profile_mode = input[size];
>  
> +	if (smu->user_profile_mode_setting) {
> +		current_user_profile_mode = smu->user_profile_mode;
> +		smu->user_profile_mode = input[size];
> +		workload_type = smu_cmn_to_asic_specific_index(smu,
> +						       CMN2ASIC_MAPPING_WORKLOAD,
> +						       current_user_profile_mode);
> +		if (workload_type < 0)
> +			return -EINVAL;
> +
> +		if (!(smu->driver_workload_mask & (1 << workload_type)))
> +			smu->workload_mask &= ~(1 << workload_type);
> +	}
> +
>  	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>  		return -EINVAL;
> @@ -2487,13 +2505,18 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>  						       smu->power_profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
> +
> +	smu->workload_mask |= (1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> +				    smu->workload_mask, NULL);
>  
> -	if (ret)
> +	if (ret) {
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu->workload_mask = (1 << workload_type);
> +	} else {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index cefe10b95d8e..d88bf9bad313 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1747,7 +1747,7 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
>  		}
>  
>  		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
> -			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> +			i, amdgpu_pp_profile_name[i], (i == smu->user_profile_mode) ? "*" : " ");
>  
>  		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d\n",
>  			" ",
> @@ -1787,9 +1787,27 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> -	uint32_t current_profile_mode = smu->power_profile_mode;
> +	uint32_t current_user_profile_mode;
> +	uint32_t index;
> +
> +	if (smu->user_profile_mode_setting && smu->user_profile_mode == input[size])
> +		return 0;
> +
>  	smu->power_profile_mode = input[size];
>  
> +	if (smu->user_profile_mode_setting) {
> +		current_user_profile_mode = smu->user_profile_mode;
> +		smu->user_profile_mode = input[size];
> +		workload_type = smu_cmn_to_asic_specific_index(smu,
> +						       CMN2ASIC_MAPPING_WORKLOAD,
> +						       current_user_profile_mode);
> +		if (workload_type < 0)
> +			return -EINVAL;
> +
> +		if (!(smu->driver_workload_mask & (1 << workload_type)))
> +			smu->workload_mask &= ~(1 << workload_type);
> +	}
> +
>  	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>  		return -EINVAL;
> @@ -1845,9 +1863,16 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  		}
>  	}
>  
> +	workload_type = smu_cmn_to_asic_specific_index(smu,
> +						       CMN2ASIC_MAPPING_WORKLOAD,
> +						       PP_SMC_POWER_PROFILE_COMPUTE);
> +
> +	if (workload_type < 0)
> +		return -EINVAL;
> +
>  	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>  		smu_v14_0_deep_sleep_control(smu, false);
> -	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +	else if (smu->workload_mask & (1 << workload_type))
>  		smu_v14_0_deep_sleep_control(smu, true);
>  
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> @@ -1857,12 +1882,17 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> +	smu->workload_mask |= (1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					       SMU_MSG_SetWorkloadMask,
> -					       1 << workload_type,
> +					       smu->workload_mask,
>  					       NULL);
> -	if (!ret)
> -		smu->workload_mask = 1 << workload_type;
> +
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
>  
>  	return ret;
>  }
