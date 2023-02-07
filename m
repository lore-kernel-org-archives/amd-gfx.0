Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2911C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C79210E462;
	Tue,  7 Feb 2023 07:56:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F63C10E462
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdVhmzvywcOmHbls9OdU/bvTzJEohJNIHILkI1F7NoqJPAJdx1Kr1LECzeZvXJVWQ6TBzfdhggoRClcQQbJMmcmkp6gv85PeAN/gjwxU/Wi3zbNaYPZsLjliP1UfY1LR5nU6v0cyBa6jbFbF2AlEE8v67X9L9I99jIceRv6uAUldCRlLdPQHb0Pfc+m+NX5GNPHg97v+776X5QMbU9mLde573GgP9xh9mn2jDO1+kYnYOnnXEdK0NtmwyCkqZq+w9AvEhcp3KB9RYRBMZ1t2vi03pyy+fj5Pq+cUBwoMI0qy8YRsYWKXFoJVUccteLQ+Az5VFPw1a/LqIqp1DVQ3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eojuu6vmEe9SqE6N7mjq6lY72Ea0exuDxxpdrQik2as=;
 b=Q0nXyuN/geDOiNZ2QNRI5FxGub4V+lpLUxXmszQ6zLECAvyZHyhTc7tim5WGDefly1fF++WNwlRvkoboBkY55FbYOhI42pj5HvJV5j2ztdoIpPCVkT+08A4kLVFOwJVxDEL8GlXbppNVkrTuNGmdzKycngZhC4AwpQzCfQ09q++SfKyZYfn08eH+D8GtHgA661F1gcNTww8NPzSCGLwG92mIkV8c3VnE6hVtgwbruux8qC2lax6oUJ0FNJFxhUFTkjmFp67+7E/SoqOLgdWSj1xiT0GLo3UQiGc5Iu1NXeWYwMafQI9cZgy6K4e63RjZqUicINgtRqRi4tr2A6SWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eojuu6vmEe9SqE6N7mjq6lY72Ea0exuDxxpdrQik2as=;
 b=spvKSV8Yu+2ql8HaBpN3mKObpx9hNO18IPpOgev/XAwSrjl954aumggcZxT/FNhcF9VmZ2B+9Vf+zAAI5E4Tgjypad/WatvLLRJ+U3WPjdhjeklcMk4q58Ix+R+yqqlkcLiTeIu8gZIsI59d0GN3YyTuCyxYTTs6KcCYrwtnDgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 07:55:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 07:55:57 +0000
