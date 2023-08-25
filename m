Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24CCC3DA66
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 20:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3E910E154;
	Fri, 25 Aug 2023 20:10:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F81010E149
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 20:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/UZ7zzI/DJ5toGPlGHf9nznPorrjrvG39yU0YbGyFJvNB4ssptf1MKuaXkHmh1MzDsCNsUDpuPKkGP7ZiHiABPvNnynuCYu43wt8sxgGiQknY6MMYtljOD6IUepjSZzzZS3DFPwqw9Lict5NA6BdSUOKs3U8Xv5vXtnXyo/cKLccj6r9JQ7dcsPpYCny0zlMsqb+edBX6+WAyeM6jMpgzUcH3vHK2GLxD+NF+DAMBAYXkfHnUcpydbWtSeAz0uL6NAwuH7KyLlt09Cn/9o0jzXBFUWJ34J96gbC2abD3Qva+VavNGZDVxKXvph6FbsvxldNFwYac6j/DM39gCFWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YxblDkCxm36X+JcsPM3iQ/0NlsGxVWMQbM7RR6G5H0=;
 b=kx7ZItn5Tc681sv4t9ITLJKBxJQK7w78Mi3SAuEyvGy+vA5sFsd13+ru9BAJnuC7r4wHJS90/Jpx7FE8Ff195y7T7aEEeydPrD6nufXf6ASZB0IACVSCbuC6ZiqhUTAL3xuMrEXxMxhCq/5cZCk8sfJq4GUdTJiPuVGxfi/HP/WJvQCAk9q5bsTmfjGmb3PsxEWiwQWTP6hLd7od4alh7GoidGRXNPyxMoe8r30WvmL7HSJfyRBKo7AwH0E9jKcBkZ52v/LvYgIElMpepTpopcudouYAl8E8bGIVwkkD4AGyPtfAXckB1L+zzFv53Z8ckKKyPAIfYvqFm49taCJbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YxblDkCxm36X+JcsPM3iQ/0NlsGxVWMQbM7RR6G5H0=;
 b=RySgVsvc5IPtwZl5pCUg9UeoC5bq/cmjA+Fcgdv3FBf6mfeIAPWtYnJT/ax9xBb/rg4y4IxE/6h4zyAE3vBEHMjUlCj888Rjy39x0I5DiJEFKtBf119h69XbdYzqTrAspyp2R/55vdUe3Z/1b6VSRa2FsY39/cobdQGqpiR7abY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 20:10:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 20:10:20 +0000
