Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCFAEE4996
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 11:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F3010E326;
	Tue, 22 Aug 2023 11:49:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6151D10E326
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 11:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKwwlDHqRSKtwsNTzv/Yiqf0gq6HBVf/uQfxlAj3B3haXJSiRqnzhmy1UBl9r1vmFLOGnwu7t32EbDHNcB2gTP7Vv5SYjXwIDVBdo1R/rJa+nsNIgxpSDhNG+7yn8aOsJolh1GvwsZeUY0N2PS+fcKccgrvTUpkfRTwqJsfuc/c0p8pYrYsi/R8EL/qnqAdQkk17Rc3D8NTGkASsWRhiMGZ4uJYK4+2r5wmPVqYb2o2cIjB3u9cZKPT8yXqxdVeCfPmN3X8QxfTUZxqmbCqMjvBTQmoEmxjLlSxc7SjkoZaZOyNKWUe+/CxkMM6TS4LaEXeLwrDv+frf+VZMpJInYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8RFVm/jErSMIyf6Yj2fXmSNciMQdc8mUroxucN/ZsU=;
 b=EQLSwpgvP436UlGxlsc+yuHWW7QcaNZDN69EwEw8I5Oz5JZSg/lKhcHxA7oInJzSUFgjtgemRBgCv9C7Jqb26FeklzQS4JShw9+5zJfrs6VPP1aR0X97mqqQxSMDgAezs94/unGQdHbCUOapc6trsihCzIkX3KsOlPHVXt4mlkzGTAFS6LPRKYUxMxIx1srce1N7WZw2Yq3B3NLo3g0Pzq7eB0XCmO7ID2DuqsDkzYM7VKn11oORWqIQwoOJSBtzsZOnUhDjyUEYJOKbqWQJI+k/4WBxfy0ZOpFL5L7NPrW3zBzxFbGs7LEVwFPCV9Kdh9EaAvmUZz4/NzZcOH1BiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8RFVm/jErSMIyf6Yj2fXmSNciMQdc8mUroxucN/ZsU=;
 b=QlRxGOmBvaQ/Zlm0W0ylnoGmwJ+q50JOou5Vtet5Rfdy1YAcL5KVCLhCId/bsgxxKhm6no1ldsV0Gh5ZRXoydAvRY+n7f17Pvs79EVIZyG2bqRYLxsSRf87se9BgTrXsFizRSYtxNTe6BpfKfB6SR2XZgG/gAal9jNdm5us8msQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 11:49:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 11:49:18 +0000
