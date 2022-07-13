Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C719C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 19:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A19A9878E;
	Wed, 13 Jul 2022 19:32:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C07987DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 19:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOzTui5y6GimBjxd+OO022+APkUZ80v2+/Ax6oU5Q/bShWqdAoIg/dRWjTTrCxwBkzeuMBF/Vg7XsX8JNbLZR5x36hUphtBRCBwi/y9+EJPhMuV6TV6RHzD43JKEpIT1pjyV9kX2q5LtCXjjupuyszNUBYGJta6qpWTz929SE+JNJxCNFx2rxuJAFYRu5SxaDdT70oFq8NzceXRaUv3S8Mo6CTqzg46Jkma1if3B3d4pjqHPIrJuYrIjrR3RaAXO1IjWFq30BWKNcj5SB7QAmB+VyiIa47DYlCLcCmZRZMhOZmKOuIkf326p0IlNS9NYL0mCr8TOz7ziwWGU8FOT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnNoNlGJbjoktEiFmGA3UnUDsvNI2zDHicKnCjUzcEU=;
 b=dgjrFfeVLYX5osABoBr2+j3PGnJqZspSH9p/PQyKsaCG60roRrU6dATOIBvaO0SUV6P22wusNmXGEC/BONfaE5nGKQC4uK//cQYyKXnhICJrQdQIThamy2FEW/nSCTpLhNby90TQ1Z2fzzU0wPlRDRvQkJK6i9917nCAaEBuLWXpDFg6abT+OmucUFGoVEU/XtXCTgvMezj0yXuoGfAHsHeRK3J8E51ktkWK/nMiiNzERoL+WxXB7nV5aZ2it1TEz+e6oYWXH4O6ofnFtcupROx54glD0b/cIEwQzoifH/6fz5cL53nyCeZz3L8fr1egXvE5RQqVdt0BY0sOVYVsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnNoNlGJbjoktEiFmGA3UnUDsvNI2zDHicKnCjUzcEU=;
 b=D9KHpSDqmY6HHePJkdgsnrGn0ZAJnZTdNg+RNvvQZXtJIQnpJbeMvhXLBtuCuaKbD93noCDiMEsTBtAnTM6xFoypMq9uUfOhm/SlKRuguqtzp+QHeVw/l2FI5H1ioJ1K9jPxE3sVLGd5GlXU+1bAHX7eQZHvWAgN3kZbojlNoOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB2953.namprd12.prod.outlook.com (2603:10b6:5:189::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 13 Jul
 2022 19:32:21 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 19:32:21 +0000
Message-ID: <d6ace474-c5a4-59f0-4ea7-6367ce474313@amd.com>
Date: Wed, 13 Jul 2022 15:32:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Get rid of amdgpu_job->external_hw_fence
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220713171340.495314-1-andrey.grodzovsky@amd.com>
 <48441a62-7557-a96d-77f6-e564e2ed8717@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <48441a62-7557-a96d-77f6-e564e2ed8717@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:610:20::34) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cec027-6cc7-48c9-ab53-08da650667ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB2953:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZlE2icRIJY7G3w7BE+zIaCLIwOYDSfMTFWUbpExCvwHxwk2TVnXDRMCwTWELypSKHOT8/P6w8AbEi1NqKv2BYKIk3m5iiIc+kVV6gJxeaUkBMJxXxYzi8/IF1oOqTXVj4suusmFu/8Zh2FmsEChXj/7pCkupMG1R43o6N5zHMb+C4HaKh3jLIn2xz1h87qVdS0upEmbFYZA1XE1zlSYy/tukFp4Km0Mu8bG02XIzJ3n02AGwhU2sLTxJFbE3575N2h+dMUmII3S/X6I/BhAQr2bk0laKFdpwky4fAM0EusNM28zxovzJRBi5szw/ZYx3aWBjHBjPZYZxk3CX3NloIC1WsvaysYd7LyY81B6QuOQ2HVm+hus5xxNx90YLOUwopgHuXWIq9IKUfqJ9smHORQH1cR7bcj8xFnR8OQbiyAj4pZ20usMzqi8oCPsyojj4MgNJyyXHRrdQZiKR43d8nauE11bYX9kwfhY/IVBZGOFog+4MhCFntK8r0gJW6vq84Mt42cglifMcyydtqw7sN/2dsUSdK310f1tQKPyXPqEDNPS0RW+7CfyARbDcbFekyyjdMLbyRLYMnaeiwJ/Yasozv8nrLWWjXGMYhk2Tl293yYY4PD63K2hvoxBKmokVpsF9WjSUVGWZ2jbZ2aHbsY9C4kqx9XKejl0/tQh33prf9tKFC8nra6M+XWVCD4F4Er/6fWvwvJYvPLzjzY7bAHJUF3OOwXu8liuO8ewVXNgM+8YQPopPEFrqOjakxcANrHcD8xrMzDNtuF6Cpwo9AZisu+nQ4p14BEZVpUTz3HE7ykZ7uVxEvA6ySb1+CPuF3oHoXLB24Injj+T33/XHN9m8Z7VNOw5IIGwCnE8o5nQNa/MrxkJELVR1AO1R9DVILrWdrJWjBexZ/TheCeJlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(966005)(2906002)(186003)(53546011)(316002)(83380400001)(6486002)(478600001)(44832011)(4326008)(41300700001)(6506007)(6512007)(86362001)(2616005)(66476007)(8676002)(66556008)(38100700002)(36756003)(31696002)(8936002)(5660300002)(66574015)(31686004)(66946007)(26583001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29IakZzWlpvOWVPSjdMeWNoS0tYUW5mcnZWaTFLRzVJMkpqa3NRR3NraGky?=
 =?utf-8?B?ZkpLZTN5dnhxZXN1SGdoSWZIVE1Edi9Ddk04SmdlcEFYVTh4Y2tJb0lRNURN?=
 =?utf-8?B?UFRQUjFockx4Nk1BSjJxZHMyV3J6Rml6SEVDaVFEaVVGOGZoVmZxVFZ6UlNx?=
 =?utf-8?B?eTZ1L0pHdlF0RzFDd3QrK3VtQjlIcmdNMjVHZ3NSTzg3b1VYYzFtdEhRaFhh?=
 =?utf-8?B?VHc0S29FTWM4c1IzcDRIcWN4WCtKa0xITXFieVdwVjBLaElWeVgySHdFaTAw?=
 =?utf-8?B?WElWRXRUSnZORHJhcHViSzg4Z1Ztd2hsOFpkcFUvdWFsK05yU09oaTdUSys2?=
 =?utf-8?B?MS9oOEpDRFlYZFZxakNxTU92Y2wzNElscENxSDBkdXMvcFRLVHpoZ3N5MEdP?=
 =?utf-8?B?eE14SVhPTU1yUStHeERPeHh4T1lONVlVN2NRNGMwQWNDL2FKTjhXMHRxeWFs?=
 =?utf-8?B?cnVuNm1JUUh3b0NBRi8zKzhmL3RpVU9HQkdXZEZmbkcyMkdFUExUemZXdjRk?=
 =?utf-8?B?dVpvSzJCRjdScW13eUFsNHJGNlF2UUJGRDZsNDNFazFRaFpzcjRLMmZXbi81?=
 =?utf-8?B?cmlBMWZRVWdCK2JtdjNjQ0JnNnJUZEZ5WnVmRUJZZ2gzbDV0a0V5QzR1N1lo?=
 =?utf-8?B?WEdXMGVybzFscnZLUEhKVDE2U3VlYTIyNDNkQkhtOGxPTjk0aEo2dkt4NU1T?=
 =?utf-8?B?MTE5SmFHRStsQVgxdEtObGhiVUhLZ3pzQ3dUMFlDb00wQStXRDZhV2ZWbCt1?=
 =?utf-8?B?bU5QcllkYXZheVFGY3ZxMytBTU1XRXIrek1CQU5TVXdOWk1jQUdDaE5ZQjNm?=
 =?utf-8?B?bU5aWnBFNkRxbFcxZnQwNGpva0crTkhsUU83ODNJT2lMdGNBa21MYUJYOERB?=
 =?utf-8?B?eWlYUmY2QllHZ2lBK0dJVnp5SGtJVmhRd0RaSFZ5RVlhOURoSHp1WTRWcTA4?=
 =?utf-8?B?K1REQUN0cnZNYU53bHhkcW9xWFdkMEp5SGFaWHJkRWFXcmtqbEpuQUh3b21S?=
 =?utf-8?B?YU55aFZqWVlXaTFnL2ljaitZbXl3Tm04MDRtbjYyTFBuZ2VFRGE1RjBKYkVE?=
 =?utf-8?B?Qm5MTy9Iais1WlUyTm1LM054Y2k4aUtaRHBNdURSWG5WUUtXTmpZVnhndDcv?=
 =?utf-8?B?QnlQSWdhZDdrS3dqMDJjaUloYjdZZE1qcWtmQ09iRHh5U0IzZng1NXU5bmtZ?=
 =?utf-8?B?TUVCdnFnTU5aak1pUktWNU5laTVrNjlEL0lyS3NyTEZJeDNHRjRORklsVEVr?=
 =?utf-8?B?LzA5WkhCczAyV0QrbFRDZVhpU2pVbUc1cDZxWjdhb3ZmenVhVTI3R2dMSWxi?=
 =?utf-8?B?RTFJbjBLcWtBMTd3d1ZsdElvLzdHOUZGeWVra2J4cC9TaUhzSEZtZWt4eDkz?=
 =?utf-8?B?QzFBNVFZZzlnVEIvajZhcW16cDljYmFlRGUwcWt3SlhZVkN4aVY4eXIvY1hO?=
 =?utf-8?B?U1I0MzJnU1F2Ry9UVU9ZMlVITVNWUVREQXd4TDFjQ0dmTS9rV3JGN1hUZ0dL?=
 =?utf-8?B?Q29HYXZjVi9pYndaQVZrSkR6V2N5QXJ5c0ZEMUVBYm1FRks1Y09hbGY5Szgw?=
 =?utf-8?B?L000VWdMK2hldW96L3NaeXdSYk5FZ0c3QlpWQjEvMHdQVnNKRXFCZGY3QmNV?=
 =?utf-8?B?TU1QRi9kbWxta2VrVUhvV1ZreTRkMWUzK283UjNZMU9iS0JVT3BOQVdQOGVj?=
 =?utf-8?B?cnNUN3pyV2t2Q2EwK3E3U1Y0OVZpMmVtdStCVDlGa2JPMEF0eStkdG5wZi9M?=
 =?utf-8?B?enR1eVhSdEQ1bXdZZnV2RTRtK3JmdEFYN1JJVmNoV0U1YmNEckJsNkZQSjBy?=
 =?utf-8?B?ekdLbkFHQ2VGSmxEZkQ5WjF0MWNQdmFEZlloWDd4NmErOWJkTUJWME1ma0x3?=
 =?utf-8?B?Z1dvL2VQSU5UaGF4bXdKbGtOMndGRG1vSjBSSHZVQ0FXTENvbFJhMjRQZkxF?=
 =?utf-8?B?bDlhbzNpUjAybWZ0cHB6eStlZitmeTliSWNBNi9qN0RqN2oyQStxOXNmYUd0?=
 =?utf-8?B?ZUhVb2VLWWR3VzFOeHFpZnZqMTMyMVJzWmRzR3JOV0tISlRUSjlvbWx1bWFo?=
 =?utf-8?B?ZkUzcmIzcHpSR2JUclpyc29PY3JMUlprWUtwYzJiYmVVb0JKMGVDQXltcW0x?=
 =?utf-8?B?bEtMT0RWWFdZUytJYVp1QnFMWE11a0syaEY3THdiZ0sxQi9aUmtrZjlIaFdk?=
 =?utf-8?Q?kxElvjsmL95LEFZ0y2+O+HDs/R5TM+ufuJpvtjr1zfkb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cec027-6cc7-48c9-ab53-08da650667ca
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 19:32:21.4234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZuYWEe5rVs19UBbfV6nRHg1pi/sZOjngb1cnE/jCXTi8mFnzP+Qh4jkkbDjYqk8BeZxqsyH8GVOFEWc0/7+Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2953
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
Cc: jingwen.chen2@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-07-13 13:33, Christian König wrote:
> Am 13.07.22 um 19:13 schrieb Andrey Grodzovsky:
>> This is a follow-up cleanup to [1]. See bellow refcount balancing
>> for calling amdgpu_job_submit_direct after this cleanup as far
>> as I calculated.
>>
>> amdgpu_fence_emit
>>     dma_fence_init 1
>>     dma_fence_get(fence) 2
>>     rcu_assign_pointer(*ptr, dma_fence_get(fence) 3
>>
>> ---> amdgpu_job_submit_direct completes before fence signaled
>>             amdgpu_sa_bo_free
>>                 (*sa_bo)->fence = dma_fence_get(fence) 4
>>
>>             amdgpu_job_free
>>                 dma_fence_put 3
>>
>>             amdgpu_vcn_enc_get_destroy_msg
>>                 *fence = dma_fence_get(f) 4
>>                 dma_fence_put(f); 3
>>
>>             amdgpu_vcn_enc_ring_test_ib
>>                 dma_fence_put(fence) 2
>>
>>             amdgpu_fence_process
>>                 dma_fence_put 1
>>
>>             amdgpu_sa_bo_remove_locked
>>                 dma_fence_put 0
>>
>> ---> amdgpu_job_submit_direct completes after fence signaled
>>             amdgpu_fence_process
>>                 dma_fence_put 2
>>
>>             amdgpu_job_free
>>                 dma_fence_put 1
>>
>>             amdgpu_vcn_enc_get_destroy_msg
>>                 *fence = dma_fence_get(f) 2
>>                 dma_fence_put(f); 1
>>
>>             amdgpu_vcn_enc_ring_test_ib
>>                 dma_fence_put(fence) 0
>>
>> [1] - 
>> https://patchwork.kernel.org/project/dri-devel/cover/20220624180955.485440-1-andrey.grodzovsky@amd.com/
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>
> Of hand that looks correct to me, but could be that I'm missing 
> something as well.
>
> Anyway I think I can give an Reviewed-by: Christian König 
> <christian.koenig@amd.com> for this.
>
> Thanks,
> Christian.


Pushed, thanks.

Andrey


>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 27 ++++------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  1 -
>>   3 files changed, 6 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 16faea7ed1cd..b79ee4ffb879 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5229,8 +5229,7 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>>        *
>>        * job->base holds a reference to parent fence
>>        */
>> -    if (job && (job->hw_fence.ops != NULL) &&
>> -        dma_fence_is_signaled(&job->hw_fence)) {
>> +    if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>           job_signaled = true;
>>           dev_info(adev->dev, "Guilty job already signaled, skipping 
>> HW reset");
>>           goto skip_hw_reset;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 6fa381ee5fa0..10fdd12cf853 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -134,16 +134,10 @@ void amdgpu_job_free_resources(struct 
>> amdgpu_job *job)
>>   {
>>       struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>>       struct dma_fence *f;
>> -    struct dma_fence *hw_fence;
>>       unsigned i;
>>   -    if (job->hw_fence.ops == NULL)
>> -        hw_fence = job->external_hw_fence;
>> -    else
>> -        hw_fence = &job->hw_fence;
>> -
>>       /* use sched fence if available */
>> -    f = job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
>> +    f = job->base.s_fence ? &job->base.s_fence->finished :  
>> &job->hw_fence;
>>       for (i = 0; i < job->num_ibs; ++i)
>>           amdgpu_ib_free(ring->adev, &job->ibs[i], f);
>>   }
>> @@ -157,11 +151,7 @@ static void amdgpu_job_free_cb(struct 
>> drm_sched_job *s_job)
>>       amdgpu_sync_free(&job->sync);
>>       amdgpu_sync_free(&job->sched_sync);
>>   -    /* only put the hw fence if has embedded fence */
>> -    if (job->hw_fence.ops != NULL)
>> -        dma_fence_put(&job->hw_fence);
>> -    else
>> -        kfree(job);
>> +    dma_fence_put(&job->hw_fence);
>>   }
>>     void amdgpu_job_free(struct amdgpu_job *job)
>> @@ -170,11 +160,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>       amdgpu_sync_free(&job->sync);
>>       amdgpu_sync_free(&job->sched_sync);
>>   -    /* only put the hw fence if has embedded fence */
>> -    if (job->hw_fence.ops != NULL)
>> -        dma_fence_put(&job->hw_fence);
>> -    else
>> -        kfree(job);
>> +    dma_fence_put(&job->hw_fence);
>>   }
>>     int amdgpu_job_submit(struct amdgpu_job *job, struct 
>> drm_sched_entity *entity,
>> @@ -204,15 +190,12 @@ int amdgpu_job_submit_direct(struct amdgpu_job 
>> *job, struct amdgpu_ring *ring,
>>       int r;
>>         job->base.sched = &ring->sched;
>> -    r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
>> -    /* record external_hw_fence for direct submit */
>> -    job->external_hw_fence = dma_fence_get(*fence);
>> +    r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
>> +
>>       if (r)
>>           return r;
>>         amdgpu_job_free(job);
>> -    dma_fence_put(*fence);
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index d599c0540b46..babc0af751c2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -50,7 +50,6 @@ struct amdgpu_job {
>>       struct amdgpu_sync    sync;
>>       struct amdgpu_sync    sched_sync;
>>       struct dma_fence    hw_fence;
>> -    struct dma_fence    *external_hw_fence;
>>       uint32_t        preamble_status;
>>       uint32_t                preemption_status;
>>       bool                    vm_needs_flush;
>
