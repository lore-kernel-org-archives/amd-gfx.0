Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB81EEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 09:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4034210E53A;
	Fri,  7 Jul 2023 09:00:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6747F10E53A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 09:00:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm39wQW2x7aaj4BCXkFRho7vIA9OwPpllD7alltqI2JnHXDASSFN0Kdb0Qx4qqhPiH7TBZVkw2FmJfPSORhbmkTBuCTg+7i1Ye2tI/6fIXyfFSAXRKbjGckRXbolaQrrKbv2qY4WRYMjqIUQUdWtkraOo74JgWHEaXeAFJeoEkNEDw4rE5hiVKmbuDudPITadMkZkK8lm5aLQfLMb8a3jpbS+GBhZfWZjEp2RyJkbn4/bANX7i4iQOV7dtwpQxRw16O6eP5ye1rMY6Sa65+JQx4uY2T+D+tSEnSc/CM0FqWVRPoGTRXbYcyzgzRyaFFtGNvswviD8WM8ZtQuaeo9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiS7+9rMezv9+UVYpV9pcmTw6Mwwe0x5UNfFEvXL/r8=;
 b=ECPM/zLV5+LP461UaWeSIcXNbeIUUXf/uNjuwiDsVfFW7vM1oGw1hQII5MtIMnv0qYjhUUtwPo8OPIl1bJkGH/ZPqOJPDLF4DE6mSf4FQi+E1pQo2y88S3+mMjJDfnByVUBHQv/dEv8b9A1KodXEaEX6E1rvYbHsBvT6PnlUmzAzWjiGebX+ayix8qVFAdvjxMclsWb6hqataW3OM5ikNi1pvMUJnaTBtueUIQnkYJSaEd1xYncaS9kM+FfKgQ5/Iegfa1Yzm1SL0j0weZ6eMAgGD5cB+6W9Ezno/EJWaUsw0KI5yLlzCqqiiT0RvyVLFtpNZV+kMfm86dsOf6t/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiS7+9rMezv9+UVYpV9pcmTw6Mwwe0x5UNfFEvXL/r8=;
 b=gtKD8yMkJr6Bo3r4z0t1gbwviBa30S6ynqxXMqGO5xfDKyWBuc+4QBusdB+lW6oY+MSz12SSM2vX4gbEYQP+pf69rvVUOjffXbFW2NGgxBO38TRkydnCuAyUWFjnbLoD/shmh1+FOV0y4A1bfQDcTIMKA9cG/ve5fm3Fs4wpG+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 09:00:14 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:00:13 +0000
