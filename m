Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D60C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 19:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498DD10E066;
	Wed, 23 Mar 2022 19:08:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F35D10E066
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 19:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlWQ3eEaEAFZ/dA5hPYbON/f2kcrS5mEGZJ0yNm9VqPbYIgwSaoPNRag9hFGfVuCxx8o+ZYHdBqnL37tUPF3FxPErvj44PVYKpGSFI8/KdJRBbPr0ysq1U5DwL40OCDRZWqmiefcRdJqdrBWd1yLWhwzkjnsNpS3brUvA7V4X60bA50rmtv0ns5xd7TQKmg7kDutuDX+zcBTmmWkgrQYSRva7Wy76nK8fYgzCrkvVNSppSEJos33bRp6b2CR4YjJC6THI0AwJkNk4c0Jtkfr8/WVYo2UU6gNvZVek6zVCQ527rgbbpdQm42n43Gc5nW1w142f1JaapDET0Du8YCHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edohs1tWJN5tdM59kt1QqL7a4I6fnWVi0SFyXX/2lGk=;
 b=CpKATvQBZx+r65o+67DiBBIQSWxVvnRJzWF00KdeMFepsWCB6Ha+luce15qcEvMdrj5SjPOLnYD/VmTK33w1B0+cp3q2aU/ooz5W444ukekpXM7ZgOLg7bqiFZwwkPlP2fvDTPskFp95Ru5PjM0c/T9o7a8YMbcEk90MA9eAwbgCecuH93oKw2MxtKw7lzvBv9Ioej1rR8Jr0qKARu4cEnRRFEbY3+NXHSWBnjzBdY3VZ18TnwZVnQ2JXPdQqL4egpvfs+Dnc1EUhPLrpwt8xIIIsrqKRYXp4iQVQh7L3qzMvCsdEo/yjThcUYsoNQf5QSmXa17cuS+zXdA/FMwsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edohs1tWJN5tdM59kt1QqL7a4I6fnWVi0SFyXX/2lGk=;
 b=WKyq4DDuxbFhSimSUwmxVSYlZ4n3MmUrXVAiPXaza4PZtmJNUPkEqdg5jhfNCiijvtKnbkXD+UN8v56TNboziF5gM9RcI+wBIrUmjB2//s3JWDzscF6ZG9OXtwIScAEYgJ/Ncv42QgIUNWn2emP21N5c9E/HntBUcOmD23GgQMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN8PR12MB3523.namprd12.prod.outlook.com (2603:10b6:408:69::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 19:08:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 19:08:50 +0000
