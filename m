Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ADEEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 07:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A20410E525;
	Fri,  7 Jul 2023 07:57:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2226910E524
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 07:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYz2Bf9YJjbDd2pQXCIkdqI1STlGTiHNuaMpbjCaa1xvfbqN4hKRr+sr/dMNUk44NF420KWRmh+o29MX9omw+YRQy3Tes6l9IB9Dp4f5bE0wd7LOBN2T2qmNm+ldV86D7lIf2N6lhLiL3TyOBo1D8Twt+iB7VoWjN7sWEsybjX0TKwZp1cJ4tnPXVTxsUv6RBFcGorHEPG12Y7PR9YgUTwHjqGalp2uWbGZ0jEeVI6+ytMLDHfVPPy76enoIgpmI+kqTa0P023lXtbDLokbkeSoV0W052PzdbBT0PYMKW44+ZsBEMN4H7z7WGT5aQNBVwU2JnYmdGjYx/IuUUQyxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cft2gtmTmbxRRgNDAUuaE8VWElVzmpF8CJ7SD+/rEqA=;
 b=PtJHXEIOkJJV8Li/nNXJVKlqYM4lvqrV1ngPCT8xdutuZpUo3DUKQOUENHKk9AEoDtgnMAeDPhxNLqtvToZpeD+ezPppvxXHxIqNlqiiLtz5G+CNocRmZBfw9LAA1cUAXLG36+xDSQXMe4MNfengTUWV+VYdoe5Okq8LGKKOlU9h54/2BA0tRYjvYZW94yBo/souxXuIAlKCKK8EWY7HHm5Tu1obvdzO+En6/uoZNAuzF9d1RQvbD6ePMKy0aBmiRUF+P70DAQ5YKCo65jkkD+rIDpZc5BPQTFh396MqQ2XrDlRbUAwZ7F3bwpVYZs5et5G8FezzD/uSs1YinDPkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cft2gtmTmbxRRgNDAUuaE8VWElVzmpF8CJ7SD+/rEqA=;
 b=AuHfB8MqnQcd/+ao9u3VbthDMay9XBVk5wa3nOUeoPjnFstJ+C0zWihtTj1X1eG5smfpF7sz308mmdRdTfs0BnwrK9p1bqCRkWkCrOeX+Rj7vE0WJUZr1VL3gwZtKVmM5M8GowLSkuQ/bfL/0kUjTojUaY0DdBWiBgQx0zTWPG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 07:57:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:57:18 +0000
