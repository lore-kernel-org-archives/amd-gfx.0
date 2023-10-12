Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74C7CDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 15:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421AF10E032;
	Thu, 12 Oct 2023 15:40:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691CB10E032
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 15:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfUhFHyPkR+/gsL7wgDl5T9sDHiUlNuDJbplvE6atpMz8PJnch+G+tPltZ54Ij+o38JBl0hIRb9e1jhPgn+Is9PZMEPgvdrWW/58IySU3B49BfqVzHs0d0V5P+6gjdkVaF516n4DdgPtehpCXWoUxki8AfA5J1WTbqJstNqRbW4onq0XP4ZKE/KZQYxHJo6qKcm36H0AkAbUg8HThxIkrP/tII015Ll3M7X+Hrf4rGbrN0IqgRwrR57jJHdU9mdq6r2WRbPSB8NagLfCg3HfGHPASJy4Ql/wm4bNgTzoi6k1Rnfzk25W3etF5TmYXbrow4O5KpfEFh/BNHQyZ6GVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZqDAeAeZPzzFbNjn/05Vcn+gkpc2ULnp1rMD+VVMe4=;
 b=a5ihavaZDKIjKKN8feLmKQrwIU/xJ854b8GtX8bjVk3hrUy1t/Y8dhDd+1heOkp4PYGCdGYE5InnSfOn02TwazIpiq2hvF9TQThJ5zDVGUP2BA47hwa6XyBUTTweOl4CAdS8shoQMxDy1yLYAAXLYR33qmJr8FQh/AnGSVvH+kZWpN1d0+YS5oh+B+jyiQVm78gwjX0Ke5FFh8qsDntBa7MEFHzdJ201aq3ftY/jxmIwgm6NRGFF/vB/vwY1wWggWb19H1/yhaCfkZamTNFW83+ttCG9plm+GXrOI60h+a75EtE+swEceYQydbr1KpIRs5YCfx7vDaZ2uZLZABo5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZqDAeAeZPzzFbNjn/05Vcn+gkpc2ULnp1rMD+VVMe4=;
 b=fdn63EiAENOzGMyiuYlHGOOGbfylap999o55elKqNeYoYOE/yVY0XkZGrGO749pQ46rMAnIN8SauRE4sB/9cAagxDWz0DyHsDzA8NbdSBVeyrSwDbS0UWh5KxGOYCHQ7rfb4sWXVFpclUdWKsJvrPAnpC2voSFfFZY2OFsXIzLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 12 Oct 2023 15:39:58 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:39:58 +0000
