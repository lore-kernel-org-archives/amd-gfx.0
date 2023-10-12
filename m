Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1ADCDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 15:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480C910E4F4;
	Thu, 12 Oct 2023 15:19:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA4510E4F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 15:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6+2tNRlDrTqaZ6i0P1c2rWWFzUPCc1WD8S0g7jzXTooL72vEbfEV693Cjll8wgcfSp5TSexGm1g05GjXYcvWEMvxQ65u/YvBuFH1jYfPClhYZBsUg5b3ZoVC+Ibk9OXLKeYGm1MWZdjfAukU6TerDeb7PtuQK7v0/4XEzU0Ckb7aFFwyvj96XG9HvEJBJQrR/kFkBC/db9GLpCNyIFw5Lt7Wku5o2WZStWmOMYmcM+OScBQCnOV5j1ghEbOsQrbpFSmdJ+lysKiqpoEuRndzfAdSewqtczhAsTAs/jkgZ7oPzroOcB42YLU9/oZHCzF9Q2Wry0SxkxgswjlEjcIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygND7N5JB601f7y4nqO+fzQn7S+oP+Ju2otooj/wTO4=;
 b=cx1ccDgnrjmXmrvV1U2RkJJ24e53j2tYLoykxu5u9RqG6WnWGZkX58XFVTJ4joxMJyC1aWAWVSJk3LUgazzZQ0a/dRJA9s8FPC18orrzunsdQlStGGvnYU6rr5iE8ewfG1WexMxcnwR8TOuSWZJGXPa1JonlKXiRlfVwt3tghUvchJl78m777sV86T/nTv1EUFu3epyYf5VWASoiMMJJygE0CHddKVEwL+8C+wxPa6OJAhk93Kqd20l4ZiWBooKLEFC6iUjBNCEc1+HpcwQUWF5xHgcFw0Fnef71eqV6mIwzmW/7U9RzHddhhdahaFPlAMjc/n/YTsVq2YeJyJ/mRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygND7N5JB601f7y4nqO+fzQn7S+oP+Ju2otooj/wTO4=;
 b=ra/XKhcnZefU5GNoVELkgMhezK3z2MnWkkj4AcP9pqEAs2n3gEUjnioCEbkEy6AvnfN6nTASMiUKL/Vp5KwBU7Eh0l9MLCCI6DsaM2f1CZn9EeBKWzCoCZ7q+JC2/569c5jtVCFqcPHJrfBhzVmpIpXo1RLxHJt7l4py177p1qA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:19:43 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:19:43 +0000
