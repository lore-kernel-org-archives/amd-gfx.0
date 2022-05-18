Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEEBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 06:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A364113E0A;
	Wed, 18 May 2022 06:02:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76439113E0A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 06:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6wCTWhGtx/3S+HiasqXIlbOMe2/g4Bqixvvb4GaeFCLj1wTcQqCZOl/RUXJCA8PoQbuqnsv3WR8dD+Wsnlj9mw+4O/51anoEIzyUai3JI27odY/XIR8/i566B/xcHbFOK7oJB7HSv3Tcxzcw8j1LV10O/2QbtI3NXnUhyWAsMcxvBXLbNpzBUlI+/xrgPYpiiXltfc/NyZsiabuFymN6yv1hgMcokyNVjDmCE3E9O8A2A+BrFO2O4AZe7fRjge/6iUtMfD3NIk1JZLBw3Swwd9144uk4bHZQ1MRQyYFMwsbFPKYc7ehLc13Xg3n6WSZRQU7lh0Y/jwAOu3CKfqi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVt4n7wMDlNgpdgoiCjrmnp/Pe0h6WcJDENfFWp8Rgk=;
 b=ZyDEGrqDwAXNQf/IVE8OFHfNcFU72S3/S54Dj4N6lZMTOQtmTLluVLVDAz73VX3C2mgchXvpLJa6vMHQj1uiLViYyxCqTJ8T1ueZ6nE57dA/VWPXBW6knPYJOvJdlz4SUkSycCSo8w6Vj9azZpXC7qex0H+/ID0OLAUKsMxVAC3zAbcVz/yQqMkjcULECVC6P4jCnKGHzlxl9Fve4vdyxCgb20DkmTrsn1d03ROtA4FpVZD/BYzcd9VJL9Xn3mDyGq4G3LlAtWU4dx0zX5TnqHBY1wenciiP0IAlEyjrmGl1MC85khuZbM6vBUY9EKpbcfdieNjzzle8ktqikvNZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVt4n7wMDlNgpdgoiCjrmnp/Pe0h6WcJDENfFWp8Rgk=;
 b=yborgnRPGpJk7IobRaIWgHCGeCQHTf10HVLYm0lknTRUMjiUj5Ve18JoMbLweHyzsogyXAMOa/eKM5XMRifwuVvIGLfmnIk3gd0E7+5ZNc022kfRVbzdien3hDB8ooYHx10nD4vswtDqnyfsHBXp75jjV+AQYNY/6WGnkxRLtBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 06:02:12 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::557c:5a0c:56ac:3af]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::557c:5a0c:56ac:3af%5]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 06:02:11 +0000
