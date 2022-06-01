Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A97C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 06:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0BA7113400;
	Wed,  1 Jun 2022 06:21:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E8E113400
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 06:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUuPvyp+28HL7cJ5L6er00CjCioDtpXr2NmSj6y3eVQ2f9G7m4N19LhzhQIyhp76dPS+6HX2cbju0ShXJmElqootaHB30l6lG+/+JvmhLJuYICgNCn95eK86/HqKiuIrbysdXOmbxSdanS8Y4Y3aZWOGlDaFue9j7NJAF/Ikc558bGChMIbBD9a9r1uAhefnmWxLghrY4anFRm+xssH2UC9zd0RdQy/mAQ/E+C0jC/EezR11ZCi7LQX49JwzuRmZLU3meJMjRSw+8LSNPwLNiQu/DGGJz+krOzyvI6CE0iMGIHsfCaDVi0YZ5ng2r/g1YLlR7p1Cvt3VTzcp1hlXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzVpl25dvq2VhBt2F0sAWh91sCHoNSl7iPjz1vj+GCM=;
 b=Z8dTaJkkYcTWC/kGTzJ2xKXmlCXg359k9O2SU6DX/AlX7tmfK9t3cUcIvEHj1Lm/RTnzSzjGsjP5+Gl76sEz5dWqZhyLDT6QJpsISBjKzo3qD6jWRMPzwvtjlpyWAJWUECoB3/5b/BMbIWl8SAUrl9HYj17rm63fqrrXZCQ8UHvhYbEzXC1BY4mr/M1Rim5lPq5uf1E1TkobncfMe1OJ9QwuM38MbMLA5vXNXsTQugW7AZglzFpBFNuwwaPqcq/Cvn4+BI0i9Lj2XgNqJ8gaSkPNfE6ZsnliqrStkyLbjyHfvowIVVYhGGpwkeMFp0EzRmgArNsjD51bLpiUAPKHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzVpl25dvq2VhBt2F0sAWh91sCHoNSl7iPjz1vj+GCM=;
 b=3lTlgADjfMMz2afQl3UCKfn4NS7DNj3+VPNoChMk5TPSNInfTJi06fTkxQK7uOAjMlfcMAIeEOxWxagInLbxUueKkFjscXaNDjil2skS5+0rVY/1vzC1x1PGtRri1qnlp/1Q836BoIXYpFHy5qDanWkj3WVEAgEzuL5j/Y0cBb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 06:21:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:21:52 +0000
Message-ID: <996cf9b9-9adc-722b-a0a1-e4fbc97c54af@amd.com>
Date: Wed, 1 Jun 2022 08:21:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: add pinned BOs to kfd_bo_list
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220531083421.1670792-1-Lang.Yu@amd.com>
 <eefcf0f9-1fff-3c1d-0ee6-e33573306ed5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <eefcf0f9-1fff-3c1d-0ee6-e33573306ed5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR07CA0006.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::27) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e85c85e-0671-4722-3af5-08da439704ca
