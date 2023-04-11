Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AC2C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 09:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D0D10E0E5;
	Tue, 11 Apr 2023 09:29:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A78110E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 09:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDGBij8GmE2KH6EA4J7Ljma008ZCP/E214YRhEXDbNdcem6159d5D+vr9mszntWQnrfeH9U0Aeh3e0cNIPE9THLvz0P78jFAHYfBL+ZZlTTm0/NsFp5Wt+02Sc0tTx6ZR1IeRTLpuDDIOxMXL8DoRK/9v6iW1N8wd6ynmaZO2KFoOp9Pof1uaFg1sL/ORNdN4Z/Z7HYLF5R0d+Btqx6J+cGFNdWx1Ai1hxdJEuYYVGbhn8a+NuIChu9ur7KSGHdhZe6SS7lupQ7TvFXIkXxyctUc3yB01Xl5POvYqkLqNKhKaAfvYy1zQuaNxSz2UM2vqQryIaDrM4N4vyo8vAx/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2V+t7L1dMgdw9G8hHpWt5FXNEbPUFTR5SXqqTTNzfs=;
 b=kM4bJ92Ig7RUM6uBwCxr2HNVAtN7d1I96fzgecwANhbanyPzb3LXPAsC/QyckXC6L41FICbUYrLuoieB0MmXPTIrppWzNg4HR8aR6N9L/EKjHoZurvT+b8Xrd5bZBoulZ5gMP3vJc2wzR6gz7zDxxItpLhvshCQwuhLOsESUW3fDXAx9zd3DfIHh2bm78L8e0ZCq7vsAy8P2QHOqAG2vi9uUhE9u5BYjWOB/1J+unYnsjVjPW1Az2DfvW3U+ayyczdiU6/8L+WGNlwiki5JqCDErn+PIVNp2gbyuZ8TDodrpG52HsGqwzLvWXXBRRVX+8wDxjjAQyRRmHtK6KDFmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2V+t7L1dMgdw9G8hHpWt5FXNEbPUFTR5SXqqTTNzfs=;
 b=VgMq3Plv2deZvnzQnDCs+wBqral53YAorrucpdbbSa0TISjyqSDHTBdLCAPL0YtQLixVF0fn4TuocOlVA04DrJLpKFExiaeyQrxI7e1gqhcdYDA9fyV7zGoqbWJcx3HJqKf5vpnp1O8abg8A0lZlsUd0KUj0kuvnWBTPULRAHps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 09:29:10 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 09:29:10 +0000