Message-ID: <8ed08ed7-c6e0-4d8a-8900-3b6e25de3f68@amd.com>
Date: Fri, 25 Aug 2023 15:10:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amd/pm: workaround for the wrong ac power detection on smu
 13.0.0
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230825031926.1932471-1-kenneth.feng@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230825031926.1932471-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: ab831626-6287-450c-e3a4-08dba5a74e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /H3s1AD7SwrHN8dNOM4IQYDVF1zDHr6wr2fffdYSxbTcTvdXFqNmfZGn33tiQKXjkUr5ZPpm7Xn6TuRRlcxVsxeaRJOZ+NXnhr+Jy31p2pApIa170rBHrhiq8C1qmnrQS3nUn/SqMqTZKQXtfp8tRgAVrQ4BGxCsEzOkNn0kIYnJlBuqFkRyeSY3uOBtobDA0nBuKiFhrfwNVNKEDpJiWPd993DVtR55sSwtZOKf6QBPnOBjjuge6LTQNcesReNX7H0mEAaLosGugJFsG0rMF1wiAhr2MDsrcc1SQnp/AouxkPftI9NC4YHlfJjc7JuAHiQoJI/zMzHNRZ+FAkJdKhlapRyLHPdp2PUentrduYKPq26kE2S2HiVLcoAn6WfaI7uNGBmMOeqZeyv2KWCCZAC9xhRxytF95qwKYGqvjVIl7G5dAmHbejveXNQ0JG/7bUznguDso6PRwUeqn7BFE5axMXZe298nRDQYjyT3CyETEvsrZe8BO7yhXTFMNKjEHtYfP5GT2R2Rptxy8aMh4h7GI4JLZ6R+rTSgcexlxuBCIGxZs0R//Q/rBm0FnX9l3h3r7wE80PjBpOsdScm2t4hH8V7yDQy9+S+vcFHczhQDZPS2Fyp40sqUV0PsXlM0kNwGaOojeX1FYlwre1tuAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(1800799009)(451199024)(186009)(44832011)(83380400001)(6512007)(478600001)(26005)(66574015)(2616005)(5660300002)(31686004)(2906002)(8676002)(8936002)(4326008)(38100700002)(66946007)(66556008)(66476007)(86362001)(41300700001)(31696002)(53546011)(6486002)(36756003)(316002)(6666004)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3R3RTVacThxcGFSbEZXMlFyY2dUcGkvNTI1aUYxY1h0bVJqd2VGTThsMXhx?=
 =?utf-8?B?dVYzUTJQd2NRek1RVTM0TGJ5RGQxRDNxWTZUTWlhTGFHQWNlbFV1OXc0cDRs?=
 =?utf-8?B?L1VNZmZQNXJVSHB5WVhzSDEyenE0Yy96YzVabi9Db1FyRzZxallWUGp0VHZQ?=
 =?utf-8?B?bzJvUks1eVJUSjR2eHl1ZVJkU0djQklrN0VwVkFMNjdPYnZsaTBuc0lFcFNs?=
 =?utf-8?B?VXk2eXdnemt4SGo0WktRY0xJZENuT0pIekUrTWQ3eGJXNy91SjB2VDdkSkF5?=
 =?utf-8?B?QzVRdnlqSFlYQi94TGVVMkpBVTdteDRKQzVLZWF1UW5NbStGN0t6QUVjZ0Fp?=
 =?utf-8?B?bm5tSjdvRXh1Q1dLRHhTRjNDbkxGRjdRcDdSczUyakxsNVk5THpEZ0xwTldU?=
 =?utf-8?B?eERkZXl5K2VsU3NIZkRUTUFEQ1NNSEgrazE2Q3hodlRQSzAvSWZaSm90SU1C?=
 =?utf-8?B?YVpWSTFTaHZuSmVkTHNvT2J6ekxtZVZGQU1oVEhzQW5RYVFrSG5OVFN5dmdh?=
 =?utf-8?B?UWs3MGxMUkhvcGVnaVIrWWxvaEdqbFhuZ0xYN2FNbDU5bWM1eFlUUmZYczNS?=
 =?utf-8?B?U09lQnpTbUVjamNYK0xLK0M5R1VpZ3A1eWhYUEVHd2F5UXR4elMvVjFMNk1k?=
 =?utf-8?B?TGlDZ1FaZDNWSDNHV0tEMUh4bW9uRXZkS05mVGJJK0ZxcDRtNVUxYUswa2dT?=
 =?utf-8?B?SXdBWGVQRmxCeHcxUFVFbm5HZ2lIWHlmcUhzRGppaDVpcGpLVUlFWTVnZHE4?=
 =?utf-8?B?QWxQSUVVbnlCZVh0MnMxdmhYb1RwajVlMFJkTFNUVEgvU0J4QXlWWGxuMXZu?=
 =?utf-8?B?bkx0RmsxZ2JhOFhMOUVUdThjdGxseHFaYlRRZFlyaW1keDNSRk1PejZMN2E1?=
 =?utf-8?B?U2dWU09xakUxODhvcE1QeFZtSTB2MTJod29ITnZIN0hSTDBrUnZPOE9aT00x?=
 =?utf-8?B?MEd6U2ZxbWxQM0F6eHVkM1pRaE1ZQ3c1MDRMVTdsdVU1Ym52eW9xVnlya3hy?=
 =?utf-8?B?dXJjMElYRkoyTnE3ckl0SmV1SG1TUys3VUtTbGZ2QUtzZXd5Z0VCOGtWSVQw?=
 =?utf-8?B?d0JoN09EbXVTbzVWUVo2b3h3aVo1ZkM5a0F4S0xLcENGb3hrcyt2UGoyQzhn?=
 =?utf-8?B?MkI4aUs0R1Z1dXBMeEFQanR5TmhYTkF1bmF2MkRya2t0MTEyd0p2UTZUWEU3?=
 =?utf-8?B?QTRPS210U3BJL3FGVFM4ZHBBTVcvR1NKblNtS00xTFU3WmlkN0huT043azRT?=
 =?utf-8?B?Z2V6ZndhQkFlTDVHMzQ1dXovWllMUFhpMkprQmw4TFZZVklCUWlRVlN6NkEx?=
 =?utf-8?B?UjNybnZGTWNBdTZaNVptUXNXVnMrMUhKaGlLNlpWR3J3OGE0dUJ2ZnFOWWRs?=
 =?utf-8?B?bWQzckQ5dVowbXBKU2toZjZzZFB0N2ZpdThkbzhiZXowTmJxRDNCaC9CSjNl?=
 =?utf-8?B?S0FGSWF6SkN3Yk5UcGtiT0R5YzhZMU1kWmtpTjV1Y2cwWHhLMVFTYXlSVXlj?=
 =?utf-8?B?cVg4UGo2ZGpGMDBGOERlamoxOXladTVIZUhJNGNaUldUSDRXN3E2THF3RHV6?=
 =?utf-8?B?UjhjY3ljbHNlNFd0cTNFbEhwck1iZlJ4b3JVdVdNZ0RyalpmYnVsUllLUEtu?=
 =?utf-8?B?SHdhSnFsclZsMXZaaVdzV3oxbTBrUmRNWmVySVFzRi9RT3R4dE8yMXYrREVO?=
 =?utf-8?B?ZGpLL1phM2UxbXVNNHhmZzVHUVo0M0ZHODBldCtUMW1yNjZVbk5XTEFwN2dR?=
 =?utf-8?B?TEllTTJicElkUmVtRzZpZWdkOVMvQ2N3eWF1L1FLaGowK0V5dVZNcVYveEtM?=
 =?utf-8?B?MU1Od0dVK2I5QVZpd3RzZEhSRDRZS3JYbko2MUJhV0dRK3hmdG4vRDdrZk1L?=
 =?utf-8?B?Z0t5RWFDWXRMOWhiRm5rSy92UFhlc2x5dTZJYkhPNmtYdTIzSXpKSVRHUVlF?=
 =?utf-8?B?Y3FRL05NaklYeVNRakc0VEh2RERFZ0Y2OGRCRU9ONWdpd1RLeEZ6K1B2Zmxw?=
 =?utf-8?B?SzF4OWFhL2F4dzFhamhiMzlyRDlUWlptck9YR0ptUSt1NmtSSDBRTisrWTh3?=
 =?utf-8?B?blBMbEpCUmpzdEMvZ3pUL3pvYzdpSFF4d2ZUZFZHbVRUVEpLeGtNTW1IVjZk?=
 =?utf-8?Q?ZNKNdfcD1/+g4W8kYQvj0CFmN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab831626-6287-450c-e3a4-08dba5a74e4f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 20:10:19.8700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMBhkTI+lJznS/aJOj1BUncKom/XlxnoJ3en3X9PfVz+1XdDpenqff3sxnI6okD8MHoV1Q8t6ZEtG3gXBEYxjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545
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
Cc: evan.quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 8/24/2023 22:19, Kenneth Feng wrote:
> workaround for the wrong ac power detection on smu 13.0.0
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

