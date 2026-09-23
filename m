Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AC4C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFD410E155;
	Wed, 23 Sep 2026 19:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oBS0VrNg";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E1010E155
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HClPit80YZpjF9fhnlCnP1YuAEt1wN0TRpUg/sw0VeJo/391On1W5rY5SzqJ0QcCmWgMfy7EpeTprpH9fhnkgRGVt+uccCLrCQXo3Slf/OsFHDp/ZwolxitInhaUsYpmdtMGjhOgBI3kLp2VWjvqV9sTH+c8/LzSQaNztEjdxM2GfiNFERhV7im94zpQtAUfPyBdY4yTZU03x2YGstdK/R216QonK/XS6muzLBdwS7+HRoGP1I/mUjJrMFFkRv44K1QPK7+wA0FammofHC3UULMFz4H9uuV6MWJf5neonMHFsF90BYGZwwXvO1em39ol1EBM2a7Bm4yoau9oG44WNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTnbI7Zs+QsoIugntfad9gfZI7WOmcmoRjCXZmXFUGE=;
 b=n0yW3llTogIIPdGU0DbHuZII6pnASFqpToPppv1xMBy24Kav5Yno26y0t44CuQRqXjM4jOJqoqLzzBkNAFmnXbdOaYIm3R8ZxbUozbdG+680hysnMAymENV5FsAhwsIK8U1wj4PYX33iubSVGrdgl3rdwetRN0veusg339nTiymn45qXCpJJyXOBo/AqPAdu3GGyq2uq4vClX/6u6ZWQXPXHyRmnzP+L4r97FmNd/0QQYshjVK2HOoiquMlHfa5rseLCsOAeyZb4XIicC4GyggpaPgPjbcHnoXaFj1jjgrbrFw+RDTHQARAp9gWrZrFqkg7IfaxdM7qTQChne3B0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTnbI7Zs+QsoIugntfad9gfZI7WOmcmoRjCXZmXFUGE=;
 b=oBS0VrNgWTVu+6rkIVoqMDvaL5H/qoghuR6pOOc/9lrYVsrS1z2zX+zbpfOIaC0hBZXsJNriR9h/Cpw15vJPr6mnvobXwAwW2E+arFYWWVns7/A0J9VI/ld7nEh87eox6YGKsEfpu0QNla+WTIezOvkTcdVpbAd//C7KWzrVwPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:59:16 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:59:16 +0000
