Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50BFC6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 13:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A35410E2BD;
	Tue, 25 Apr 2023 13:33:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08BF610E2BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 13:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU8KZi1D9hYCRDu2LEIW+B2ld2pNOK+Z7X7vYXmsTaeEtQGVT8bumKVSUgZFy/GOb28nyWtr8HPovAMH4BiE3aR2lSc6Lk2Yl3Ep73VsfXOMWRTtTXBXfHBGDbM8rLsDqgd8YtwUUlZuJzVlEvkQty/3w7BL2hSjg5ICfKKt9+KvlABAqD0tXWQkPK3ddz7MZY5BvGY4wRL4BzZcdivlK2CRiT6usDAJvSy9VFm6i0K8+TYC5VVLyBVJSsywWcYidKcAuGvhbNiD5e6h7JZiMSRuMuO8cDANk8xVesWPIgs2l2wH/PQzmBP//0Rs9cXQKLcxhAfE+VkkbY+tZlyvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xAPMG47O/9fpiRbuxI8aCJTX46pOYvcUJUiS+KSM40=;
 b=aHkzMYz0z7R0s9kuZsOMrDfMEBFcegkYoYVb61K8fXXobiR8h8j6/1g3A+I76Fi39Y/4ZZciOJSWmLqryxpVMoRXDEdiV0tokG71oYcTwJ5bhNfi7WLby7wdNuKhwo8C0WXtjwZ1LIMqhuahci8R6Ix39+9N69FJ3H5yrCA+1aw2m1ID8j4eHv1qYBC17tgRUdX911Z8tcuwW0Y9Z1Y7e8h8REKJB7FfyCZyaBKj2N5lv0sCK56UaNIgYihitQnG48m0tZpw6yvebPERZC8wyVJ1ORl6E79y/N09CTK9jo7YPyoKWWADOlwKwr6KRxnsGAcW26IyCy3/9rtSL+WZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xAPMG47O/9fpiRbuxI8aCJTX46pOYvcUJUiS+KSM40=;
 b=GwzmzYPWGSDaEOjnHKfm3Ysa8YOT3sePhH8Vc6TPvz8TVdoXCHGI7l+Z+of5jxvkbQMCWCEdai0JolP01aO7jHKwSabwdsUyKTwpHz5mKaRsb4af+5BUuPzAbRtvk7B8Orh7PM2uK+izwG+fa9lxtBr2Jo5NddK79/dM4DNP9mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 13:33:27 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 13:33:27 +0000
