Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916B9C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 21:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0956910EC3D;
	Thu, 30 Jun 2022 21:30:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B0810EC3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 21:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWzBM2NKC3CHWk2K5F/5w1lMJxdXu+dpkSC0Q8+YaoPDcxpZhVj4R3Po7vBSEv6HUplDXB1H6tP7xvSI8fVIKcQGZ+dtWWpHHDodpabSECRpOCiMCByh09uE2XkiB/RhSdr3szTNFmcd1eBcNcyD8nkE1G1ygwkjenLZhAC8rDYdSpaESZHLXMOQqiYHtBDglA0PmstX0hcFy2MD44BBEH+WVKDE7SCkuYSirDwkH+y8iE/uNq/kMUSOipSCMtdgiJ61PcyIVgKamVq15pRLqidjJcLi6ZulocQP8KDjaKWmrYPMlY4PD/h4uxVAeq7BfRkx9BoH4yrYxdzMuzI+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRW8oOqEYe3CV1en4L5bP+4IaELuvJ44YVnL8cPYoHs=;
 b=cOgbNaufgN9A0aiabOvsGsZJgEpjAQG8Xep13YknA1DxwTtRlxcOAvEd4NpBi9A145RZQ3IIuOyx2gr6TrNcg1kzqwP2IB6lzETyrI5j27CfoK77i1FEOCWX/12Z4eiHkdeT1CKkBXXDsAj55skZyXDSUPiX1zm1ccqAQs3bOJOi+kRYcOlahYvrrYNqx38jbOnCwtcexjzeIMXFbGbc3vr0g8HVCA27EBUnzYp5HdUwD11FpOH1425ZGLChdWEY2YcusjVWsGhXjllgwMwvkio/F4fD+qs9wa/3rqMCVDt9O2kKvY0DZnRlvQqTbdzMgU8HePE3+4uOLaYpIPJsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRW8oOqEYe3CV1en4L5bP+4IaELuvJ44YVnL8cPYoHs=;
 b=xAowf5YTZ3coSTMAJiL66zPPTjaVKF3HHfrg2hrzuMbRhDiJBHuxa60IudAhkR6ONUi0wFo3wVtIihXi47Pxa2pB5+So2QYUXS98U8gJjI6HFNCbdBD9nlqTvBUzNxyXdqI26UN++aF7FfwZucNkVx+Q6oUh0xNOgMHW6jtzkRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 21:30:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 21:30:31 +0000