Message-ID: <6d94871b-7e1d-4027-869f-6882f7f7ec03@amd.com>
Date: Wed, 23 Sep 2026 14:59:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm/si: Check AMD_IS_MOBILITY flag for
 PPSMC_SYSTEMFLAG_GPIO_DC
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
References: <20260923120354.1027996-1-timur.kristof@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260923120354.1027996-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:610:118::29) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 1304146e-705d-4c41-9d69-08df19ad256d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: xrHCTRdw9iDM+AhAZ7gAd5FcI2TdYTzq4NyJAU3TDKzH9DZSb55wVi6aI9G87TF4KA1KE71gF5CwIRSoARJjLsQBLg1LMW1T3KHdvaS+MfszS1JXQ+B7aFQZu9gYu0hXJI+HYfaklnscowtg8iKl5De3m1pe0crwhk0tl+jC0KNXm7sxIMqQYIFFfI3WmqCLIpoiPiOZIhPUdsWMEKUg1Bis/hwH/La/bQ9uY4c+jakjKMU29/YO6FbbOcFqW15p7fjpJcKKX0LJOF7lPktBPgFubwT7l60aeuOMWSMR/PTlBOKW4kwviHvmNBebJPOw3jp76dYWbcyVZLwlBr8TmFzirTSzR0djxmtMSvEb+XWEkP18yJwoSnAm0qZdybl4SdVmPtHIH/9EUBD8lcHs0lpzVaAmAqKj7vBqntyXx7FEzqh2Og6/vkNW5E3kClUYO32Na1LuHnLq61t1EGK6XndSyCH41zPqqTHhlZlxBNM3NQsrld9UPMnvyNLmclHgtvxK+QJq//VOuisPwZp4efJJJNdgF9//36IOg5HogjMS4lGbPpaavxWXuGfKP7AykRNY9zxNo/3H6XiRen/oXQGsyoUr9Yt8GaagPjgVPEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVMcW82OVRnODQxd3o3a05FYkJoRWlZL285K2dJZURmNEduWTBRUEVkZDVy?=
 =?utf-8?B?WkJadWJpdTNzYS9IS3RCV3Z0ZFNndXBRYmhpaWg0WCtrKzRCM0M5K3NlWTZ2?=
 =?utf-8?B?WHUrY1ZlbUhxenV5MDhaZmd3Qmd3MEVXR3ZIRDJORTZzRzJRSFMyQUZtU0dX?=
 =?utf-8?B?a3FEaXRZSXRBWTl6cVpTUUpvWmt4VXNLK011ZmhTY3dnYXdULzBKM2ZnQU1I?=
 =?utf-8?B?bUliS3BsbHFTYXFTd2xCQzNyZ1pnMkhPQzQyVkZxd0RMbW43c0pqNWlqMlRo?=
 =?utf-8?B?d2FZMEtZTCtJRlVpSU5MWXhKL1hmWUs3S2pMcWIzMUZyZU1JeHBvS1o2VGVO?=
 =?utf-8?B?QzJ0NFpwUm8wQlNLZDhsNGpSb3lncWZvL0J4cEdxSVVTZDV5TTFLaUY0ZnZy?=
 =?utf-8?B?ejEreXJEMzdJS3J2MWd3ZlM2ZEpOVzR4NEI4N0F1VVU3bXpaVjNCalVOVGpx?=
 =?utf-8?B?c1NaMlo1b3JhOFRrUHY0OU9rODB0YytpaEtCVWhLQkVWNUF3aFFCZDk1U1Jx?=
 =?utf-8?B?cEpKcWdJR2J2dkR5SkJBWW5LMEtqWE1nb2UvQ3QvUk9nRjlEKzREVC9GT0RH?=
 =?utf-8?B?Tk16WE5BVDVLbVUwcGN3YTBUampLYVRlTFowYjA5Nmsyb1VVTHA4Skltc2lJ?=
 =?utf-8?B?dGtaUFhrZFh0eUxqWFRRa1pCbWxodmI3TTl3ckxudW43YlhVQW1EQllMUmJD?=
 =?utf-8?B?WTI2alQzMnlnU0tXMlMzUnB6MWwxOTJibmNlM1lwNG9VZkRrcHFsbWthamRE?=
 =?utf-8?B?NWs4MnMwandxQ3MydmN6OEt2cWE3R3czaDV3TlZmdGJ5c2pJTW1mWWF5Q0JP?=
 =?utf-8?B?RG9rNEswc2hNSnViZXo1d3E5V1krbTdlVmxVRDMyY08zRU1PckdPWVF2STFP?=
 =?utf-8?B?cTFjc0grRnJROEdneWkyWnhvREMySUVDRDYxNmN1cmN3UUt2YnMveElDb2JK?=
 =?utf-8?B?RjNyOXNJYWJlcDBNV0pRREJMZTA5bXplTU5hb1d0UFBDRUtPamNablRRS0ts?=
 =?utf-8?B?S3o0a1RxM1ZiUnVmRzhlU0hWWnY1VzJ0S2dUZXFOZFhDbHdhVCtWSFAzaUtS?=
 =?utf-8?B?VytWVUtMVnBGZ0dCdDlXTGc2RFF2TExoZUIwOTNUZkNLRWF4U0JvM2dFRjZC?=
 =?utf-8?B?a0xlbGJ4eHF1Y0d6VTE2Sml0VW5UVVdHZXkzNGlLeGN2c1FOeXJVc05QbUN0?=
 =?utf-8?B?LzJmc1FQNnh5WTIwQmVZek8vbHZxaUZzbE9pZkR1ZlFmeCtXTnVVZ1IwTURO?=
 =?utf-8?B?NnUxR0xBUTFyQjI1YkhBL05iYmk3MnNPK2dRcXJBZTdLK3F3RklBdjNETTJm?=
 =?utf-8?B?QzhZZFJrQVF6UHZvVEFTcWxUcENqaldxRG9jNGRuL2QzUGFLd0ZSYUMwam9M?=
 =?utf-8?B?NFNkajMxKytHcHJEbHk1c1hxY20xRjJHd21rQVMrZVpic2FDaEQxdFl2QTk5?=
 =?utf-8?B?YjBhbDBlKys3K0w4ditLMmZST2EySU9laFhkc1lUOTloVXBIQ0NWUHlXSDhW?=
 =?utf-8?B?ek0xazlWMUdRM3crQXlWaTl3bGxRdlZpS2FqUkhiTTdIWnRhVEhjZUx2amdR?=
 =?utf-8?B?dmNMSUJzK0dEYzdQa2hPK2xLNzJubm51Tkd4Tloxdi9rT280R3BudWhHWEJV?=
 =?utf-8?B?UEdLMW80NlNpMitaMjRoS0ZKREUxMFdMNmtjeXNwb3V1MFFDQmhSay9oaHBl?=
 =?utf-8?B?UkZraHBmRWJkYllJUVhXUXh6MVI3SHZzcU1oWXFVUXRsMkJIaU55OUhNc29k?=
 =?utf-8?B?YzlxOG9rZWNSRGYvc0FadDFraWRHUXdSSjREVXZZRDF2b25UVCtTUVB4Nno0?=
 =?utf-8?B?VjBMbDhYYzhxb1l2MHAyUS81NUd0UjZOVnZNdnRIZnV6aXhqYW1ubVF6THl6?=
 =?utf-8?B?ZEJ4TXlIV0VobmN1WWdjOGRxM2Zjcyt4anZ0cTA5ZnVySUxxQURoRkt2NzUy?=
 =?utf-8?B?ZzlRcTNScmV4WHlyYWJvc0VTeEJQUUZ6K2ZrRE1Ea2RZM2QzZWoyODBRNHhG?=
 =?utf-8?B?US9WTXY3alUvRmtsR29uam1ZWXVxWE9UNnFoUmZEclgzdENTbVlJazhyeUVT?=
 =?utf-8?B?TThZTytKMittMFhRS1Z0Q3U2ZHBWUkRjYXFMbXkxVExSYjJmYnUvWVgwWldD?=
 =?utf-8?B?ZHFpZE1NWHA0TjFKU3FYODJMblJ2ODJtb2JpOTJrV2g4UzBYV0JZZ0tZNVl0?=
 =?utf-8?B?VnFRSW5lVUg1QzR0N0MxSFJ2V2xjTEEzZlRvdnNDZ05FSm5scmd5cnFmZlRZ?=
 =?utf-8?B?VHp3dGhIME5tZDRMd2pjSzlHdld0Z3p2aDh1QkhteERGVUYySHhTcUd2NEhH?=
 =?utf-8?B?dzRtOTJMSVh4djg4TFQ0TGtuT0FGZVN1YUg4V1NPWm1QUmRVcGgyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1304146e-705d-4c41-9d69-08df19ad256d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:59:16.1047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4PG4Nn0k0gat1aS4J0EFgVGsmposg/6NNo+E+gMHKnbnMpPAEV1GMl8AkxkGpYjF6vygQjwSb3ySH8D45iF+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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



