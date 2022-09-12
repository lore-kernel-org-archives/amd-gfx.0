Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2869BECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 13:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450C910E4A0;
	Mon, 12 Sep 2022 13:59:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0509F10E4A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 13:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuIBgCzquX8e1+0rT+X5tbaHb842Vd37zlgYiF4n5XLdwCVD0XZ0pW/hRaQL3no8JoHnlso9MCaCRtDKd3Q2OT8R1YX07QcCrUwwMMy/jvo8lrDhfZr/37s6kRgseShFpcQi7tlnL115OV3QdO1FxSBNNBH63T2UhLxEi8DwMKuGenPxMcrRyfaNU3NkbMlU6YvsqHuiv1CX9xPLcu9hI06l15a7hCuXOpUVUNw42AkaYvvkUrPzRkNDbE4TwORhMAGcwMo0IAmnOOr8z0dgQ78Ir1ete2np9vOl4j74gYv5EZgifY322aoQOJXAJN9KJYRjUrFFUBDTRwloN7vjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcIJGLEv+Nh71pwHXS1IiZCgUsmIJ0hpPJEofBWZOWI=;
 b=CnSNj35GNla7/pLqn9bAWjnHokXfjQ4umPaTMVoQECT8nn5gHWMwtDcl2BoNl1bTn/0jsPMJBj2o9YH0/yNivxFgvHS/T/yfBtyFd/vs84+fzaDaWSnNXHCsNb5q2uYHafzXxUe9W+OlkRYJKL4uQl9bNT8Huv/z5D8HohhJz2SRcrYy04LiOt8vfg/72I1aChuH+Xh1v2Tk+W9/3IOCGv/TvG5QuhsCGkgffoHTJlHG07UtwCD0Vp+tnkaNY0Ns6Qi0NEKBawFFS7uahjWOTVxk/yR/1mBmagXo6abIi2ulExcNNkHBWHTm0ylLK8DSw4g6bhtQ35ga8OIicKG20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcIJGLEv+Nh71pwHXS1IiZCgUsmIJ0hpPJEofBWZOWI=;
 b=K94N72M52iQlpthj/vt9ryfSVAPiJBfNLccIGhTFFodYlhRa5f2+r2OVr7aOup+28yZ/3kH/KvHeZTQOBG4Tp8uC7TGOupv4luiTRAEzWQ3c7ZR8nWlXaTzU4JTRqSsQ7t1zUyYPxpelUxl7jm08Dx2mIrUwP0ngKNOkdDVnXuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 13:59:49 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb%2]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:59:49 +0000