Message-ID: <2932560d-4553-4f9f-608e-e8dd55ab529d@amd.com>
Date: Thu, 30 Jun 2022 17:30:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] drm/amdkfd: simplify vm_validate_pt_pd_bos
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220614090307.999988-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220614090307.999988-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:610:e6::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a26233-e4fa-4fef-bad7-08da5adfc257
X-MS-TrafficTypeDiagnostic: MN2PR12MB4320:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7VdxM3xaZglUSHvyNun2YO2iHdoTvVy5jPuNV7Z67TOvUg/AoaVoObJ3iIMaNjwMGmN/TiyFl877lyqBzGKwNeyWQDmsOxdruNREF69bXQb+X/PmXDjwPCNagr+ZMyLPyVjcgknq/WONXlIY8mNBAA8yyYDt+80BEZrcJ6YDi6q5T7vnWwInAek2YOKChZUlCDqWe9HQ70lb2KujdgJ+Xn8K8uahFzyxIKB50ar97dEtk8vOAoaK1mCTF9SPQBSE3bJgyAw7PJxz3CqJB2lWdaM5D53I+N89r5pReAXm05p0TYAfDT7iaF/laBWwLciiZvQfZZsFiEwoV19UP7ywCTG23zWCIfuAZTOzAK+nNxQbnqOJ72cdHmwzau5OemyCJ5Np05whi8bEkYIvg41s+HT1bd+6uT7Oqfre3yLhF8gxTyI6RiTVVE4eXDJj9wk2h9H2JRch8uwemcNF8SP9fLM+sWFMmM1imS6LPtaXx+IDVkAJGPZydIjFscg7DVzWKYZmn8jzLv0jcjgHNfOFwVFOq+w/LV+E6AJH01SgMqjL6A2Yimg1gnmE05fjrKMNoBnKMj7cd45jVSFcHcx9FP1Qn/g6bCXfJy2zlYkS/iY5DV3YoYPJI+7RMl7vG/OaRctGufLnXDXNN7D3on/l6sW1slIh7mUlcsNms3Ijs3u2rCmCwCdxUEF9s2F0LFBgo9OfIz+0own5E6now674G7XqMyc7nQUFSiXAtg35ZHI+Md7d+nQtrZd8rS1aQfNBiT7l8ec1usFFgPwTI5k+qYYbxzo7XUFweHU0YYP7mW4mzLIajzxLqpZpR0uKk3vQDB3f47L9QLDfVM406Xl8ZkJi758nf73WVsUun61/mE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(8676002)(4326008)(316002)(36916002)(54906003)(31686004)(36756003)(66556008)(66476007)(66946007)(83380400001)(6486002)(6512007)(2906002)(44832011)(26005)(86362001)(41300700001)(5660300002)(53546011)(38100700002)(2616005)(478600001)(8936002)(186003)(6506007)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGIxb2FzV292YldteW9zdWErOGVDYkJaZFB1N0l2RUFDd1o5MlhaK3BVVXBT?=
 =?utf-8?B?TmZBV1l1RCtoT3VSR2lQd3FsQVE5NmxjY1Ywb2w2eVVKcUFmSGtidy83WXhH?=
 =?utf-8?B?YVVVVU41RFBYbU94OUoxWUdOUm5NbGdvRkRJbmVDQ0prMFluTFhmTEQxVDRP?=
 =?utf-8?B?cHhNRnR4cS9JNnRoODdSdldOb1IrK2lTaGFwM2YxUmlva0RrQVplbjVhZkto?=
 =?utf-8?B?RVkxbnZkbmNOTDBmL0FyaTc2Ny8xUENyWExXbk5VWkRNeXMraDU0S1Y1Sm9i?=
 =?utf-8?B?MnY2dUhSdG5MK1VOTGxwVTR6SDRFOHVwcGZCRHRVbFhEM3V3V1JHcHdWU2F2?=
 =?utf-8?B?UmlKRWpUQS94dkdORDAzMk81VFZyaWRzTUUrWDRGUFNDKzBDZlFJL1hsUkh3?=
 =?utf-8?B?WmVzektzVVVveDJjK3dKNEFjN2xPb3BUTnFkSURwSXdqcXdOOVpncVN0aGNl?=
 =?utf-8?B?T1ZaZndZSjdaQWRHbk9jeUhVZWduYmxsRS9lZVhrOHVoaVNJWU4yZGlacHVh?=
 =?utf-8?B?MEVLa3FOaDZTVE02Sm03cTMwWTA5V1BXeG5qR0dielVGczFCRWIrdnBFd1JX?=
 =?utf-8?B?RC93TWdxT2FYRFNJcklVTWZHMjdiVElHbzZXaG1ZQTBTS2RLN0tYdUhwSFdW?=
 =?utf-8?B?SDhkNytLNTlia3FoQStHZHZFVFBYN0tlN0FmdVpHV2F4S2laNThXYll6dHE0?=
 =?utf-8?B?Q1puaFUyZHpMNXdhaVd0RXR4c1lWV0phLzlMdTlseHV4eitKOHJNYVJyOWU5?=
 =?utf-8?B?RXBsODZ4VStpMFJsamp5N3pBMzlWNXNMS004c0UvVTZXSTJwRVpWVGlVd2ta?=
 =?utf-8?B?enJpRWdUSDJZM1ZqdVFodDJiZ0IyVlBHRVhCS2ZBTUJnalpCUTk1anl1bTJN?=
 =?utf-8?B?dStGbllpSGpxVm9OcEtSRGJWd3VIL0xZRXdWZFhWSkFVZmt3OE0rUHdNcEVN?=
 =?utf-8?B?clhkT0g1N3I1N0c1cEgxY08rMXQwMlkzVDQxYlh0eHEzV3U4bXNpeUttaUd2?=
 =?utf-8?B?TVkvT3NSdTJDZXZ3Q0NORlA5UjFWWWN5enBMay9MQTNvWVFWc0ZtekN1U3pM?=
 =?utf-8?B?NVlyR3lRMmpVWCtjOVFJaWpmQlBLU2FGdmNRTU44ZHBZN01WczBYWXpmS3NN?=
 =?utf-8?B?ckhEMnN1WC82QkVhbmdZcUI3bWRYZXZ0TjVTcXVqL25lUHpKVWZ1K3pYVWhk?=
 =?utf-8?B?dTk1T2V4ZVc1Z0p2aUEremduNS8yZlpFa2V3QlNVM2NpTUpKUU1yNXJ3VmF4?=
 =?utf-8?B?RGZIZnVqWXcrRVZ3YXhWSW16OU1uc0IyUkw2cU9vMFFhaXhIN1NjZ3RVcU8z?=
 =?utf-8?B?SGc3N2pSNzJIU2VMaHhxU0N5M2tCcFZyL0tDY2pOQVBqcy9JUitlcGRWRW1O?=
 =?utf-8?B?Q0gyMm16WHRBMTNhRlA1aTRsNExnenc2b3VhMTZtRFljS2pMR01TTmF2RGU3?=
 =?utf-8?B?NUh3THBxdmJGTnFjZEY0a2ROanZVVXpkVGNWb0kyYW4rWTZEUWNzY09ONDRX?=
 =?utf-8?B?dm15VWMyeFQ1d29YWnRhQWxia21TMjVRVzRER2ttSXdGTjlFWThoRUIxcDJs?=
 =?utf-8?B?bWVFamJjdE9lc1hVaDZ3U3dWcW9rMXhnanVGTzd4Wmt5MVBiakRvd08rMVZP?=
 =?utf-8?B?NWtTYit4alZjZG96NmZPM2JwZER6RHdyY2xsZFJjRmM5NVNFdjBCSGYxOE1u?=
 =?utf-8?B?NFdGL1VkTlMyMnVZTkV2eGQ3djZpVmhDbnEydW9DM3FJVDcwaWdZaDRtTGVk?=
 =?utf-8?B?SW5QNUk5dURFTjF5ckNFVGl3OHMrUmpkSTJqd3JjVUFZT3NVNGdJL2k0WnRu?=
 =?utf-8?B?WTFGdzkxSzNXeFdHWEZqdnVnTTlLWk9xcjRCUmZ6QVVnSDhkVWJjcm93M2M5?=
 =?utf-8?B?QzNBMUFNT0xBLzRmdnFIMVpYOHBIcCsrb1A0N3p2NjBaVGxPNlY2OEFDL01I?=
 =?utf-8?B?MmswL0k1WHhNZ0phVHp1RG9hdTJXcmVZWGg4cmhsUUJFWHhTcHI5VHlBT1A1?=
 =?utf-8?B?ZFVIb1VPNkNDVDVxdlNkeHMwSTZzWVdwVDdod1Y5NjVWVW9mSlV6SjFsODlP?=
 =?utf-8?B?clZXaDJQbUlYbmxaRVoyaG9JcUE3eFJwY05Qa1dmTGsyUnJDUVlsdWROU3F2?=
 =?utf-8?Q?wWtum59+ur9VhvT0vNsisSj7B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a26233-e4fa-4fef-bad7-08da5adfc257
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 21:30:31.2800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /S6ttBVbN/x+TkdLRw7pCSjB8qP2lFu67vJtUZ7grfJ4YsFrLZilXtWqNmjXnObcFyvlgp1Uije6kCC13TAmLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-14 05:03, Lang Yu wrote:
> We don't need to validate and map root PD specially here,
> it would be validated and mapped by amdgpu_vm_validate_pt_bos
> if it is evicted.
>
> The special case is when turning a GFX VM to a compute VM,
> if vm_update_mode changed, we should make sure root PD gets
> mapped. So just map root PD after updating vm->update_funcs
> in amdgpu_vm_make_compute whether the vm_update_mode changed
> or not.
>
> v3:
>   - Add some comments suggested by Christian.
>
> v2:
>   - Don't rename vm_validate_pt_pd_bos and make it public.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 --------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  8 ++++++++
>   2 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 50bb590c3306..c9ef242177e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -439,22 +439,8 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>   		return ret;
>   	}
>   
> -	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
> -	if (ret) {
> -		pr_err("failed to validate PD\n");
> -		return ret;
> -	}
> -
>   	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>   
> -	if (vm->use_cpu_for_update) {
> -		ret = amdgpu_bo_kmap(pd, NULL);
> -		if (ret) {
> -			pr_err("failed to kmap PD, ret=%d\n", ret);
> -			return ret;
> -		}
> -	}
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 703552f9a6d7..3a6b827e540c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2225,6 +2225,14 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	} else {
>   		vm->update_funcs = &amdgpu_vm_sdma_funcs;
>   	}
> +	/*
> +	 * Make sure root PD gets mapped. As vm_update_mode could be changed
> +	 * when turning a GFX VM into a compute VM.
> +	 */
> +	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
> +	if (r)
> +		goto unreserve_bo;
> +
>   	dma_fence_put(vm->last_update);
>   	vm->last_update = NULL;
>   	vm->is_compute_context = true;