Message-ID: <721699ed-b08f-59fc-42eb-4b0f5b3b3d9c@amd.com>
Date: Fri, 7 Jul 2023 09:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 08/10] drm/amdgpu: generate doorbell index for userqueue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-9-shashank.sharma@amd.com>
 <2834445d-8da2-e853-50c2-2fececdb86e2@amd.com>
 <317c5dc2-ef39-d88c-d78e-5823daa5e92f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <317c5dc2-ef39-d88c-d78e-5823daa5e92f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: b969d8a2-ed99-4933-87ab-08db7ebfc914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dj5fcZP7Y3tRJ/fmBkOrw1G64K32JfCQC02M8bu+jLUh7QcpcnbNWDhPX7O46MZW2Wy3pa5xysL8hSO/EtQQHgUbftul/H5w1cKShdUSk8+x6AcYwKVQou5cOwA2YhL9Nh01+a+LXurXMO2Q3GiURBWbHRS0L5XqzHHOf5h1sg6JSJOobz1CkS9yrinHJsnyaMskyrfus/WIVBJSvsdgZef1HVCHoLUQmRglwh4SxS4UaPgKb6eqJd9681TkABNQdpH4BPMcQwpGadsOHHj6zHoqFemsmxSf+NwJtvhKnaqvIeleKzM8Sz2+TC5nfFidBvg4SVP76Thp+64UISUyCE1Jx+OhpW4kz86oAlvnvtG+cyfQWs4J9SxRGpX9/Uf+zsDwEMVvk7vdwhxxA97c2rGHOqKXONZ7XZPo41qpaahTpAdIUwoUv3RsbX801PHoKBIsECeMPanglag6Nk5cPb2J7HwSV/p7pyFGbQTv6RY29p5NyDJSJrof+ixY/a/2PLaPfd5ifOcTSoLWqQMBNt79mgzyso8mNX8KnnYHSYtNRIvDWMPF2XQC1FMZufZFIlXmk0GSIi3GVf/Kbyh1HFseqTlPnn4UmUHe+yrvB5UthcJZ0jfT1x9KL8IwsoRP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(2616005)(6666004)(478600001)(6486002)(66946007)(186003)(966005)(6512007)(53546011)(2906002)(66556008)(66476007)(41300700001)(316002)(4326008)(8936002)(8676002)(83380400001)(38100700002)(5660300002)(36756003)(31696002)(66574015)(86362001)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGI0QlRwekJkQTAzSHNMTGtQY0lZTnQxUGFuSjFNMlVIWDVobEVzb0JKRXNx?=
 =?utf-8?B?OWJDdVRobjRqbmd0SHFFMlRtbzd5ZTBrL2Zsd1ZVQ1pzcTVIOThrcmpTRVMr?=
 =?utf-8?B?cDV6MFdqYjNCaytrVzZNZ2RIZkVOdXdvSFRrV3pOaEJzbEJMY01nM0pjdTVM?=
 =?utf-8?B?SVAybHVRWk9Kem9UV01pZXRacUxjQTRvd1UvdjlvZnhiSWNHNjdaMlhKcEtx?=
 =?utf-8?B?bnRIOGZ6WFQ0aS9KQzIwRUd2N3ArZWVOOWxkQmhKM0VOQjhoWGZicDBUOFRJ?=
 =?utf-8?B?Uml4ZnR3ckVLWGhvWVhNNXBlWDlwMkgzcC85NDNFRDA2UEx0Mkh3TzEvd3o2?=
 =?utf-8?B?aW9aSlVZNUtNMUZCaEljVzBQbmF4SzBSRzhJZG0xTWcxdVRTaFNvd2NWdWZB?=
 =?utf-8?B?VXlubDF1ZTFwaUtKbXRVU0IrQW5mejFjekU1d0RLczFmSE5kY0tkNTNYWmtB?=
 =?utf-8?B?LzdFWnIvSE5mZkVJRlN2OHpacWxlZE1DbWR3ZVdDaVNtQTZBWEFqZWxXcnd1?=
 =?utf-8?B?YzBvSlkwSk5nSDQxV2lrKzNYOVlHSVU5Nkd1M1ovRWE5YUhuclVCMnkxZEZX?=
 =?utf-8?B?MzUwVExuQktNeGt5VWMrT1BTdGpKamd5Mkd0UGZORVZSSURVV3dSaFZNU2lX?=
 =?utf-8?B?eEVENHJPeU9SUWM1c295ZHJ6dktGTzEzbEtkbTdRbStxNnhIWFI5emU0bnp1?=
 =?utf-8?B?djBTSE5jajIySmZRYjhCeGdpSUNNU0hTZWVkWEpSc2ZGV3FWTDFaRTNwdnZO?=
 =?utf-8?B?ODBxd1N2TzZBaklsZi90WUlnMTRYMHhiajlhZzY4RFRPOFUrSXNtY0tvWU9a?=
 =?utf-8?B?cmFRLzQybmMxNDl1eHgyVTlPQU1YeDNCbDBNajRnUUs2alFKSlAzZHY0amNY?=
 =?utf-8?B?ZlVaei9aSm5ZRTFhWElVT1RtNlpVRHg2WGtnRTRKb1dHcnFUZHk2b0wvNUtJ?=
 =?utf-8?B?d09waDZlTTIxSUtPNEVNMEJ4UGZKdGhpYUp6KzN4YWRzYVptMXlPdHplUTBF?=
 =?utf-8?B?Z05KSTFaMUMzQmVsVExOWE8wbDVKSDBOR2YxaGNNUUZSRnBUTzMzbXp5RW9q?=
 =?utf-8?B?empzd09NVnFtdkFkMXI3blp1c1pRZFBVQ29LcUU3cTFDamxkeWdaRDNSdWMz?=
 =?utf-8?B?dW9EYmsxZ25DMFRRZkdXYU5NS2ZzRlZRdlByZGpNa3N1MFNnNFhlUUFSVnhl?=
 =?utf-8?B?UVc2TjdHNXIwZC81bStlOElFc01oMXB2VTFvQ21hM0FhbEpadGppcGtKMlVJ?=
 =?utf-8?B?QVJrT0sxNXlYSmI2d3VVK0lKaERyMjVNYXRPb3B2U0RWZVdOUnJ3UEhaL0Z6?=
 =?utf-8?B?b25jK1gxSVlydmtQdXJhN1p3eVdwU0pjRnNOeHpkdlJxZEhjS1ZiRnpGRklh?=
 =?utf-8?B?cnRoR1o4bmZ4MzlUUm5rcksrOVcvR3RWdnlXdVEvMUZ3Y214NW1LOHluaTBi?=
 =?utf-8?B?NWhIQTE5TjlEbjF0ZDZIaS9KYy9PM1luR0FReFFIRDJmVUI2THEvOTVOdEtW?=
 =?utf-8?B?VnhTNk5lMzh5S2VNQ1gxWGRpNnVRRlVaNDVyd29yRXN2OEl4Tlg1SVIwMGpa?=
 =?utf-8?B?emJ2eXFQRlhVOWNTTlBKT1lOWThUb3FMZHVTa0NHbXpDSytGb1JqbUFnMkZR?=
 =?utf-8?B?NHpOdW0yT3B3dnNkNEdiMkNiUzVZcm5jaVRhNzBZNXhxYkNBc0pYbGhQNENw?=
 =?utf-8?B?QlNFdld4TG5NNW0xVzBjbmdXR1B5czdqdlc4L2czZFc4K0M2eWVvS3lRMXV2?=
 =?utf-8?B?Sk1hdnRsMjlxQVNvMEdQcVlUamFmdTd0bzI4dmFVZXhScnhBdEU3MDJYbnc3?=
 =?utf-8?B?S2ZrZEtnakVKQWJjL0hXalpZVFI5M1Jwa2Jrc05ON1BpcnJ3S0NJTU9lcmNY?=
 =?utf-8?B?MVNpaUFhQVJjOUtCTitUOXZUbGpOVE1ITnZkdi84b2IvRzZkbzNvNXhZYm5L?=
 =?utf-8?B?S3pKSUlNVnBsa3dVV05iKy95elJHamhET3lubHozUzZnTncxRzNNVUxDNUYv?=
 =?utf-8?B?WStzWmlRd3FnNFBuZ1pPSlczT0taUGNja2RRU2NRckN1emxmVjJ1cWRFUXpP?=
 =?utf-8?B?Z1NMdEk2YjBuaktrQXNyNThGYzhtZHFaUzVZaUN3U1BDSXNmcUpUc0Q5ZTh6?=
 =?utf-8?B?UXNDOFQ2OG0xLy8zTjJ6RFZEdFRDNU5uKzBkYUlsaGhLY2Y5MjV5b3Z5Und4?=
 =?utf-8?Q?nanwv2UilyJsNLjbefSrZUw6qq+SdflExkv/SIh3O42+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b969d8a2-ed99-4933-87ab-08db7ebfc914
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 07:57:18.3277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suwep3Sgu/jpTwQdUUot/+/vq5sck99zqzUi/MlhJ+MheiJetC15pd84ggZs1YEB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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

