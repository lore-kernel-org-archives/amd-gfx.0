Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7324DC282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 15:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 172F410E453;
	Mon,  3 Mar 2025 15:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uXVrd0UH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DA110E44D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 15:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM34ytZ7QMpBcbx7yvfjB4iEUr0g2NCzun7VpQJsZfjA9ZuwPDJaH7cT7nQ5KvF5Gk8hmf6CLA+Ats9Opx1qqsYEnM/NXKa0tDJCIuimaqV/78n+m7coJ+i93gAQm0/9HyTUu3yAilIhisKgVn4FcKUpPpT7KK5+9SvhxT7lg4kTAdCO48DqJJwv3E4T4y2v7ELnv7u8KPM6DIWKXJEHIPmX4ejeyVh+PAhWm4PaHUW5ug09iq3f0iv3MAqMNN2y1l6ddtyypi3lRjHBXvD8d8Fokt6RLzxaIOREqnOE4A+Y4tre0bKdYkU8ULxpK67UtAFTLa61A8AED1KQ3RbDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8ubn747P/y7aKoPXSEFrxdQB7+g7ztU5fmK8/CZB/8=;
 b=QRnit4fXhOS4OaBI4zRdt9OtvFfClLcCjGXBOt+j48BLOxGLbQ8KniuhFXYh4tqij3AdYrV6XDN8Liej9CCRarIunDoOa4Qodskhe3iXy5tMyWWBavXlQP1grTDd3dCfZtpBdjcTi9XAN6n7ZI71mLYZW5cC7rRrN1mKA8QbjtSf2+WhfZsnQElBGqljuvuckr8/tYEDyCJz6ELFVkbWeST3LPJhTfSMUgPE89nGhCFlr2SA44AWkexm21nPtiPgo77dFyBnLtQz2qa+RizDedu0ZIo/CEgDh97gWq4WQ1MTfBx6sAYR0pWWgKcefrcPOa4rbnKn+S2FT5xKH9II/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8ubn747P/y7aKoPXSEFrxdQB7+g7ztU5fmK8/CZB/8=;
 b=uXVrd0UHLPhQWh2ShRqSksINLdWeMCzrqggutqMNHQL4JJ777BmGCz9jk3pjz8BYfl/VN2LYse3DhJvfdAG5yiUtyKgxO8j0pCSaS1+FpbAX2HjoQMhEsKWsuq5wuWwReiGnFPMXwuH5+xU8hjLfWWdP+qZxtdyFMiQYaX9Qpmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 15:03:43 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:03:43 +0000