Message-ID: <09efa7e3-4c8e-5b43-a08a-f19424b8d0eb@amd.com>
Date: Fri, 7 Jul 2023 11:00:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 08/10] drm/amdgpu: generate doorbell index for userqueue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-9-shashank.sharma@amd.com>
 <2834445d-8da2-e853-50c2-2fececdb86e2@amd.com>
 <317c5dc2-ef39-d88c-d78e-5823daa5e92f@amd.com>
 <721699ed-b08f-59fc-42eb-4b0f5b3b3d9c@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <721699ed-b08f-59fc-42eb-4b0f5b3b3d9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c50e682-3014-452b-033b-08db7ec89346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtpE8Urif7Yzk+f+ngFggIaNFau+eULZjA5smevSl2/VX6JQeOmMs3yHEZdAuXL7Umbqobf12tuWQpYVIMjZgdFhHIYxG041TEEIHCqHtlwG3K9P+OmYDEyCJUrkjYFYPc7ouc/3ZqniX9ImjEck5p1jwNWjLqFvOTBoYRV+kgvSCb0ZYWJXlQSraxtIeJJ74sujnmqlWgJQUWq+ybORGFFEJVOFG5myQOe+G1ya3OSaqkWe0q9ovPFxe8+xwdY4cXIC8rherW6qFl8/fzSaDhEALrzi3ImZI/Q89HsIur0QVIYfvocbiADC7dLX5h258skiT76RSj+l/nG7fwTbzscGQ/ySu7dPiUC3HbZUtTum6sC/uWi0qJ1p52Ys55Jxu4nB9uAxpvabn2tEc1AnQck3mIl6LL4UjAhBPOO7/JSe3vZLSq9W7YVmzWu6EcvpV2+t+ZZB/Q6OWeP0RvYKbniaacr1UCMp8mFaMEJnKZcPJzgjJ9wIJRYUXMRkTNoVOYVVhGmuO9e7VT5/dcHneTi2CjuXGo9CDhAVsfZCyFM0MlZ4HSWx0UKs/VVjMMgIBDURpT9w8Pre/p6efoFRPB1ziAEmlFZE7pof5cj5t9/1J+8Awk0TYyn9SKWgPiPX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(186003)(31686004)(44832011)(66556008)(66946007)(478600001)(4326008)(316002)(66476007)(36756003)(8936002)(8676002)(5660300002)(2906002)(86362001)(41300700001)(31696002)(6486002)(6512007)(966005)(26005)(6666004)(38100700002)(6506007)(66574015)(2616005)(53546011)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5Rcm45ejJPaHFGRDJqYmM1U1A4c1lMM0NjSWdIVHJCbDR0cWhIRWM3aTN4?=
 =?utf-8?B?ck5tNENYQi9BNFdDVXNaNHVMUGdZcWtMMTJlVUlJT1lSSmVRUXU0UDBxY0F0?=
 =?utf-8?B?SnRoVTlZTGlYQ3g3WEQzTm4yL3NmUnZ5Rk9aMEhUK2xkdXJXc1FsTFcxbm1m?=
 =?utf-8?B?WURhb2cxdGx3b1gwRGNLRmwzREpHa2x3NG9zdjZ2UkJSeDZBUnlzTnZMelFS?=
 =?utf-8?B?Yk5DRjVFNUZlLzFBR0htOXlJNFpoejJrQ2pUb24yYVFDKzAzUHhnTTExZlVr?=
 =?utf-8?B?Zy9CQTZPWjVVdlZmTzZ4bUZEejZ2YkIzbzlDcTNrVkdhdGNlZ3IwYU0yL2Fq?=
 =?utf-8?B?bmZVc2w0Nm1mNGNsN2xDT29zNXRMcW9TZHpsanJ3blYvTnlVT1lFMlREZTJj?=
 =?utf-8?B?UzZ2eVU3Uk1GK1pOUVFZckhIbk9oMDMzUGsrWGtqOUFYcHgrM2wwMVMwcCti?=
 =?utf-8?B?dXFCbGM3K01rT2o3L2w4TGJxOXQ1dDZCTHYrTE9pMDFOL2IrSUx1Y08vdHN3?=
 =?utf-8?B?enUrTlBHWjZYUGNnRTRQaVAyUkFoTVRvOEZ3RXJ3S1ZGOHRGN3pBc1VSZFJj?=
 =?utf-8?B?N0tUbi9uSGNLU1I5V2h5M3VpTWsxcit3K1N1ZE1ZZURBUHBQeTFlVkRhK1dB?=
 =?utf-8?B?allUSmNBenlOOG5COFlwd1lvdTVJQkJTOVBTYk5hWFVQUmJrV3ZoNWxuUnRq?=
 =?utf-8?B?bGtXamE0bVhPWVBmamFvWFZNQnEyZ2hiRFBpTTJMam9CRGdqWWpUVnNhSE1l?=
 =?utf-8?B?djlHMkxoNkQxQ3YwVEpmU2JyTXVIdnlWUGczeno3SkphTXF1QlNMTExQbmVC?=
 =?utf-8?B?Unk5amhFU01iR1pLS3VpMEhoTTVEUHp3UnIxamFRVmJpak5SYWVWZURBZ0I2?=
 =?utf-8?B?WXdDdG1hd1NQS1VkOFg4QVhmRFFnb2UyNWRqNjdZNGxIeUg4Nmp0Rm1KbG5O?=
 =?utf-8?B?amNCNjJDOGlWK1BlTXFuTlJXSk5BUU1kVEoxWTdCRzdBK0lkbHp2STVqUWhK?=
 =?utf-8?B?UVBhZnhJa1hyVk4zVU5rZXA2SWkybDZkZE52YmFWSDFhdG43akpaamowREl6?=
 =?utf-8?B?TDI1ckpQV3l5Y2JhUWhNaGdOdk52bUw1ay9NRE45SEhUMXNza1laKzdSZzlD?=
 =?utf-8?B?NXROTW5WeXAxVHFDeVNFSzByVk94QmQvU001UCt2NzBvVEJkaGxncGN6N0l2?=
 =?utf-8?B?SDlqUTEwU2hMMmZYeEZycTZydjJkOE9McXJHcEI0dkpSMFdqSTlIaUtkaTBO?=
 =?utf-8?B?NlRIcXFHRE9sY3BBN24rL1AzNS9aTUhmSmczcUNabUJ0Smk2OFNnMFlaQ1VU?=
 =?utf-8?B?dWQ1eXBOc29QcE1IQWlBTDBlKzFNakhZSFZKTWRieXMvZ0lTa3o2Tnc2OHgy?=
 =?utf-8?B?RVpXb1llN2VzRWlBdU9GL0VyWXZjeVlobUFCT0l2bzFkeU41cWNXRlhZU2F5?=
 =?utf-8?B?ZDZaRWdMOUl3VjFKNlN2NjgvZHE2V3J5NHJzQmkrMzFOQjloV2pYVk90ck5t?=
 =?utf-8?B?NkE3R01WeUg4NkN4R3Rrd0lveXFNaXJjdDcrTkQ2NldFRWhrNml0MHd0NG5p?=
 =?utf-8?B?WlN2Z2tSZjU2ejZpUGJVbU41TkZjNlNSQUJBdnV3OXhFQWl6SGRHbzhOYTRV?=
 =?utf-8?B?UzB2eTBLMzg2QkZlZkp3aWFydW5KejVpVXBVZU9JbElXd3F0YlJ5WEdzYjY2?=
 =?utf-8?B?cUVCTnpPR1FpVHA0TUhNSEJrNDBNdFpObDQrQVlXcm9nS2Q0T2ZBYUVGNkNl?=
 =?utf-8?B?SUVtdWplU0paTGo4M3B0dnBWYmQzSmFCVlp5QkRWQXp1cEpoMFlFMjRnbjdX?=
 =?utf-8?B?Y3d3bkQ3NnZJV0kxUVF2dU55MXJuM1g3VWZKQjRTcHRQNEo1WXhnZ0JxcjNp?=
 =?utf-8?B?ZGp4VE9TQlZMRHBFczhaTG1qb3lDS2tYS28wRnliYUl0dzFPZnlmbVVGYkRP?=
 =?utf-8?B?RHN4YVh4ZjZhU2NtQ1ppSkthVTZoVmVLei9DcStUc3l3S1dIOTNPbEpkUTNU?=
 =?utf-8?B?cWRjbG40VzlGOTFXT3lkcTgvbDdwc2prS0VDZ3hMVkphSVFKUmY0bXNYTTZP?=
 =?utf-8?B?elZHWlBqU3JkWXJkdE5wUFpnR3RpNllJQXViZGZCWW1Zak5CbkxrQzQ5QXhQ?=
 =?utf-8?Q?tYij8OGIuHq/B16KVoJKKAi3R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c50e682-3014-452b-033b-08db7ec89346
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:00:13.5342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvxNMXiFGIL/MPVGYxdL/QFZaDiYZ2KxMOQyCtA2P92Im4b6MAwnkbKkM1tHT0aGpll9kdFrk1e5yHaoji88Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/07/2023 09:57, Christian König wrote:
> Am 07.07.23 um 09:39 schrieb Shashank Sharma:
>>
>> On 07/07/2023 09:15, Christian König wrote:
>>> Am 06.07.23 um 14:36 schrieb Shashank Sharma:
>>>> The userspace sends us the doorbell object and the relative doobell
>>>> index in the object to be used for the usermode queue, but the FW
>>>> expects the absolute doorbell index on the PCI BAR in the MQD. This
>>>> patch adds a function to convert this relative doorbell index to
>>>> absolute doorbell index.
>>>>
>>>> This patch is dependent on the doorbell manager series:
>>>> Link: https://patchwork.freedesktop.org/series/115802/
>>>>
>>>> V5: Fix the db object reference leak (Christian)
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 34 
>>>> +++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
>>>>   2 files changed, 35 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index bb774144c372..61064266c4f8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -32,6 +32,31 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr 
>>>> *uq_mgr, int qid)
>>>>       return idr_find(&uq_mgr->userq_idr, qid);
>>>>   }
>>>>   +static uint64_t
>>>> +amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>>> +                     struct amdgpu_usermode_queue *queue,
>>>> +                     struct drm_file *filp,
>>>> +                     uint32_t doorbell_offset)
>>>> +{
>>>> +    struct drm_gem_object *gobj;
>>>> +    struct amdgpu_bo *db_bo;
>>>> +    uint64_t index;
>>>> +
>>>> +    gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
>>>> +    if (gobj == NULL) {
>>>> +        DRM_ERROR("Can't find GEM object for doorbell\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    db_bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
>>>> +    drm_gem_object_put(gobj);
>>>> +
>>>> +    index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_bo, 
>>>> doorbell_offset);
>>>
>>> This can only be done with the doorbell BO locked and as soon as you 
>>> unlock it the value becomes invalid unless you pin the BO.
>>>
>> Which means I need to use create_bo_kernel() for doorbell BO's or 
>> specifically pin it while creating it ?
>
> For now I think you need to pin it when amdgpu_userqueue_create() is 
> called and unpin it when the userqueue is destroyed again.
>
> It's probably a good idea to not use amdgpu_bo_create_kernel() for the 
> MQD and context BO either, but rather explicitly pin it during queue 
> create as well.


Noted, will do that.

- Shashank

>
> Christian.
>
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>> +    amdgpu_bo_unref(&db_bo);
>>>> +    DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", 
>>>> index);
>>>> +    return index;
>>>> +}
>>>> +
>>>>   static int
>>>>   amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>>>>   {
>>>> @@ -64,6 +89,7 @@ amdgpu_userqueue_create(struct drm_file *filp, 
>>>> union drm_amdgpu_userq *args)
>>>>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>>>       const struct amdgpu_userq_funcs *uq_funcs;
>>>>       struct amdgpu_usermode_queue *queue;
>>>> +    uint64_t index;
>>>>       int qid, r = 0;
>>>>         mutex_lock(&uq_mgr->userq_mutex);
>>>> @@ -87,6 +113,14 @@ amdgpu_userqueue_create(struct drm_file *filp, 
>>>> union drm_amdgpu_userq *args)
>>>>       queue->flags = args->in.flags;
>>>>       queue->vm = &fpriv->vm;
>>>>   +    /* Convert relative doorbell offset into absolute doorbell 
>>>> index */
>>>> +    index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, 
>>>> filp, args->in.doorbell_offset);
>>>> +    if (index == (uint64_t)-EINVAL) {
>>>> +        DRM_ERROR("Failed to get doorbell for queue\n");
>>>> +        goto unlock;
>>>> +    }
>>>> +    queue->doorbell_index = index;
>>>> +
>>>>       r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
>>>>       if (r) {
>>>>           DRM_ERROR("Failed to create Queue\n");
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index afaeecb9940a..8edb020683a1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -6719,6 +6719,7 @@ static int gfx_v11_0_userq_mqd_create(struct 
>>>> amdgpu_userq_mgr *uq_mgr,
>>>>       userq_props.queue_size = mqd_user.queue_size;
>>>>       userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>>       userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>> +    userq_props.doorbell_index = queue->doorbell_index;
>>>>       userq_props.use_doorbell = true;
>>>>         r = mqd_gfx_generic->init_mqd(adev, (void 
>>>> *)queue->mqd.cpu_ptr, &userq_props);
>>>
>
