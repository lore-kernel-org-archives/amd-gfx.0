Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D94CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 18:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1EE10E51E;
	Thu, 12 Oct 2023 18:01:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A20310E51E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 18:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EynnzRzpNUAHf18g90xpozcaHCDrlEImAODcnKvXeUKkvyILRQRbzgnT7PgNb/W73MY1YXiy2JH8ppXCLIa3PWtB7026rlxpq8zTvqyrLJvYohj4JEfB3B8wk2O02bagdyXmSINV5jtXHqZoGtWzxJzEMKrtvNanmWwfXVjUsVUiABg6A2Czl0T8C0jG3wUU3rSgyrJFyPkrvRuQGYfEAvqRmkzawojbgTFo0o8OTTWYVWsy3MvUF9caZXVuSH2I5jSz4zGVKLUSfyO9jwEVAmZMRuz7UeCDJTIQKtlL1d3tu2wdvV0CyvHO9vl1WdaEm06M1klKlIXqN2CNHtmzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZZpHzW3T2GY6o6kdZNUDh4DWBSN48rjWzqOVYWNyrk=;
 b=bvRYEvHxofGVrnS6pwd23gqR+IuBGhETVrtkcUSWdWxBOUx1J89lMW969/pS98zzI26A0lIlwJhvRpjeV8mxyHEBr/2BLM9cSF1QmesX6VXknbL3PYt1ShjQeguE9G/qZpVclS0YDUBtz8pQqIKVeKM09YmFsEiR23LIXMJuhK+AoabEGRHqIWQ466l7dckMgfnsNLstChyOUJio7uQX8uNe/xZuYtmxiN97SxVl4IiBP897bkEfGKRKbFTsOORYYspDVXQzxdBGHVHAtRem/Fo5tGkynISQHWTgMn4LtfDzO1UA1VUj1th1wR0TOi+13+uxrF+UJuzuCeTab5mquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZZpHzW3T2GY6o6kdZNUDh4DWBSN48rjWzqOVYWNyrk=;
 b=S2jMb1QiWYZWDgZhtqI/ds02RZ9/16vAB0PtAqCqEopaVw0LCK/balPglxlJrw7GMWffy1ImYOhnAJpeOVqf5ilSkNqHeojV83jN/pK/AKh463NdsZEoEZejat8BRp41DH+M/EiFBOdDEKkUT6jGxxygrUhSq9bDLx76YJgos/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 12 Oct 2023 18:01:41 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 18:01:41 +0000
