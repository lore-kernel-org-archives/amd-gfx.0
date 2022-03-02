Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E3DC43217
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 09:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1226710F25D;
	Wed,  2 Mar 2022 09:51:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D440610EF65
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 09:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf9lmYhF888JNhWllR/+ZqHl3hzs/FudUBwcEb6ur8voNohi6fvDZcXB2m6S3BfduJiYfmkqtOEEnnm1L+juTKjTknQ0ROscPWL077x0t/HYRAVeNNnwAlE/ME3PqO9BZSWCgXEqD6lhRpGCQjwGesnbzk+ncq3cJRe3W6gsExjyxgx18zWC2/sFRX+QGuvVUGejSf0KRn5ZOTfwVtuLvmLevbc0kB+nvw8trja4jhij7Cs796kuW2DNGuNkm38phGM5jtAr/8PCvgOpI+EPIThV5BrzV5/0xBTVVmZpE5UGDlGw0xIAK8C9db5G31OIoR0lI4bBknARmR96Zr93Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIEYqV8n8HXW68vrCR5/FVYC+0BY8PIuHfcOz22jzno=;
 b=Ei8Nk3K2XBff0gLkrhMNH8M4JSCXzrI2NQFVdnHQSeZaAhCTgAhdN+b4ceazTnUbt0bnQuLZVaJkKF+JrsdkGd5MPcVDnF0yZrXio3ApTiuiis6wKgeulcAI08C5KWdYsHmL9Ppfvk5I6OqUzo6aouahwFQEoXFqVtRL3DtPi1188BrNS5/aFg19+ZG0DonfpXlIxRGIBM3bg9Xqwob3V/+WexnZSAfj+Ze3DhA6/gih9Ad0Zxj8zQqEA5czsCLpqhdeTc7bGjI39Pl/3r/jbyiVeRozR/CWKw8DBaVTGqL+zcAeNdr09CJenBQB9JoU8FgZunVmdivELX5H3gWKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIEYqV8n8HXW68vrCR5/FVYC+0BY8PIuHfcOz22jzno=;
 b=jIsyu+IoUW4/GLSDS6B6qPAXYSJwl3memseKcIEnBwZlOHILVSbZ+fl2s4PRmD/Ew91Tp7FwN2lqcrzywY7xboblcaJkNevumHJlVK8lx7E9/QXMNCt2y/g8HDGXUvXtMSPfq4prfciwKRl40zzuXlnXDKJvpuqAsEA7J6s7jTY=