Message-ID: <9fb69efe-a8ae-fdf7-358b-2914473b3949@amd.com>
Date: Thu, 12 Oct 2023 10:39:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Find bo_va before create it when map bo into compute VM
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231011233630.32205-1-xiaogang.chen@amd.com>
 <befb06a4-a970-4251-b195-50c0cb375b25@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <befb06a4-a970-4251-b195-50c0cb375b25@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:806:6f::6) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d09628-8313-4723-def0-08dbcb397dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWzfek46xNR/ALDimmeE5ZhBWZ3TMIkDwFcUIER4zCTUFB/VX6tpRsrxkMThoWqSDZW5iSeoG5zjmzcBJM7hy3ceXN1e5mRrNRDxyIIvBpLgwJCpClUBF204B6xYdzfx4n1P4PuU8yT+u3g4n+uDfLim/yxwcqDYpneUpIdJSDTr+pc2Si1eJ6VD+ufyh6Wn4s+98uhfyLcvUfAcds1GksOker11J2SPS+imB/uW9Z9CAc8EWjNPO0pLjQj9dEmeJgsncyxHjbaZkdQVVAFDO3zHeDyo1VpirsvABpRDYx2pIgcMNClHOmwT7EV0cc9kLmdy7XUrTtvjT0q9RZCf0vf5/Cy9q+APc1lHbMttMCcFGz7TpsGF7K7gFXTGv7qPSHkuRFNZqxC9URcNRpyFjCvrRhgbwfinZchHXuVpwYfVaJv/A1U03YefUpm/qOXPfBPycLEw87pWPobn029AMHQYtir/udo+myatX22IofiLxjzAO0FXC33noH6SEdA3scz/0Xi6N7sjDmiYgfQI+SuGe6G/G+n7SsyBr8oKDEBamRPpeGpzSumZEofGPvRSxKPq4Z8yf2ISl4CY6I4O4qxSsXsonQca0fIttjkrF+AzZ1hAL8HAr17a190YIa5WB1NxOYOYsOCYcvDQpypcNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(6486002)(6666004)(66946007)(66556008)(66476007)(54906003)(6506007)(26005)(2616005)(66574015)(316002)(53546011)(6512007)(4326008)(8676002)(8936002)(41300700001)(4001150100001)(5660300002)(2906002)(36756003)(38100700002)(86362001)(31696002)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzN0SGVjenB0L3k2UERjc2Jxdmh3dHZ6dVFiejIwTFpoZ1dtTE1MTDErcVV0?=
 =?utf-8?B?LzFSUVFZSnhUVUZiY09reFJ3THhHdjAxZnNqZmN0RitpZEhtZUVkWkU3Y1ZM?=
 =?utf-8?B?WElPTm9Pbzd6WmRJOGljVzVPQ1Y1S3BjRU1sUm1DaGNWVnNyVE05b2czKys1?=
 =?utf-8?B?Z3lLdE1lUWVTWFJDc3BtYkZ6Z0pzdDQvaGtDMnE3dktFQ0J3R0FEZnVNYWRr?=
 =?utf-8?B?aEEzUXFvYTF2TE5FTnMzVXlISFZWTUNZMGlzSDNFUmQwSmpKVHROWDJvdDRD?=
 =?utf-8?B?a1RtamUweGtrYUh4ZjhDVm1Ndi83YzRpcE9OQjd1WTJZVHFxTWpIc0FRUEhN?=
 =?utf-8?B?a2tnTmc3T1hjc0ViS1RSZU9ncDFRdU1SQlUyeUI4ajdiWGlPajVwanljY3Jx?=
 =?utf-8?B?NmR5OUxoenQwbjZwb2k0VTZlMFZiSnl2R2wwV3BrQkcrUzBBbEtvVk9xUEpi?=
 =?utf-8?B?czAwYTJ3cXJmbndHemUwcThaZWI4U2xYd3dFMXVEOGdlcDB6QWJVdTVtaHZo?=
 =?utf-8?B?MWpWcWRwejNRQ2ZMMDN4c1QxMER1a0JPNHJhY0VYRTZydmZXSzZrRTFmSDZ5?=
 =?utf-8?B?N3A3LzFKU3JEUVpCQXVhTUl1YS9VZlpsVngxWnZ3MHdENmkzSW1qUHNvZFhy?=
 =?utf-8?B?YXJFSUxaUFBSNEIvWS9KNzF5d3cvbVJpVjJKYk12RHY4VkNKTStkSEQzUmVx?=
 =?utf-8?B?cFc0clBvck5vZXUyV3hXTHhrbThvNjNveUJSRG1IWmUzQ3drcEpkVlVNZ2RO?=
 =?utf-8?B?aUs3WXF5UEdWVDJHdFhJUUc5V2NFaW5rTFFkcXlDRmtoZ3dCQyt2Y2l6bW9P?=
 =?utf-8?B?R0VmL2YwV0pmNEplRklSem9nVElmVlZkSUh2TnRBVXI2NlljSVF6OFlGZ1c2?=
 =?utf-8?B?blNtL1Q3Wm53dWxrNzJtSC84WWlTVWZsM1hVczlBTVl5bXYxN2pjbFBKT2hk?=
 =?utf-8?B?Ni8zVHVFYjlFeUxHbE1xajB6OWJ6c2wra1VTdTlxclBUYncxVzdUMW1saUpL?=
 =?utf-8?B?aGFORlp5NUJrdHN4STdxdzk5ZXRCMGE5eUlleFlrNS92TGhxQW1odm5sOTdE?=
 =?utf-8?B?Vko1TVYvZ2owWVppeU4wOThLb0trWWFzT3ZORzlZSXNyMjJmZHAwZ0NFRHFW?=
 =?utf-8?B?Q1NmL21zajc1Q0tuSC9lRmFNdGdQQ3FId21pVXZxRFBLd0VyMUU3RndPOUEv?=
 =?utf-8?B?ZVh3YnZFbXlkL3RRWmlxdVFJQ3lvSzB3alI5VWkyWjRLSU1rRkcwQThMcENy?=
 =?utf-8?B?TENpRElpdGRFa3lQcXZuaGJiK2ZWUyswN1YwZ3ZQVGVFQ250UkFDeGIxT0dB?=
 =?utf-8?B?cGYrSVpOcTlEempWbGUrc0NKdkVyUlRvTE1WUGlZUkdvNW5mb3hhM2o2SHA1?=
 =?utf-8?B?NGJVZEJabm1sNzNaMW1jbHMyaU0vemFpZGNQYlBDajF3MWd6OTBkcVZRc0pI?=
 =?utf-8?B?QVBWV08zMklhOWJGb1BtOW5JUUZsb05JblFEZGJRUTRtQnVMSTVGRWV2WWhl?=
 =?utf-8?B?bVZ6MmFkWExRUlkyRnJLaFlMZmJLN0JjOWFFdlFXQk1wekpmelNHb2xLamZL?=
 =?utf-8?B?czRFbXJFWFRjSW9hdFYxc2VtMEhkUGZtMUpoMEhPUklyTmZKSEo1eUVGb1hD?=
 =?utf-8?B?QUdra2tGaEhYeGt3d1dHMzVXTlBEMDJON3B2YUxzOUw3TDE0c1EvbjNDenBx?=
 =?utf-8?B?cUJzdmZvWXE3V1UvdVo2Nnd6UGtacjR0Tjd4WUxYdEd4bUNTZjRzcldQMVo1?=
 =?utf-8?B?bXVMT3hYaVBLREU0OEpZU1d4cTc2N1Z5bjdkUkpDeGlKelNhODRGZm5uOHRV?=
 =?utf-8?B?bnJwLzcvOGhRRHhTSkM3RXdzcmlVdmRuaXFnTjJQemh6YVEwazFkRFdMOG1L?=
 =?utf-8?B?TzdVai9pRnZ1K2dTdU1DV2cwU0tXMS9iMllGQ3Y3MFAwdVRFYks0ZHYxNGVx?=
 =?utf-8?B?aGMydGtZQzRScFdHYy9id01STWRTQ1FIMjEvTlh2ZkgyVkNJMmVkTTRjdTZx?=
 =?utf-8?B?ekVFZGJsSSsyakhVMTlwQ01DWjVHcnNIUjdFdnJKRnJmb0RKTEdJeXBlUWNN?=
 =?utf-8?B?R2RJRTV1L3AwbEdTY3ZDQzRZUVFTeFZzenVneUJjcnE3Um9rbDB3UjdaTS9m?=
 =?utf-8?Q?a22E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d09628-8313-4723-def0-08dbcb397dbe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:39:58.7405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUhsl67rHpjie2wO7UQVSc8VDrCkzPBhbfJiPf4RYynA8f6Q+rCkdFvrkobQjlog
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
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


On 10/12/2023 10:20 AM, Felix Kuehling wrote:
> On 2023-10-11 19:36, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Since you are the author of this updated patch, you should also add 
> your Signed-off-by below.
ok, thanks.
>
>
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
>
> You lost any mention of reference counting from the commit headline 
> and description. I think that's still an important concept that should 
> be mentioned. I'd change the headline to something like this:
>
> drm/amdgpu: Correctly use bo_va->ref_count in compute VMs
>
ok, will update commit headline and message and resend.

Regards

Xiaogang

> Regards,
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