Message-ID: <e471ec60-21cc-412a-b4ce-b6d32d87f524@amd.com>
Date: Mon, 3 Mar 2025 08:03:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/amd: Copy entire structure in
 amdgpu_acpi_get_backlight_caps()
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250228185145.186319-1-mario.limonciello@amd.com>
 <20250228185145.186319-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250228185145.186319-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::24) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7228003e-646b-41cc-b6f6-08dd5a6496b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlJmNlUyYS9iRHFzT25DdEM2bWFXY2xSYnJFeGNCWHh1QkNIblNoem94Sjg4?=
 =?utf-8?B?dVUrUWJubmxLODBKeXFQZTJGY2JsQ0xzaVRnTUZ0WnBkUHpxRSsyaFRsZ21P?=
 =?utf-8?B?MjEyWjZHWDhaQWdwcERaV1JOKzkzNVhEM0dvY2Jva25pY2NXTCtsNU42cld0?=
 =?utf-8?B?MXN5RCtmUmcyV0kxZUFyNjVsR0t4QStjS3V2VWZNa3BMU0dCYVJlaUlQL0hv?=
 =?utf-8?B?UTdOZVJqUjBTNXAxNGxzVGxiekJqTTVKLzl2Uy90TUJQUWNqdERneXFsUEJx?=
 =?utf-8?B?VXZicWo1VXA2N1ZCMXpHOHAzcjhBTUo3T0NlaG0ra01NSTl5QjNUeWx6QjF2?=
 =?utf-8?B?djcxeWQ5NkN6M3pYbGRvTExoNEdpQkJTcFloM3FjSzU2ZERKNVVQbkVLbjdl?=
 =?utf-8?B?TWxZT1RnZVR4SWQ4ZTgwZGZYRk5WS213cEZVUGJJNWFWeWJ3UkNlaDFLUW1I?=
 =?utf-8?B?dG01TUxKS05GUUZpVCtSaGNYdG1NTzdQVFJjQUpKUTgvUkNYT3JiVVY0NWJJ?=
 =?utf-8?B?YUxQaTNpdU1CWGRZQW9sdm5FUHIvaDYxcGdKYUxoYXlDbkE2ekV5KzFxUU1w?=
 =?utf-8?B?V1VnYWFTYk1mTDg4ckU0N3JDZXFScUpFR1BDZjZGbzNINTVYaG0zV1JlbUQz?=
 =?utf-8?B?cEY0bk9FWmVKOE9HRytUZzJadFJlVzNwcmNEeEFMNWF1cnNUWFpsTWRWNTdR?=
 =?utf-8?B?ZlVnNzVEUklYNmw0aThFT3QwRHBkK3BXdzZDMFoxYVJOU2ZpaXJFOFM2bHpH?=
 =?utf-8?B?NmRyN3VlOEJjT0U1a2VUM255ZWpZZ2hQVEZCbkR5RDFFMXIvOTBSa3NobzJ4?=
 =?utf-8?B?V1lrV203WlJwMDhsM2NSaUlUV2ZwVk5JRmRLZ2crWjBaTkVUdmM4dUVScHVa?=
 =?utf-8?B?ZXAxcm9lSFlEc2RBcGoxcTBBVHZpOTVqMWtKa0NWdjNWUTBDS09GT2txaTBi?=
 =?utf-8?B?OTZ1TTNEWXB2K3gxMGd3RjF5bEJxci8rbldkcU8wQUoxYlR2a2hrMEp4OG9t?=
 =?utf-8?B?am1ScjRab3RTZTJXcjhqUmgrVE9jQkVvVThGOWhncGQ5L3dJMUlEdUtSRVFO?=
 =?utf-8?B?OVRXMFFjUTJvK21LbWVqMk1mNDY2WW1uNmxxMU9OTlpDajUzbGhEQWVReml2?=
 =?utf-8?B?K3ZabmdUYkVHd2orOUJLamVObkpnN2tzNGpmU3ROV2xKay9BbFdjeHhNa0NY?=
 =?utf-8?B?V2hxQ1Rjb3ZXSkFVODJ5Z2hSSDBCc3A0OFRZYkRScTRDMFZzM2o2aEZuZHRr?=
 =?utf-8?B?YVZoT3hjejNySVplRGJPMzk3WkFRbXp1UVdldXFTSEZmUUNBUTY1d0NrOUxU?=
 =?utf-8?B?UTdUSGVzZ3lQRkM2SGJPTDk5SWdHWERBbUowT2tpWTVEQnR4VkpHUHpqQ0pG?=
 =?utf-8?B?alI1aE5TRGFQNWthbGZKQzFaSVpGSGpDTG40NjVwT1BRcHZLa1YyallVMnYy?=
 =?utf-8?B?ME5iMU9CSlpOd3pxM3Nsc00vOTZCWWVCYmdRRStvN2Z6WnZtYWxiY01kOVMr?=
 =?utf-8?B?cGc5QnoyZWhheVlkMURSWG5QWnJ2YTIyUnZlSklSSEZuQWtSSHFSUUZrajRk?=
 =?utf-8?B?c1VRelZscjVmSU0rVTNxMUJhUTliWU5Ib2VKREtLVCtDaGxIcGhDOVM4WU9i?=
 =?utf-8?B?L0kxN01vak55VXNZYlhxZHBVelJCOE5ZalZDcXNBWVhmNjBqbzVsT3Jxci9F?=
 =?utf-8?B?WUFuM1NROVYvTTBYL2djNjVDVU56NWNGRXlEd1VVbjBZalNZNnY4eVFUbEFx?=
 =?utf-8?B?Z2d5eGI4RTZTWXpUQzhmSS9VWnRMTWlyWWNtNkM1Vi82UndtdDludUo1bmEw?=
 =?utf-8?B?aG5vbk9sVUJ5QlZVRWRTOXoxdE1iZEVSdjJNTzBkNlAwMjFsZ21NeW1IUSth?=
 =?utf-8?Q?7ratRMmoIUpk/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3lNOTFKOXhrU1N4RXd2WmtYNHdWVEdjVjVhL0Z4WWlyMUt0aUg1ZHBmY252?=
 =?utf-8?B?anBzREJrck5TQTRLVzVlSTNnYXU3NEFJM2VSWHhCNHNJRE9tMzI2dnFGQ3ZF?=
 =?utf-8?B?eUNuL3UybUR5Z09SMy81MFdGWXREbU5jVFc0VGR5YlAwWXdoRENSNDN6MEpO?=
 =?utf-8?B?YmE5Ykt4eFQ0U1JyN1kxcnZiTDNMWjUvTnlqV1lBanlkbHFMMURLSC92T2VI?=
 =?utf-8?B?dVRFbUQvVFBzOUsvcCswK2FveDJ4YXltZW1Od2lBZXlMdmhycUhrcEdHSlZm?=
 =?utf-8?B?b3ZERmozSmczYW1zWHU3KzBBQm9ZZU1KRE9TTHpxTVF5UjJYNFQzMWFpZEtL?=
 =?utf-8?B?L1ZXakd3VTkrYjhjT0EzbzFjcW5TRUxtaXRuWFpra3JwNFU3S0xYMGMwTDYv?=
 =?utf-8?B?Nnl4Mi9xMi95dVNyb0NNUU94d3U3M0hkazk1VDJlSjYzenZESnRxdHhnR3Zt?=
 =?utf-8?B?ZUtuOEVaVHp6SlNRV2FQdEg3Yzd4TUx5bGpRNmFXUERmZ2ZJUGc1bysremN4?=
 =?utf-8?B?WWJvVk9jTER0MzVWT01QTDM2aHA4TEpvQ0NLVXFBMEhSRHE2VjVJRWE1RzNu?=
 =?utf-8?B?TDFoSVU0eTFTQ3dvaVZIZG1DTGhIdlhRbS96RHZpZlA5Zm5VQW5mMTlzN1BS?=
 =?utf-8?B?MXlxOGhEekNROWpQemdIY3VUUTRteVJvUlVTN3ExOFUvLzJXZ1QvanYzUlB2?=
 =?utf-8?B?eVBFUXRESXFHNEE2eXlqcklYVWhWSkxkSCsrYmFaMi9ITkhubFYvMFNCTllo?=
 =?utf-8?B?SWR5VS9CVk1tVWtibkROWjUwRnVFanREY3pjSld5WVgreUoxQjFsa0hFUTlw?=
 =?utf-8?B?VUFPNjIwalV6RFZiOTRKcm9lWEV3YUhYVGlEdkNaNEdvMjljU1V0WjRGZzlp?=
 =?utf-8?B?VE5pOUs3SEppZEN3d0w2M3lBM3FkbjNMTXhkaThxNXFiOVNFMHE5QmNramxV?=
 =?utf-8?B?M0h4a2JmRE81blBKZUZqZkJhenZqbW12Y2tIVlc4aU9PUlhlOTNHKzN4S3NS?=
 =?utf-8?B?RDJ3bmtZcUpLUlh3MW9taWNSVVQvSEVrK1lDZjJRM2paZUlmU25JV0JYNm1G?=
 =?utf-8?B?V0d2TUFXZE43NlJFV0NkbVNMeHN0b0g4K3BTRFJRb1hrQVN5a2dLZFQwLzJE?=
 =?utf-8?B?dmJqVXJ6SDBWa0tjd1RTcVVFblhZYjNHYzlZblQzZlhYNSs2ejBXZVVDcTM1?=
 =?utf-8?B?V3hyQjNQaXlVOWJVbXNZL3BoNzM0bjZpb1JLcS9FSGhQUkZoSlZGWWJKV1ZI?=
 =?utf-8?B?SEdPQ0xmSldMVEtyMUwzakcrcUJQK2RZUFRWTVU4V2ZNbEhvOXhoSDQrQlVa?=
 =?utf-8?B?MW1LbjFncVFwMnFUaGJjT250enY2U3JnV2dMd0pYQ0JlL1dCQitIQ1VkR0Yy?=
 =?utf-8?B?U0IzL3ozaHRDais5RnhqSmpXUXY0Y29GdGJsUk5mSTcyWWZCWlhDUVdwK21n?=
 =?utf-8?B?Q1JEazRmSFR1YlhxRlp0eFZFUTJPdGJOeFo5L3NhV0VRMFNuY0VORjB1M2Ri?=
 =?utf-8?B?N29ocEx3ZWpZMWtvSUpUNlFIdmpYSCtTL3dWSHNJalY1T1dkM1o1OFNWSlVS?=
 =?utf-8?B?bit5SVVPSktXTDRzbzB2R1haMlp3TEZ4ckxKYTlTNitBNVVrRnBwTnBRakIy?=
 =?utf-8?B?bUNOSXpQZ25NZXdCZTMzMWUwRW9kVXJoMmVUVkRQb2pWQStNaXRTNE1iRElJ?=
 =?utf-8?B?Z0xieFRkNFh0aDlWQ1ZRYmpTY3NGUklJeS9HQ2d3dzBsR0ZEaVFtR044VUZF?=
 =?utf-8?B?OHdUZTRWcmdickUwUGpINnFZRUpwQ1ZtMVNIZmlmVUhUYXdGZWxxY096N1Jw?=
 =?utf-8?B?RFVWbGRIZGlsMER0MXlMZTNib1o0anltNmpPaDFjdEhYcGZFMDhxRmkwMGNR?=
 =?utf-8?B?NVdJMGxtM3hGVXdnRzQzdDJ3SkEzcjhYcDNQVXBaUzdBQm5ISzBhTzVpajJs?=
 =?utf-8?B?WHU2M1pGemVoNFVWN3E0SDg2Qy9xdUd6QXNVTDFHekxndG9haGRQZjdBU2dK?=
 =?utf-8?B?V1hWTEx5MnVIc1d4bDZxU3dXenYwdjVXSEhkNGd4cE9KOTFzMFlQS25YNGQw?=
 =?utf-8?B?V09zTFNlbzRBZXR3bzQ5eXQ5bDhFNkMvOWZJRERKc1d4RmQ3aEdURGIzN0Z0?=
 =?utf-8?Q?PsXSBI8AiHHbAzZ45cr+I4yGw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7228003e-646b-41cc-b6f6-08dd5a6496b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:03:43.0417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB119qRGT9raJxO0QUDceiNTn+qZkt2u/m/Le2aI4jND3tm1Bh4JgoqBPNH+DO62UkjXCRYxCxlCh0UCJ8lQTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2/28/25 11:51, Mario Limonciello wrote:
> As new members are introduced to the structure copying the entire
> structure will help avoid missing them.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index b8d4e07d2043..515c6f32448d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1277,11 +1277,7 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
>   {
>   	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
>   
> -	caps->caps_valid = atif->backlight_caps.caps_valid;
> -	caps->min_input_signal = atif->backlight_caps.min_input_signal;
> -	caps->max_input_signal = atif->backlight_caps.max_input_signal;
> -	caps->ac_level = atif->backlight_caps.ac_level;
> -	caps->dc_level = atif->backlight_caps.dc_level;
> +	memcpy(caps, &atif->backlight_caps, sizeof(*caps));
>   }
>   
>   /**