Message-ID: <3da97c12-7ab6-8c16-00f0-359b73f6b0e9@amd.com>
Date: Tue, 25 Apr 2023 15:33:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 08/10] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-9-shashank.sharma@amd.com>
 <007d02c2-069d-5597-79c4-3cd21e24d3c1@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <007d02c2-069d-5597-79c4-3cd21e24d3c1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dbe368-01f1-48de-98ec-08db4591a6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1Jeudr2PVpIe4y97F5SOjq/JjuJXfvdRmLb4iuX7VgoAIfHxMbT+R9ps43LMm/ryFSCC5lfi5mSlfkQ/HmZBADtaEsadJxmxWFh3ZBfx8pzJTDnI1Aw66cjBYSd1B01HioFcIDbBFt7zh0Q3/Y3cVQ0u9yywgCTItEm/Cf8hwE1mJZJvvdDd2SngSwJjUN/SFddPZaHUKyUXrcrEh8L/fCxxx2qC31/lnf4RNbhPrucx4cnBFLcfLfE0WjK6DWOABHxKehbiEHS9jPnt6xHlIVeq+XacB+tShc4pei1X14vP1HkDcvurj8ELwrrkL9CJRPcBcL2EwImcxzpp/TiO10CTylj56IjHR2gbOsC48Mlw2OSBzLXf+XNT3ct1r/WR7SEekOXn5gfb2flTjHUxJ7Mk5GuVx254Q3gqxIVs1nKbMovaGILpswoo7MmrkSB96T4mvqgDlDyA77UR1j3tnl0qaCp5JoeZwEDQ6ri6SaCeWASwU7+qqdeZPvZOGO4hYZEKy37vQIIUOXWWoKX8jn8UhsgHfbL2hF8fqii3v3goxbLuzxKG6b/b4OVPJYZ0QhmeUzdR+p1vlbvF1Xo9uiL+oCrmIZLOh8Oaqb6r+rODWIk+tZlqgMub6p8X2cPbGd2FBg0eu0zkucr3f7s/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(36756003)(8676002)(8936002)(478600001)(66476007)(66556008)(66946007)(4326008)(44832011)(316002)(41300700001)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(31686004)(26005)(6506007)(6512007)(53546011)(31696002)(6486002)(6666004)(83380400001)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXM2endLN1QycG5MR3MrMTVPYzlyR1N4SzlkaVZuVFBid3M0bzV5b2Nib2dI?=
 =?utf-8?B?U3Y3NW9laGswYXFVZ2JpendURUhzb1k2L1J2eU55bGRDWnQ0ZmxKYUUxNGtV?=
 =?utf-8?B?N0c2UG1xSlhGYkVvelZlWmtmVTVaRit3MUgyV09TR05obG5DSHVIejNkUGR4?=
 =?utf-8?B?eVlBTHVMTU13MGlaRWUwTTZqRExxK3o2WkNZb0tRL2QrZE00Ry93R0cyenJx?=
 =?utf-8?B?a0NET0JEMVZJbjF0L3ZRYVlrTW01bUFCU0xVSzdqWkI5aEhMWFBxVWkwZ1Qz?=
 =?utf-8?B?TEZnRi93d3IxaVRDWWxoaS9zekxEZnFsa3lnNlZtY0dtb3hzV0UrLy9COGcv?=
 =?utf-8?B?bnFHMEVrcVg4Z2dGWnZNRENlV2orOGdDdlF4aHRWY2Z2SDdHRWpZcGI2ZUJG?=
 =?utf-8?B?QjRUV2Z6cXc3cDVrY0FlK2VENDh1L2Fpa1BUOEVRMU55cmMyYllJbm0rZlBI?=
 =?utf-8?B?YXZiQklYNTErUkdLVEVQTEp4QXRON1VEYUJpVFJybjgvQWxLUkJTdDRlb1Nl?=
 =?utf-8?B?VjQvUEM5R08vbTZKbEQ1V1dKUVFYNTdrV2Q3UmsrZTcxdU9JRW9WbysvdUZ5?=
 =?utf-8?B?djBaMWNOQkZWRmFaamMwVFRUUnU2d1IxK1U5clhzaDNlWXZLWktkTzZ3R2Vx?=
 =?utf-8?B?bGEvOXJtdXpsKytES2hKek5UOStLbHRqQkMyQWx0bmJkNnpZV1U3NWZrWGM0?=
 =?utf-8?B?a3c4d0VGUEc3eE5XMTVFTUZjTWZGNkVvKzZyNGpONVRySk1hYXo2TUtvUWxm?=
 =?utf-8?B?T2ljQkZuQ2ZKeTNpUXpRRXN3YlowY2d2Szk1R01aQjlaSzQ1ekhYRlUrczRD?=
 =?utf-8?B?L2VmMlN5eDBiWlpoVUwxZVQ3OEhSbmpLWFR0bkVTTU1UTmdOakpJRzBaOTIv?=
 =?utf-8?B?NnJuZnZFVU04MG94TEJpUTM5c0tPRnpZM2RzcTdnZWMwUFErUG5TQXdMMFBu?=
 =?utf-8?B?NWRCR0NRdWJaZmluQSsxblRpNUhDVEFIeEZLMnB3bHI4bE1FQXViaGtSNlov?=
 =?utf-8?B?WWVkd3pVTXFxNWpuckYxMjVZQkFIWXAxL2o4cXZaemk3RFNQK2YrZGhzQW1N?=
 =?utf-8?B?WlpTM0ZyTGxMc0lCVFVSdjQrRFJLRmRnY0EycEJKcVBkZ3Bqd1M0UmFSY1Ji?=
 =?utf-8?B?Qy9IcUQ0SkFkR0c4N0J1OWFTS003enRuODAwdGRPTHIxeC9yelpQRmprWjh4?=
 =?utf-8?B?aU1wbTRZTFU3d0Fjem9JcWRCQjA5Rmd0eGI5QzZQWlg1ekdoUzJSaUZibm5i?=
 =?utf-8?B?QmlUdWZRVUNpYnQ2d2dENnBERjFmNE54NUZVbFUvQ2lzTlpzVFcxKzFsVWYz?=
 =?utf-8?B?MjArNW9Ib3dLaVNZcEQ2anV0cGlrV2Y4cUF3MmJ2Qjg1azQwMjZ6cGdXRDIy?=
 =?utf-8?B?OGs1ZW80c2krZ3ZCZlRVRDJPMWhIb090OXNIdTlxUS9IV0Y4L0pBeXQ1VW9B?=
 =?utf-8?B?b2tpRktjb2hWWDVZUVJ5SmRpbEJoQUF5TkxWaFl3and4Wm9pQ29tdEJnZ3FG?=
 =?utf-8?B?YUJTRklodzQ1aEQ3bldjYnpHeksveFM2Sm9BOGI1ZHljaDZHclh4WXB4V2x6?=
 =?utf-8?B?clJrYlhadTJtbE01eUE3SDZweTBGSWNZNlR1aTZ2N05oS0RhUTNOMlhVeFBo?=
 =?utf-8?B?Slc4QXB6alpqTVIxeGNvSGN0YWlITFNVVDlPS2pPN3R5NHUyMW1JWVh2WDA5?=
 =?utf-8?B?RGg4OU1VSWlaQisxUWRFWTlEUHRxdEIzTTArRHQ3Nk1STklmOFJ4azVDREky?=
 =?utf-8?B?T0RxUWNqWFk0dUhlbng4c3N6L1pTSGNFbVgyanRSN2x3bWludkVJQkpVbE5J?=
 =?utf-8?B?Q3JhbTI0V3Vlb3FvcmRvRWR3a0ExRTFvc0xheHJQYXcwd3BaQ1Z0aERha2ZF?=
 =?utf-8?B?elJnV3pCOXM3bzVuVld0S3p1TG42RlRJcEtnMzhtc3lrbVJ2aFFpSEt3a2wv?=
 =?utf-8?B?azEybWZ3QWNmWEYzZWlSUkorTFI2R1Z6T1lOYzg4MTVJL0dsd2cwNVF1OTdj?=
 =?utf-8?B?bThaKy9nZ243S21BMXZWdnNPUTU3b2l4c2hFbm9qTkYvS3RuQzZvd0M4NE1m?=
 =?utf-8?B?aC8vdTVQYVB0WEJHSHhjNUZ1NmhhYjhNOGFPb0lZYTNVWHNDUXZXRHhORERn?=
 =?utf-8?Q?1wSrcE2HWiJoNAchIByfBt572?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dbe368-01f1-48de-98ec-08db4591a6c7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 13:33:27.6784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lt7F25vVpFbIaDzYDmyDBzeC2MGa5H3Sr8zvJ0lPOM4Wv8nC3pDFJLaq1b37JicDGO5bp8QKduWjSs7em8UDzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 25/04/2023 14:36, Christian König wrote:
> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>> To support oversubscription, MES FW expects WPTR BOs to
>> be mapped into GART, before they are submitted to usermode
>> queues. This patch adds a function for the same.
>>
>> V4: fix the wptr value before mapping lookup (Bas, Christian).
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 90 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>   3 files changed, 92 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index e95fb35b0cb5..385cd51b6c96 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -44,6 +44,89 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr 
>> *uq_mgr, int qid)
>>       return idr_find(&uq_mgr->userq_idr, qid);
>>   }
>>   +static int
>> +amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, 
>> struct amdgpu_bo *bo)
>> +{
>> +    int ret;
>> +
>> +    ret = amdgpu_bo_reserve(bo, true);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>> +        goto err_reserve_bo_failed;
>> +    }
>> +
>> +    ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to pin bo. ret %d\n", ret);
>> +        goto err_pin_bo_failed;
>> +    }
>> +
>> +    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>> +        goto err_map_bo_gart_failed;
>> +    }
>
> Either pinning *or* allocating GART, but not both!
>
> I think calling amdgpu_ttm_alloc_gart() is the right thing to do here.
>
Ah, silly me :), Thanks for pointing this out.

>> +
>> +    amdgpu_bo_unreserve(bo);
>> +    bo = amdgpu_bo_ref(bo);
>> +
>> +    return 0;
>> +
>> +err_map_bo_gart_failed:
>> +    amdgpu_bo_unpin(bo);
>> +err_pin_bo_failed:
>> +    amdgpu_bo_unreserve(bo);
>> +err_reserve_bo_failed:
>> +
>> +    return ret;
>> +}
>> +
>> +
>> +static int
>> +amdgpu_userqueue_create_wptr_mapping(struct amdgpu_device *adev,
>> +                     struct drm_file *filp,
>> +                     struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_bo_va_mapping *wptr_mapping;
>> +    struct amdgpu_vm *wptr_vm;
>> +    struct amdgpu_bo *wptr_bo = NULL;
>> +    uint64_t wptr = queue->userq_prop.wptr_gpu_addr;
>> +    int ret;
>> +
>> +    wptr_vm = queue->vm;
>> +    ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>
> All the handling must be done with the VM and all resource locks held.
>
> So this should be something the caller of the function does.

Noted, will add the protections.

- Shashank

>
> Regards,
> Christian.
>
>> +    if (ret)
>> +        goto err_wptr_map_gart;
>> +
>> +    wptr &= AMDGPU_GMC_HOLE_MASK;
>> +    wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> 
>> PAGE_SHIFT);
>> +    amdgpu_bo_unreserve(wptr_vm->root.bo);
>> +    if (!wptr_mapping) {
>> +        DRM_ERROR("Failed to lookup wptr bo\n");
>> +        ret = -EINVAL;
>> +        goto err_wptr_map_gart;
>> +    }
>> +
>> +    wptr_bo = wptr_mapping->bo_va->base.bo;
>> +    if (wptr_bo->tbo.base.size > PAGE_SIZE) {
>> +        DRM_ERROR("Requested GART mapping for wptr bo larger than 
>> one page\n");
>> +        ret = -EINVAL;
>> +        goto err_wptr_map_gart;
>> +    }
>> +
>> +    ret = amdgpu_userqueue_map_gtt_bo_to_gart(adev, wptr_bo);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to map wptr bo to GART\n");
>> +        goto err_wptr_map_gart;
>> +    }
>> +
>> +    queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
>> +    return 0;
>> +
>> +err_wptr_map_gart:
>> +    return ret;
>> +}
>> +
>>   static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union 
>> drm_amdgpu_userq *args)
>>   {
>>       struct amdgpu_usermode_queue *queue;
>> @@ -81,6 +164,13 @@ static int amdgpu_userqueue_create_gfx(struct 
>> drm_file *filp, union drm_amdgpu_u
>>           goto free_queue;
>>       }
>>   +    r = amdgpu_userqueue_create_wptr_mapping(uq_mgr->adev, filp, 
>> queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map WPTR (0x%llx) for userqueue\n",
>> +               queue->userq_prop.wptr_gpu_addr);
>> +        goto free_queue;
>> +    }
>> +
>>       if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
>>           r = 
>> uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
>>           if (r) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 7a45d68091ec..6eeae0206d8a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -6439,6 +6439,7 @@ static int gfx_v11_userq_map(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>       queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>       queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>       queue_input.page_table_base_addr = 
>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>> +    queue_input.wptr_mc_addr = queue->wptr_mc_addr;
>>         amdgpu_mes_lock(&adev->mes);
>>       r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 11e8ad649f6e..0001ecd710a7 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -38,6 +38,7 @@ struct amdgpu_usermode_queue {
>>       int            queue_id;
>>       int            queue_type;
>>       uint64_t        doorbell_handle;
>> +    uint64_t        wptr_mc_addr;
>>       uint64_t        proc_ctx_gpu_addr;
>>       uint64_t        gang_ctx_gpu_addr;
>>       uint64_t        gds_ctx_gpu_addr;
>