Message-ID: <c7e42f04-9031-da16-2f82-7a616c7d0c50@amd.com>
Date: Thu, 12 Oct 2023 10:19:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Find bo_va before create it when map bo into compute VM
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231011233630.32205-1-xiaogang.chen@amd.com>
 <908fbfed-7d21-4588-9c22-d976d985af93@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <908fbfed-7d21-4588-9c22-d976d985af93@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:806:127::31) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: efea2736-0125-42ed-0eaf-08dbcb36a93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwKE1yI8ku5x6/HCRRf8XLHIhVuTpoj7inLdpwFKQWbC9dpotnCaLHkDW/xri0hwTyNDr4PZ4NYFriY8M9Sz+FXBsl2b55/Y2sbDNbQ9UbY76kfwEeTVNegBMm+iXCh+fOcXtvEJidQopHyi52kIV30O2dwf0E1CbDPj0qC7Mh7L4CZPSbIl6QiF2ZAFYp/NurG0e+3bTCyn44gohUOK47w1n7yABM2fafjlccAYJILbD++Z8nOakWTkB5TyF6FaOfw4+ENoL2O86Szsonh2PiLFkypPZQAxOLTWyIQSCIf2SdgRivPwmaD+DspwGghSky5PNDJiif1zNAsUhVE8FbEJgoN8gG3zUBRGPE9zx15qORTtxNjUtJ7kolbCdJ4d/waxD1vSu86iIlYSpXyLS0p7IaXI1uq/2shCH8STsmiQ3LvVV35IffEEmj2nEaXFlnO+jUtLtmtMMGbAQa4YhtPoYh6Y0oenO8/1BrHHjlFflHkHscKea4XWDYmDlQeRP9/mlKRKZqKZCWYkNjU6AiOxsAsQSEvpzuwlG1AfXLGQiMurITffyvMKFn5kDR4If1d3OWFBvNBZ2+JLeqqX4RWYrv+lKr+mMa4sLC90DGzD9Hm7HlD1O6aKkmCfgbDcLuH1nI1YnVqw8BWqNivsow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(53546011)(2616005)(6512007)(36756003)(31696002)(86362001)(38100700002)(66574015)(2906002)(83380400001)(6486002)(6506007)(478600001)(8936002)(8676002)(316002)(26005)(4326008)(41300700001)(66476007)(66946007)(66556008)(54906003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERJa1lWZjg1OVdacUJlc3VORnRRSVRRUkNMd2F5YndOc0h4ZU1zbERaYmtK?=
 =?utf-8?B?N2txR0diRFZuZTdwc20ydlhhdzJ2cnJ1NzhZYXAwQ3FGYUNEZHhwb1VTVENo?=
 =?utf-8?B?NW5QdjRZdFl2SmpkajU4NkVGUmdjS2R3YXVRSEVTMk1MUjB3dDlRR0RCMzJJ?=
 =?utf-8?B?WURIeWNDanRwZ3FGL0pkc2hEZ3JSeG5Rd2tpd1RmV1hSNUl1OVp5OEtiZmx2?=
 =?utf-8?B?V0ZBT2IrczVNTkN6VTA4ampINWpDWGFLTFR5ZXIveVRIemtzUHJzSHh6bkJT?=
 =?utf-8?B?UUs4dkVxRjJkSnRPZlBkaTBnUWRBWmQ2WStYUHNHWjhVallwN28xTXZJWXlu?=
 =?utf-8?B?cDllSUwxRDhCLzJvb1lneSt2Zk1HTDU5VGthZGFYTHNWckNOOW52NWhXWkpa?=
 =?utf-8?B?TmsreHI4ZWtqRjl1blpIZm04bW1XRzgvdGttenBMb0ZzZ1hrOVROT3VaV1B6?=
 =?utf-8?B?Z2liMjVWMFV4cW9iUXA1eW1HSyt1dlJaZm9xa2hYTjVqcVVYODlpN2NLMFdG?=
 =?utf-8?B?WVpJd3lmTlV2MGZrN011Qks1cFc1VDgzNkxaRVY3UWZXY00reDdXUUY4K2FX?=
 =?utf-8?B?QzgvV0kzbmtybXorTWRKSTdNTTdQNjZtTzQybnYrRjB6OFI4dDkxY1JzTHZv?=
 =?utf-8?B?MmRZSmx4L05iWkpad1VrRjY2UTJQK2lCOWk4K3Fjemp6K3c2MzcybWRJaUNV?=
 =?utf-8?B?bDIvQzJWd2djZk1malhWSUROdkJMaTBDRTJXNHFyaFptWDJrYU1LM2tSTWwy?=
 =?utf-8?B?OUczWHIyOGg1eUs1enBRQURwR2xIcFNMbnhhNGNtQXVlMHdTQmtDSEtXSnFZ?=
 =?utf-8?B?bTFLTHJQbzUzbnE3U1d0VzRjS1ErZHk5ZWpVZEFkSkJlZjZIdGsvMWZXRG53?=
 =?utf-8?B?cDNJMjJKOEU3cGpSRGxEVytVRFBBZWRoZTVYZXRQekl5bWo4aFptMklJN1Rk?=
 =?utf-8?B?WFBjM0kwdVZuenNkQ1J4b2dKSTVWN3lTdjlIQ29UbDNmeitYYjhRT1EzUXNz?=
 =?utf-8?B?ekpQRnBIMldpMWhSZ3hrYm5zellIWEF0WDJCbVZaRHRyc09JQmdwOXBIS2Y2?=
 =?utf-8?B?bGxBRXlWTjFNUDcrc0o3eTRnWXZxelVva2IzV3U3a1J5UU5KL0xGTmtPYUUx?=
 =?utf-8?B?ek85eklrbk5WZk9IL3g3djZxdU4wbVFkWTlRaFZMM1hLaTN6V1ZTSkU4YlRl?=
 =?utf-8?B?bXV1YjkrdTVGWjVoeUx5WFkwMUs4Z29SRlZVMGRFQ3dLWGdRakEwZ0F2WXNB?=
 =?utf-8?B?RDR0ZUliSkdrUkZneGxUd0ZwamxmRzJtc3pZcWx2SDR4TkxaLzFZS0pKYnlW?=
 =?utf-8?B?cXVuQk0wbDVwZkdKOEtKc0NpY0hIY2dyY0Z0c3Y4b0VqclFRREJ2Nyt1ZUs5?=
 =?utf-8?B?NDFYYzd1Z2pFeUpac1U5aXY4VGtSaVlKeDdJYXJFZzNPTlc5L2Z4Nyt3M0gx?=
 =?utf-8?B?TTJLVmlyRVdpUEVEWmEvUE5DOEhsdXlCV2hGTVNaZVZ5cjhKT21sM0gvWTZj?=
 =?utf-8?B?M3NTdTZqU284WlQyWk1TeWQvTnJnTmd6R2tNRzV0emZIazd2OGYzRU5kb1ZR?=
 =?utf-8?B?aVdDN3J6S1lDWFlKa241NnRxV1ltVGVnZkw5WkhhdmIrQ0JLT1VHYmZMdE1O?=
 =?utf-8?B?NVZjL2l5TzAzSnF6dTNnWUJocTZ4d09EYkUwY1V1dHVibUFiS0wvdjdVb2hx?=
 =?utf-8?B?d1dFbEJmb3krV2hMQnF1OTdtSmE5NWgrZVFTa2ZiaXhBeEt1NzkxbjJZSmlv?=
 =?utf-8?B?T3h1eE1hRjRBTElFMnRsY0o2dTc2REZKdUdyRk9iMzJBTUFMQjF3VDdreFlw?=
 =?utf-8?B?S1NqU2tONW9jRzEyNXJXeFBFdk8vMUdKSTN0Z3dFcmZiN0lkelI1RzdUc2tM?=
 =?utf-8?B?c1EySEdiZTdmL0tndWpIbDk3OFNxNzBNcDlHbk50U3FaYXZNdHR0VS9JRFQ5?=
 =?utf-8?B?Qjd3TDdpZVl3V3NnL1RTanA4OGhTUjl1Uzh4QnJVZWNVa0pib1NFMlEzNWFo?=
 =?utf-8?B?NVM2UnlGRVNKbEFZb0plQ2pQNWduMnR3U2gwQzZVUzNwczVRYmMrajN5UjlO?=
 =?utf-8?B?VzF2eHdhMy9ZRVdXMEJxaC9EU2hUTEpnOENyK3grT25Rc1FLREs5UUVCNTJj?=
 =?utf-8?Q?ajm0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efea2736-0125-42ed-0eaf-08dbcb36a93b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:19:43.2565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+x0Y0xmdI5fdlt2eEj3N/YwVzZt1Qgcz7nicUoCJIzs2xteA64ejqFE0BlB+M0C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/12/2023 2:35 AM, Christian König wrote:
> The subject line somehow got messed up. There should be an drm/amdgpu: 
> or drm/amdkfd: prefix.

yes, will resend it.

Regards

Xiaogang.

>
> Regards,
> Christian.
>
> Am 12.10.23 um 01:36 schrieb Xiaogang.Chen:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> This is needed to correctly handle BOs imported into compute VM from 
>> gfx.
>> Both kfd and gfx should use same bo_va when map the Bos into same VM, 
>> otherwise
>> we may trigger kernel general protection when iterate mappings from 
>> bo_va.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>> Reviewed-By: Xiaogang Chen <Xiaogang.Chen@amd.com>
>> Tested-By: Xiaogang Chen <Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index a15e59abe70a..c1ec93cc50ae 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -832,6 +832,7 @@ static int kfd_mem_attach(struct amdgpu_device 
>> *adev, struct kgd_mem *mem,
>>       uint64_t va = mem->va;
>>       struct kfd_mem_attachment *attachment[2] = {NULL, NULL};
>>       struct amdgpu_bo *bo[2] = {NULL, NULL};
>> +    struct amdgpu_bo_va *bo_va;
>>       bool same_hive = false;
>>       int i, ret;
>>   @@ -919,7 +920,13 @@ static int kfd_mem_attach(struct amdgpu_device 
>> *adev, struct kgd_mem *mem,
>>               pr_debug("Unable to reserve BO during memory attach");
>>               goto unwind;
>>           }
>> -        attachment[i]->bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
>> +        bo_va = amdgpu_vm_bo_find(vm, bo[i]);
>> +        if (!bo_va)
>> +            bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
>> +        else
>> +            ++bo_va->ref_count;
>> +        attachment[i]->bo_va = bo_va;
>> +
>>           amdgpu_bo_unreserve(bo[i]);
>>           if (unlikely(!attachment[i]->bo_va)) {
>>               ret = -ENOMEM;
>> @@ -943,7 +950,8 @@ static int kfd_mem_attach(struct amdgpu_device 
>> *adev, struct kgd_mem *mem,
>>               continue;
>>           if (attachment[i]->bo_va) {
>>               amdgpu_bo_reserve(bo[i], true);
>> -            amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
>> +            if (--attachment[i]->bo_va->ref_count == 0)
>> +                amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
>>               amdgpu_bo_unreserve(bo[i]);
>>               list_del(&attachment[i]->list);
>>           }
>
