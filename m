Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8B3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 09:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B716C10F3A6;
	Tue, 14 Jun 2022 09:08:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD7DD10F3A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 09:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGffqGvkGEcsd/4BL76xlpUtQagslXfka6/VYvjexayKf9wsksxWUnZlXorSxFRPqqCIATs1w9BZCZAF+rR7yfMu5vm9d53MOjmg1BMCRNDuEruYg+dvuy/T0ESqE36JhxZE+eKGT3t8vuMAWPFWtuIsVkQ6OtJ9tQPhJ2tX/ip0Q/+xmZCcmEVmNH0Ky8Y34VMMWYoTTGqd5xn4yyZqnDN3GRwaL4VQGnPiG/W2uK4faTzdoaS9qMd05yJdw87dR0vhjfTOEKDNAYr5u/yX4GwikXDR0RyzBieHajuc25ZYOHQ6EgB1RaMSGW8HYHjQ9/JEANr40o3CmoUnswUUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+CdMX/03puVuTcnFj78DZKv5+hlvatnJ7tUImkrx0c=;
 b=mEiGL0AIenQIUJYAIeToIUFhCqlTZWJbf+wWB1nA5nJjsjlB6jxvVWgShgnFY55tPW1akWXVvWNMQKlNm3ldIy9rjs5M5zD9Rn1MytEydrU2/qcBf3NgyLjfhKJVD1yTZXbIh0avCxTCEKxJ9HuZmUS5PEQvKgjv4XITppzblqVNjHiQ+P4c4v++6HMwXQeO8DBbQ1TLNQPoLDUvsYEhsTb2k8uQtIVQ8brQlRPuA3tvC5WRELWjaQtZ0s9EBd2T4BTjAWn/QIVqiaUXr/NlIy+s1LsmwcTz9u0FZtpJFI4zGaX5mEEQjV5yBawgbax0y8RSWcL7MyX3P911+IqswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+CdMX/03puVuTcnFj78DZKv5+hlvatnJ7tUImkrx0c=;
 b=voQzxyyaqfaBBc/WyFsVPt8By3MR5089gmvVAFWt1mqTxH7e+F+CDeXj13fObtedTYuLfgC6XQ7CK9w48Gv5bmpz5z1C+oWsJiYIIGBy7VQK98N4ZCeE3uZbI74WxR2+ONv4x/eHSab9YSTpNpvwc6VDONGhbQZQ/Br7VYRknYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Tue, 14 Jun
 2022 09:08:06 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 09:08:06 +0000