Message-ID: <3112bae3-1756-32d0-e4b5-6264a1307a7c@amd.com>
Date: Thu, 12 Oct 2023 13:01:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/amdgpu: Correctly use bo_va->ref_count in compute
 VMs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231012163402.24058-1-xiaogang.chen@amd.com>
 <b8d15aac-1761-4ba9-81c0-bbf8ab43c0ff@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <b8d15aac-1761-4ba9-81c0-bbf8ab43c0ff@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:806:130::27) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|CH2PR12MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fa81a6-f48c-411d-9ac6-08dbcb4d49bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnFhBF/2BcOxKfaPpr52Ydlq99Txx9Mgbae4GYQnM3DK6DQEun1wlSl22hD1v0NXat31mBGfz9aFyeziP9421eV/fUjrTiGn926VXLCpuGm/mLNM387cjLZxtvXOMhMBUCamBdnj7IQ7wl6Anb79lD6IZWadIQqFCL14RLPTpwwTm6fran54R0EJYE7U39+Sp3FfcvV8QN6rQpYVWDotE8PyU4MehbaaXejyeAklkUkEiH/XJ7RXMrgK8DIsyGA3bOKcgV3KRsReXNw0tgSeUTbIww5V+KkFx0+qVhI6nnvLFFhK9Adm752wF/qNnzFJ8GcwOuz9klGLe7EhjAkjWXDv06Ow6iq7i3krvI+1S751CbmqWwjQ9YZ7+8uJZWs2vLEVNv2QEI3kxIh89q6unf3xJB/+40NTIQVRuamxk76qIBZDZq1jSMmu8sWjT8VSMplPz7Au05/nMKJT5V+FDMwIfh49jfRL9jb0mL4kEHs7ChEiSHI4znd6/c7H7BFyui5c7kdG4A3P++23wck5f8BVL8Lam0bl5MDCm5VFIm5CuuA1P9uG5V24SryZ4Z94nCyPRyqMGiTRamrUBKcy0PXmzVWmY1qkC3NugGaPhDr/vdy1FPAji4BtTviS9Zq74ZEudbsFoFZMBJts3KR2Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(53546011)(6506007)(41300700001)(2906002)(66476007)(66556008)(66946007)(4326008)(31686004)(66574015)(26005)(478600001)(5660300002)(6512007)(6486002)(4001150100001)(83380400001)(316002)(36756003)(54906003)(38100700002)(8676002)(31696002)(86362001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVUzVFFCQk4wRzUxR2V4K1htZ1Y5djZsV0cvQitsWUJyS2ZzUW9lbWx2RC94?=
 =?utf-8?B?WDM2ZFlxamVwZGxpM3JYU0hYeWhpVnV5dHREU0VKZVc4ODZQbU1FcGRoUVZl?=
 =?utf-8?B?blQ3Ym9ac3dvMktGcStjZVM4TjNiam9qaXVGalRBRHNGaC8wejdWblQvWkhO?=
 =?utf-8?B?ZVhnNFNZbmFnTHM5VXZERzgxOUtyejUzalcwL2tjOHpIUFhxQlNTZm9EQVF5?=
 =?utf-8?B?a2hQWU1KQzlGS2VUMU0zd3RHcEZWeVo5L0xOOVNJUlNsMFBLd1JoL3d2emJu?=
 =?utf-8?B?cHdKb01vUnlCZTZYTXBReXRUVFc0SGhJaWlsekNsc3p1cFB6RklSamdkWmti?=
 =?utf-8?B?K295NTBDbW9KNVlOT0liYjNzMUgweEZYNGxVOWRubEhnMWJYTW1DRHg3ejF2?=
 =?utf-8?B?eTRvcnlveldzck9sYVhzMHRRQW0rUkExU0RhazdTZ3J4ajcvaVIvWTFKMk0y?=
 =?utf-8?B?cGltNHRmcnB3UGY0b3I4M3ZVMlJudFFqdkhMYVlVbmRwMHpQekllOE4rZnV0?=
 =?utf-8?B?YmYxVTNycTlNcUtsUHRkNmlveFE1SGF6c3RNUUdNbzhNR2xkcU9sVXNGYitV?=
 =?utf-8?B?Z0tnd05wQmxCRWozTnZHMllaQnVJb2s1NDg4dlRQZUkyRFoySmZoeTNYUjM3?=
 =?utf-8?B?d2xPTS9lcHRSOElOMVpzU0RtSHRvaWhPT0RxQTZUSnNOb1JTMFVnUXA2ejBn?=
 =?utf-8?B?UUdDZVVJSlh0Z1FrMDBoamdaSnY4WU9CS3hha1RKVmZla2pLVDYzZm1IUys0?=
 =?utf-8?B?YjVHNWdSWG1GSVI5U1ZZbVdndmwyNGFqZStxV2NCMWFZYzJUVlF1MHRVbnNU?=
 =?utf-8?B?L0NhVk45aE5jZ2dBNnZKcmNZMFdwcUphZDZJOG5LOFRkQm9wVm9GZUxnMmIr?=
 =?utf-8?B?NTlJVVdBMUhQczdPalhIUExCV3lya3p6dGhmTXNZa1dpcjhHdGlPcFlZaDZT?=
 =?utf-8?B?T3R0TjRYd3hEd0p1dGpyOG9LQU9SaGZtYi85b0RNMkkydHAwZlRBVXg3dEVo?=
 =?utf-8?B?bVhlcFFSL2VHQjhIRE94WFpCMU9qY1l2clVUN1g0d0phbUNDTkFIWjlZYXlz?=
 =?utf-8?B?MGwwOXNpamRraTA3Z0lsa1REK2xPMjMvSjRVeFVoQVF6bnIrdFdWcUR3SnlB?=
 =?utf-8?B?cDUxdEYxOGpCNGRLa0IvUDRWb013MEE1UTZJK01WWnRuS3YwajhnY2pGM0JP?=
 =?utf-8?B?aUd0SVRBazdsVUVGbTZLd3VVdWVnZ1l1UHRCdDNZZ2p3N0IyemNNaCtqM3hh?=
 =?utf-8?B?K3VpNVdmUFNKcGRHRVpLd1l2RFc2UXVnc0R0MCtJbktmQXBlNXdBcHRXRFpZ?=
 =?utf-8?B?OHNRNmxPdHpuTUQvc2dGNjNtdmgrNWE3MnJ3VVJMK1dTd1h4bGtiRlU3dkdH?=
 =?utf-8?B?VmNYOXdIZjJ4aTYwTDVxeEwzUXdYL1BsTnlqRHpZSkJlR2pLekEvcStTMG9i?=
 =?utf-8?B?ZkhJeC9aR21XQVdZNFNoY0xLSW5ZUHNNWTFZblRZY2dMZ29tR2NPZHNGaEJt?=
 =?utf-8?B?TlZqVkNRZFU4TUh6ME82TjBKeGszRE11QXZGMnN6VUpxMDdKTWQvQnRRdEQy?=
 =?utf-8?B?UDlxeHpjdWZZbmw3bnZ4enRkVlJpVW1VUzB5dFU0YWlPMTAwaU1DOW1oMjRC?=
 =?utf-8?B?QitRV3kyQjlmbzAvcnlienVkSWJRQUxyVnkwZlBvclk1NndqZWhIZlR6NEVI?=
 =?utf-8?B?SFZ1ak8rY0o3Wm1LVkJoRDYvQk5salVMczVwdEk5YmxnbjlMM1JEYkloWG9w?=
 =?utf-8?B?RlZPT09ZVDR2dmFmMUpjNzY3Y1dHeHdZaWpsbzJ4L1JFRXVIZktYRXlEcXU5?=
 =?utf-8?B?SXB4K0prcEJCZXBERjErZmJzczRjVS9mTmpYaENUbkFQdkt4NDJZNjhnZXFJ?=
 =?utf-8?B?SGxnQkRVQmVMK0RpSTRvTXVrY1pQa2JnbHM0bjRzSjBYaUp4WHVDL2NUNURO?=
 =?utf-8?B?Mk56TjNaTitRMVZ2YVlFb3ArZDE4Y3ZyS2NzaEN5YWNCamMweVdoblFvdUcy?=
 =?utf-8?B?S3dxbXE2MVFQRnJ2QVQrbWJWTXk3bmUyRUpFMGpQYmVoWndoSlR4dlZwdFFk?=
 =?utf-8?B?Z2ZlNU9tbmUyc1lyTXVHT3lPVGR6WUc2bG9kblorZGd4bG5XT1pNa25mdTR1?=
 =?utf-8?Q?H5N0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fa81a6-f48c-411d-9ac6-08dbcb4d49bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 18:01:41.4801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHvBWQF7sDEvI1C0prZ17dBW+lknYMgKGZWvlBVo0nSbdQO7lYcd5HkxMIn1IEz7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/12/2023 12:48 PM, Felix Kuehling wrote:
> On 2023-10-12 12:34, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> This is needed to correctly handle BOs imported into compute VM from 
>> gfx.
>> Both kfd and gfx should use same bo_va and set bo_va->ref_count 
>> correctly
>> when map the Bos into same VM, otherwise we may trigger kernel general
>> protection when iterate mappings over bo_va's valids or invalids list.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>> Tested-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>
> Not sure if it makes sense to add my Reviewed-by, given that I mostly 
> wrote this patch. But feel free to submit this to the branch.
>
ok, will submit it.

Thanks

Xiaogang

> Thanks,
>   Felix
>
>
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
