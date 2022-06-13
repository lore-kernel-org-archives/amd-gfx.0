Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A48C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 08:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B13010F0AC;
	Mon, 13 Jun 2022 08:03:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CEDC10F0AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 08:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY03K6NSpMAo1eQGYxDrlENzD78Fcx55LICDedebhsx7BkwhI2sfNBf8S6RQDRsbD843DU1odMsfyI/ZK5/49ceHCEbNWHUPr7gnQDkwEhH9BE8DZPvyQ8WF7As74J08nZQxPbvgzGOrruOilRj+LhwCDdUSFnZdLFFz1PmuMdu1w+yQLjUr9Yna3OydfISmTMjXcrdTm0IWu086fxuPx3E6kXCMuZu3vSNfsIG5LQzmgUf8ohTEVqpRL/dDeX97PsCVJWgzbyUig4OVFaP8frC3lVF9y3xUcQGnE4lnPl6PsWFOoUK4DJOasxfoD34RKySuwRdwI0n7ovxvOBKsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEE7RUjN23ZOis04kLMXFYJfNd9RG3eKYlqwfInRLhA=;
 b=Cz6xR/z4i2Ju210UqvSvU8GswWz9kTaMqodL+6UwBrx0twTvtmvBGHyQzznELY35btHbtqam0CmjuMFtSE7w1h/4s4zDUhVW5P6NT+c23jxqEaNILiW4KkFIrpYTs8gk+oimcIdlZlOu4UxuIT3KFjeTNCsPLM/daNyvucgfrdC4d4k8DIlRjqW0/NVsZVlXAD4OVCeNXQSun1AZXQdCd5gCfKB1U9iIIhL0k/CogS/4jPsFEQ+ayvMm9qB+LyyJE9h8odAXFmBgawkewiSYCGMAqExMdxNloTP6eZZX9Ybz+dQvxF5wNGuTlQSXXL1nRZkJreZe/UMEm7LkL2HSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEE7RUjN23ZOis04kLMXFYJfNd9RG3eKYlqwfInRLhA=;
 b=ltX+F2wOzj2wxYQR6jVvb8WRvt9+uQ3xOaEW4sohswqMUTK78LLScXZaO0Z3Pz6Viecyh17I+iBzJAuQqP786zl7XtiLv19NmnTZmIrWe521wWdRnUG38pck4bofN5xtoh+76B2PLONtdciPlk1D6tw6/9uVx4Fz6TAWsNqX2ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB3161.namprd12.prod.outlook.com (2603:10b6:5:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 08:03:27 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5332.019; Mon, 13 Jun 2022
 08:03:27 +0000
Message-ID: <55d98218-7032-5d29-fea7-afa7ff1e5ea6@amd.com>
Date: Mon, 13 Jun 2022 10:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdkfd: simplify vm_validate_pt_pd_bos
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220613075956.720375-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220613075956.720375-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR03CA0030.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::40) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9edb58d-01c2-4dee-357a-08da4d133232
X-MS-TrafficTypeDiagnostic: DM6PR12MB3161:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3161EBF7A193146A631DD18E83AB9@DM6PR12MB3161.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdgn2nzoduOJ0BcrWia7hJjWVsVLXQof3Pyy2KtlrG9Se7C3DwKsUKGIFVdIXRobumKrO/wOOy/uFuL/QGcgtmjdmFNaZo+IhHFzCrleXtObU7ZB6L5knNHp57H8y/vMerLdrGi7aL5YmbfWqNvMtpU4CTD/2iMhzntVDTmboI9vDbAo/5uDx9cOej6XywS2Eu2jxOkuYT3ght+EBuwAyITFNGn6/phff7mULD2PJGJPJiRdigVOfBVQtkbEWWuGz+ziZFy3tqrZkLDtQkSbB+GVrZJ2PDcOQHuw+SntIgk0qF8OFt1wARr9W8qTzyGcrcSyfvEJP77I8Y0YFrUE6m0/ln3Lvkqk2lwgTh35rru2qku3YNmzCaBSpVMVArZEfTuaPDnMjxkiMnbnBlNDNouVdnUWi4QuWLwTOTEdxwnuyhw5dxIiFHpSkT3RebYNh3eeXMkkWhX/8Cv6V9hnXs8/XEta0pML4x6YYN3yGowBiiedKxxdE/gE6WFeWkunMKQNoM4h+MEEdCh3+2y/B2W8Ouim5vADStXcCESFm3+/57kZLve5UeuGZNFE222oeKErzS9LSYJLJ+I6gvbCbRzjesL+7wuE1Y25ir2mKg0kJEuMEm3Db2jmEGaYb2cZHibNxaqdvYoAT2nNG8tnx18Ta/WTZ7ebpiW0IBFA3wM339cAejbbjs5CtBDyTa+j8DkbZYUokyzqgsxqTnli4CbdT2bpTcTYf2RZPFaolyslhOOLb+eHzGpvdA8sSkYM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(186003)(86362001)(31696002)(31686004)(54906003)(36756003)(38100700002)(2616005)(8676002)(8936002)(66556008)(4326008)(66476007)(6512007)(5660300002)(83380400001)(26005)(66946007)(2906002)(6506007)(6486002)(508600001)(316002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ljbU1CWGg5WEs4TGhzKzBDSHRzYkRJalQ4Ym00UW1VWmdSQ1BsaVRpRGx4?=
 =?utf-8?B?V29tL3lDUEVBZjlDalZnZXl3SjhGa0hIbEhWTkNtUG1wV3NOUGsvZ0sycEhH?=
 =?utf-8?B?N2QyallZZWg0cVNaeHJ4Q3BvQWZxbEFuNHR3ejk3cDQrQWs2cVBNZ0xZQWUy?=
 =?utf-8?B?UU85N3AvL1c4WHIrSEp0MWhLRGZGS1FLRzRCaVI3NjdlOHVxRlRVeWNyNE5O?=
 =?utf-8?B?SWJJU2JYNk0xMHF4Vk5Bams2TEtGamZxK25nSXU2Z0xVVW1wOFQzdk1OZHlT?=
 =?utf-8?B?ak5mWVBJNlRhT1crT29OdzlTN1ZXOTZpRW1DUXo1VEJYTHlKTWVpTHoyTEN3?=
 =?utf-8?B?dWtMMTBYTEFuZ3pTcE4wclROWVJBMStwQUFlZW9zcEVCUDF3RGF1c2k5YXdC?=
 =?utf-8?B?bktYQmVUZnQxWUVkZ1N6QnhGVzlxdUtaejhHZC96bVAzd0xDeHZXZzJWaU1F?=
 =?utf-8?B?N1FVb010MmJQVEZZQXVmc255RGdRMlZFUjE3L2JnTHkvVGZ6MXFDUkFCYmlJ?=
 =?utf-8?B?VGN0eFo2YVRPMDFtQlVzam9QaG9IdTNRM0RBUiswRVZFaDNEbnRxd1ZXMjFC?=
 =?utf-8?B?NDFOcDU3c01mdG04bi9PSzhXaHlOY3JZWk9sQTg3Ymsva3k4ZStVNFJoT3pD?=
 =?utf-8?B?SlVVemZKU3M2Vy9QN21PSUEzRVNmYlBpWUpLWk0rSXc1dE5VU0lQNzQxRWJl?=
 =?utf-8?B?WkVDL1NXVXdJU0dUVzhvcC9VemRpZmxydzJsYXBqbTRzQTcrU3ZyQVVuc2py?=
 =?utf-8?B?b1ZKNys2ckY4MDBJUS9NNTZtVjhVcTEyRG53d0JQL1orTjlSbzZlU2wrK1RI?=
 =?utf-8?B?UWRpb3VBdC9yUFhaeGJZaXlwVVBNZ1FkcnNaUitrU1JqWlhzQzJmSUE3ajQ5?=
 =?utf-8?B?U2g3ME1TK1VsdU5ING9rMWNPOUxkWHVDKzRPSURwUU9LZWV1aU0vSHVSQkFD?=
 =?utf-8?B?cjZUa3JoTnYvREFpVXNwK0s4L2k5SkdpMnlkZE1Qd0lXVWcvNFdTcElxOGxM?=
 =?utf-8?B?ck5KVGVJRnVIT1RGL1hGV0sxaSt6YU1pdmpmU0w2V1ZyKy82aU5Wc1g5RnlZ?=
 =?utf-8?B?QjNOWnZCWXo1N3ppZ0c4aWpDVWREVU5ENnR2emErTk1GYndhQkFYc3dmMElG?=
 =?utf-8?B?QjM4Q2N5WWpuaGZGQTJXcnYvU3lUY3VtZUZNRHB4RHFKY1pmaVRzaE5xWTVP?=
 =?utf-8?B?aURZNDFZYk50UmRHMCtHVE1xNVRXSjUyMkRMaTY1RXZnNlkvTkIyUy9zZmdL?=
 =?utf-8?B?ajBkNG12NXI0Zy9aMldkUDBRcDJaYU41eHFjUzVkR3BoZUNaR3cvSUNyOHdH?=
 =?utf-8?B?Wi92bDMrV0tJWEJQdHVBUkRsZU1WRWF3OTNOQlZzdktvMEpNWGNTbTE0T1dl?=
 =?utf-8?B?bENjVTEzR0VPODFqcEt4N0E3WE44VEswT3R2cHVUcGd1QllkRHZQYk1Raysy?=
 =?utf-8?B?NE5OOWdWbnNwN3EyNFdVRjNEM2xMRGxleXpGVlZsY1MxRTBRL3Q4Z25XWERu?=
 =?utf-8?B?TkFsclZGVnVFSUNnKzdSb1BYL2NEK1dKUEJMWjZxVFJVUWRsdzZnL2JYeEJU?=
 =?utf-8?B?YWFtMGJIRWp2bVhLRGxWVDlYQUVvL0NyQk4zSmszKy9YaFBGb1VudXB5VGxo?=
 =?utf-8?B?SWwwaUtOeEhJNzVpazAzNDVuNmlBVjlLQm93L1ZSa3J0Z2Q5Z3BEQTRIaHRu?=
 =?utf-8?B?N0oyUGM0em9LcmlLWFdlM2ZXWU5tL0hFdDZULzZlL1VKL200NE1ibUY4UC85?=
 =?utf-8?B?WHFlQkU5K01pVHM4bzdRYkQ1WnRwVWpJdHdJYWh5ZXNCR1o5TlVKTFNIM1FF?=
 =?utf-8?B?a0NjdFlvUXB2NjNvVUNxRkorUHZOOHk3TzJ2eC9OY0pJT3dLRGtPNXJZd0h6?=
 =?utf-8?B?T2IrdzI1RS9PTlBlYVJKRnNHbkFSVGpiM0w1ZkdESnFaYW5iWDIrYUdaQXVB?=
 =?utf-8?B?K3VPbmFJMGJkY0lEcHE0Sm1LdlM3d3g2TnhvUEE5UXdhRzdQY3Y0T2w2Vm4x?=
 =?utf-8?B?aEFzeUhGWllkL0tuQlJ4Q1pYVk42bmF0ZGFnZDI1VFhZVlFaM295YlJicnNq?=
 =?utf-8?B?OVd4N0ZWK3ZnaVF3dTdmbFMyU0gzMXE2RUlIcHNsbnVNU1piOG1maDhTWlJs?=
 =?utf-8?B?U1paVUpGaGRCMWxia2swVW5RTThSUlkwY2R1NVo1UnpJV05BaUF1SWl4NGxS?=
 =?utf-8?B?LzBqMW5UK2F1NnZ2L1Jqdy9PajB2dm4xd0dyRHVqS2p2WVlFWkpENGQ1SWNN?=
 =?utf-8?B?ZG5GeGdQOFFoNUh4a0VZdlRqVTJGVzhzYldzWjJRQnM5ZEFIV3ozalpRWTcr?=
 =?utf-8?B?N2pqd2NhbkZEcHo1N2w3cEFFZWdINVdSYXhoZ0VyRXAzS2NMZFRYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9edb58d-01c2-4dee-357a-08da4d133232
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 08:03:27.0402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtOX4MyxQCRvPxnWOOMNrtWqUxN0zMSwxgDjsZ1gqvxK77KffAKAVabV623t+Rjf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3161
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

Am 13.06.22 um 09:59 schrieb Lang Yu:
> We don't need to validate and map root PD specially here,
> it would be validated and mapped by amdgpu_vm_validate_pt_bos
> if it is evicted.

I'm not sure if that's correct. Traditionally we have handled the root 
PD differently to the rest in the VM.

It doesn't make much sense any more today, but I need to double check if 
that isn't still the case.

Christian.

>
> The special case is when turning a GFX VM to a compute VM,
> if vm_update_mode changed, we need to map the root PD again.
> So just move root PD mapping to amdgpu_vm_make_compute.
>
> v2:
>   - Don't rename vm_validate_pt_pd_bos and make it public.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 --------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +++++
>   2 files changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6a3bd8b9a08f..3805eef9ab69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -425,22 +425,8 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
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
> index 703552f9a6d7..08fda57f5aa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2225,6 +2225,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	} else {
>   		vm->update_funcs = &amdgpu_vm_sdma_funcs;
>   	}
> +
> +	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
> +	if (r)
> +		goto unreserve_bo;
> +
>   	dma_fence_put(vm->last_update);
>   	vm->last_update = NULL;
>   	vm->is_compute_context = true;