Message-ID: <ec741915-a0da-e3f2-ee98-bfe516fa4dc3@amd.com>
Date: Tue, 22 Aug 2023 13:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] drm/amdgpu: change page_table_base_addr caculation in
 mes queue property
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <20230822061724.3917603-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230822061724.3917603-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fe8d0e-9894-4cd6-a707-08dba305d10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBmZOj+4ZAyGVTnfrEULC/VFKDqFQnKNNTa1u7MKtG7oXr0/rqdStOuewA2sU6QR7yZru9hDm0odAGPw9ZNw6wnWf/AOCNQe8n1GSIqJWnjp8p4ShvIRpfpKteELTTtybTXyaLK9j9/c7zIkWceS17QY+YGT/AlUNgYkSH2OQrj42qZ8sEXrLd3cI4tP7xOOF2KHZtt4H1ombJEd8Dgl9y9vC4xuobBbAri+YmWEhAQ1NQ1vMMH6SX+ZDfd7VGzV74I7pb0CPGYAMfkmfbmY4NEokC7LdMUR2ykubZJv/LpwJU9VlcsF1+K4k4V/dyUhorOrYYean95YjmErf96eAzgPu4fFUNKF2spTPM5Y4ExfrFMwE4h7hVgbuk7GoiqIs/56eguGTW8MBlMjmMvaO47GajYEyEDj4XKCF+7dXWKRmTJ/FAbOH1NiKGIRx9klM9yLC4HVmRGiMW4niOudYMRlbNUUDZ0q89seZLHP56AKV0SPI/QFwQ4fWa3adoGjlY1Vlb2rmAPLEwvHcgHdbJAdIhrw+GEw0wuNbPdQrOUR+AMQqxDTlMimHDHkEf+JjAdUqh6aWbu6H65qFTY7ngQy5F2a78uk+6b6TGB33k8E7qInrqQxsyT7aJ/64Z4P2JF7qt9sMCFphIIS8e430Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(1800799009)(451199024)(186009)(6666004)(8936002)(8676002)(4326008)(316002)(6636002)(478600001)(31686004)(66556008)(110136005)(66946007)(66476007)(6486002)(6506007)(41300700001)(6512007)(38100700002)(36756003)(26005)(5660300002)(2616005)(31696002)(86362001)(2906002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHlqSVJYU3ppVXN6U2YxMjlZbjNZWE5MUHFzOHgrYTN2Wmd5VktMVUVzc1R4?=
 =?utf-8?B?Q1JjNXRYakRkQ1hTVGxKWnNOejI0cEZnZzAvbEs2Z3F6RmlUNGhyMUsxSUVE?=
 =?utf-8?B?UWN2Yld5VEt0YmZBM3VqUGtvZTZnQ3V1NmR6TUJqSzdwWElBWVpaK0F5UVp0?=
 =?utf-8?B?dExSLzFIdS9ZRXhwdERpajRNVFYyZlhkdTNQOGhJMkJRT0hyZENJZm9OUzAz?=
 =?utf-8?B?TVhOWDhMUnRDY2ZjZ3poQzVoQ2lSenpvQ1dNTkxiQzROczg1Zk80dXNZdmRo?=
 =?utf-8?B?Z20zaGt5cWlyNUE1bjh4M0UrNkN4N0U3ZW9iTTNDRjNiNmN3ZjZKNU01Q2tO?=
 =?utf-8?B?eGNiQXJpS1JmNDQyb0RpSUc3QVQ3cWk3a2FDcXZZbGpWWklRSzc4SXY1WStO?=
 =?utf-8?B?QktReXAyWko4eVRNTGhzQ3lQMmdMU2dmZ0owbloxeng2RVpRQ2xKbFdIT2R2?=
 =?utf-8?B?aHZnUER4TFRpN3U4VHJUOVZLQkpPRjYzUWdXSnF5b1FMdVJxNjFlejVjVEhJ?=
 =?utf-8?B?VVQ2OFZsVEMrcW9qczV1YzhXSlJrYVpVeUxnUGN3SEZFY05JeHFsSHBPRXRi?=
 =?utf-8?B?ellKQkFVWHZ2UHRsREpVd3NqU3dKVlJ2b3lqU3lRaTdOdFNGcFptejIzTXN1?=
 =?utf-8?B?dlk4OXlSczAvTEJzZVZwL25hZHJpQjNqVDZlTkdZRi9ISWRLSWZuTDNsYVd5?=
 =?utf-8?B?ZWROZkJsYmc1VGlUZmh4b3FFQi9XRUxFTWQ5OTcvMU1FT3B2TWVXM3VPRklW?=
 =?utf-8?B?ZUZYQjhBc1pKY0R1dkhFUFMycEsvKzlNdlVtMUZrSll0U1dERkRYWEhYT3dU?=
 =?utf-8?B?NDU1a0tCU3NZaFFYckx4VFhWam9nN28vcTdhNVRxWkJ4ZVNuTyt2L0gxWEpQ?=
 =?utf-8?B?ZEx3OWRVektaNDFleGtyK1puUGw3U2wzalArRnJCb0JkZDVPSEM0YzRldm9k?=
 =?utf-8?B?OVBYUVNlNG1HRUU4eEk0eHVrMzZjT0lpckROVTVjL3pxdWgwd0FlRHhLSkVq?=
 =?utf-8?B?ZnBRS0trbXYrdTdnd2t6SDJSNk5IdDh6bkNJYmNqbnJtZGNnT2FVKzJYWkNN?=
 =?utf-8?B?UWtmTjNsRmVsOXYxeDI5MElSZFQrMXR0OWlDSS9PWXUrek5IZDFPa29uQ2Vj?=
 =?utf-8?B?ZnJzbTJWQUxFVGZ5Z3VJeTVGNTlYSGcvK2k4MGVFajl4cTNsV0QxeGlBNmN3?=
 =?utf-8?B?VEhoTHpVTzNSOWw0YXVxYVlVbDR5MysrQ201b1V3WkE0cmp2bE95RmpROHRH?=
 =?utf-8?B?VHg3RUI3OEk3SWxLbmVqUHJLUVZjZFN3M3FPdzFhYmhJY0JIazlSN1dXTzlo?=
 =?utf-8?B?dXRVbUxyK3loalZEY2ZzNlErcjZaK1JHY2d0UlJtNEMwYzNTSWlKbi9EaWFD?=
 =?utf-8?B?cFF5SlR1SEVWSEcxUlpJNXhjb0d0dlh6Z1Z3cGN3OVlhTzdQbWtKek9lYUNS?=
 =?utf-8?B?Ymw0M3VaS0t4eHJyS0xYNkg0clFidG56ZDFoUGNtR1pzcC8xVmR3amZUWEVB?=
 =?utf-8?B?VC9wcCsvZEUxUUNSZjl6cjF5SFFhYjVCZzN6TWFNRWZNTktyd3VzdmNKL0lx?=
 =?utf-8?B?MW1Ham94cnUxZXhDcWwrUzJaZVFQUmF1bXlZK3VPWkNPN0gya21yc1JQb2NX?=
 =?utf-8?B?NmhxVVJ1OHFGczV6aS9UUFZXQjhDaWtQa0NpbzdlN3JxVnJOQW0xc1hzeU9V?=
 =?utf-8?B?eEpZclhaVTFCYnlDdFdBbVY0OG42UWV0V1dRODVBYlFhZmR6MGhkczU5SWZJ?=
 =?utf-8?B?aytSYWFnQ2FwSjlHNzB4VDNYUEpQTnFzVENEai9zdTMvOEdKbklscWVuU1Jt?=
 =?utf-8?B?UUxPQmltaW5MaWdib1JidC9vQlVtU3ZtQmViWEFWT0RNRHFHZzlibjZTSWlZ?=
 =?utf-8?B?Rjk4K1Z0QWsrV1FEMFk1dmxaS0xxZ3FvbkxCRHhEZ2tLOHRCQXFEcFVIYzB2?=
 =?utf-8?B?cGYvNUJudGtYUWZDSDdNWDNRZFVEd3pCQjhkazRNUWx3dmNGKys4NTNyK3Ns?=
 =?utf-8?B?Y2QwUWl0RlpkZGlZcmFMMndOdW9HNUw2MGE3NnBGTllJdFBJS2d5Q1M4WWt0?=
 =?utf-8?B?ZndHdEQzd1BpZnp2UGVGS2ZEYnBVSFh6WUYrYXFhU3BwSFhBd3dvOWhuZVhN?=
 =?utf-8?Q?MXCwhpnWGYq/dxCrhC2Obc0bj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fe8d0e-9894-4cd6-a707-08dba305d10f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 11:49:18.2626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVtFQngFB4Bxsd2Dfyq0Rzg/evZznYkgpS0x7f5E4zpJlAY0oWdXob+SDTEPtDHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.08.23 um 08:17 schrieb Yifan Zhang:
> current method doesn't work for GTT domain page table, change
> it to support both VRAM and GTT domain.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Of hand that looks like the right thing to do, one comment below.

With that fixed feel free to add my Acked-by, but Shashank should 
probably take a look as well.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 ++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 +-
>   2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 10ce5557bb11..ee957f059786 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -259,7 +259,7 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
>   	process->vm = vm;
>   	process->pasid = pasid;
>   	process->process_quantum = adev->mes.default_process_quantum;
> -	process->pd_gpu_addr = amdgpu_bo_gpu_offset(vm->root.bo);
> +	process->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>   
>   	amdgpu_mes_unlock(&adev->mes);
>   	return 0;
> @@ -621,9 +621,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>   	/* add hw queue to mes */
>   	queue_input.process_id = gang->process->pasid;
>   
> -	queue_input.page_table_base_addr =
> -		adev->vm_manager.vram_base_offset + gang->process->pd_gpu_addr -
> -		adev->gmc.vram_start;
> +	queue_input.page_table_base_addr =gang->process->pd_phys_addr;
>   
>   	queue_input.process_va_start = 0;
>   	queue_input.process_va_end =
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index a27b424ffe00..e1c20e2453c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -140,7 +140,7 @@ struct amdgpu_mes {
>   struct amdgpu_mes_process {
>   	int			pasid;
>   	struct			amdgpu_vm *vm;
> -	uint64_t		pd_gpu_addr;
> +	uint64_t		pd_phys_addr;

phys_addr for physical address is quite a bit misleading since this 
isn't a physical address at all. It's actually using the PDE format.

The entry in the job structure is equally bad named because of 
historical reasons.

Maybe a name like root_pde or something similar would be better.

Regards,
Christian.


>   	struct amdgpu_bo 	*proc_ctx_bo;
>   	uint64_t 		proc_ctx_gpu_addr;
>   	void 			*proc_ctx_cpu_ptr;