This workaround appears to be only necessary if you're missing these 
commits.

a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
95339f40a8b6 ("power: supply: Fix logic checking if system is running 
from battery")

If this is run on a kernel with those commits then it's going to be 
broken in reverse.

I suspect the reason that you want to do this workaround is because 
you're trying to run on a kernel without them and which you can't add them.

If that's the case I think a better/safer temporary workaround is to add 
a module parameter or a debugfs entry to use.

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 +--
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 -
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 0232adb95df3..fd1798fd716e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1021,8 +1021,7 @@ static int smu_v13_0_process_pending_interrupt(struct smu_context *smu)
>   {
>   	int ret = 0;
>   
> -	if (smu->dc_controlled_by_gpio &&
> -	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
>   		ret = smu_v13_0_allow_ih_interrupt(smu);
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 3903a47669e4..128468355375 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2664,7 +2664,6 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>   	.enable_mgpu_fan_boost = smu_v13_0_0_enable_mgpu_fan_boost,
>   	.get_power_limit = smu_v13_0_0_get_power_limit,
>   	.set_power_limit = smu_v13_0_set_power_limit,
> -	.set_power_source = smu_v13_0_set_power_source,
>   	.get_power_profile_mode = smu_v13_0_0_get_power_profile_mode,
>   	.set_power_profile_mode = smu_v13_0_0_set_power_profile_mode,
>   	.run_btc = smu_v13_0_run_btc,

