Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A34CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 22:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93ECF10E82E;
	Thu, 17 Mar 2022 22:38:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BD810E82E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 22:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eckx02BinMPYcO+DxuprcNTHizkzbD4RlMrIQOoP1Z5Z/f+vETlfE4VsKR+tQ1D/HkxV8yT70QxfwxBydHQz3uuQG29MR9eslnP1x6k9urMsw9aJEzj/zEg+INQCOzRG7wbdDK0bWMhJjF56nD2BZ/Au4Rtq9zry8THWE40giwxFBc4/JCc3rXKUp6b2MELYmyF4IVfEnf79lt/Gfdssd/CLof2BFxx9FjjgYK3ZWVpI5MkE8xDf21f/PhC/yJ+sbLpePkPzkSWH7rRd095qE29CcX5+tJLdfZu/hymanNQ+On2SvG9Dl1668lGPv/o0obZgqiWFO3qqzsEcUG1Xuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ljNje/lt646indbDDLpNqV/QfhHrqvmZueY+wdNYfA=;
 b=b8YZ0LB/OIq5j7E7eKlqtzc7hQ+lvoKjK94mrnMAYU/k1jpygU/iDI89sdmmTY1GGxaPvifJxjRgTHg/yKdH69f/ZxjTcqGC9rgIisqEWoXiL2KTDwM56ZAKYkfV4e7sEZfkoUtXaDPsBT2ajdyDzsXSU0BELFI/BA5Fq3MWtWihE/tLj/Zce+aC6+HqfaO5jlhelcBiritCddk5S4A5b+p7aGqv8c5t4gCtAW8K2Eg+HfbZO/CJbXbO1paTAKhtRmSoL6cJrRdHaQsQCxvm0u1Ag6TT+xmq8vJt//D1VvVfHgrDgdxkmaIGXVDYJLlY8fqT9Iundb2d57bYzZvp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ljNje/lt646indbDDLpNqV/QfhHrqvmZueY+wdNYfA=;
 b=jFl3j4WrHmsoFQn8X+r3Sxkn3gCrgf38XN6t1FnYc8J59WBSS8KcNn4LADs7Xl7Mo8FfU/nQ3HXgxGrGC+WVVXogvMeAO9tk6ENRRo2ReF6MpBfKFzBfzNzeFuHvUsyqRngoCTYSTSFWUkEiQHJmuq9CZ+6SUV6ykLPdnd4XM3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1498.namprd12.prod.outlook.com (2603:10b6:4:f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Thu, 17 Mar 2022 22:38:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 22:38:06 +0000
Message-ID: <05e6858d-70ff-09ee-3f6e-8044806ad1d6@amd.com>
Date: Thu, 17 Mar 2022 18:38:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Fix Incorrect VMIDs passed to HWS
Content-Language: en-US
To: Tushar Patel <tushar.patel@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220317214005.133302-1-tushar.patel@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220317214005.133302-1-tushar.patel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1491ddba-cece-48d2-d2db-08da0866cda2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1498:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1498C65DF7229544ACDC2DB892129@DM5PR12MB1498.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQxH3p7PTivqLqZe4/acQBYM3DpZh4EaaoIeJaoXJkqze7g1nsEUBccwkMp2EEwEytPU7AZsJqnRWBo1OHs/g8zVNjmCKElQlPHeYAQr9eAUmTcnOEVrpV/Az6tSuDZldRzjdNXiyf/7HvBcO5XaTIpMcABraE8s8oWMtKgWpox+BcffIGr4P4zGetUG82auOGAEte2Vq/4JQQ6ZMkC4Zsxl8YOEwHLu29mZZNPx3azemZ9yJ+oF/NMZeVBGCY1pYwH0UkmlxtwfbDu0RyCpdspHBAsYnxJq+GuaM69Sw0zZdawvFuWel6ekx1vzaNrCQvn+686qfQ2Hgj0cdRXwIFF9FJmPEt22DQXGn8ExXUNtaUS5uaxyTAbK3/sxe2x9aXDyqCuPOziiCwEB3CunF72qqUhatMmwl13lCrBjf1L04vlFbjTtsDVT1isy+Gd+FroD6/UnZRW4eMsQLwIelMIj5exwd+F4F4gpAquul7SwdB1eK8Bd2/10dhIKc0aUBrCKMgH6lBMvkNmWZAsN7vZl38FasS3RPc+jYfsEr3g+nAMmnD5P0wqbeYbmcpcKXfStO8gU0i/6rCdl/zcPkywAkgYdOvTmROOhAhzfURlAfNhMgYdzILeFT6StmUp4AYgAMSvDtYBOM3yyLeqJveBcvm+x+9k5uexN3wSWFH5O629V6kJ2TCMPR8W/AKvXwrTlU111XngcD+MnnWobKMakz0Q+Sn1JCGCYE8AbgoOKKroa0EdCM0fTvyNV4oaO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66556008)(6506007)(66476007)(66946007)(83380400001)(31696002)(44832011)(2906002)(86362001)(6512007)(508600001)(8936002)(38100700002)(6486002)(6666004)(26005)(31686004)(36756003)(316002)(2616005)(5660300002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUkvR1E1NkdVT0Q0R2lQZnNGQXc5VG1nMTFKSFRqS0VuSlViZTBSNC85elZo?=
 =?utf-8?B?V0VURGtEVS85cXlyK2h0U1cyK0E5cnIyMDJzSUFqR2lNSW1vOFBMY21lRmQw?=
 =?utf-8?B?SzRuR2JpM01IUVB4UlZjNnNIWmowdE9pT0FZV2hVdUkvMlh5SVdHdWhxTWsr?=
 =?utf-8?B?Yy92dkFwQlZLUkpJQjQzYnVnMzlMNEdUakx3b09tNVVlNTg2bTlDcEpHeDNZ?=
 =?utf-8?B?NUJ4OGlzSW0rbUpyOFlUU21rR1h2MHh1TTAvZFQ3SllFVTdneWJodHlZTC9F?=
 =?utf-8?B?VkgxMTB4d1EzOGtaTjZtd01UaGVjaG81V0xNaGpoY3E2ZTgvNVdWbFZSeW9F?=
 =?utf-8?B?a1F5QmJ4aG9xbnlQaUFVWm85dWZmcHg5cWtzd3pVSHR2TGNudFJaNGhQUWw1?=
 =?utf-8?B?Z0xMVThINWpZY0RLODNlMEQzQlVCa1RGNDhMUjZVbVl2cHpPTkw4QjVuOGk3?=
 =?utf-8?B?VEtqaG1CTENJOEh0TWluOUxud0w5MHc3NnF3WklPY2pISWx1RXhwbTExOFZx?=
 =?utf-8?B?SndqbTliSU9BTXo1QWNsOXhYT00zN2lOMUZ2b1dtZS9Ta1g2cnNjdWREaUdo?=
 =?utf-8?B?VXo4UmUwdDV1TU53UkVMNFJweE1wenR0V3E2ZmNIa1NSSGxIQXF1Z1J5N0R0?=
 =?utf-8?B?WmdiR2k4a2F6Qk4wZHNQaTZGLzhzRkRKc2dDczFiTVFpRHU1Y2ttRW00VTdr?=
 =?utf-8?B?Ky9rWXRkcWZhZS9tR3RtMXNjS0JvQjFiU2xMUnZhQkNrQThkUytvQlZQUFdj?=
 =?utf-8?B?d1ZCR3Z5K2lSNmRHYS9zaEM0UTcyUDVPUGgwWlZzVk00NFg3QW9RTks3bWRh?=
 =?utf-8?B?c0Q4bmorZFdrYjk5WEVNZFQranZyQ1FuTXNTY0Jaa1RYeTNjRlJqWDc2VWNn?=
 =?utf-8?B?WDFKcTJ2VFZjOFRiRUs3U3RvRXNMUS9JZXlPSGEwZnBHTlFHU3lOVHVGRFlS?=
 =?utf-8?B?a1cxRm9MT3p3ZFFwM3ZIRWx3bkpGbGRvK2tQYkVoTnJjcmErUFJIUkFrQTlK?=
 =?utf-8?B?aS9aTkE4YnJENytvN3MrdVQzRDNzVjVUTHF2TzBUbFNiRllzei81WW84S2R0?=
 =?utf-8?B?Tm5ZRHYwQXdrK2I2UFk3cnI5OVdaOWkvQjl1TUFqazEwRzdBbEs1Vm9wNGNE?=
 =?utf-8?B?RFZKY1YyQytuRU9kZG05NFFxODArZkJBTHZFdThVV1F3LzNmdEtPa0FFM2Jj?=
 =?utf-8?B?N3Nhcnpwek1sS3g4SzVEV0JKU00xcEw5Z2RWSkdqSEo1S3FpaTYzaHpiT2hQ?=
 =?utf-8?B?dnpOY29CbmNRWTc2TWxEWWhFeE5XYi9aTkhaTlZ0UTh0ZDNkYnhlaWhGR2xh?=
 =?utf-8?B?NndtS1l1Y0U1Zmk1OGEzbGZBSytxdVlXUDAyVGVrbGdrQkRTRlc2dXdTYzI1?=
 =?utf-8?B?emJWZDA0a0FSOUpML01XZ3IzMTY1SGpMRmVhSVRaK2oyZU41RUFWSmFvajAv?=
 =?utf-8?B?djNmZFBVK1BEek5RT0xOMmxJeUhicWEvZG9XVWdGRkhiOU1tMk9MdFVQNHV2?=
 =?utf-8?B?M2ZQRHFUK3Y0QU1yRmNEWWtlNGlJNFJMNlBSQXdxajRaSWtybUZ0K3NJNlB5?=
 =?utf-8?B?amw2a28wVENSKy85aE9aZnRiSWxhSkt0TDZCVWhGSUlITkZncDd6UUdDaXVi?=
 =?utf-8?B?RldQQ3Y1TzVReVBzOCt1UWljM1VzOXpyVWRwYU5MZ2hGazVWQU5wVnRrbzlI?=
 =?utf-8?B?ZDBlVUFRYm4zS3RyRktzUjhKTkQySUprMmIxSkw5N3JQdEJDTnpmV2paN3Fr?=
 =?utf-8?B?WEJJcloybkRjcE94K2lqbFkrZmw2TnlTUUZzZmkwc3NVSVZZWE4xVW1XOUkr?=
 =?utf-8?B?SHJ3R2NudU04NEdKaG44UzJrVW9tTU1NSERIN084UUxzaVpPUkVhKy94K2ln?=
 =?utf-8?B?TVdyN2FoSE11clNXeVZzUWtJQ0M2YmlGVW9iNHdHTEFZLzJyb21Ob0JPWGhn?=
 =?utf-8?Q?ys/lXqNjlN48F+gKYCveUahV19dUDy6H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1491ddba-cece-48d2-d2db-08da0866cda2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 22:38:05.9626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ns/3vTAvMC0+92MIF06ZjCzFEB8tKk2ssYHP2bPdZ+G9MVOuuOEPOrj4fV0c+B2Wra6M4UUKc/krRaEuUOg7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1498
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

The code looks good. But please add a patch description.

Regards,
   Felix

Am 2022-03-17 um 17:40 schrieb Tushar Patel:
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 +++--------
>   2 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4c20c23d6ba0..bda1b5132ee8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -680,7 +680,7 @@ MODULE_PARM_DESC(sched_policy,
>    * Maximum number of processes that HWS can schedule concurrently. The maximum is the
>    * number of VMIDs assigned to the HWS, which is also the default.
>    */
> -int hws_max_conc_proc = 8;
> +int hws_max_conc_proc = -1;
>   module_param(hws_max_conc_proc, int, 0444);
>   MODULE_PARM_DESC(hws_max_conc_proc,
>   	"Max # processes HWS can execute concurrently when sched_policy=0 (0 = no concurrency, #VMIDs for KFD = Maximum(default))");
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 339e12c94cff..0978e1145995 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -483,15 +483,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	}
>   
>   	/* Verify module parameters regarding mapped process number*/
> -	if ((hws_max_conc_proc < 0)
> -			|| (hws_max_conc_proc > kfd->vm_info.vmid_num_kfd)) {
> -		dev_err(kfd_device,
> -			"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
> -			hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
> -			kfd->vm_info.vmid_num_kfd);
> +	if (hws_max_conc_proc >= 0)
> +		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
> +	else
>   		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
> -	} else
> -		kfd->max_proc_per_quantum = hws_max_conc_proc;
>   
>   	/* calculate max size of mqds needed for queues */
>   	size = max_num_of_queues_per_device *