Message-ID: <2264ea1c-3e44-5ff6-e4c3-a7b7916b98c6@amd.com>
Date: Wed, 18 May 2022 08:02:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/7] drm/amdgpu: Cache result of last reset at reset
 domain level.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
 <20220517192102.238176-2-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220517192102.238176-2-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0301CA0009.eurprd03.prod.outlook.com
 (2603:10a6:206:14::22) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86681f04-295b-46c4-d937-08da3893f30b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4554:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4554D3D452044508E06E241883D19@MW3PR12MB4554.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8xyvQKwEISCKgB4PqvBFrHqULeton8QuN6PsNh9E4IK6G4nL+v/+gs7ntw1SIIrXliYmSLUtvDBi6FN/luBxd7NIwb4voy2MpYJo+lbLHxiFtOzzJ0bCycnQ70gU70dRszFLXuUEY6pTk6gz4jpPqFkOZrae/6LSGxUkT7yjBu4daNNWgP2nWalYLxG3xkdnIZjun3Iy7mHN3fbMTkwA9YWKFsShO6DUPZJkUFuQkUbN5ZrobtDUXaB36g41ymz0buFXe4W/0Iwg96AiK4vdN8BeMxWM2QdtaV9+1rgUpzpU263JnpPTgPtt9KCI+lTlDXp47Kp6gCZvueh9G/+vTYDt1fDJhg6YW++Cqd88K6hitxsxpNmPldcYLtaUkhsaezAKNlKQQR/mTA5ozX5bvyQKJBfYXbzhDEOSMgSFidyxHyLkHQpa1cmpe7/rdMVGk5HFhxRp7Re7tXRR2HjPv2/o4Zy1rzanhcxqNaVSlp77UJTMfRTh1S3VTrz3ThX3pOymQRctLo6VxaBC9l7aR3g4cQ/tP5GBCB0RH7MY504FIwGwu0kt+hr1sWxt4kuLk+EoLgEx406cViCP4ytWCGA3VQNcVVDxnZj7rIdenJKZwQsHuThbQETL2OzljdXoXjlL2AA2n3XufdO0j/xSaZYSbRPt/qL4mKge+qd6lhOB8mTGSnrmS+jaufaq+YSWs4eZKNpj+2vybjf8tjcV7+PwlqHWQydoTNWGrM4O7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(8676002)(4326008)(66556008)(66476007)(31696002)(6666004)(83380400001)(2616005)(316002)(86362001)(8936002)(5660300002)(2906002)(186003)(36756003)(31686004)(6506007)(6512007)(6486002)(26005)(38100700002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dndSZlA3OSsvWkNCZzhqa1dRUkxDR20ydEdobktac0pGa0pLMFdsZm11aysy?=
 =?utf-8?B?cUxiRDd4bWUwZDdLVjl2bEx5TXNuL1UwNVptNzVMaFFhK3p4QzFWSVFTMVl5?=
 =?utf-8?B?MXgzOEtxc0xjQ1dYUUc2ZzJlOE50ZHNZdzdiNXUveUc2UklQb2lmSnF1OEFY?=
 =?utf-8?B?Z3FzM1NyS1ZPeDQvbHdERE5xQU9hSUQ5czNiaTNtQ2xkVUxGdXhTd3dFKzQv?=
 =?utf-8?B?MWdJeWd3RytUVVNVaE1GVkhqS2JSNW9GRDRKSW1PMkIxblVReXZ0OGYwcExV?=
 =?utf-8?B?MFNPTVVkaWdzVS8yTEVGbE9RV0piVGIzQm1IUnNXWFI4L09CVlJvWkJOU0F2?=
 =?utf-8?B?WkR0SXZKM3BldE5kcTRMNG9lNEMwYVQ0b05ZSklGdTdPNUtMUERDVlJsa1ho?=
 =?utf-8?B?NTBBR0ltaDNQMGs3aHZlRXg0Y3pYQzc0VjlQS3pDWUNVYXhmS1VTdVZENVE4?=
 =?utf-8?B?Tmt3eXloRjFiZkMzK0FEVXBST1dKMCt3bE5OVzNwbHVmZS9kNG1mcEtITGov?=
 =?utf-8?B?UFQwZGt1VzREMlNpZHZxdFhNVlFxTVUrSXZzN1hHU25hanhFSXdZQ1IvV004?=
 =?utf-8?B?Wjc3SFZDdUdkRUZ2TzZweDFkWFJvUUpvT25ncG8rd1hqdjY1a0dvNTdlNDJa?=
 =?utf-8?B?K0NDN0dYdWlTWHpKSm5ab0M2RnY2U2RhUmJaNDVCOEdPMXZWTzZkYjlPdGhK?=
 =?utf-8?B?RXRiUW1HVWc2SXBoVGRxT2kyMm51eHl3bytxUTBSbEdmUUFvRTN5NDRneWVR?=
 =?utf-8?B?WUk5NmdyczN0NzNzSXppNTBHalRyWGtrajhKblRqLzFEdnRGRzNLWWFEbTYz?=
 =?utf-8?B?ZWpya0lrUnVRcWpXQ3RTSGNONUJKaTN2VTJZY3JnS2NlMml6RklpN3kyanJP?=
 =?utf-8?B?bXRXalIzNDdhVHlHWWx3alM0R3RWWDhJV2hkbWIxa1crM0l6SU1qL29PQ1ZI?=
 =?utf-8?B?NzRNL28xSmNQUnhDSHN4TUFzOFhvWDN6Z2s5clFIaTBTRkpSNjVSZnJ0VGoz?=
 =?utf-8?B?Q1ZRUXdnWFhsME04ZnYxRmFPUGx0dE04WlQycFdkV3lJQVgyZGx6UFczUllw?=
 =?utf-8?B?V1VveHZZMGVOWWlMWDVXUUlzblJiY0YwQ3c5em9GTkZRNE9XV1ZjV0xGekQy?=
 =?utf-8?B?d0xiV05reUx2KzZrQ2hEandHeHNyaFhmQkEzcys4U3RrN2FJd0tmRVFDYlBE?=
 =?utf-8?B?UXRZYXRaLzg5Uk1GaFJlTVV0bVZhVVY3SzR4cENnTExCWkVtS2RXeFhoNWlv?=
 =?utf-8?B?SVRRSVU5ejVhYjNxZXRZMnZqOTh0VGFKWmpJbWd0cmI3bXVwZlZUaDJhVTVs?=
 =?utf-8?B?QzZhaG5PeG90R1E4K2pnZkZVRHhJSWtreVFsdFR2SmE5YWwrL1ROZW14ZVRO?=
 =?utf-8?B?QnpRRXgwOHJsdGdJOUk3OGxlYTZKc3BPb1ZuNU1pcWgwTEpiU29qaFhuNnFR?=
 =?utf-8?B?Q3Z0ejZ2K285UzlsaFdyVk1jaGQzZG1TWnIyZFlJSVBpaUhGLzRKOGsrNjJQ?=
 =?utf-8?B?VkhXZ0l0c0ZZMGJMWVpDeE9jMm5UR2dnZWdIVm8xMndNcStlTnVDMkE0Smxy?=
 =?utf-8?B?Ulg2dUlnZG1aZHlLeE5XVXFZc1l6YWFOdnZqSnNoNCs3cW5aNFZNK1creXZN?=
 =?utf-8?B?Qk1iQ3B0SDBlZDl6RzFveTl2Q0t3R1VGK3VHSm9LZU44TnUwNjRCYkgzRDJG?=
 =?utf-8?B?TWY1S1ROcWtHeC9rTDB2bG9VUTROTElDeWJ2UTJVSVA2OVk2eExsVGlrRnRr?=
 =?utf-8?B?V2grT0tRUDlJTlhiUXZHR0dXaE1YN3paK3dPT1FmR3lCamo3Vi81SjZ1SkVX?=
 =?utf-8?B?dUFFdUJQdXdWVEJDZVh2bGJjaDNNcngzUENlNDM4cUM2NHd5MDMxMXV6VEQ1?=
 =?utf-8?B?eXBBV3IzQStRS2IrbGR2R3RGdmdHSTBvRVhvb0Q1Wkx3UlU2OGR4K1ZaekdW?=
 =?utf-8?B?T1QrRUJyYWwxcHA2ZWpBdDkzOEo1RXc0UmZNVlRDSDRIVWszaS9hYnJ5bE5z?=
 =?utf-8?B?Mi9SQUNoVzlQR21QMTY0ZzliS1c0bmxreFRNWlBmT3hxc2tXU2xYMDNBcmRw?=
 =?utf-8?B?UjNQS0ZmYklQUjljMnh0SkF2UVNuTkZrMUJEbENOamVkSVpJaUNsY3ArUzc3?=
 =?utf-8?B?WC81bTltMGsxTmVHZXlCZHhSazVMWTN5aFIyWjZacy84WlZ2TTBTemZrV2ZL?=
 =?utf-8?B?aU5KMFVnaDlVU0NURHh5TFRub0hmRnZ0WTRGOEdXOWxmNklrNW1PWG90NUtC?=
 =?utf-8?B?aVFSRlM2a1JjLyt2dS9oQjZNQ29wQTZiWGZUOHFKeEhUZkVVMzVnOGpBOWVR?=
 =?utf-8?B?cUppVlh5d21PS0J5SWVTQUZEcXRROVEvNjJJL0NPVDgwakVJVmdudz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86681f04-295b-46c4-d937-08da3893f30b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:02:11.7990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDf2jsNukFx3m6Vtah8YdBjK94Ntt+81z9J4NP4bfhnYT7bZs+TS8fWWCW1BjX0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4554
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.05.22 um 21:20 schrieb Andrey Grodzovsky:
> Will be read by executors of async reset like debugfs.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
>   3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b583026dc893..3948e7db6ad7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5303,6 +5303,8 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>   
>   	if (r)
>   		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
> +
> +	atomic_set(&adev->reset_domain->reset_res, r);
>   	return r;
>   }
>   
> @@ -5317,7 +5319,7 @@ static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
>   {
>   	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
>   
> -	recover_work->ret = amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
> +	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
>   }
>   /*
>    * Serialize gpu recover into reset domain single threaded wq
> @@ -5334,7 +5336,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   	flush_work(&work.base);
>   
> -	return work.ret;
> +	return atomic_read(&adev->reset_domain->reset_res);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index c80af0889773..32c86a0b145c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -132,6 +132,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>   	}
>   
>   	atomic_set(&reset_domain->in_gpu_reset, 0);
> +	atomic_set(&reset_domain->reset_res, 0);
>   	init_rwsem(&reset_domain->sem);
>   
>   	return reset_domain;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 1949dbe28a86..9e55a5d7a825 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -82,6 +82,7 @@ struct amdgpu_reset_domain {
>   	enum amdgpu_reset_domain_type type;
>   	struct rw_semaphore sem;
>   	atomic_t in_gpu_reset;
> +	atomic_t reset_res;

Maybe better name that last_result or something like that.

Christian.

>   };
>   
>   