On 9/23/26 07:03, Timur Kristóf wrote:
> Unfortunately, some desktop boards eg. the FirePro D500
> have the HARDWAREDC platform flag set and also have
> a battery power state configured in their VBIOS.
> This makes no sense for a desktop GPU and results in
> incorrect behaviour: the clocks are stuck at lowest.
> 
> We observed that the kernel driver can work around
> the issue in two possible ways:
> 1. Set PPSMC_SWSTATE_FLAG_DC on all power states
> 2. Clear PPSMC_SYSTEMFLAG_GPIO_DC
> 
> We think that the PPSMC_SYSTEMFLAG_GPIO_DC flag
> makes the SMC assume it's running on battery even
> though this is a desktop machine with no battery,
> and that's why it doesn't do DPM on power states
> without PPSMC_SYSTEMFLAG_GPIO_DC.
> 
> Issue was uncovered by "Fix updating clock limits from
> power states" because previously the limits for the
> battery state were not tracked separately. However,
> battery power state has lower frequencies and voltages,
> so the kernel doesn't set the DC flag on the current
> power state anymore. That causes the SMC to be stuck
> on the lowest clocks.
> 
> Let's clear PPSMC_SYSTEMFLAG_GPIO_DC on desktop GPUs.
> We can use the AMD_IS_MOBILITY flag to determine that.
> 
> Fixes: e6c5d36756e7 ("drm/amd/pm/si: Fix updating clock limits from power states")
> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/16352
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 6cc414a8a4de..d090dcada1b4 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -5263,7 +5263,8 @@ static int si_init_smc_table(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> -	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC)
> +	if ((adev->flags & AMD_IS_MOBILITY) &&
> +	    (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC))
>   		table->systemFlags |= PPSMC_SYSTEMFLAG_GPIO_DC;
>   
>   	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_REGULATOR_HOT) {

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
I'll queue this up.
