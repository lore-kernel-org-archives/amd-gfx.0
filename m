Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED56C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5775210F16A;
	Wed, 23 Sep 2026 19:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DDGQ1xpn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1CE10F16C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRbucAMZFTFqFLbPxmMK20W7eX1w/AauwSm3U8MJrFSTlmz4QsuaUDKYkfQy9pfM9SBbak3C2pPxadiegN+1OVaVRaHunSDJlFfjjpjqfeJhKbwqAepCLCNIo4DvtkLbRKyywKkLh60jTG7JQyYNvK1yDoDiWQSy0pU40PnHC3tPlm/6/32OffDwUeVxoNGpoNlPwyKeP9ePy/3oKEJ7tg83x1Jizg+Y6+1xUipo8RyDxeYRFfFHzJx4C72j1vE0wr/L/iJuBOsNRgZHrc3eRCdCjabz1BnV67AS3ukZj8erbBy5OD5i6cSVuBNdJyBm/6IB0gW1GmhZg1zJY7i5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKyCoCjeMBwXqQuBqRlO71xPNvn9qGMVjXmnyuPHxYY=;
 b=R4CmZB2J3stOtalIV8Kwc3MKvRZ7YYrYQ284N3r3hZjzTfQnAkuy84KNft7IRRp1bPCvg71iKXj5qMnMGbRKIeYzSRUW9MOjy91icOK7IekXfW914H/M9pmE3uUVuzpl8HmzmSVg9SJ4zpDl0G75EG1g0OW0zt8/hDM/6IVCfSZfVeejwTdrWGxEeKyE4Xta+oAIUXgqhA51iE6UJKaoSy9fYP+Aeveo4okMlGJYO+cIDoyG129cgdZvjxevir1sHXg3jfEXWhJkISWR8EY5AHKS4HEia+Bq9N6SKQcWaDblJnj9JiP7hGa3b9Q4kk7p7Z9U4T1pBrthr/0w/dJF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKyCoCjeMBwXqQuBqRlO71xPNvn9qGMVjXmnyuPHxYY=;
 b=DDGQ1xpn3/t5Tj8vJ3RvvmX2533Y8ZF894yeujLFS0vTk+vWZvQGnhZ9+TJMMAIvx5boj693CdBXjnPHj7oqWL3x2S55ZulTB0RP8IH31FIHogJv1GE2bNr/pZefBxQKMUxtSgZuohbmhjeJ/fqeMThlwqbu6kR7m3lx1KG4aww=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 19:52:04 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:52:04 +0000