Message-ID: <975d7a80-1100-a058-948c-18d763abccaa@amd.com>
Date: Mon, 12 Sep 2022 09:59:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220909182502.13995-1-Philip.Yang@amd.com>
 <45eb080f-eb84-7b54-73ad-dce8de0727d0@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <45eb080f-eb84-7b54-73ad-dce8de0727d0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM6PR12MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: e14e693b-0b14-4131-1ae7-08da94c70ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFSQ7w9anlklex7uJli0XF705ilXjNIXyF4kRf+H6vWWAJf1165YHvyVlIftPWlBORRUDzS8gsFkVSWIjdryd7IGhsI/fKdqREdahn2xFJDP29rnOGR/5GTxIsRyvwzCH4HMZsTpxtRW6sxaY+NY42xiNzbzt9JecyCNmzUUJxkXwY4Ob2+V3KqczkqFrzUwnB7P3EYNKrcIFgBc+3fuX0rst+ZbqSBzoCOEVHr5hEPGInSLOhxpfbM7hF03GHPLYOu3brZo8tg33bGCgaXgiqL+xbER1qrJJBIfbnwjS5o/85PhAH54Zh9swcV9tKSXFsRrOsjOrWyNOz4nBA41arj2tlW95T/GredtsGHn2gSC5wPVtuhC09ui+46aCgDx+G2iIE4hDD/nXWbs1RHgLd+ycDt8p/fXvj6ucgPHPyulXTfV8dY/xJ4E3cSntFuH/D3Vf6LFVS+VpxrdLSHnq+gKXr5hBiDJ1Ko2H4AXMlVq4L9STf5sGYk6jKpET2cXZWmHtsTFt0uj84eMPmL4Vxq1X9IiGMOlJZAQR5eOwveJ5mcfSk1gNSfpcA/ZRzCTxYR+gzNe2dLS+gx/9Rj/KHHkwgpobd7Ki3xMTLY2EbqDENevtE03i3vIt60kCfJE/XIibEFRacocwk2m/eN9f1Rft2ibvgOPr150gyjcmZB5ArLC4h59GUn9n/b40u2jStVUKVboYNCnK485coZ3Bp9vz5yIiaEmJTIDxlAtL51VQQC4x6t7AtTLoNwLRK3aRQqc6fnNaeq6xC9eW6bfCunTiKmnBLzLft7JNdWrhXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(186003)(38100700002)(6512007)(31686004)(26005)(6506007)(83380400001)(2906002)(2616005)(53546011)(316002)(110136005)(41300700001)(478600001)(66476007)(4326008)(6486002)(66946007)(66556008)(31696002)(8936002)(36756003)(8676002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmIxcm9UQnNMV3F3V3lHd3JVd05XS1JDSkZoR0ZsSEpjTnlMMXRLS3VzN1dV?=
 =?utf-8?B?RitiTktOS25mOGJaSnFSVUt2M1NDaWVSalhGZUFSdzlOdERyVWJHOFMyaTcz?=
 =?utf-8?B?RkNQSy9TSmdHQjVEUkhSSkZIRGRFa20rblF6ZXFNY3ZtRTNuYkd6M0dySlgy?=
 =?utf-8?B?b3BkaHZac0VnNXVzbFk0ZmVJdi9CTnRMVGdIVklHVFkxbUJwSVBzVmRDaXVR?=
 =?utf-8?B?aVNrWmdMKzlwUUJQUFo5RS9oRDRiZkdMNk04bHZsdGJxeW9VeFZlTkZSRkJk?=
 =?utf-8?B?MmdDeWxOYWpnY0IwMy95M3dTbmh5OWV1SE96Uk5DcUtNVkdjTVhSMXBGRjFN?=
 =?utf-8?B?NUF6QVlsUzMvbkcybEEwR0VxYkRnSW1RMHdLd1ViaTV6dWs3NkZtWHJ5a2Nt?=
 =?utf-8?B?cDFHTXV6WnQ1R1c1T2t6TUpycU5XMXFsL3hsUGFqMnhjekNNNC9JZnh6dnp6?=
 =?utf-8?B?V0FqbkdzbmxNNGhyaVVHSDFpcVF2MHdyWXF1QWJQemRjdmxibnRDdnN6NGQv?=
 =?utf-8?B?dkIreXpCTFMvZFRCSDluOWNCQkR2clVpa0Q0bzIwYm44SW9DQURpZEZxQjhs?=
 =?utf-8?B?aTdVZGN3Yyt0RlN1MS9WUytad1drZ1Y2RHFIZ3hjZHYzSElLZ2M1QloxeFJ6?=
 =?utf-8?B?S3c1WFN3Z3ZESlFCK3QwQWZlZXhkWlBXTk14dldySEZ2bC9CNW1lL3hCaFZD?=
 =?utf-8?B?Ui9lb0RQVXpvRzV3SDdTd0EzWk45dWpibWRzTzRRaXFUamRoOUxiS0YrbEla?=
 =?utf-8?B?NFdHSlcxUHkrOGd6cU1BVzJPbUV1WUlsd2FNczBwYUFyditrZW9ia3RHa1dv?=
 =?utf-8?B?QnRKVGhFVDNBV2FlRlJ4YTVjR0xwQkpQby9EOEJzeDZPd3pJZDB2Vk1ONTdy?=
 =?utf-8?B?QjJUd2pBRnJ0KytrWGlIM2FMWHdMV3V2YkFoajRHaXRXZUNKbVE3K0ZxRm1T?=
 =?utf-8?B?V2d5NUdWOVArd0VjSzBQa1pZOGE0Vm43T0ZXUi9wWUxFWUthTEJzb0NFOXJQ?=
 =?utf-8?B?eWVTYWh5Skd4Vy9MdkRVN29zRWR2R21LMldqWXZzdDdOWi9sUURxbWFWZjBv?=
 =?utf-8?B?cjJCZWNYazMyeCtjY1F2NVhZNlUrSzd0OHk3TDZVeFlEWUFGV0UyT0F6aU5U?=
 =?utf-8?B?c3dMWE1FM0hlWmNEU2ZmOG1UekdJTXdVbEhPZ01sWVRZV1NQeTdjU3pOUnlR?=
 =?utf-8?B?eWtmajllN3NYTVVrTm1vNVJPYXhhTXkwWEwyZldockw0NndkN2JROENGT2Zr?=
 =?utf-8?B?aE5ub2MzRHlpbkNINzVpWlFobXRHbEd1N3p5My9admJ0NmwzWko3ZHRQdkdZ?=
 =?utf-8?B?K29yemwyMVBLditVbzJVOEYvdDRaNkRDSnNOTVg1ZURNVGNWdWE0Skt3MVRz?=
 =?utf-8?B?RTBiZC81UFlidUlYS05EYUNXOVRmS0RWczVlbWppNWNPUnNOc1VvNjFPTFdJ?=
 =?utf-8?B?M0Y0YXA3emlSSUEwKzNad1RMVy9tUENuOWpMZzc2K2FKTjVVWkFnTGNiWWh5?=
 =?utf-8?B?VGlVY3EwcDBuOGdZL3g0TVl3c1hsSEUxWVdGcVdHZUZjZFMrc2I5Mlgvaml4?=
 =?utf-8?B?NkNBMFhaUEwvcmxHRUVSQzl3MDBZcTVBN3hMSlBJVDNBNVI1a3hFdittMDB0?=
 =?utf-8?B?NnJPMWtmSUllbWpkYzE4TDRLZmVxMDBvYVpmYXg3M2p1b0VKeGRTRkk1WTJa?=
 =?utf-8?B?SGdCc1dyQkVIV3k1OFhRVzZyZE1CMjREZUNEemlLK3ZYeEtSaFoxRGY2a1VJ?=
 =?utf-8?B?N2oxK3ZCRXRZV0d0a0I0SjlUZGIvVm5yTCs2citMZ2RtbTZXOHFyNlU5WnBK?=
 =?utf-8?B?bER0NkZFWmRhelhQei91MEZQSzRtNFJrUEsvS0Z6aXVrTmw3a1pjRlVpYlRY?=
 =?utf-8?B?ZktJVlNkMkJncUhjK2lNT2tjQWtGKy9UaXY2QkRicHZmL25CODZ6dEdMMElq?=
 =?utf-8?B?MTlxZGlibjFCeCtXdERSOW5TWk1DUFViNzZCTW9Cd3V0ekRIYURxMTg0UUlE?=
 =?utf-8?B?Vnk3dDRvS3J2MWZWVnZucWMwanMxNmJ3SU5QVjlKSVQxZTlnZDAxQVJ6SURG?=
 =?utf-8?B?OXhYdk9oNDA0Y2pVTEtEdmZrYXJpY1VGazlhK2h1aUxGaThuSE0yUUpBcHlv?=
 =?utf-8?Q?fWvE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14e693b-0b14-4131-1ae7-08da94c70ef0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 13:59:49.8084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK7dKq0UdPhkFriwUof427COPywGuaiPZ30hDViJa8QF99ozEcxSNNMbE/V3QPv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-09 16:01, Felix Kuehling wrote:
> Am 2022-09-09 um 14:25 schrieb Philip Yang:
>> Free page table BO from vm resv unlocked context generate below
>> warnings.
>>
>> Add a free_work in vm_bo base of each page table BO, pass vm resv
>> unlock status from page table update caller, and schedule the
>> work if calling with vm resv unlocked.
>>
>>   WARNING: CPU: 12 PID: 3238 at
>>   drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>>   Call Trace:
>>    amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>>    amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>>    amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>>    amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>>    svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>>    svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>>    unmap_vmas+0x9d/0x140
>>    unmap_region+0xa8/0x110
>>
>>   WARNING: CPU: 0 PID: 1475 at
>>   drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
>>   Call Trace:
>>    dma_resv_iter_first+0x43/0xa0
>>    amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>>    amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>>    amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>>    svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>>    svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>>    __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>    unmap_vmas+0x140/0x150
>>    unmap_region+0xa8/0x110
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 40 +++++++++++++++++++----
>>   2 files changed, 37 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9ecb7f663e19..ac7cd2c738e5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -150,6 +150,9 @@ struct amdgpu_vm_bo_base {
>>         /* protected by the BO being reserved */
>>       bool                moved;
>> +
>> +    /* work to free pt bo if vm resv is not hold */
>> +    struct work_struct              free_work;
>>   };
>>     /* provided by hw blocks that can write ptes, e.g., sdma */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 88de9f0d4728..e6f6d7e6368f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -37,6 +37,8 @@ struct amdgpu_vm_pt_cursor {
>>       unsigned int level;
>>   };
>>   +static void amdgpu_vm_pt_free_work(struct work_struct *work);
>> +
>>   /**
>>    * amdgpu_vm_pt_level_shift - return the addr shift for each level
>>    *
>> @@ -607,6 +609,7 @@ static int amdgpu_vm_pt_alloc(struct 
>> amdgpu_device *adev,
>>       pt_bo = &pt->bo;
>>       pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
>>       amdgpu_vm_bo_base_init(entry, vm, pt_bo);
>> +    INIT_WORK(&entry->free_work, amdgpu_vm_pt_free_work);
>>       r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
>>       if (r)
>>           goto error_free_pt;
>> @@ -624,23 +627,46 @@ static int amdgpu_vm_pt_alloc(struct 
>> amdgpu_device *adev,
>>    *
>>    * @entry: PDE to free
>>    */
>> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool 
>> unlocked)
>>   {
>>       struct amdgpu_bo *shadow;
>>         if (!entry->bo)
>>           return;
>> +
>> +    if (unlocked) {
>> +        schedule_work(&entry->free_work);
>> +        return;
>> +    }
>> +
>>       shadow = amdgpu_bo_shadowed(entry->bo);
>>       if (shadow) {
>>           ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>>           amdgpu_bo_unref(&shadow);
>>       }
>>       ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>> +
>>       entry->bo->vm_bo = NULL;
>>       list_del(&entry->vm_status);
>>       amdgpu_bo_unref(&entry->bo);
>>   }
>>   +static void amdgpu_vm_pt_free_work(struct work_struct *work)
>> +{
>> +    struct amdgpu_vm_bo_base *entry;
>> +    struct amdgpu_bo *root;
>> +
>> +    entry = container_of(work, struct amdgpu_vm_bo_base, delayed_work);
>> +
>> +    root = amdgpu_bo_ref(entry->vm->root.bo);
>> +    amdgpu_bo_reserve(root, true);
>> +
>> +    amdgpu_vm_pt_free(entry, true);
>
> Doesn't this just cause the work to be scheduled again, rather than 
> actually freeing the BO?

You are right, I will send v2 using Christian's suggestion to use a 
single worker in the vm.

Thanks,

Philip

>
> Regards,
>   Felix
>
>
>> +
>> +    amdgpu_bo_unreserve(root);
>> +    amdgpu_bo_unref(&root);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>    *
>> @@ -652,16 +678,17 @@ static void amdgpu_vm_pt_free(struct 
>> amdgpu_vm_bo_base *entry)
>>    */
>>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>                     struct amdgpu_vm *vm,
>> -                  struct amdgpu_vm_pt_cursor *start)
>> +                  struct amdgpu_vm_pt_cursor *start,
>> +                  bool unlocked)
>>   {
>>       struct amdgpu_vm_pt_cursor cursor;
>>       struct amdgpu_vm_bo_base *entry;
>>         for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>> -        amdgpu_vm_pt_free(entry);
>> +        amdgpu_vm_pt_free(entry, unlocked);
>>         if (start)
>> -        amdgpu_vm_pt_free(start->entry);
>> +        amdgpu_vm_pt_free(start->entry, unlocked);
>>   }
>>     /**
>> @@ -673,7 +700,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>> amdgpu_device *adev,
>>    */
>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm)
>>   {
>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL);
>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>   }
>>     /**
>> @@ -966,7 +993,8 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>                   if (cursor.entry->bo) {
>>                       params->table_freed = true;
>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>> -                                  &cursor);
>> +                                  &cursor,
>> +                                  params->unlocked);
>>                   }
>>                   amdgpu_vm_pt_next(adev, &cursor);
>>               }