Received: from DM5PR1101CA0009.namprd11.prod.outlook.com (2603:10b6:4:4c::19)
 by DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Wed, 2 Mar 2022 09:51:34 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::b5) by DM5PR1101CA0009.outlook.office365.com
 (2603:10b6:4:4c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 09:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 09:51:34 +0000
Received: from [10.252.247.122] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 03:51:30 -0600
Content-Type: multipart/mixed; boundary="------------xxLZALHhgsUeHxRAOScsGuS1"
Message-ID: <f36352a4-78a9-8e4b-4ec4-8722240d445d@amd.com>
Date: Wed, 2 Mar 2022 17:51:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220209002320.6077-1-andrey.grodzovsky@amd.com>
 <20220209002320.6077-3-andrey.grodzovsky@amd.com>
 <d82ac1a0-d81d-9861-fc1b-8cc06017a2b5@gmail.com>
 <1d7cb471-c32c-416c-4336-317ee9f171ef@amd.com>
 <3752a89c-d468-8c39-03a9-37d592dae89f@amd.com>
 <48c207dc-cc7a-efda-a4a8-4f1f1a6511fe@amd.com>
 <BL1PR12MB514424A75728E78BC0E5B848F73D9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <91b8771b-695d-b126-13ec-50dddd56f200@amd.com>
 <7c07d1b7-e700-60f3-1114-f1386892e836@amd.com>
 <9df3a044-a0a6-cdea-887a-82e7cc9f47eb@amd.com>
From: JingWen Chen <jingwech@amd.com>
In-Reply-To: <9df3a044-a0a6-cdea-887a-82e7cc9f47eb@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db7a216e-18f0-4aa4-969c-08d9fc323c85
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5445B6180663C5403B22B58FB7039@DM8PR12MB5445.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbfV2vq6zIHTkdkSj+dSyr7iHx2ynyiQgjj4OcOHjjvqWOgu6XUqVshnO2NVvA0lBIs3GlK2D/zLsOv4pPV8AATYPsPkE8CSrZUVRHZJ5iZgftHY/jT5fJbvCx93qIIFvr00Ixve1QCzrRbCL27iJ6I1GTN4HBa9oSOMnfLLtFlVwmy8Ks75KudiUYZYvxRWsOWfcKKYhQ8qmTQh9CA2YqmUSZozBsQAmbPm+L4s/XqcG9P9J0AyPK5P/fupBGKsjLCwc6wjegv2KeJet9oteYDemsg7rfyJKwPhjKGCcGeY+QAcCIOKZO0OXlD5Uz9aL7LlVPEOHOiEVbY1BrvincK581po/Vt66hKONkIqQKDF30oXqqZUgdihtQETSf4fpMFHly8YqEOkxRqYiqpUxSoQhdtkU78XZmORYBEDBacm8l3/d30nV/mr42ywJNp8XsDys7FvxiDF0y5jROd8+iyjBEPKKSbiKv7dDfJIzYQ9VV7xWWm5FgjgaMrJhySW7aIhX3AFWAYPK9CXA9YsjoB1VkyenSOXJo0XBVrV+c598qM+kFkaslbhsP47MRkHsouLH7eX4+l0CzXqFXCuapUa5tYZd8o6zaMwA+OghxyZf60nssKeamcsfb+B9VXBTddHqMRC4U7GGkRNuWvthVz8JQ1nVhnH30us+B44VU3vZpuDmFuJh/E91mE421OprAUl8vR05Ves1K9gsFddyxRyLmgpdUIKmHr+qrFSjLY1sQgXx+mNAeMoTK9eQ46v
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(31686004)(40460700003)(53546011)(54906003)(110136005)(47076005)(66574015)(36756003)(83380400001)(2906002)(235185007)(5660300002)(36860700001)(356005)(8676002)(4326008)(336012)(70586007)(70206006)(426003)(82310400004)(316002)(31696002)(16576012)(81166007)(508600001)(8936002)(16526019)(186003)(2616005)(26005)(33964004)(6666004)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 09:51:34.2494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7a216e-18f0-4aa4-969c-08d9fc323c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5445
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
Cc: "daniel@ffwll.ch" <daniel@ffwll.ch>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------xxLZALHhgsUeHxRAOScsGuS1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Andrey,

Most part of the patches are OK, but the code will introduce a ib test fail on the disabled vcn of sienna_cichlid.

In SRIOV use case we will disable one vcn on sienna_cichlid, I have attached a patch to fix this issue, please check the attachment.

Best Regards,

Jingwen Chen


On 2/26/22 5:22 AM, Andrey Grodzovsky wrote:
> Hey, patches attached - i applied the patches and resolved merge conflicts but weren't able to test as my on board's network card doesn't work with 5.16 kernel (it does with 5.17, maybe it's Kconfig issue and i need to check more).
> The patches are on top of 'cababde192b2 Yifan Zhang         2 days ago     drm/amd/pm: fix mode2 reset fail for smu 13.0.5 ' commit.
>
> Please test and let me know. Maybe by Monday I will be able to resolve the connectivity issue on 5.16.
>
> Andrey
>
> On 2022-02-24 22:13, JingWen Chen wrote:
>> Hi Andrey,
>>
>> Sorry for the misleading, I mean the whole patch series. We are depending on this patch series to fix the concurrency issue within SRIOV TDR sequence.
>>
>>
>>
>> On 2/25/22 1:26 AM, Andrey Grodzovsky wrote:
>>> No problem if so but before I do,
>>>
>>>
>>> JingWen - why you think this patch is needed as a standalone now ? It has no use without the
>>> entire feature together with it. Is it some changes you want to do on top of that code ?
>>>
>>>
>>> Andrey
>>>
>>>
>>> On 2022-02-24 12:12, Deucher, Alexander wrote:
>>>> [Public]
>>>>
>>>>
>>>> If it applies cleanly, feel free to drop it in.  I'll drop those patches for drm-next since they are already in drm-misc.
>>>>
>>>> Alex
>>>>
>>>> ------------------------------------------------------------------------
>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> *Sent:* Thursday, February 24, 2022 11:24 AM
>>>> *To:* Chen, JingWen <JingWen.Chen2@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>> *Cc:* Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; daniel@ffwll.ch <daniel@ffwll.ch>
>>>> *Subject:* Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is ready
>>>> No because all the patch-set including this patch was landed into
>>>> drm-misc-next and will reach amd-staging-drm-next on the next upstream
>>>> rebase i guess.
>>>>
>>>> Andrey
>>>>
>>>> On 2022-02-24 01:47, JingWen Chen wrote:
>>>>> Hi Andrey,
>>>>>
>>>>> Will you port this patch into amd-staging-drm-next?
>>>>>
>>>>> on 2/10/22 2:06 AM, Andrey Grodzovsky wrote:
>>>>>> All comments are fixed and code pushed. Thanks for everyone
>>>>>> who helped reviewing.
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>> On 2022-02-09 02:53, Christian König wrote:
>>>>>>> Am 09.02.22 um 01:23 schrieb Andrey Grodzovsky:
>>>>>>>> Before we initialize schedulers we must know which reset
>>>>>>>> domain are we in - for single device there iis a single
>>>>>>>> domain per device and so single wq per device. For XGMI
>>>>>>>> the reset domain spans the entire XGMI hive and so the
>>>>>>>> reset wq is per hive.
>>>>>>>>
>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>> One more comment below, with that fixed Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>>>>>
>>>>>>>> ---
>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 ++++++++++++++++++++++
>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 34 ++--------------
>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +
>>>>>>>>      3 files changed, 51 insertions(+), 30 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index 9704b0e1fd82..00123b0013d3 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -2287,6 +2287,47 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>>>>>>          return r;
>>>>>>>>      }
>>>>>>>>      +static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>>>>>>>> +{
>>>>>>>> +    long timeout;
>>>>>>>> +    int r, i;
>>>>>>>> +
>>>>>>>> +    for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>> +        struct amdgpu_ring *ring = adev->rings[i];
>>>>>>>> +
>>>>>>>> +        /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>>> +        if (!ring || ring->no_scheduler)
>>>>>>>> +            continue;
>>>>>>>> +
>>>>>>>> +        switch (ring->funcs->type) {
>>>>>>>> +        case AMDGPU_RING_TYPE_GFX:
>>>>>>>> +            timeout = adev->gfx_timeout;
>>>>>>>> +            break;
>>>>>>>> +        case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>> +            timeout = adev->compute_timeout;
>>>>>>>> +            break;
>>>>>>>> +        case AMDGPU_RING_TYPE_SDMA:
>>>>>>>> +            timeout = adev->sdma_timeout;
>>>>>>>> +            break;
>>>>>>>> +        default:
>>>>>>>> +            timeout = adev->video_timeout;
>>>>>>>> +            break;
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>> + ring->num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>> +                   timeout, adev->reset_domain.wq, ring->sched_score, ring->name);
>>>>>>>> +        if (r) {
>>>>>>>> +            DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>>> +                  ring->name);
>>>>>>>> +            return r;
>>>>>>>> +        }
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +
>>>>>>>>      /**
>>>>>>>>       * amdgpu_device_ip_init - run init for hardware IPs
>>>>>>>>       *
>>>>>>>> @@ -2419,6 +2460,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>>>>              }
>>>>>>>>          }
>>>>>>>>      +    r = amdgpu_device_init_schedulers(adev);
>>>>>>>> +    if (r)
>>>>>>>> +        goto init_failed;
>>>>>>>> +
>>>>>>>>          /* Don't init kfd if whole hive need to be reset during init */
>>>>>>>>          if (!adev->gmc.xgmi.pending_reset)
>>>>>>>> amdgpu_amdkfd_device_init(adev);
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> index 45977a72b5dd..fa302540c69a 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> @@ -457,8 +457,6 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>>                        atomic_t *sched_score)
>>>>>>>>      {
>>>>>>>>          struct amdgpu_device *adev = ring->adev;
>>>>>>>> -    long timeout;
>>>>>>>> -    int r;
>>>>>>>>            if (!adev)
>>>>>>>>              return -EINVAL;
>>>>>>>> @@ -478,36 +476,12 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>> spin_lock_init(&ring->fence_drv.lock);
>>>>>>>>          ring->fence_drv.fences = kcalloc(num_hw_submission * 2, sizeof(void *),
>>>>>>>>                           GFP_KERNEL);
>>>>>>>> -    if (!ring->fence_drv.fences)
>>>>>>>> -        return -ENOMEM;
>>>>>>>>      -    /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>>> -    if (ring->no_scheduler)
>>>>>>>> -        return 0;
>>>>>>>> +    ring->num_hw_submission = num_hw_submission;
>>>>>>>> +    ring->sched_score = sched_score;
>>>>>>> Let's move this into the caller and then use ring->num_hw_submission in the fence code as well.
>>>>>>>
>>>>>>> The maximum number of jobs on the ring is not really fence specific.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>      -    switch (ring->funcs->type) {
>>>>>>>> -    case AMDGPU_RING_TYPE_GFX:
>>>>>>>> -        timeout = adev->gfx_timeout;
>>>>>>>> -        break;
>>>>>>>> -    case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>> -        timeout = adev->compute_timeout;
>>>>>>>> -        break;
>>>>>>>> -    case AMDGPU_RING_TYPE_SDMA:
>>>>>>>> -        timeout = adev->sdma_timeout;
>>>>>>>> -        break;
>>>>>>>> -    default:
>>>>>>>> -        timeout = adev->video_timeout;
>>>>>>>> -        break;
>>>>>>>> -    }
>>>>>>>> -
>>>>>>>> -    r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>> -               num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>> -               timeout, NULL, sched_score, ring->name);
>>>>>>>> -    if (r) {
>>>>>>>> -        DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>>> -              ring->name);
>>>>>>>> -        return r;
>>>>>>>> -    }
>>>>>>>> +    if (!ring->fence_drv.fences)
>>>>>>>> +        return -ENOMEM;
>>>>>>>>            return 0;
>>>>>>>>      }
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> index fae7d185ad0d..7f20ce73a243 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> @@ -251,6 +251,8 @@ struct amdgpu_ring {
>>>>>>>>          bool has_compute_vm_bug;
>>>>>>>>          bool            no_scheduler;
>>>>>>>>          int            hw_prio;
>>>>>>>> +    unsigned num_hw_submission;
>>>>>>>> +    atomic_t        *sched_score;
>>>>>>>>      };
>>>>>>>>        #define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), (ib)))
--------------xxLZALHhgsUeHxRAOScsGuS1
Content-Type: text/plain; charset="UTF-8";
	name="0001-drm-amd-amdgpu-set-disabled-vcn-to-no_schduler.patch"