Am 07.07.23 um 09:39 schrieb Shashank Sharma:
>
> On 07/07/2023 09:15, Christian König wrote:
>> Am 06.07.23 um 14:36 schrieb Shashank Sharma:
>>> The userspace sends us the doorbell object and the relative doobell
>>> index in the object to be used for the usermode queue, but the FW
>>> expects the absolute doorbell index on the PCI BAR in the MQD. This
>>> patch adds a function to convert this relative doorbell index to
>>> absolute doorbell index.
>>>
>>> This patch is dependent on the doorbell manager series:
>>> Link: https://patchwork.freedesktop.org/series/115802/
>>>
>>> V5: Fix the db object reference leak (Christian)
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 34 
>>> +++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
>>>   2 files changed, 35 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index bb774144c372..61064266c4f8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -32,6 +32,31 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr 
>>> *uq_mgr, int qid)
>>>       return idr_find(&uq_mgr->userq_idr, qid);
>>>   }
>>>   +static uint64_t
>>> +amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>> +                     struct amdgpu_usermode_queue *queue,
>>> +                     struct drm_file *filp,
>>> +                     uint32_t doorbell_offset)
>>> +{
>>> +    struct drm_gem_object *gobj;
>>> +    struct amdgpu_bo *db_bo;
>>> +    uint64_t index;
>>> +
>>> +    gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
>>> +    if (gobj == NULL) {
>>> +        DRM_ERROR("Can't find GEM object for doorbell\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    db_bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
>>> +    drm_gem_object_put(gobj);
>>> +
>>> +    index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_bo, 
>>> doorbell_offset);
>>
>> This can only be done with the doorbell BO locked and as soon as you 
>> unlock it the value becomes invalid unless you pin the BO.
>>
> Which means I need to use create_bo_kernel() for doorbell BO's or 
> specifically pin it while creating it ?

For now I think you need to pin it when amdgpu_userqueue_create() is 
called and unpin it when the userqueue is destroyed again.

It's probably a good idea to not use amdgpu_bo_create_kernel() for the 
MQD and context BO either, but rather explicitly pin it during queue 
create as well.

Christian.

>
> - Shashank
>
>> Regards,
>> Christian.
>>
>>> +    amdgpu_bo_unref(&db_bo);
>>> +    DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", 
>>> index);
>>> +    return index;
>>> +}
>>> +
>>>   static int
>>>   amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>>>   {
>>> @@ -64,6 +89,7 @@ amdgpu_userqueue_create(struct drm_file *filp, 
>>> union drm_amdgpu_userq *args)
>>>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>>       const struct amdgpu_userq_funcs *uq_funcs;
>>>       struct amdgpu_usermode_queue *queue;
>>> +    uint64_t index;
>>>       int qid, r = 0;
>>>         mutex_lock(&uq_mgr->userq_mutex);
>>> @@ -87,6 +113,14 @@ amdgpu_userqueue_create(struct drm_file *filp, 
>>> union drm_amdgpu_userq *args)
>>>       queue->flags = args->in.flags;
>>>       queue->vm = &fpriv->vm;
>>>   +    /* Convert relative doorbell offset into absolute doorbell 
>>> index */
>>> +    index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, 
>>> filp, args->in.doorbell_offset);
>>> +    if (index == (uint64_t)-EINVAL) {
>>> +        DRM_ERROR("Failed to get doorbell for queue\n");
>>> +        goto unlock;
>>> +    }
>>> +    queue->doorbell_index = index;
>>> +
>>>       r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
>>>       if (r) {
>>>           DRM_ERROR("Failed to create Queue\n");
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index afaeecb9940a..8edb020683a1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -6719,6 +6719,7 @@ static int gfx_v11_0_userq_mqd_create(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>>       userq_props.queue_size = mqd_user.queue_size;
>>>       userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>       userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>> +    userq_props.doorbell_index = queue->doorbell_index;
>>>       userq_props.use_doorbell = true;
>>>         r = mqd_gfx_generic->init_mqd(adev, (void 
>>> *)queue->mqd.cpu_ptr, &userq_props);
>>