Message-ID: <2a51ae1d-7386-c22b-92f2-e7c7f883b65b@amd.com>
Date: Wed, 23 Mar 2022 15:08:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: Fix Incorrect VMIDs passed to HWS
Content-Language: en-US
To: Tushar Patel <tushar.patel@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220323181120.110652-1-tushar.patel@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220323181120.110652-1-tushar.patel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b95de9e3-189d-47e8-42b9-08da0d009059
X-MS-TrafficTypeDiagnostic: BN8PR12MB3523:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB352336BA5CA4D621F23CFC2592189@BN8PR12MB3523.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYxxZ30MX/Lbw+qKGGf/O9h9S3VsDspffwgSlpKqsPfleMRnbtz4b8FnFoYuBM7/0AnPo1JrGAx3OpZShOmmSdB6ZFWHMFdgvakRP9DZ+JNze9S9oB4G1Xs93Jm3wnjmXvr//nsTaEvrDG2TdngnWB79IBvoyOmADkfNaee1Veg4paQ4Nsn8p/KRqV8iDxVIyJm2sYp/9Thpg66UTWkWHs1bOW1JHG+z14T9Fb6buztQmxCH7wSd4NUrt4Mjal4pn2A870u7WeWU/gC4Qx44EaQMNiI36lyXQ2w5DTpXro5iqaC67bIN6Oz4o9we5sauz4uPEpgzmvM/IbaIhKiFkJPrzYqMygH8BGPYaXrbA/juqA6/RZidqOWcDMg5+hWCRFpSpNayN7KkFsYTfZ7RJF9y3Ba1yIUb/xjnFDaD3x/dOtC1DtWkE2Q5Snoae3aNNMYM61x9uolxaqfIiNQ5b4Oh8SA6Piv9HZB3+gTxCZcARU/SWAVygeK4dO6Pvj4s3RmtxCxhD39nPqO3djsL9XCFJjBYktHGob4tuGn72uN8xdQwzJ79/wVn8+vlfepBh7KXfgif+bKzEd412Y4wJ5hllgX6a5SDAJXKi8vZY1xoaKtZ5ZmcYRGjyuMUh90o10cSC2/Oks8ERz7G8zh1+o3g159Kp+9/6VFOc5vbzBd2mK2YVHyn1aJ2bY3fgVsmPWQu1Xl2Rj5uCilMCGDMQkieJyQRr1V/6lK58qyVe4VxA3GxjaIo90KWQSqKyyr9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(2906002)(44832011)(38100700002)(6506007)(6486002)(31686004)(508600001)(6512007)(36756003)(66476007)(66946007)(2616005)(5660300002)(66556008)(83380400001)(316002)(26005)(31696002)(186003)(86362001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpSeW1zWEJZN1VXa2hSK1dtb0FtNmVZODJRMTJyVVhFZDc2alJORWIyYjFu?=
 =?utf-8?B?VzVrbVBXc1RER3JlYWpUSndlQXpZMVZPVTFyN1owYmNUYllFdlBoRGxuYk85?=
 =?utf-8?B?RVAyaWlOWUh1S2l3Q0ZvSEZvOUt4OHVNRVZ4MDdSNm4wcW9RMllyZlh6WDNq?=
 =?utf-8?B?TWx4cWpKL2h5ZnBrNlZFOGRhTzFhdE8yT3VGL0tBY014YTFJN0tvS24xakp5?=
 =?utf-8?B?bDZ1ZERPTmZFbXI2bzRtcDArUEI3UWhKVEpmQllMVG9XTmxuTFJ4US9lb3cv?=
 =?utf-8?B?encvZWlsTXJpTDZvVlFKNno1Ryt1MFlvR3EyaFhnNThnYWQ2V293SG9wR2xz?=
 =?utf-8?B?K1lKMnMxMFVYTFhmNCtEOXNqb0puNVF4SUJ5VGJsMlF1cWw3SG9XUEQvcjVP?=
 =?utf-8?B?TlU3d1N0WTVBdVFibUV3YTZzSUUraE0wMVRVakx0R2hadGZ4QU9HZGNaZUph?=
 =?utf-8?B?cXd1Z2tXN1llWTdkd0NpTjQyL2FLSWNhWDl4UmtOaXVwZ3NTbzF1K0FMdG4z?=
 =?utf-8?B?WFdWRTRMNzRmUmNVbHRWMDJvQVJSNmNtMGJlVnhuT0pCeGJ4d2U2Nmc2aXdV?=
 =?utf-8?B?cCtCTzFYajMzbzY2YnErcksxWVRReDByU0hTdVBhSmFsd3E2OWhNL0dPdDFs?=
 =?utf-8?B?RVlKR21YNEVjR1VmQ3JrdTR3Q1lQQjMxZWFoR3BSRERqc3BHN1BWQXlhN2Z1?=
 =?utf-8?B?NWpPcnhtMzNFcjIxZ1RrYVY4cW4xM0I4RlU0S0VpZ0g0OENoaWJJR2hFZ253?=
 =?utf-8?B?WUJZNkNmdm8xSElIOG9PelA5eDFYU1lDTkYvMW5JZ1NtbWE2cWx4Vit6VkJs?=
 =?utf-8?B?VkJIb1pHQjBqQkJRdUZKdVhlTWFWczVkbWhGUnJmZ3ZHaDBCRk4rSjdLVWdw?=
 =?utf-8?B?YVkzQU8wbUsvWVRGTC9lT3cwNGV0VkZaeDZTN1hkZHh6R2J4UktGdndwZXRr?=
 =?utf-8?B?c080eG13MjI4L3gzUTJNRC9USnVwckpNb2xKZkJzQnNnc083YVNpSm9oSDls?=
 =?utf-8?B?Qnp4bmZralkyWEQ4SmZjUStYQlZ2SW14S09ZOUx5dzJaMk5ueVpaYXJyVFc1?=
 =?utf-8?B?cmJZVWIrekVFbVJHYndxZVlpbERQL29BWlJOcHVDQjRobUdQRWhweHM1UGho?=
 =?utf-8?B?NW56K2M5UVZZR3JnbHgrL3kwMU1GT2RuaXZWSmxUNFg1ejhXVThkSWRwQUhP?=
 =?utf-8?B?b041NlJnWTdWcTcyQXJtT1gzeU54MGFjZUN1cEhlVTI4VFVobDJNY2NJZ2Rs?=
 =?utf-8?B?WUR2YTdDeUV2eW9OR05ZWmZhR3lFSzRMdmRqMC9qQW9JOGlCZS9uZzl5aXZW?=
 =?utf-8?B?MHo0Mm9jRDlYVHhPM0tXejNiNTZ6RWJkOVpvZHVXZXcwSUZlTnE1Vy9KMVdZ?=
 =?utf-8?B?ZWkwODR0a1A4N3lycGo0MzJTOTRFc05CT0V6eXVRcG92c056M1NxSU1rK3dk?=
 =?utf-8?B?T054dytxZmJ0YjZ0M3N0ZDJFWHFkWjBpOXZQcXNUemxuUTM0NFFGVG5LOU5Y?=
 =?utf-8?B?VmZWUGw5RFNicjlMZmdVRytvRGVUa2Rra2Q2Wk5EcWF3TFh5Z0M5THdiM25s?=
 =?utf-8?B?Wmhvc0lsVHFBcDNxN2NzUllSLzNZb0RxVEMwWXh2d2xpZ3o1SUpKN0tiUDhS?=
 =?utf-8?B?NGtNenU1cDVmMk1mSkRBdThCTzRNSmVTZk1IRlR2N1I1UFc3ZmlvZHltZWEz?=
 =?utf-8?B?Y1QvSTYwNmlDOTlmRTlvdjBPQ2R2MmFTL3J3cTlqT0FLWDk4TjB2Z0w0aDZM?=
 =?utf-8?B?ZWo5OXhWZC8reWdSUEdSeHNaN0ZNcW1PQ0dBMS85L3JIbnBMaDNIUXhlc09S?=
 =?utf-8?B?aGc2RUtoamJLVGMzSkZHUVJqK010RmZHSWpldTl2YitHQVRhc0NrY2NuU09E?=
 =?utf-8?B?NERTN1J5TDN0R291eTRmZmxQTGk0NkVDaUJXbDhPUC90Umxzc3NFanBtMzNi?=
 =?utf-8?Q?SI5lUZvHlDSlOtGH2AbBQOJdDb5BHKtF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95de9e3-189d-47e8-42b9-08da0d009059
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 19:08:50.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DruQ7qsMexg+m1BLr1yJ0+R8Vp9tFEVTN/Yv3mMvk8jG/SsJNvWx0069H44TuoWdUH8GPZo/lB+kO3TmniOzWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3523
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


Am 2022-03-23 um 14:11 schrieb Tushar Patel:
> Compute-only GPUs have more than 8 VMIDs allocated to KFD. Fix this by passing correct number of VMIDs to HWS

Checkpatch may complain here about an unwrapped description. Other than 
that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Tushar Patel <tushar.patel@amd.com>
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