Message-ID: <22d78b4f-786f-4022-801e-d17812abf902@amd.com>
Date: Wed, 23 Sep 2026 14:52:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Mark DCE 6.4 as not APU
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Leo Li <sunpeng.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>
References: <20260923122033.1046651-1-timur.kristof@gmail.com>
 <20260923122033.1046651-3-timur.kristof@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260923122033.1046651-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:610:118::26) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: fa37711e-01e0-461e-e7b2-08df19ac246c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dR3aq9AZtfG+ByvcmDyH8FwOgLn83zHkKLnLR1J6nXtoIMkR0l+VB1MzUENyzRYhcN9oOdroxcLYnA5kJbsvNpwHVlyeVLBdiUp92BUbNbtKL/BaOtGpNwflQ9ZuMpzIBjFN1acrwRDcnmAOk4v3llJTeXgc3ZWHDqApuy+ZhsdYPKeHhjXJkq8cC6jSMATrrpY3sqI/eEFs/I6XSdWLSL5mKjlhcYj3YsHEJSUwNLrGSfSlCHwHs9e6jDUYn4+hr7IoIwHifMpWX59ZlBJ6B0MAftVHZyQzwIoyHuKOT8YW0x07C1dNOrVymnKMWtqmsskW9BuZ7AbEwGzBMlnGYOgy3M7kj3KjaWYE0zCm5EGdfBX5mIXSBMB4vawsJEze81AIsEKivbtEzeMmJ62efNW94VONxUUXLb3jAT9TifuEubHU+aGIL2vJvJEoJM14YNml9eyUCXG/6yqb22FOWqfVPj13ZjqPWnnTHs1K0+9YxT7CATZsUJldVPBieOT51JSbFRHDGDppDYiI9piJqttcV6T2eFOTexV3V0vhclzR6h6Ugs8GUQQzGaAZ6DdONdzRusuKCG2ECUuXPwQOBtiNN0mJKiX0Rux34UyqxeqrZJ7WVivxNOOwiX82ZaUP8W7rWAOi+7JQDZ9jmnjMcVgkT0DVr/8jxJQPTKJV+Vy5VTNPG2rs/Bx2/GfMzf70jeCWtsRyjMZMcp8fhlZMRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRRdEd4bHRTc0o0MC9uZDJlWEt1WXB2RTVHS0QxLzlQUGdvQ083YnBLNkRT?=
 =?utf-8?B?ZlJoM2pUQ1RaUnJXK2xtYXZIbzl4Qno3cDR3amc1Uk5UZVF2NmRaRkQwNHBl?=
 =?utf-8?B?U0lBSCtUVVhHZlRTVTJ5WVRvNHZnWWZ3TVR3TEdiWFFQMDlOb3lQbUNRUjhH?=
 =?utf-8?B?VEZoNWhHZVV3TDNoOWtYVlVSd2lHL3k4blVDSVlQeDRLWTAya2tneHhiRU5y?=
 =?utf-8?B?akFDZWZLUkViTXZKZ2xyazNGY05zbzNxNVlVNTlFcGptbnNpWThNZHUwNjZp?=
 =?utf-8?B?Zk5TWXZqSnc2b1NBN1N4bWdLS0NuK2RQSFFCaXVDZytBOEQ5dFcxYy9xUGlH?=
 =?utf-8?B?d1VXa1k1UG85bUtlYnVYVEtzeWNWMk11MWtlQWJVblVORVVhS01kWDFDVGdH?=
 =?utf-8?B?Z3YreTZEQ3pMVEEwLzRMdFJWQWJ2aldDN1g0Nk05Rzl3MFZZMGlDcHhEeE5Q?=
 =?utf-8?B?VWIxS0tQZlNFbnNiS2JESXRlcEdmU25TTUVRc244by81THhrTW5JMnJWdWRL?=
 =?utf-8?B?NTd2bmFCcEZQWXVrblRmUjlpWFl5SmZqRGpIZUxwS2JRNEJ3RUIvb1JjYkpy?=
 =?utf-8?B?YVU4UjZYaXdMTVBWVXZkZmdjMHJnRjJQb2lhNmF1L3ppMDFPN3pTV2pBVXIr?=
 =?utf-8?B?SjVQMFNreDl0U0tkZlpDMjdZdUJDZFJPck1kOHNIREZyL0pLRU15OCs1RFF3?=
 =?utf-8?B?b1NoWVJGSkJxek1KaElCK1RJazd3ckNHUGFnbnB0RGEraExnTHJyRFVKTUF5?=
 =?utf-8?B?UGpJSC9XRURSY01LdzV2MHM0NEZYY0VRK1ZJMXFkcWd3bkdiclZuNmRqQXA2?=
 =?utf-8?B?dzJlUTdSSkwzOU9vNzRnU3lEQkFESTU3K2RBa2phZERSclBaaXpSRFBjYzdF?=
 =?utf-8?B?U1BaN1RnUEUwRDJvWEVkZHVOYlh5WmVTaW8zcFZ6V2RvTkdPeGF6L0xKOU5S?=
 =?utf-8?B?VzlWVVpqMU16aXRuNmwvTmZGcDlkU0w4M0Rpb3gwMFJGeXI0dmlCWjRwVE9W?=
 =?utf-8?B?NVNOMmQva0ZmWEFpZ0t1VkpyTFFjMThCa25MSGs4QW53RmswQ3ZMV1Eram9R?=
 =?utf-8?B?YVNzOStxN3JESG9QNmJ3aXJqZTk4MTFITVNsdEhRbERTS0ZjZEVxRDRHOHpB?=
 =?utf-8?B?UFFCaUpEUlQ2WnIxalNUVnpVSyt5bmZJT2VYWHNnd2haZ2phUG5aZnoxSWdz?=
 =?utf-8?B?TXRDYW1jbE05eGRheU51K1RFVzZYZ2s1UE9XdGVwWG4wMXVpaHd5TUMvaHg2?=
 =?utf-8?B?d0duNGhvbGI4THVqWSt0bFFOZWRTbllLWHhqeHRTTUJ6eEY0ZnkrMExhVm0r?=
 =?utf-8?B?cHIwTURGMExpVDRYYXlUVTQ4NHcva0I1OURlNXdZWjJoWjd4K004azFiMHRT?=
 =?utf-8?B?MmV2S3Q0RHM4V2VkWHU0MFJ1SEhsSm5Na0oxbGI3OGNqa21aU2pOdXVld0dv?=
 =?utf-8?B?QlhmZDVIUVVENzdoTEtKR2xmSzdIL2Rsb29LM08zaW9rcWF4T1NPNG01TjE0?=
 =?utf-8?B?VTN5WWlUbXYrTytvcGlxbGMwWURjcjU1eGhMZHF5ZFZJbFpreDhKNEdwUXhQ?=
 =?utf-8?B?R1d5ZUtLV3ZGUnZZRnlHaUNYcFZDR0VrazVkU0RRQU91ckNVakZibEc0VUV4?=
 =?utf-8?B?MVJyQmpMeVpncDYyanlGUFV6OEg2b29xa3ZWbXNqSUtleXdlU0xwTmgrYVNH?=
 =?utf-8?B?SDRxQVlGQUNzdStHN3dJRG50N0p4Z29ZTlNCNzFzMkZobmtBOGs2N2UxR2pD?=
 =?utf-8?B?alUzVFluWTdEeE9mdFpMSXdsTjR1VTMwWTJnRlJXcU1IRVBHQTducU5LOXRl?=
 =?utf-8?B?WU9IMXdqWk9vNFN1c2JsSWNmK1FKZkRwNXNrZ2dSaG53Q2xTdGtXb3ZSeHZa?=
 =?utf-8?B?TlJpYy9TazlOSFhoeWVPVXJVWmxwakVBMkt6d2VZdzVpc3IwekgvUElvcUxV?=
 =?utf-8?B?VHFWSSs4eW5Ra05WY3F3UzRucE9SdVB6bFIxNzdtc3I4UmRqOG5GcFpiN1JV?=
 =?utf-8?B?NHU2dGtTbVlXbnJiRWc4OE9hT29neXp2UFhhbFEvdXRmWFRjVDFwcG5wRTd2?=
 =?utf-8?B?YmozUFZ2dXhxY01lUG42MW43OUVjV3dHb1ZoTmZxbjRtVGUydTNDRWFlRmxK?=
 =?utf-8?B?cmxmNUlLdHJ6eWdkeHBPMHRIbFQwUHM0bUFZWER1eFJqTTQ4Tk5Fdm96WlBh?=
 =?utf-8?B?RzJodHE2bVJvMEZoaDQyU3dpWHhJV2tzRStFM0QwTnhyck5hbWpCY0k3NFJ4?=
 =?utf-8?B?M0ZVaExOZ081dU1wY2dNVC9jSE5JaVV6WUhzNGh4d3pyOGNWQVFqV2FqK1M2?=
 =?utf-8?B?R2FnM0wxSWtoSUhmZHZmREtZall1Um44ZCs4R2pmdVhGdFpSZDdJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa37711e-01e0-461e-e7b2-08df19ac246c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:52:04.7852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CVpUjz67vTtXP4YX8ddoyBYwNmdxDGDolXk1my8TO23FhruIzEJL864vVrX07pU+r/dd2csxSV06R8VsFu5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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



On 9/23/26 07:20, Timur Kristóf wrote:
> DCE 6.4 is found in Oland chips, which were advertised
> as low-end gaming GPUs in 2013~2015 and then have been
> sold as low-end workstation GPUs until 2017~2019.
> 
> These are not APUs.
> 
> Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> index 8612cc66a6ba..65c7dae3ff66 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> @@ -1341,7 +1341,6 @@ static bool dce64_construct(
>   	dc->caps.max_downscale_ratio = 200;
>   	dc->caps.i2c_speed_in_khz = 40;
>   	dc->caps.max_cursor_size = 64;
> -	dc->caps.is_apu = true;
>   	dc->debug = debug_defaults;
>   	dc->check_config = config_defaults;
>   

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
I'll get this queued up, thanks.
