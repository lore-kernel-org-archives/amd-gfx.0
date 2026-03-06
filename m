Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4590F01812
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 09:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC6810ECB9;
	Fri,  6 Mar 2026 09:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1gL8HQN6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91F7010ECB8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 09:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adw+zYOQZEjzzch3szTKc/0CW5Oh+M0LHyXN48Uyd+B/J6DywaYFL7TCJzn2m5kT4zdlYjjMLMYwQsQDPO1qEvbvUWTxwAJW3zgdA5mlXftwqDdo/d7plEjIQzZ5qrCoN7TYuBoaXpQQhRkZ9exQbjgoA3Dr8C28xlzN0LDbBcS++BbNvdwKw1SnoLdBgxhXnWDD+Ua6l7A5ehwOXNm1h53xgvKQgcQqRQcsntPdFBljj8wX15pf1r2LT3zY0o5XtPp2Wgl+042keWC+i7aUSAaA6LKA4Dy5i7YwJxjkQMX8wYPYOfrQ+vg0VLvscd9x71fGpxzA1RpWD9CHP1oAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+MbSHvivDZR1FUoK8QIfn2hD1phRJGLOYKDgnBRpow=;
 b=XOv+cf5TuE/nXfS5YTJDN57Qw7ur7ruRnmbGmBGnYMmF0a6EvUPzj54dihJJX/7dbUvphcyxyigqJWoLSSw7LgsjvMwYGqLGtySm+Ao8TjS+BCL88LYeKoctPVr4UGE+7zHsBN23irJ27Y/9n05z9kOidZfIm3jbhPQdSiYDNinka7lWE5AFB88phd+aX2TwvXsHdljNezHwoKf56DqXfhdbFu1zYGacAikXy8kOkL4fh5Z/8qJ18eQDO3eyWLAIYoUsW3tasmmuSSLYFxgpp44BTGdfEUUB00VgoSTUfl4M8cs3BHVM3IfQlyLlyW8l97572XpcrfA3X3k/0buu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+MbSHvivDZR1FUoK8QIfn2hD1phRJGLOYKDgnBRpow=;
 b=1gL8HQN6F9DFbfXxMLfvsJ0s+5BmZHesaaWFu7GT1UbcP2d4GRbQZou4NseoM/PsFxnO+8jbm9zQiR2Y2ylw9uOnuEnNI2K3KHOD3mkKfZpyLnUEceoPX0LmHp36dL8TNZvWDMnP7OvVRWigWAuRDSuIUrqup7t1VhqvF79gF7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:28:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 09:28:42 +0000