X-MS-TrafficTypeDiagnostic: MN2PR12MB4581:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4581FB1A50589FE4DCD8454983DF9@MN2PR12MB4581.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jU2WCGX3IrS3bq37rSvEQ6cVET6wmj9RIzMPLAxgZscmSEkAqKG2vMcu7hkIxQbEeoWN/ayFZ9TbKpL7Qn4VQunmB2H7tZKxKA1kcT4eoYoKlTgCi7rVn2FYvqHHwla83u6/dENkSvf8QPNpnK2kheU6ylw/Yx3uaKXKOQJW7JklhhwkjfiSYzrH4Ws3SDKA2iRIfkA0f2LjGPGhtdj+g71VzVp1J03ZDssXVr0T+TeU0NKGkPP/JAy7LOraCRZViWJp4Qu1Jso4qS7/R0wa1xO2OAioXa7WQb3h/3/2TR+dTrKaTIpCzBDbKzpe8GsxqYFBHimwjKKktjWpdgKDFSb2BeGcVJZwwAKtEdSmu702kFaS3qIBsCpbDAlRQXSWV0JO2CMZ18Zo7Q/G9PYWKLFTBzI97TN+MC58wUMpzzXc8zK5uZgtIyGfOKLxAKBEoFIh9LDhzYW6pCY8wVk3Cghj28HnG2RYq8DlFjrYoTZRkOQeZ4Lxz8mVX3akxhODgl8Sk+Qoa+Fkg6mD6e0JRiPVcf/NNwYR/080j+8itM6YwACCZJ5ZdGClG8wKKvILRrZeYIPgFPNEKskrU5tVofi4EsvTeAVx27g70ny2awNrSHqAPpTORrNu2Nc0En0EuRIIBVjz95XAkdznlV07OzMvOipa6kQ/FjH+BrZjHKkugd0kYT1r6bJ7TFrr69jQlB18ULo9nteYIpIAp8+ecGshH0jkX3wpk8uy/3KPoic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(83380400001)(508600001)(5660300002)(6506007)(8936002)(66556008)(66476007)(38100700002)(36756003)(31686004)(66946007)(4326008)(2616005)(2906002)(6666004)(31696002)(186003)(86362001)(6486002)(66574015)(26005)(54906003)(6512007)(110136005)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZtMWxGeE1FYjA3TFFmTXZMNFZNNkJqWjI1OExVZUVoVWpDWGRObFlMV0NT?=
 =?utf-8?B?WjZBVWVodEd0bnJLR050ZDQwQ3F0eldVM2l3K0szQVRvMHkvY29VUWJFaGhE?=
 =?utf-8?B?TTJ1eUZaZ01ibWZpM2VLeTlUaE5oRENqdklMaG5mOTVYRllqQ3pvRFRKK2Mz?=
 =?utf-8?B?eGlnMlhEeXMxQ3pmREVWL3NBSjRPcnhvZGR6UHErS0tHS1hYOWU1RCtPL0JQ?=
 =?utf-8?B?Qi9kN1VYVGFOem5Ed2lDVlJjYWFxQWtKeHJYWkJlYmpLdHNuTjhBbXlGa3Zs?=
 =?utf-8?B?YzZRUjg5aStWMEp1UEEzYzVQcmQ1bWtJQ1ZsaDBQZ2paRG9CSk1raUh2NVlQ?=
 =?utf-8?B?Q2czNFpVRllXTmdkR0lJTFIrYWRXcnhHVFZxVUM3dVpHTkE0STA0cGRWZDlV?=
 =?utf-8?B?OURVWTBvS1VLV1NkUHZIdHZOTUZTOTJkVjZOYytlS0xHRG5XNkxtdmRVVlQx?=
 =?utf-8?B?ak5rWTUrSkJrN0VRWVFFSENxcU1KdExDbW5MZ2NZb3JLOVMvaTB2bXRHOE8r?=
 =?utf-8?B?Mi9FWmZ1N1RHMUE2WjVGelY5aVlVQkxJRmVjc0k3VFJ6V00wOCt3VFNEWWdT?=
 =?utf-8?B?cUUycnI1bjVKd2FKYkVaTWNnV0tpQ2ZCM0NDVFp6SlBOVU11QTVVM0hLTU1Q?=
 =?utf-8?B?TTMrdkJzOXdmYmhCYVJCNWVhcHM2VWNtOHFqaHZZdVJOT2wrSFBkOFo1T1JG?=
 =?utf-8?B?bjZNUGpySnhuWEtoWXBPREtON2N1cDczQlVjZkFqTjV6QWpoMXJiaVNYUXgx?=
 =?utf-8?B?bitpYTZGVkxGTmlTU28wY2huMEhVdGRVUEVjcU1tUWpQb3lFTmNpV1BkeVh4?=
 =?utf-8?B?TC93RDk4MEZ6UTNUTXAxczhOM1VMa0pUY0YwVDZqS3FVbytpU0h1eTRkanE3?=
 =?utf-8?B?VWZ1VHhvU0lzd0M0b2FhdDcyaFpDa0tnVFY1WWtIYldxTjZDeG9uYlBhK2pX?=
 =?utf-8?B?c3VNOTdxczlPaE1tZ1Q4VnBmREtVTGpRRE9TaWJxcDJCY1hWWDBydU9nT1ZE?=
 =?utf-8?B?aUJaK1lNdnVHYjJLSjkvSHJNR0x4eDRZQWdFVndHd3RxRnJiN3psdkJhaVRB?=
 =?utf-8?B?T3djSDVzam5pL2ZVNzJGcmtlZXVDcU9RTjRuSnVVWWJuRFRpb2MvYitKc1lQ?=
 =?utf-8?B?UG4yaTRnK05DQTNEekhucURiSUtjbVZLeGdtVUpiaG03Y0ZsTU80dFVodzBW?=
 =?utf-8?B?c2VaS09nTlM3THk1Y0ZIdlpGV2ExbmJsZnhsYTNJd1ZPQlFxRTR4ck1sRGt0?=
 =?utf-8?B?WUVueDNmeFBOSGtCUzFkL0dVcjdFSThnOENxcFZlSUxzTVFqanVOYUVmd3V4?=
 =?utf-8?B?QXZjNTNVVUlKSE0xYzU4am02WlVETlh0UGpEZzJIMFplZ2sweFhRWXViaS8v?=
 =?utf-8?B?K2lzWHR1c1g1ZG9FZkdmWi8wMTJPYWpMUjNLQVdxNHRPM1JyY3FEU1lMVnRZ?=
 =?utf-8?B?Umd2VkYzSjgrNDZHWm1BOWNrYlBIbmtOMjIzOFJzaXgyMysva0UwamVFNjhz?=
 =?utf-8?B?UTUvWFhiaFR3QTIrb0Q4L3I3U2tDZGQyS3c4Q2hQZE50QVlScCtDTVBpOUNr?=
 =?utf-8?B?by9TYkdwbkpheXdZMVlndGZxTE9JSVBqY1VnenYrQVllTElieWJRY3Fyd1d3?=
 =?utf-8?B?ejZkMUV0MHNLdGZKaGZ5MTdRTzhqbmFuaVZRWGdtaHRDS3NCcmpxVzQ0VU5q?=
 =?utf-8?B?TGZneG4yKzFwOXZxamtIODIrNDNKdkhFQUdpckdBRjVkVWxSdVdyQUtNZEx4?=
 =?utf-8?B?Z29TUUpnOUh5cVRTTHJwWGJMK0pub3U1OFNDVm9QcDFTSGxMYkFReDE2ak9K?=
 =?utf-8?B?TDhuVlRRby9YZWNHSG9QYkVweHRyS2JzU24vUzY1R2F6OXhnVk5SOWVVMW9i?=
 =?utf-8?B?Y3VYb3ZSSTF2Y3lpbmZNQmw3VEJ3TnBWVXJGSk1zOUR3QjVKZFMwVVg5UXNG?=
 =?utf-8?B?OXlLd2xwMGxtUThXTkZPZFRYR0hmSFcydGMwenRIUEhHUW9yMlFqREp0Y3pP?=
 =?utf-8?B?UTQ0R2tDSkFCV2NnZmkra2xLVk9aOXQwa2EzUEc1OVErZHM4Vk1LTjNWWVg0?=
 =?utf-8?B?V1VZU3QxSGQ3OXNyL3I1amRHTGtyV0RZVWZ4R0Q0OWEwd3l1aUN0TXR4d2xW?=
 =?utf-8?B?ay9GNHUyaDJFYmRUTnlxMkVUejNwSEE0MWdCNzViMkNNTGg2M0Noa1FRRXFK?=
 =?utf-8?B?MDJIUGgrVDUzUUdLN01VdzZmRExnVWliVVU4aStVeU1Ha245REJtVEt0MWtO?=
 =?utf-8?B?Ynd1dlRlYTZILy8rQXFTRXR3NGV2Z1VqeUJheUNvRkp3VkhqM0ZDa1dWWk1t?=
 =?utf-8?B?WktkQTFoMVp1YUVaWEhnVFBLUlRXcHAwVXVIUFNuYmdEeU5WcVBGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e85c85e-0671-4722-3af5-08da439704ca
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:21:52.7862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6VjCyE4kRtL5W9/C95hp1fQQacyCjzVDQLzFK6o3wv5xT6Zw40Tz9ScmksrMnP5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 31.05.22 um 17:22 schrieb Felix Kuehling:
> Am 2022-05-31 um 04:34 schrieb Lang Yu:
>> The kfd_bo_list is used to restore process BOs after
>> evictions. As page tables could be destroyed during
>> evictions, we should also update pinned BOs' page tables
>> during restoring to make sure they are valid.
>>
>> So for pinned BOs,
>> 1, Don't validate them, but update their page tables.
>> 2, Don't add eviction fence for them.
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 ++++++++++---------
>>   1 file changed, 20 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 34ba9e776521..67c4bf1944d2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1953,9 +1953,6 @@ int 
>> amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>>           return -EINVAL;
>>       }
>>   -    /* delete kgd_mem from kfd_bo_list to avoid re-validating
>> -     * this BO in BO's restoring after eviction.
>> -     */
>>       mutex_lock(&mem->process_info->lock);
>>         ret = amdgpu_bo_reserve(bo, true);
>> @@ -1978,7 +1975,6 @@ int 
>> amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>>         amdgpu_amdkfd_remove_eviction_fence(
>>           bo, mem->process_info->eviction_fence);
>> -    list_del_init(&mem->validate_list.head);
>>         if (size)
>>           *size = amdgpu_bo_size(bo);
>> @@ -2481,24 +2477,26 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> **ef)
>>           uint32_t domain = mem->domain;
>>           struct kfd_mem_attachment *attachment;
>>   -        total_size += amdgpu_bo_size(bo);
>> +        if (!bo->tbo.pin_count) {
>
> I think this special case is not necessary. Validating pinned BOs that 
> are already valid should have very low overhead. So adding a special 
> case to avoid that is not really worth it.

I would put this check into amdgpu_amdkfd_bo_validate(). Otherwise you 
get a nice error if a BO is pinned to VRAM and you try to validate it 
into GTT for example.

On the other hand that error might be exactly what you want in this case.

Anyway, with or without this, feel free to add an Acked-by: Christian 
König <christian.koenig@amd.com> to this patch.

Regards,
Christian.

>
> Other than that, this patch looks good to me.
>
> Regards,
>   Felix
>
>
>> +            total_size += amdgpu_bo_size(bo);
>>   -        ret = amdgpu_amdkfd_bo_validate(bo, domain, false);
>> -        if (ret) {
>> -            pr_debug("Memory eviction: Validate BOs failed\n");
>> -            failed_size += amdgpu_bo_size(bo);
>> -            ret = amdgpu_amdkfd_bo_validate(bo,
>> -                        AMDGPU_GEM_DOMAIN_GTT, false);
>> +            ret = amdgpu_amdkfd_bo_validate(bo, domain, false);
>> +            if (ret) {
>> +                pr_debug("Memory eviction: Validate BOs failed\n");
>> +                failed_size += amdgpu_bo_size(bo);
>> +                ret = amdgpu_amdkfd_bo_validate(bo, 
>> AMDGPU_GEM_DOMAIN_GTT, false);
>> +                if (ret) {
>> +                    pr_debug("Memory eviction: Try again\n");
>> +                    goto validate_map_fail;
>> +                }
>> +            }
>> +            ret = amdgpu_sync_fence(&sync_obj, bo->tbo.moving);
>>               if (ret) {
>> -                pr_debug("Memory eviction: Try again\n");
>> +                pr_debug("Memory eviction: Sync BO fence failed. Try 
>> again\n");
>>                   goto validate_map_fail;
>>               }
>>           }
>> -        ret = amdgpu_sync_fence(&sync_obj, bo->tbo.moving);
>> -        if (ret) {
>> -            pr_debug("Memory eviction: Sync BO fence failed. Try 
>> again\n");
>> -            goto validate_map_fail;
>> -        }
>> +
>>           list_for_each_entry(attachment, &mem->attachments, list) {
>>               if (!attachment->is_mapped)
>>                   continue;
>> @@ -2544,10 +2542,13 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> **ef)
>>         /* Attach new eviction fence to all BOs */
>>       list_for_each_entry(mem, &process_info->kfd_bo_list,
>> -        validate_list.head)
>> +        validate_list.head) {
>> +        if (mem->bo->tbo.pin_count)
>> +            continue;
>> +
>>           amdgpu_bo_fence(mem->bo,
>>               &process_info->eviction_fence->base, true);
>> -
>> +    }
>>       /* Attach eviction fence to PD / PT BOs */
>>       list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>                   vm_list_node) {