Message-ID: <8186d839-3966-257b-d06d-160a2ab06c05@amd.com>
Date: Tue, 7 Feb 2023 08:55:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/8] drm/amdgpu: Create context for usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-6-shashank.sharma@amd.com>
 <240a5ab8-6743-4588-4a73-17f2ea894f1b@amd.com>
 <43c2b1eb-dd09-6a55-c252-b59176293b93@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <43c2b1eb-dd09-6a55-c252-b59176293b93@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: eca2a584-7e95-46d8-f315-08db08e0bf0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3QUm+/qPf8I1OHxt6r1rajoKKk4Y2gc6CiWhg+05ZfPRWMo8LghCaPoi44xWyee120PNI4SbcCg7itqa7mblXcKefe3TZjqTlTORJxTALyZzlp2TsBvtVXYf+dDaK/JkS+P5c8A1kAlWikX+qMSKo2p3fDTnuAgVRZCoTl+IpvKs4FP20wcNvrg3qBrgdDN1s4Ua4DmXbyxpkmlm20S5iYllWfMrntPU3okY3bLOIlthODoGzQNwbby4leuSMJyrl1r33ks5Xw5xW5b1bh8+juCrwUENavgBndS9xqhoi7m4OwfVEo9dEzyeY2Q9Hy3wEvPG7YRNhoUhKMoe48umysSdpeP20c9AJFlFH+AGdls5WTN9FRFr3DNY+FE9wuMTb8uCuWrYAmytQUTqi89Wb9QVYTI5TEn5M8IgXLjrAoh3XTsgVbozIoLdx88MS9S4VycCmNjNpT1Kx/AXSIzdqwLy3DBhIASBBryxREd0cJT3+DggXQrnXbejSkFiAJvcu9avB0DXFmPwmMITmiyswnB50QODSE+TGuG9Slup9/teS3xeDQH2V0Vf1Aj9D3+MxULkzgrpyh9TT+MUDVvb2yLHlEkFLn2Ax11Ydy27LOEFhrT9tKXecAJwSVmQa9WZCTn2OVQfmyA2qeoxTFyqs3CrnMIYS9t1RIl3s5nspL7K1LE2lzqa4rBgduseZBIGrFAE4s3wCf1D0pw94aXo3MyKv1cjBwiEIMmgy6CxXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199018)(4326008)(31686004)(53546011)(8936002)(6506007)(41300700001)(66556008)(8676002)(66476007)(38100700002)(316002)(6512007)(5660300002)(26005)(31696002)(30864003)(478600001)(66946007)(6666004)(186003)(36756003)(6486002)(83380400001)(66574015)(86362001)(2906002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkYya3E4MzA3QXJlZklBeG5MaVloSkEvTGpYVDhSSnBvNFhtd0hRcFB1WXl3?=
 =?utf-8?B?OUU3dGI1YXFJWkpjVHNKK0pEZlJlbVdZdGM2UnJSK2YxbEd5ZGhWRzRydUxp?=
 =?utf-8?B?SVJJWkg3NStjc04wWFpFblJ1clRHOHlMeEdWaHMzWGxqaE0zckE5Z1RNNWVw?=
 =?utf-8?B?K0k2L1lFN0NuZENkZnRPZTBZdEJweWlaMExpMWxmbDVoNnRFbXErRVRRZFVO?=
 =?utf-8?B?MEpNVlZUVnR4U016MkNLS3RzcHRoa0hORHJtRklYVlZGSWh4MWRuRWZyMkYr?=
 =?utf-8?B?YjZRaHZvUVg2dXZCdUdPRWVpaWZ5Q0NtWm5PUG1wQzhkaHRJQ0xJd2JXM3Ay?=
 =?utf-8?B?RlZqcUJDWjNmL1kvRjdOTm9PTDJlZGNPbjRyalR5VkRiZzlyR1owOVZXYlhq?=
 =?utf-8?B?VVVXNjFCWlFIRmFIaDBGMHExTWw3Rk9FbnhWVWtJVGdBdW5ZWHNwU2tBVzVC?=
 =?utf-8?B?dWNYUFppeHFDYzd1VGQzenFucjZjcDJaRmtrMnlQNE9NVkgwbElEeDVzN296?=
 =?utf-8?B?V001ZGE4M2o4K0h0Q2dxNmpTOVdGMVJYbmpOeGhhRnlyMGVaL2JjeGhkcjNE?=
 =?utf-8?B?UEoraXhIU3NNbFR5all3YW1yaG94dHhhb1IzZjIxRHBOQkphOEJTdHZld3dY?=
 =?utf-8?B?em1lcHVid2ZEdTRxMHVyNk92Skp3ditzVldiNzRMb1VkVkFObVdhK1UxWlFn?=
 =?utf-8?B?RWhPUHFxb2V1ZHlycTR1aG5JckVLNXlvS05JLzgyMmFIZ0UyUXBqRTdXMksr?=
 =?utf-8?B?bVB2S1BlT0hkRG9QRjZFMVhORmxKRkY5QUxuZ1VIR1E1REVpUHZQTlBTUW1X?=
 =?utf-8?B?SFF4aXdVYnN6YVZmZDQ1TEZWZ1RTQnUrcXVKaDR1YUdTZ0pZVXhVbFhBN0Zp?=
 =?utf-8?B?SWs2NU1GQ0cwWVZBbFBxZU10STc1T0tRK0MzdHY2QkcrQlVJY1hrNmtSSkZS?=
 =?utf-8?B?YXhVN0MrM0NHSDM5aXJydi9SRnJuVHM1azE2YzVxeFNHWHBXTkpiWDRBc3Vo?=
 =?utf-8?B?MXNwM05oL0RmL2k4Sjk4bEtLS09WVEhSUldhMXdYZzB2WjB4MlZ2V2xmVE5P?=
 =?utf-8?B?QzB1N2QwckowbVRSN3lVRmtiNzRHLzNCMFEyMS9OT29vSTNyOFhEZnRQK21D?=
 =?utf-8?B?ODdEVXNHbWxPMXczRzB3RStkcHNQZHU3SlQ4a2t0N2tweDQyMmYrc0hHR1J5?=
 =?utf-8?B?UHRBeWdHYUlNT1QrTG92RzJmS0Q0ODUrcHp6UjZXRnR6S1BoeTdGeVMxV3ls?=
 =?utf-8?B?Z1hvZEIyM29ydVEzdTFJMVgwbjltY3JYVVhzTmIyZVUrYmFmSmJkdVNVa1J6?=
 =?utf-8?B?SFJScmFpNUlWOG1wbDVIenV6MVpkZDliU0dvTlNvM09zYVRkdnpxaHhSYWor?=
 =?utf-8?B?TjRqUWd6U3c4MVQzbUxJTVErVmRWY05rMXAvUEZtYWFpVzdNdEdCWWI1VC9E?=
 =?utf-8?B?RTZlVVhqVW1RYVZLK0FGTU1QOWhNK2FzL1hYQjViNlk2TFFJd3pZdGU5bGRu?=
 =?utf-8?B?YXE0c043WFBOTVlnME9qcHdWeE5GbEM3dGZpYkJQLzZmMFQrRmlIOCtmVTBs?=
 =?utf-8?B?NDF1NWFjZWVLRTc4RjlreUhMc2JpWHJ2d1Q2NGtoekllUHlwVzBnSHh2NnNx?=
 =?utf-8?B?QjV6ZzBIMFZyZ3JnazdQNFJEQi8xRzBMS1ZmVlFidk91Z3dWcDJVQU53WnVT?=
 =?utf-8?B?d3VJV2dRMEl4cVRWUEI4d1kyemFYVUdhRUpQRWI4Y05XazhLQ29va0pyRnYw?=
 =?utf-8?B?MGVHREx2bTdqdlR1aW5lL2o3VjZhVWNCVTZpSkM3WHltNlNxcGpubkw0L0d6?=
 =?utf-8?B?QnVmWG54ODJiQzlkK1VpRGxDVGduUU8yNW9ZdC84VHpOdENCU25EakNHQ3Zq?=
 =?utf-8?B?RHQva3E2K1oxYzNNVjhRQVN2enNKeTBWdDMra2U5K3o3clRJbHAvUG5ENTMx?=
 =?utf-8?B?L3F1WUcwMDBkeHZVL2NVZkU0YkRKZm9wMWMwL2tUSG5aMkI0VkxxQm5VcDho?=
 =?utf-8?B?L2lxZ2F1WTFCcWM3RDFEQTJtbWgxRUR2VVJQN1ZZVWFNc3paS0I5WVhIYktW?=
 =?utf-8?B?d1doMkYrbytrbjdpSWZYRDJFWFFucG5NNFRMUXRESzkydDNxclFGUWRNVHEv?=
 =?utf-8?Q?M3OVvMGGmrBFW+oUgnMvmDi60?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca2a584-7e95-46d8-f315-08db08e0bf0f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:55:57.6434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5d9K5RPOJsj5qw4Wm/TRov9liyazPA3dJEOlAX4cqFY0IhFukWvkJML/rkBhLJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.02.23 um 08:51 schrieb Shashank Sharma:
>
> On 07/02/2023 08:14, Christian König wrote:
>> Am 03.02.23 um 22:54 schrieb Shashank Sharma:
>>> The FW expects us to allocate atleast one page as context space to
>>> process gang, process, shadow, GDS and FW_space related work. This
>>> patch creates some object for the same, and adds an IP specific
>>> functions to do this.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  32 +++++
>>>   .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 121 
>>> ++++++++++++++++++
>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  18 +++
>>>   3 files changed, 171 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index 9f3490a91776..18281b3a51f1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -42,6 +42,28 @@ static struct amdgpu_usermode_queue
>>>       return idr_find(&uq_mgr->userq_idr, qid);
>>>   }
>>>   +static void
>>> +amdgpu_userqueue_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>> +                                   struct amdgpu_usermode_queue 
>>> *queue)
>>> +{
>>> +    uq_mgr->userq_mqd_funcs->ctx_destroy(uq_mgr, queue);
>>> +}
>>> +
>>> +static int
>>> +amdgpu_userqueue_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>> +                                  struct amdgpu_usermode_queue *queue)
>>> +{
>>> +    int r;
>>> +
>>> +    r = uq_mgr->userq_mqd_funcs->ctx_create(uq_mgr, queue);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to create context space for queue\n");
>>> +        return r;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int
>>>   amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, 
>>> struct amdgpu_usermode_queue *queue)
>>>   {
>>> @@ -142,12 +164,21 @@ static int amdgpu_userqueue_create(struct 
>>> drm_file *filp, union drm_amdgpu_userq
>>>           goto free_qid;
>>>       }
>>>   +    r = amdgpu_userqueue_create_ctx_space(uq_mgr, queue);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to create context space\n");
>>> +        goto free_mqd;
>>> +    }
>>> +
>>>       list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>>>       args->out.q_id = queue->queue_id;
>>>       args->out.flags = 0;
>>>       mutex_unlock(&uq_mgr->userq_mutex);
>>>       return 0;
>>>   +free_mqd:
>>> +    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>>> +
>>>   free_qid:
>>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>>   @@ -170,6 +201,7 @@ static void amdgpu_userqueue_destroy(struct 
>>> drm_file *filp, int queue_id)
>>>       }
>>>         mutex_lock(&uq_mgr->userq_mutex);
>>> +    amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
>>>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>>       list_del(&queue->userq_node);
>>> diff --git 
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>> index 57889729d635..687f90a587e3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>> @@ -120,6 +120,125 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct 
>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>>     }
>>>   +static int amdgpu_userq_gfx_v11_ctx_create(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>> +                                           struct 
>>> amdgpu_usermode_queue *queue)
>>> +{
>>> +    int r;
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
>>> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
>>> +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
>>> +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
>>> +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
>>> +
>>> +    /*
>>> +     * The FW expects atleast one page space allocated for
>>> +     * process context related work, and one for gang context.
>>> +     */
>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_PROC_CTX_SZ, 
>>> PAGE_SIZE,
>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>> +                                &pctx->obj,
>>> +                                &pctx->gpu_addr,
>>> +                                &pctx->cpu_ptr);
>>
>> Again, don't use amdgpu_bo_create_kernel() for any of this.
> Noted,
>>
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GANG_CTX_SZ, 
>>> PAGE_SIZE,
>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>> +                                &gctx->obj,
>>> +                                &gctx->gpu_addr,
>>> +                                &gctx->cpu_ptr);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate gang bo for userqueue (%d)", r);
>>> +        goto err_gangctx;
>>> +    }
>>> +
>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GDS_CTX_SZ, 
>>> PAGE_SIZE,
>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>> +                                &gdsctx->obj,
>>> +                                &gdsctx->gpu_addr,
>>> +                                &gdsctx->cpu_ptr);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate GDS bo for userqueue (%d)", r);
>>> +        goto err_gdsctx;
>>> +    }
>>> +
>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, 
>>> PAGE_SIZE,
>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>> +                                &fwctx->obj,
>>> +                                &fwctx->gpu_addr,
>>> +                                &fwctx->cpu_ptr);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate FW bo for userqueue (%d)", r);
>>> +        goto err_fwctx;
>>> +    }
>>> +
>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, 
>>> PAGE_SIZE,
>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>> +                                &sctx->obj,
>>> +                                &sctx->gpu_addr,
>>> +                                &sctx->cpu_ptr);
>>
>> Why the heck should we allocate so many different BOs for that? Can't 
>> we put all of this into one?
> If you mean why don't we create one object of 5 * PAGE_SIZE and give 
> 1-page spaced offsets for all of this, yes, that would further 
> simplify things.
>
> The reason why we kept it separate is that these objects could be of 
> different sizes on different IPs/platforms, so we thought defining a 
> separate
>
> size macro and object for each of these will make it easier to 
> understand how many FW page objects we are creating for this GEN IP. 
> It can be
>
> either ways.

