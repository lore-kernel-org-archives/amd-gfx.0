Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6776DC7EE22
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 12:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29D410E5ED;
	Fri,  5 May 2023 12:46:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 667AB10E5ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 12:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAAO5EfoSFOgNM02f9qq0acrgH4VOXsKaLsVnTD2Fken9pG4IeomN63Mf1G1Xo4NGKUMLB3ehrYcsxMRKP7tp3mKKbz7I/a6ONHSFKqDXMGQNyVH8Ac34ciuLgdDDAnT9FeePlSGyQhicnMLFPhMWD5aaRopIOBsN917u0iUn5qBoNmh6jfuWl0S/MXylFCmkBQXCihhFk1M6fzMXrep1tDfToC4etvjgbtdhNBrG/fZSAJdQyplBKQAPbxqK7zLpKvIyv9OyuQIJGQ0xMQJejLwsjlyyYZ4mgRJaVA+hLHRCr9Cy/riq8A12oUoqpY7q7s1vj25TKC+75Q9cyQFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcsGXHJ4Y3nS2nPykjoiUqFs3hAtUL8vY/r2I14dPVk=;
 b=NaeTBiUmawhZNDLXlr+15lvOq9me3coW8f2sd87j+4v0riTXX1TgYwn74WilSTzVv1f0HqrOYlJJqzQc/et43ZZQ4b3w3M8tcJUZSflAEkNzFdrQIJG3JEqcpOEMJPQus7XlMy174cm34SHNpfMhrOHwQ6Y0sjGdcDR6RZ6QWU0pyHe7t8I04Hhv/kLMB2LVG/nJhDW6+nDFJgGSUvUoCk+mEuP/8PD0Ol2IK2AMDK5xfQF4htzrfQfbkVyi6cw+vWKvRAE9VGRbj8zlmqnao7IfHzkEYpa5OmmbHQ9VpATq3mU3E8KwkLFY3q9o6XR61x4h+WajjKS8aU5BMQvkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcsGXHJ4Y3nS2nPykjoiUqFs3hAtUL8vY/r2I14dPVk=;
 b=g0mIcaZeWG/AI0RUv///YzqHhRFxKsENe4OpjZT+x3zxFyetxHwHyyFJz8LE1i7HZZN3uw4eJrBRrr71DrJlphUK0abNkJXuRXWSMUEU10IQSEJQKwdoHph6z3IT/yXr+ktmKQr4gyc6SJKmwJhXXZF3qbE/j0wYMoF88q5ui54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 12:46:41 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 12:46:41 +0000