Message-ID: <77fb7897-0a54-cdc6-4c1a-77b7ec82f9f4@amd.com>
Date: Tue, 14 Jun 2022 11:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] drm/amdkfd: simplify vm_validate_pt_pd_bos
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220614090307.999988-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220614090307.999988-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0016.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::29) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70aaab33-b5a5-402f-344f-08da4de564e0
X-MS-TrafficTypeDiagnostic: PH0PR12MB5632:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB563246294B3FA39390FD399083AA9@PH0PR12MB5632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEkcEkGmTVm1LSrBZm4pGDwly4IG3gHgIOoFffy2TBFYg6Raz4XzhYRswoAFKTKFMnVvD8QNFjnO48ivO1q5UD3kVhcdcSR6wJXQb5gRmdUWpE9d85CPU1fslI/L8x07oUejrY5iwhZMDZMtQ6aVwrITaBeo8gDeP3XFGrMjR+t3qQFCLNTH0zk0eFiI+KY5/6BJ47E0Lz8n0P1imQQeJDG2euMUuThH862YV4udchaTKmJx9rOUUNjdyHNnZYVQRkVsnozwDUknWN5ahcfXd2RGw8yqyQwATpNvuBLpiUYjLjkAmI+iDzHMa5/8KkHy7eTqCMvH4expdZBUaOmPyuACV+WjaDDMDGe3msKUC+kzDRbrUxhcRs2dAsgzKdr4229dboyoFwvpX8Juy8SRTWOT1OHQkc27LIadKU1D/82QQNWCdt0+V/SBJIhcYCD8M6QRAOwfizYKDdRJAnbxjERXniTf9GlUEqKdoYtGQOMFa3cCrMFz7tktbrTQpQIhIXaMbPs3IKHgnxg9aYo9MdlRlFEz+lIcDlyTxji/Z+iuiwoqIdCzZDJOC/0skchITV4plMw2f4NX7Rbk9fPArRMqaJlQx0qTcqv0iPMm4T+QO3e62ALuM7lqAejdk+yQxatapCQknXR1CO+AdczTWwpSgnN7dYu4eOKaBmmPTHEc/nnwgr8TRecLFXmj2+fWxrLdgowliZB7Rsz1oKuwIqD3aOcO111kHx6Pql+0uv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(4326008)(66556008)(66476007)(6512007)(31686004)(2616005)(8676002)(66946007)(8936002)(6666004)(31696002)(5660300002)(86362001)(6506007)(54906003)(186003)(316002)(508600001)(38100700002)(66574015)(2906002)(36756003)(83380400001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGE0dUpNZDU2clNnRmN0Z0dDbnVGcjNUNkt3UUxOazhKeTdpbndsRWZpcHdz?=
 =?utf-8?B?dlBjSExPR1RwY3EyMWdGbVdzOWhYWVJ0TUUzSVJWSHNYcitBU1N0bVB4L2wy?=
 =?utf-8?B?WTlhL0VaK2E5N1FrRFd5TURwd1UyeFI1RWdwWVU4d1lRVDJwU1pqQVlPUVlK?=
 =?utf-8?B?Vm5LWEVCZCtQMldva0NjU2g1WFFRN2NuZjd6TkMwZysvSDFiMWhqV2lkay9m?=
 =?utf-8?B?Z0pETkYzZnFZaWRHK2ZEQy9MRWdvd2hLUVlTT2xVS0VXcU53NzBBYk9PV3E5?=
 =?utf-8?B?ek5VM2huZ3M3bFAyY1U5Kzl4c3ZnZHo5bHoyTzVkdnNidFFVMHBULzVKMlBL?=
 =?utf-8?B?NlMweUNwUFJOSVcrbjd0RGgwT3JGUU1VS29NMll0SDhTOG5MRUJWRGJuWE8z?=
 =?utf-8?B?eXhjNE5HWUpoa2lIb3daQ2JkbzhoMytFMmlUYmpWNFdGRHk0VWwzUjdpMklK?=
 =?utf-8?B?WHcwbUNNcTExeUJSS29yQTM0bUkvZTZsNjBhVXdhYW4wckdFNHFidVJYeUlT?=
 =?utf-8?B?YXYzMW55bmZESTRqL2pyQWF6Y0NSK0drMENaMHBCZFhabHh1UkZKWXVwZ0VR?=
 =?utf-8?B?OWpmZmsydjRYb1I5YXZSREFha2wwN3ZFL1BuVCtZYmdqK2lFY1NrVmNySk8r?=
 =?utf-8?B?NDlVaStpeTJKTU8vWHZITnlObHNQemhoeHFLdFZFNEIxQm5pN3ZmODdMQ2JE?=
 =?utf-8?B?MWdqYjN3djFTMjIvNUk0ejd3c3lKcjE3dDZ6eDhtTHhXVlRxekJ4bE16STU5?=
 =?utf-8?B?WTg3TWdzc3NveDZ3OUEvUERXTGU3MFhjdW03L1hUdXoyRnhRUnhpcEJ1aDB2?=
 =?utf-8?B?OElTaVRKRE42OGtTenYxYVR2MisxMUE2SWtLWDBpZkpudEZjaHZ5ZE13WWhn?=
 =?utf-8?B?clU3ZUcvZHJKb3pLc1k2Nk1iU0w0amI3OFFENWQ0dk5QVCtlMkRCdXowaWxY?=
 =?utf-8?B?RTV6anhtM0xIYTZtdlRhSHBHMytlRkpxRUFQY1crN25NYkpXYXZacnF6SER1?=
 =?utf-8?B?bkVVUm9xRnkzeW5iK0VQYjlJS3FhRDNjNEQrVHVMcVZHTWxlOUpCdW1ZSzBV?=
 =?utf-8?B?MDBtTXdjRm5SdDluSnJ2WjV2MEFIOS93ejdLTGgxN2F0QVQ5bDFXZjF2K1J2?=
 =?utf-8?B?NDhCeEk3T2wwcjNwN25hdVk4T1pNc0VUVVNPM0w2M3lndkh5aWRzUUo2cFV1?=
 =?utf-8?B?K01jdjgrYUhEODVzTTNUMjVNYVhNZmE3N1V1c09oakFDODhIWEV4R2JXeXg2?=
 =?utf-8?B?NEU5TGxscWVxY2EwU25tSWJ6YWtZaGN2a29ieTlwQUF0Ynk5ZEd4UGR2NEtH?=
 =?utf-8?B?YTFCa1cvMW1yVnd1K2tsV0VkTi9rV1ppQkhGYVBFbEZMRGJDR0JqcU1HVlND?=
 =?utf-8?B?bXhLcHBobWxCZllpNzMyUmNuV3pwTVJsNHZHaDlYRnBvcyszdWFCblZwVzh2?=
 =?utf-8?B?UnlWZ2NONVRMdDNOWUFTSHZNSFp2VndPemFGbXhhbzRKMmN2d1dRZG1ab1J4?=
 =?utf-8?B?Q3g2b3NnYm1BazExRE5VUlFDL3E3QVc3NUUzMlk2Q2VQdkUzODdyaU04azFF?=
 =?utf-8?B?c2pSUTNsOE9EQmZzZGRKelp4ZENWZnVRbU92RG9BaEgwb2lVcURvcWhwQnh4?=
 =?utf-8?B?NHVmTzVyc1dSaGxyQngxYkJDb2tmMXM3eTlFQWZsS3kzVDFQMVNkdUYrMk1L?=
 =?utf-8?B?N25TR05ScHE3R00zbnVuWkZxc1Z5RnRGS1BRa09jSDA0VmdGcll6MzkwaUxT?=
 =?utf-8?B?U0J6dzhFdEgzcTd6VGxzMW0rVEM1K3hRelFLMlpHd3VjREsxalhBb01LZmVE?=
 =?utf-8?B?V2NMZkc2WkJEaVZZem9zTkhEV3pQTkdMWGJUcHdzYUxrc3hqTnZxUGZJTnFO?=
 =?utf-8?B?QUJGeWt5S2dXQXRYZU8rTENaZWlQRzVqbXBuZnk4QjhuU2N0UU5ob3pkdHY2?=
 =?utf-8?B?cWZMbmtLSEY2SXczZ3VtdXd0TFM2dURCTjVKMHIyZnJsd1lEaVc3REJIbThB?=
 =?utf-8?B?Zmt3NjhHSThqd1dXeXN5WnhjOFJ1SnZFVVR3ekpsY0hkSmZxVytRZFJ2SEl4?=
 =?utf-8?B?WStXZEx5N0NrRTRFcEtvbnlXZDBiRzFYeWljVnZVQ2pmM0I5cHl3Ry9ldVhu?=
 =?utf-8?B?SlBIVU5QNVFnR1ZNU1E3dHA2djJtWDlrZlVGM1NCRHQ0ZytsQW5iRnNRRXhQ?=
 =?utf-8?B?WGpYZFJYWGUxQ2JLeUk5bzlnTHVVMWNOM2N2NEtiTTB5VGxOZjU0My9PRGMz?=
 =?utf-8?B?Q29kRGw2dnVmNkdiVXJwZFpjTVFRanUyTllkOFdla3lFdWhHYmFzazlHYWtH?=
 =?utf-8?B?TDFiZFgrZzBHaVFzY3YySXg5aGFMc0VNOTBDYnUyVkhmN2F6cHhTWXNFTG1v?=
 =?utf-8?Q?EnJOQalWjPiUPDjYLzV4lEOmhDMal0SDVUuSJ7BxNp5x/?=
X-MS-Exchange-AntiSpam-MessageData-1: m2CGTc1bQIz0/g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70aaab33-b5a5-402f-344f-08da4de564e0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 09:08:06.3017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsPWTA2+Hbwxyg0OUg9sE+U/SeY4pXKRNhwW7GqIuj+JvP3PcPhmgj3k9i7WdxpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.06.22 um 11:03 schrieb Lang Yu:
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

I can't judge the kfd part, but the VM stuff looks good to me now.

Acked-by: Christian König <christian.koenig@amd.com>

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