But this is completely uninteresting for common code, isn't it?

I strongly think we should just create a single BO for each queue and 
put all the data (MQD, gang, GDS, FW, shadow) in it at different offsets.

This handling here is just overkill and rather error prone (BTW you used 
AMDGPU_USERQ_FW_CTX_SZ) twice.

Christian.

>
> - Shashank
>
>>
>> Christian.
>>
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate shadow bo for userqueue 
>>> (%d)", r);
>>> +        goto err_sctx;
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +err_sctx:
>>> +    amdgpu_bo_free_kernel(&fwctx->obj,
>>> +                          &fwctx->gpu_addr,
>>> +                          &fwctx->cpu_ptr);
>>> +
>>> +err_fwctx:
>>> +    amdgpu_bo_free_kernel(&gdsctx->obj,
>>> +                          &gdsctx->gpu_addr,
>>> +                          &gdsctx->cpu_ptr);
>>> +
>>> +err_gdsctx:
>>> +    amdgpu_bo_free_kernel(&gctx->obj,
>>> +                          &gctx->gpu_addr,
>>> +                          &gctx->cpu_ptr);
>>> +
>>> +err_gangctx:
>>> +    amdgpu_bo_free_kernel(&pctx->obj,
>>> +                          &pctx->gpu_addr,
>>> +                          &pctx->cpu_ptr);
>>> +    return r;
>>> +}
>>> +
>>> +static void amdgpu_userq_gfx_v11_ctx_destroy(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>> +                                            struct 
>>> amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
>>> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
>>> +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
>>> +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
>>> +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
>>> +
>>> +    amdgpu_bo_free_kernel(&sctx->obj,
>>> +                          &sctx->gpu_addr,
>>> +                          &sctx->cpu_ptr);
>>> +
>>> +    amdgpu_bo_free_kernel(&fwctx->obj,
>>> +                          &fwctx->gpu_addr,
>>> +                          &fwctx->cpu_ptr);
>>> +
>>> +    amdgpu_bo_free_kernel(&gdsctx->obj,
>>> +                          &gdsctx->gpu_addr,
>>> +                          &gdsctx->cpu_ptr);
>>> +
>>> +    amdgpu_bo_free_kernel(&gctx->obj,
>>> +                          &gctx->gpu_addr,
>>> +                          &gctx->cpu_ptr);
>>> +
>>> +    amdgpu_bo_free_kernel(&pctx->obj,
>>> +                          &pctx->gpu_addr,
>>> +                          &pctx->cpu_ptr);
>>> +}
>>> +
>>>   static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr 
>>> *uq_mgr)
>>>   {
>>>       return sizeof(struct v11_gfx_mqd);
>>> @@ -129,4 +248,6 @@ const struct amdgpu_userq_mqd_funcs 
>>> userq_gfx_v11_mqd_funcs = {
>>>       .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
>>>       .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>>>       .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>>> +    .ctx_create = amdgpu_userq_gfx_v11_ctx_create,
>>> +    .ctx_destroy = amdgpu_userq_gfx_v11_ctx_destroy,
>>>   };
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> index a6abdfd5cb74..3adcd31618f7 100644
>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> @@ -25,9 +25,19 @@
>>>   #define AMDGPU_USERQUEUE_H_
>>>     #define AMDGPU_MAX_USERQ 512
>>> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>> +#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>>> +#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>>     struct amdgpu_userq_mqd_funcs;
>>>   +struct amdgpu_userq_ctx {
>>> +    struct amdgpu_bo *obj;
>>> +    uint64_t gpu_addr;
>>> +    void    *cpu_ptr;
>>> +};
>>> +
>>>   struct amdgpu_userq_mgr {
>>>       struct idr userq_idr;
>>>       struct mutex userq_mutex;
>>> @@ -52,6 +62,12 @@ struct amdgpu_usermode_queue {
>>>       uint64_t    mqd_gpu_addr;
>>>       void         *mqd_cpu_ptr;
>>>   +    struct amdgpu_userq_ctx    proc_ctx;
>>> +    struct amdgpu_userq_ctx    gang_ctx;
>>> +    struct amdgpu_userq_ctx    gds_ctx;
>>> +    struct amdgpu_userq_ctx    fw_ctx;
>>> +    struct amdgpu_userq_ctx    shadow_ctx;
>>> +
>>>       struct amdgpu_bo    *mqd_obj;
>>>       struct amdgpu_vm        *vm;
>>>       struct amdgpu_userq_mgr *userq_mgr;
>>> @@ -64,6 +80,8 @@ struct amdgpu_userq_mqd_funcs {
>>>       int (*mqd_size)(struct amdgpu_userq_mgr *);
>>>       int (*mqd_create)(struct amdgpu_userq_mgr *, struct 
>>> amdgpu_usermode_queue *);
>>>       void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct 
>>> amdgpu_usermode_queue *);
>>> +    int (*ctx_create)(struct amdgpu_userq_mgr *, struct 
>>> amdgpu_usermode_queue *);
>>> +    void (*ctx_destroy)(struct amdgpu_userq_mgr *, struct 
>>> amdgpu_usermode_queue *);
>>>   };
>>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>> struct amdgpu_device *adev);
>>