Message-ID: <0a347c54-0d08-98bf-2125-34ce13fd3f67@amd.com>
Date: Fri, 5 May 2023 14:46:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: install stub fence into potential unused
 fence pointers
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230505124407.44496-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230505124407.44496-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BN9PR12MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecbaba8-6ff7-438a-1a01-08db4d66c5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8drCsA6eaaDHYX16d0fqM6UXhgSkP0pTyNi+4bb6cjPCZ6cDXkj9qK1kwfR8Lau0J22N7hSGf8WNyuQAVcELHK6FokDRRL41Lc+5nJsY9OPEC0mCmWUPFzD+Tx08OCQmYwwtmRY2uq3nJbBu0gaXjnEvpUXEAQFBxQzXL7UpOk6rIxV5y39YZuZktOwnsW2ZKyx/SqpB8ejclYXIrO6+S7SDbngV3k5rOAqPuGHJt0D9F0z8cFTmYMikZvaUnwIc6NRjvnhEye90Y1qYm0POHiUITT0rH5t6sX3s1t11/DBSEgYi+R4x1UCpDRD4Pb4/E1+rhhdBKTXB+bxe/8RzgLFNjpu1d1G9kF31aj+LR4H9lx8z/046euQbk2TIjcpMA8GFbDOGgMvm/3Td73kv9l0tGdpOzneCrJRugJKxw91dL+fB/7/vsOqMLavxfRmP/dbDnmroX72tF7bZmrDvbuvwF0bKvqGLyEFkDDwqiBvVrrgvBNnN4tsbBpFctfkBYRRIS2YcLQebWamw8QaqSgF3hi6rSttxLgQvTBzrLhJ5SKG3tJ6AupDupOVnOSk7VgaFBvp4KtopGh/97uMY9zj6lMvqCrXHUsi82wl6kYgHqgi+qpEs7SCgoSDq/56i+ixCjlP3W6NtlczdwuT2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(31686004)(66946007)(66556008)(66476007)(6666004)(478600001)(316002)(36756003)(6486002)(86362001)(31696002)(66574015)(83380400001)(2616005)(6512007)(6506007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnVpWDBGZFJWMUsvYm1zcnVpcGw0djJXc0trYzI4SksrVXBlMkFLalI5dk11?=
 =?utf-8?B?ZnhlanI2MnlTTExrYXJlbFRZaGVqMnpqemRzbnJvUk9jRlF0Vkp2cXhMOE1O?=
 =?utf-8?B?Q2xVNk5WWGJEc2ZFUnBNSCtNTWNoUy9hVEdlOGs3YjdmejNoMnc3a2V6OXlU?=
 =?utf-8?B?MnV5R1lHSFBRdmxBVFR4UmJzcUVLNnhNYzBuTGs4QURmazRKR21hemNxUWFK?=
 =?utf-8?B?ZC9ZSG5lWnBPdUltOUhYdnVGcW5iM3hFdUhKUFFVSDlhb0xBUTdvUEZKUE1S?=
 =?utf-8?B?ZzlxbVl2VHFDZTdDQURydTRRVldFQkwxbnk0eXFQbEE1SzdkUGJzb3cvWnpt?=
 =?utf-8?B?NHhCT3BQdmFBYmxweWZTK01CdTZhSWlQTWRrSEJXNk9malJnMGxHemhpaVVN?=
 =?utf-8?B?R1RwT1hXWWp2YjhkNnZXT1d5bnA3OTVNaDBHYVZtNlJUZWxRTVFMT1lXdXRX?=
 =?utf-8?B?RkE4enVsQWVsU2dqZEhheEU1SyswS2ZPMDZjdXIrNDQrYkk0NWlBb2FSVUxY?=
 =?utf-8?B?bGNSNzZpQWFDUXJLcHdSZW92SmV1TmZ4OXZ3VFErUTJxVU4zQ2JTaStTMllD?=
 =?utf-8?B?YWFDaHVINUZnQVZOdkVVNEdlcWFjdHV2c1NwYjV3REVUc2xaQTdtTkk3NUFK?=
 =?utf-8?B?VzVLK3R1Q09Lek9FcXgvWGlGTE9MRUVMOE53UjU1aGNGcEw2OTA2VndvcGw2?=
 =?utf-8?B?bWYrMG1uSTl6cEYzc1MzZURDSXZhK01IbnFyVjgrb3QxTFZZeVllUkJOcHpQ?=
 =?utf-8?B?Y2I3aWZrdWNCMlBuQ3hPVUdLUWtxdS9oQnpnYXdZSE9vZlhCclp3TXNJNU5R?=
 =?utf-8?B?bGVhRGZpcmNMVG5jMXE0ZWVaUmZ2cGNrMHh4K1QrYTJuckpLOTJ4bE5iTFFx?=
 =?utf-8?B?SktjU1Vhd29jYzNxYW9DNE9jb3cxdkNLV0QvQi91S1hQRFRveEhXMG5qTEtR?=
 =?utf-8?B?eExOUGFRV1c1anh0V3pkZWJpM1o5Y3BaV1FRSndEME9LNjdyQTUvY0pLR2NP?=
 =?utf-8?B?cDFoVC9remhsZExxZ0pEOVFpc24wbjd0VUd0bjVpNTQ0S1BwR2dISjd4Ukg4?=
 =?utf-8?B?QnN0czdZd0NrNkpXZHNiTWV1ekF5TE5CMENLRDQ2UjZUSHdhMStIYVpBZTVi?=
 =?utf-8?B?TjZsNkJIdjhPTjNLZ2g0K3VXbHlPRjUzbGF3bTVnSW1ZQ2QzN1ExbmdHdDZS?=
 =?utf-8?B?ZlU4dXFCVnB5NzN4WmR3T2VDRFZ1ems1U1ZGdDdmNDVlS3N3ZEhFaldaUDR0?=
 =?utf-8?B?K0R6RE9LUmMzRStyUnp4TEs2NDlZQTB3aU9pV3lxUzZta201NklBWFFXNk9q?=
 =?utf-8?B?RTZTbkFQYUVzKzBSQVNma1ErWG1peWloWHdTVmhBcnl2QUlFSjc1MU5iODRW?=
 =?utf-8?B?YXliNXI3YzNqRUhYN3RjU0JDTndjU2N6Q2w4ZExlTDhqSmxZdm13NUZsQ3R4?=
 =?utf-8?B?S2lSK2ovclBQWmpvbDlzL3JhRjlZRTBOV3FCNld5b0FFZThMRkh1ZWZDSUlE?=
 =?utf-8?B?Q25LZXJuSlJSOU1td2VGV2ZNM0hxelF5aEl6YjJ6MWJsYVgxTG5wOExTZFgr?=
 =?utf-8?B?Rk5DVkVhZiswZTdHNmZHZ0FJeG54dVNnM2QyMVNlNE4wNE9sOGYzUFdZVERt?=
 =?utf-8?B?ei9DUGVjK0FCVk5pOVNuT215OU5KOWpQczdtSmh5RlJpZUZBMHkwUTVmK3lX?=
 =?utf-8?B?RmNsOTRJK2E3SCtqa3F1MHZOeTA1ZUZKU0NUVkpNTGZZR1JwdzhxcjBmNlFQ?=
 =?utf-8?B?VGdmWGs4OGpXaHF6dlBXd2hySy9sSjNmam5paTZSVjBrSFRJVllmRlNMeE5r?=
 =?utf-8?B?ZG85cDdrRU51MUNlMzBGQWlGUnVVM0IrMElTM1NzYi9nc0FSMld4amdFWDJI?=
 =?utf-8?B?QWo2WS9ROHNSSjdiMll6R0F3dXVLRWtTdkR0K0VSN0pLSisvWnk0aitiaTlP?=
 =?utf-8?B?dC81enBsQitqWEpvVWUwUlRFRGNlMkdNZHpoMnNFU2xrUGFYakxoUGNtcHVR?=
 =?utf-8?B?dU91VjVEcnF5SCtIdFQ3dmV0Zmh6U205RExscDlpOERKM1NZbVFnb0RHVlo5?=
 =?utf-8?B?Tm1qK3pFWjVMZzU4QVUxSHBacllrNTZuWmtjVVFjMkY2ZkRlUDRtdVNIUEJK?=
 =?utf-8?B?TVl2d01MUmxmdzNlQ09SY1dGWEx2a2kxc3hxMmRKSmNoMG5VMW9qTzh2ZGoy?=
 =?utf-8?Q?DQ41PJTY2Rrk6UL51Ec9Q1nzqW+wJQ+sYZ0Jr4ihukRt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecbaba8-6ff7-438a-1a01-08db4d66c5fd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 12:46:40.9163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAqhIaMd7Ox6j++/+LmEmqXaP4RDbNvtIOcfFGcIMGffU2+dSRrwcFdDKHkZXE0P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
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

Am 05.05.23 um 14:44 schrieb Lang Yu:
> When using cpu to update page tables, vm update fences are unused.
> Install stub fence into these fence pointers instead of NULL
> to avoid NULL dereference when calling dma_fence_wait() on them.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 78daf6e2f337..aae70a16fd46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1444,6 +1444,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>   	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo);
>   
>   	bo_va->ref_count = 1;
> +	bo_va->last_pt_update = dma_fence_get_stub();
>   	INIT_LIST_HEAD(&bo_va->valids);
>   	INIT_LIST_HEAD(&bo_va->invalids);
>   
> @@ -2144,7 +2145,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		vm->update_funcs = &amdgpu_vm_cpu_funcs;
>   	else
>   		vm->update_funcs = &amdgpu_vm_sdma_funcs;
> -	vm->last_update = NULL;
> +
> +	vm->last_update = dma_fence_get_stub();
>   	vm->last_unlocked = dma_fence_get_stub();
>   	vm->last_tlb_flush = dma_fence_get_stub();
>   	vm->generation = 0;
> @@ -2267,7 +2269,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		goto unreserve_bo;
>   
>   	dma_fence_put(vm->last_update);
> -	vm->last_update = NULL;
> +	vm->last_update = dma_fence_get_stub();
>   	vm->is_compute_context = true;
>   
>   	/* Free the shadow bo for compute VM */