Message-ID: <743c44ae-6ad2-448e-9d9d-56884f7dec31@amd.com>
Date: Fri, 6 Mar 2026 10:28:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdkd: fix the warning for potential insecure
 string
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <philip.yang@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260306080855.1886520-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260306080855.1886520-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 206b5b93-6b42-44b5-634e-08de7b62c1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: rp61MzWM5LBo/QbN1J+Ouje2xtYO4o4nVBTAka4mF3IpntlsShR8xwMfjdyU9CIOuZNE6XCHIYLWe/o8QlKlMZL/qfkYiMfq7V/Tl07eKB0KJT/rYttJMrWW8ar9r3A1Bc76Tg1xd/nWCYnC0i50veKj+WzcjP+Rakju8yL+T6nEl6YYFgLjUMoSNR/zr8WV2gdf6M3inkFEi2q4wFdr6pd5lwIKXJQ1KXTMlbwpSjKSMaAMleLWvh8Q++9sFjdJIv8p4nPGPe/IFxYOwi/GMPHGonwiJjXXKSGN64BYSqtaUE3xopltJkkPrj/+N83sY0GTfJRWQzhKMXi5OhBAoGJKXyoKdv7Rh60755PfBpznVOJhV+FpRfp3eJatAMjPSdRQxBoqxFX5wqLDlUC20XdSOnPNtlQ7v7uYGqax6JLK5VLLuRCgqZcFCdHq9+dHWbChIoyyWDXrntsfwuH5PZRcMnEaC4g8IAymIQSrk53TGlFKY8ZkFucmFFf5/hwc7xvPn6sNIsIj9s8ZrD02DSKTtvZT3Dt5+vQY5Ulhs8bKr1VuaL+cC6bUfldK/2qaVoPlt7TMEs4wO93SHAvOvwCbSGxNujJ2NmDGoeJmHS5g4dofR7WrQUg4SR2LJqjgvcRaqkOmnFvdc59Ky60m24FngAJRDHMvy5yDum+3BeyZKM7YzFKA6ucQQPyrPYsmDcqhv/PG1zz8a7NgeInrzKdLQiWRADkkiInYRiz69XI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ZOYWQzakdHaVlsMHQ2Z3FjQmM4MGNlMklzTk9JRUxNQ3VYWnlQOWhuVUZK?=
 =?utf-8?B?MFFjb0lnNkZTeWNUTVJXUCt0TEp4Qmw1Z3JOUHBzaVkxbWl0S0VSaGxBcCtu?=
 =?utf-8?B?bjRzTWxuKzZMdmdISlJ3WmN3WldWeHljdmJWSlpqUG9Pb2w2dExwdTFMZjBi?=
 =?utf-8?B?NmQ4S05rZWdSN2lTdWowY3I1VmRGYzE2Mzl2TGRLWmt3aDZMb2xUNzNvWDdm?=
 =?utf-8?B?RitUTjFIWUs1OXJ2NFBqQSs2OGZiSUhZaHo3VXluUGdEalNFSWxyUlRYbGRM?=
 =?utf-8?B?SXU4NFRFWEloeWFmRng4eGQzZHRuV0cyUkNMMVFES1g1eEcvb1paMW1BZk9E?=
 =?utf-8?B?OVM3cU1kTythM0hTcDNjbkhSUGtpSTMxQ2xSUW05L3c4aC9uOGtmRkVZcEcz?=
 =?utf-8?B?dGliM3F0VTFvNjUwZHVKVE9uaDZWb2xuK3JQUWpibmtiMEhNN2kvZUZPRTV0?=
 =?utf-8?B?NWxuUW5ETVVNaVl4QTk3UVo4TkFNMDV4UDJPSE5Ud0pXWnB5UU50SGY5RU56?=
 =?utf-8?B?ditSMStZMXpQUEprMzV6N25Iamx0L3ZCcVZMUGsyU3ZGMTdvcEY1QVdrRjNM?=
 =?utf-8?B?Uk5laU85M3ovWHBzbWFBazJseUw1NUJPNk5HU21nWENiOVNEZ1JUOFhUcDc4?=
 =?utf-8?B?c1N4K3ZCdUFzV0RhanR1ZHNtTGdTYktvWWliN2ZVUGt2aGNqOU9ldXZKRUpy?=
 =?utf-8?B?ZkFXNmhiQ1NTV0F2SGRvSVM5RHNzMWRxaTcwMjlNY3hteGNiZkZzdmNKNkNL?=
 =?utf-8?B?ZjNHMUtHWG14ZjY3UWhnRUFNd3ZNYjZlOERENy95ckJyYlBqTmN3TnpSdUo4?=
 =?utf-8?B?dXk5bC9tdEcvOFFUdmpVZ3JQS3VkYjlhVFFvekJMbW5YZFBYbjRsbFRDZFRp?=
 =?utf-8?B?N3oxclNiSERaSm5welY4TnplcXptWlFDV1NiT2QrM1ZacFA4UmZkbXVudVkw?=
 =?utf-8?B?VE9ST0pzMVNjRkw2SEZ3aUw1V3VVa2xTY1d5dXJOaVozL2VRZWs3bTExWXor?=
 =?utf-8?B?R2RNVytLaDQ5Vml5VmhFbjVrWlBIcUtNczk1dTdKMEdvVExzV2EveVArMEl3?=
 =?utf-8?B?QkU2aDhDb2haWDdBbjJXU3ZtSFNZN1MyNGxTNk1SRVEzR3VMcy9vZjU2dmFa?=
 =?utf-8?B?R2dNd3pZaGdzMFNXSmsvcmRkcTBObGFIZ1RLcGhaTnJPQUx3NVI5WW8wVG1i?=
 =?utf-8?B?ZkpmMUVud3JraHJ5dDBCT1NtMnRrTnlGUjVBWFN4RkZuNHFTRFhnWlk0Z1V1?=
 =?utf-8?B?M1V6TzhjeTdXMFh6R1lrOUo4SlhKc3VSZmlYYkdqVHdSVWVwYlZ0MVBPMllD?=
 =?utf-8?B?VlhXT2hhdjRvT0twM1NrZlpNSjFydlB4MkxYeGd6UGZSY2J1UUVROTNWbzcx?=
 =?utf-8?B?QTZOVi8reWFNS3A1cGtGRlozcVFHZnMwMTlXKytacmdTdGI5OTNjdlB3QkpF?=
 =?utf-8?B?N2xRTGUyNW1WUGUzbGs4aGp0K0xIY3pBQ2ZzaE0vYVhUT1M4SjdBeGNWUTl1?=
 =?utf-8?B?SDZvK2NYL3dyTzlacit6bDRNNGpWQzlZbGM1T2F0eVg3dUxKaFFMUEhDUjZu?=
 =?utf-8?B?TG04cGdjeDRGZVRFNFQzQ3JQUTNOVWEwWEc4U0tnUzZEektjSGNTV3pHYlpj?=
 =?utf-8?B?dlZ2cjM4UnVFbkpYWFhrUzBHK2JQeHo2YitoaDBzV25JbnQxQ3l5cTNEVGM0?=
 =?utf-8?B?MTBMRWhkVnRpOEdDL0RMRUJNK25NM1pTeU9aMGdOaWZUUzNCckhKL3lHT045?=
 =?utf-8?B?U1JwcHVTUERWbHN6cVB3MVhHcWs5NElmV2dGVXprL2lESWlOeDZLNmVxbGtT?=
 =?utf-8?B?Y1pvRFZwamhmbFp5Vk9ySVlPMHIxTkc0WjhUaWtiazJiaVBVK2RDdnpFbjIz?=
 =?utf-8?B?NEdjRzdFZS9vc05XQ1dIcUxTV00zRWNPN3ZBVFA5RjNmYmxkZkVTcFFQWktP?=
 =?utf-8?B?aHpvRkhwcEJqTjlXbTFTd1ZyTThCcSsxSjYzdzV0TTl5Q29OTDVzcm5vTUxB?=
 =?utf-8?B?bGRCaU5BUWN0VVppK1N4WXA1L1NSbTBSWEs1Wjk1QUw1VnArNUV3Sk9aTjFY?=
 =?utf-8?B?WXNYdU9ZUVFnMlJ6QXV3VlVsY21kT0RQVUNTeFhMZkk3MWRCa1dXZkFOU2ZI?=
 =?utf-8?B?dC9BekxiNG5EaTZneHlPM3JkRFVpQVVWNytRVWNab0xaRGlHVXp5MHluL3M0?=
 =?utf-8?B?c0lhVXlMY3hydjVDOG16ZU5oTVVXQWxjWCtFNEQ4enFESjFwRnFmR25RVTc3?=
 =?utf-8?B?Q1laWVM2NGpsSmhnOEJJNzNtYlJPOTNUYVNrUGxrZm1ydGFJcUtvZkJXRUZN?=
 =?utf-8?Q?Jf2iInkC9ixM4hFXBb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206b5b93-6b42-44b5-634e-08de7b62c1d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:28:42.5335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+CziO5MyoY8LGay8ZOOPfoqCnOTjXEJXCcYnIl61fPTdj1FjkvXPUh/xIDxYo9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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