Message-ID: <fdaccfa8-4849-2750-66da-5848e6ca20ab@amd.com>
Date: Tue, 11 Apr 2023 11:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 8/9] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Shashank Sharma <shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-9-shashank.sharma@amd.com>
 <CAP+8YyEDqyJxUHP4xJ9zjJ5BcCKeF0bH8ibjh-y+hp8SyiVgzw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAP+8YyEDqyJxUHP4xJ9zjJ5BcCKeF0bH8ibjh-y+hp8SyiVgzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 4310ecb9-e5e9-419a-a9e4-08db3a6f3487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCUXjeSH3z5mpy+bxStR6VjALJAvJrJfY9TNBxyslRR5bYYuuFXmYIwmhk5BNutPA8XQE0a9fXGi1Dai9rk1obIctJWBnw2DWrw6kl45pyKQTBNMZUtb8T4S2wY0r8ofyzkmIYV73dMzJOvHfHXVrPZe3aB4J4DwfCKcPgCqPuFyZ8GIR3EVkbQwND/1USrS+RB+2JBQmDtVjSxGpp0mANLUEl6fByL3r5gTHR76krf9Fn64EInxGrVlmsWNJtg/Sno2u8TzB55NorhMxDAY4tNdnkUBmhCNHr51AT0qHjVFae1VnY/TLuohJ2VQcCv/K/0cy+jz+iP4AjSJ6E1MrrKPK4pKx/S42MXlbnAw/W3hZrkbnlWCAGcQDRsz9AkiR8rLQzOWF2HV0MXRGfh1cBTsidw6pno8RDVyJ91w5ZwoKCKkEweN7Ch5gCP5TcaECs4EALwshaiTVPnigMMDi2qeOVsQ9dYc3N/5gB8C/7GB+59NDgkUBuX8heLzI0fXiF4NKGLZek8XSbryPnFqoSOPyydo7hRldlpDnNEZOkGKPWqoMyRQyCwQImII/NDYvafoiP4wwnZNrOlx5i2xexTYubJVeRHJSCqv8Sa9s+ztbmdD9mc3SNA8uSAO6nfHh6xgKDC96MBqava+87Z5MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(478600001)(6512007)(316002)(110136005)(53546011)(26005)(6506007)(186003)(54906003)(6636002)(6486002)(2906002)(5660300002)(4326008)(66946007)(41300700001)(8676002)(66476007)(6666004)(8936002)(66556008)(38100700002)(31696002)(86362001)(83380400001)(36756003)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjI5N0E3blpzRDJPYWxvS2VIZVUwSzh6NGNvT1hrenJ5NmZOc01udkhybDRO?=
 =?utf-8?B?SGg0UHBNQWlabSsvSTc2RE84SVV3NDR3cit6aVloOGp5ZW40SXBhaHN2ZlBW?=
 =?utf-8?B?RkhBdjU5UzFvZDZzUGRJMzM1ZVdhaGdFVEVmcjVnekFCUmVYUXlERWlydVgz?=
 =?utf-8?B?ekJZc0QzOGovbHBST1k0aXpvMkpqZU1RRHB4d0tlSVZCQWk2RU4yYlZYY0lE?=
 =?utf-8?B?OHdJWm8wSjY4N0Q2Y1R2R0c2TytET01HRVVPTFkxSURKSmJYSkJhdXRHVWY0?=
 =?utf-8?B?Q2V6aTNXT0w0aHpaZnZxTng0dWE4bjBhQXR1VU9Ick5GRUsyTVRoQ1hIRXZG?=
 =?utf-8?B?MmRtdlB3UjJYRmR3RmsxbXZXUWZMeXhOZjZSK3NJdnZvVWlHbWoxMGU3dUpP?=
 =?utf-8?B?R01hTE5aeFEvMXppR0xSSlp2VzQyb044V1lyUVVWNDBoZjhudU5PWk11dE4y?=
 =?utf-8?B?WE5IL25jUWVGN2pJS09jTStMMndaS1VRdWtsRWNIN1FkMlBKcW9tcDV4MmNm?=
 =?utf-8?B?bXlmSWpZMGFDVVlFNWViMVFDaUhCemlad2EvVEo1NlZYZWhZd3owSnF2d291?=
 =?utf-8?B?SXFZZnhqZURJdklYODZnU1ByeU4wa1NMUm1FQkVqKzNsYzBkbHF2SXhOa3BR?=
 =?utf-8?B?RFRSM1lPR1JiUUFEbXEvQjZMeTFXM0JsV1luRFprMEhUaEg1b09lQWlQU0RI?=
 =?utf-8?B?bjRaNFpCd2IxR1cwZDdKR1Y0Z3dSUm42emRZV3NRQkVpait4UUxiRDI0NFNi?=
 =?utf-8?B?NzRwREZPUy9ZOCtqYWhMdE9uRmJ4OTlWR0wwVHh1eVNkbkltU3AycXk1WTQ3?=
 =?utf-8?B?b0JYemg4TTZ2anlzUGs2NDI4bkw4ZWY4T2VlVjJRajc0d0hkWDQ0VllTaUFr?=
 =?utf-8?B?c08yRVBkR2dTMjlYM2VkbnpoOURKUUZNeWlLaHppTDN1ZU5vZUVJMlY3bm9L?=
 =?utf-8?B?SWlIdUtmSnpUbklkdUZ2aEd4ODQrWWRXZFpIRWFTRm02ZEJ0SGpqYjFvT3RQ?=
 =?utf-8?B?dm5wU0dmRG40UnpmdVFidW5iSUJSMkhvU2dPVVovclZKalJNWmZpRXZGeTNJ?=
 =?utf-8?B?SFRIckhhL1NTQ0IyMThya24vckhnYzBMTlJOdG1uTWI5dUlHK1pWdFNRcGZQ?=
 =?utf-8?B?VnR2WjJkamNFOU1YMHgrbkpyTmhyVUxDbFhYcTNwc0o5bTdnbGtBd2czMUxB?=
 =?utf-8?B?a0VDZG14c09QVG9nRklTOFFscTlTT2psMjZrRnU5VnVkQkZDNElOQStLcGo1?=
 =?utf-8?B?SnNkL3l2b2NlbGxKa1NxWUNUOUh6QUFKRkhaMzB0T3NmYTh4cExzNjhaMUNw?=
 =?utf-8?B?TVcwUEZTeFh0MWprVVlYMGZYU0dkRHBQSTZ4aFBKb2lpSURVR0U0Q1JBZWRO?=
 =?utf-8?B?ei9Mb2dwMHRRSWtDSFY3KzBMb1dwV0NiaHNUbzlnOXpETVhJNEh2RGlqVEJ0?=
 =?utf-8?B?TzNSVktBVlhLaGVTVFdwS0xOMmNxT21Oa3AyUDNVdVdabUZCekErUjNYS1NH?=
 =?utf-8?B?M3JnVkQzR3RmR3VwOU4ydk4zQmROQWt2c0RmakluazhhdzFxRjF0dnEwWWov?=
 =?utf-8?B?MUJEbmM5RFQzS1ZyZzNjR3hsek5YQTF0VlM5Tnd0MzcwTDVJblArK1NCVmdz?=
 =?utf-8?B?K21uWVVnN0Q0VnQ3aU9BMDFmM3dtaGJuNVpNdndzeWV2em1UMlpGb0k1OGlK?=
 =?utf-8?B?ajMvWTVxeE5RenRZays4dXJXMG1zZW9hQVJmc0VsNFhFNFZ1QXlQdzY0RFdE?=
 =?utf-8?B?MTRKNFRSbUhTNjNueUpsRC83Vy9LSm55SUhxN01GaWNQSnhrUzFsWmMwWldS?=
 =?utf-8?B?ODcyWm1OUW8vcWdJeEFibGQrYm9wTjFKSjdTTGZQTFg0ZW5YU1ltd1pJQzJx?=
 =?utf-8?B?RkFSYXdIL2lyK1dSdlRIY2ZQK2FtOU55aUZkdDVCOEZoSkdoRXRoQTlqMU14?=
 =?utf-8?B?bDZNa2YzblBoYVB5a3BUYklUZ0FWQksvb2RvMjFhcE1iN1BHR1lWQ2N6N3Nk?=
 =?utf-8?B?bGk0NjhsVFBGb2NnNmxFZ2tUbHBLbDlIRytkMW93enBzSlFWbVVweEpQV2xX?=
 =?utf-8?B?K0RwYTNjTGhCZjhMbWptMTJ1RmNubzVUOUZjZmxCSlZTbFRJYitoMzBNSUFr?=
 =?utf-8?Q?x4lnrxwtR59atM/DqggueQ7uO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4310ecb9-e5e9-419a-a9e4-08db3a6f3487
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 09:29:10.2504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtY1lfgb1Fh+0kE3xXylaXlaUT/ixG2csIYTAnQcOcn4kcblS20JknxZ4TFE4r/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
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
 Felix Kuehling <felix.kuehling@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.04.23 um 02:00 schrieb Bas Nieuwenhuizen:
> On Wed, Mar 29, 2023 at 6:05 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> From: Arvind Yadav <arvind.yadav@amd.com>
>>
>> To support oversubscription, MES expects WPTR BOs to be mapped
>> to GART, before they are submitted to usermode queues.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 89 +++++++++++++++++++
>>   .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |  1 +
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>   3 files changed, 91 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 5672efcbcffc..7409a4ae55da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -43,6 +43,89 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>>       return idr_find(&uq_mgr->userq_idr, qid);
>>   }
>>
>> +static int
>> +amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
>> +{
>> +    int ret;
>> +
>> +    ret = amdgpu_bo_reserve(bo, true);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>> +        goto err_reserve_bo_failed;
>> +    }
>> +
>> +    ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to pin bo. ret %d\n", ret);
>> +        goto err_pin_bo_failed;
>> +    }
>> +
>> +    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>> +        goto err_map_bo_gart_failed;
>> +    }
>> +
>> +
>> +    amdgpu_bo_unreserve(bo);
>> +    bo = amdgpu_bo_ref(bo);
>> +
>> +    return 0;
>> +
>> +err_map_bo_gart_failed:
>> +    amdgpu_bo_unpin(bo);
>> +err_pin_bo_failed:
>> +    amdgpu_bo_unreserve(bo);
>> +err_reserve_bo_failed:
>> +
>> +    return ret;
>> +}
>> +
>> +
>> +static int
>> +amdgpu_userqueue_create_wptr_mapping(struct amdgpu_device *adev,
>> +                                    struct drm_file *filp,
>> +                                    struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_bo_va_mapping *wptr_mapping;
>> +    struct amdgpu_vm *wptr_vm;
>> +    struct amdgpu_bo *wptr_bo = NULL;
>> +    uint64_t wptr = queue->userq_prop.wptr_gpu_addr;
>> +    int ret;
>> +
>> +    wptr_vm = queue->vm;
>> +    ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>> +    if (ret)
>> +        goto err_wptr_map_gart;
>> +
>> +    wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
>> +    amdgpu_bo_unreserve(wptr_vm->root.bo);
>> +    if (!wptr_mapping) {
>> +        DRM_ERROR("Failed to lookup wptr bo\n");
>> +        ret = -EINVAL;
>> +        goto err_wptr_map_gart;
>> +    }
> This triggers for wptr BOs mapped to the high half of address space,
> may need some mangling wrt the top bits?

Yeah, correct. Shashank this needs to apply the hole mask before looking 
up the address.

Regards,
Christian.

>
>> +
>> +    wptr_bo = wptr_mapping->bo_va->base.bo;
>> +    if (wptr_bo->tbo.base.size > PAGE_SIZE) {
>> +        DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
>> +        ret = -EINVAL;
>> +        goto err_wptr_map_gart;
>> +    }
>> +
>> +    ret = amdgpu_userqueue_map_gtt_bo_to_gart(adev, wptr_bo);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to map wptr bo to GART\n");
>> +        goto err_wptr_map_gart;
>> +    }
>> +
>> +    queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
>> +    return 0;
>> +
>> +err_wptr_map_gart:
>> +    return ret;
>> +}
>> +
>>   static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   {
>>       struct amdgpu_usermode_queue *queue;
>> @@ -82,6 +165,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>>           goto free_queue;
>>       }
>>
>> +    r = amdgpu_userqueue_create_wptr_mapping(uq_mgr->adev, filp, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map WPTR (0x%llx) for userqueue\n", queue->userq_prop.wptr_gpu_addr);
>> +        goto free_queue;
>> +    }
>> +
>>       r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
>>       if (r) {
>>           DRM_ERROR("Failed to create/map userqueue MQD\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> index 1627641a4a4e..274e78826334 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> @@ -58,6 +58,7 @@ amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
>>       queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>       queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>       queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>> +    queue_input.wptr_mc_addr = queue->wptr_mc_addr;
>>
>>       amdgpu_mes_lock(&adev->mes);
>>       r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 8b62ef77cd26..eaab7cf5fff6 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -38,6 +38,7 @@ struct amdgpu_usermode_queue {
>>          int queue_type;
>>          uint64_t flags;
>>          uint64_t doorbell_handle;
>> +       uint64_t wptr_mc_addr;
>>          uint64_t proc_ctx_gpu_addr;
>>          uint64_t gang_ctx_gpu_addr;
>>          uint64_t gds_ctx_gpu_addr;
>> --
>> 2.40.0
>>