Content-Disposition: attachment;
	filename="0001-drm-amd-amdgpu-set-disabled-vcn-to-no_schduler.patch"
Content-Transfer-Encoding: base64

RnJvbSBmOGU1M2M3NGNlN2QwOTRhYzE0NjQ4ZTlkYTZiZjQzYjMwOTgzMjNmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaW5nd2VuIENoZW4gPEppbmd3ZW4uQ2hlbjJAYW1k
LmNvbT4KRGF0ZTogV2VkLCAyIE1hciAyMDIyIDE3OjQ0OjM4ICswODAwClN1YmplY3Q6IFtQ
QVRDSF0gZHJtL2FtZC9hbWRncHU6IHNldCBkaXNhYmxlZCB2Y24gdG8gbm9fc2NoZHVsZXIK
CltXaHldCmFmdGVyIHRoZSByZXNldCBkb21haW4gaW50cm9kdWNlZCwgdGhlIHNjaGVkLnJl
YWR5IHdpbGwgYmUgaW5pdCBhZnRlcgpod19pbml0LCB3aGljaCB3aWxsIG92ZXJ3cml0ZSB0
aGUgc2V0dXAgaW4gdmNuIGh3X2luaXQsIGFuZCBsZWFkIHRvCnZjbiBpYiB0ZXN0IGZhaWwu
CgpbSG93XQpzZXQgZGlzYWJsZWQgdmNuIHRvIG5vX3NjaGVkdWxlcgoKU2lnbmVkLW9mZi1i
eTogSmluZ3dlbiBDaGVuIDxKaW5nd2VuLkNoZW4yQGFtZC5jb20+CkNoYW5nZS1JZDogSTY5
Y2ZkN2I1ZmUwYjlmODZjMjYzYjI5M2RjNjYzYTkzNjhmMDU1YjAKLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3Zjbl92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jCmlu
ZGV4IGRhMTFjZWJhMDY5OC4uNWI1MTVjYTM2NzQ4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3Zjbl92M18wLmMKQEAgLTI5NSw2ICsyOTUsNyBAQCBzdGF0aWMgaW50IHZjbl92
M18wX2h3X2luaXQodm9pZCAqaGFuZGxlKQogCQkJcmluZyA9ICZhZGV2LT52Y24uaW5zdFtp
XS5yaW5nX2RlYzsKIAkJCWlmIChhbWRncHVfdmNuX2lzX2Rpc2FibGVkX3ZjbihhZGV2LCBW
Q05fREVDT0RFX1JJTkcsIGkpKSB7CiAJCQkJcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsK
KwkJCQlyaW5nLT5ub19zY2hlZHVsZXIgPSB0cnVlOwogCQkJCWRldl9pbmZvKGFkZXYtPmRl
diwgInJpbmcgJXMgaXMgZGlzYWJsZWQgYnkgaHlwZXJ2aXNvclxuIiwgcmluZy0+bmFtZSk7
CiAJCQl9IGVsc2UgewogCQkJCXJpbmctPndwdHIgPSAwOwpAQCAtMzA3LDYgKzMwOCw3IEBA
IHN0YXRpYyBpbnQgdmNuX3YzXzBfaHdfaW5pdCh2b2lkICpoYW5kbGUpCiAJCQkJcmluZyA9
ICZhZGV2LT52Y24uaW5zdFtpXS5yaW5nX2VuY1tqXTsKIAkJCQlpZiAoYW1kZ3B1X3Zjbl9p
c19kaXNhYmxlZF92Y24oYWRldiwgVkNOX0VOQ09ERV9SSU5HLCBpKSkgewogCQkJCQlyaW5n
LT5zY2hlZC5yZWFkeSA9IGZhbHNlOworCQkJCQlyaW5nLT5ub19zY2hlZHVsZXIgPSB0cnVl
OwogCQkJCQlkZXZfaW5mbyhhZGV2LT5kZXYsICJyaW5nICVzIGlzIGRpc2FibGVkIGJ5IGh5
cGVydmlzb3JcbiIsIHJpbmctPm5hbWUpOwogCQkJCX0gZWxzZSB7CiAJCQkJCXJpbmctPndw
dHIgPSAwOwotLSAKMi4zMi4wIChBcHBsZSBHaXQtMTMyKQoK

--------------xxLZALHhgsUeHxRAOScsGuS1--