On 3/6/26 09:08, Sunil Khatri wrote:
> Below is the warning thrown by the clang compiler:
> linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:588:9: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
>                                            stats_dir_filename);
>                                            ^~~~~~~~~~~~~~~~~~
> linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:588:9: note: treat the string as an argument to avoid this
>                                            stats_dir_filename);
>                                            ^
>                                            "%s",
> linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:635:18: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
>                                            p->kobj, counters_dir_filename);
>                                                     ^~~~~~~~~~~~~~~~~~~~~
> linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:635:18: note: treat the string as an argument to avoid this
>                                            p->kobj, counters_dir_filename);
>                                                     ^
>                                                     "%s",
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> CC: Philip Yang <philip.yang@amd.com>
> CC: Felix Kuehling <felix.kuehling@amd.com>

There is a typo in the subject (amdkd instead of amdkfd), but apart from that:

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0b3b0c26e05c..d202827df66e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -585,7 +585,7 @@ static void kfd_procfs_add_sysfs_stats(struct kfd_process *p)
>  		ret = kobject_init_and_add(pdd->kobj_stats,
>  					   &procfs_stats_type,
>  					   p->kobj,
> -					   stats_dir_filename);
> +					   "%s", stats_dir_filename);
>  
>  		if (ret) {
>  			pr_warn("Creating KFD proc/stats_%s folder failed",
> @@ -632,7 +632,7 @@ static void kfd_procfs_add_sysfs_counters(struct kfd_process *p)
>  			return;
>  
>  		ret = kobject_init_and_add(kobj_counters, &sysfs_counters_type,
> -					   p->kobj, counters_dir_filename);
> +					   p->kobj, "%s", counters_dir_filename);
>  		if (ret) {
>  			pr_warn("Creating KFD proc/%s folder failed",
>  				counters_dir_filename);

