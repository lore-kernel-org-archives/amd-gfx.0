Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2C1C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 21:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82102074D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 21:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x7Z8LQOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82102074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565576E332;
	Fri, 14 Aug 2020 21:32:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4970B6E332
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 21:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVSblFYKIRChbIYP3RHEVwyn8HnSvc4vc3scMKl/7BqXohSHmtRk3XXfnMkta/shrSMyCCno6pal6NHTdxX28r+KR+tPyzebOhIAe43TS4MWn68MWllLOajgKUz0ZM1CvwoCPCvnige8TG4shzgsRsmc8HHLV7k0hNHQ1J9hqpsgkBbz2vVW/nfHHV11sUIShN2+sMotPqA+VJzKQ7VcOaRINItNcRdqPF/DVBuIWQuinn1eb2gcp65wAXhyEwKiu6jfFw7KwvoHjb0PNnXEi/lft4X23RF0Yda7MnCRsCYAPsuPoJEAwlStDg37M2rUrZn/BJpZ0dmveWsBzdWmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzDca4mgmn65QZKsLfEzmg/Oezm1OSu2mMdHpWxs9OA=;
 b=bx2DxVRpO4cKStSUgo8akKlEZNxYcZ52yToUMBRKS64vCn591XP27h05x9cREQ7IMBUmOHZRBPSz3X+5PF9nnf8HeBhABB6X/n1/yYRs4F/epBk05dIkhXygBVZ1Six9TW5bbd6FqUaUrY4oMyigWYMaCZL6f30FVBbFDRaE1PkoMAx3qKwxrhBmi1QPizIIakPEGsuxGkmHuohkKbBmG5F0LvilUDRqvNBXNxUd18IBdddj/EVYfpZ1cUBHVjuVV2yZQI0ntpBmx7qSNnPL8Yxy3wCQ7dJbDEp4Vpntd9pPS9rxFQEtwEwP8E2BpXqeb6Zds7dzqNOrPf/JAbEnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzDca4mgmn65QZKsLfEzmg/Oezm1OSu2mMdHpWxs9OA=;
 b=x7Z8LQOFxs8S7YdsZzk/DpowMsLjV1Lj3tasNle2lE4Q9NXprUPLIdfsmqZAGtdnncXaDUplc1AortQY8GIpoKPY47jna4T0B1xrp8UwHFMfN2DJFbu8CZ0qDv2h7qyoMx6yWGVPT3PAaLmrEvxAa9eI4ne9XN0FLPvvKrmR9eA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 21:32:34 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 21:32:34 +0000
Subject: Re: [PATCH 1/2] drm/scheduler: Scheduler priority fixes
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200814191401.25606-1-luben.tuikov@amd.com>
 <20200814191401.25606-2-luben.tuikov@amd.com>
 <CADnq5_PnSNNZjyHt_hEq1Sb_g9TpAnYL3fo_L57oaM79HM90Jw@mail.gmail.com>
 <CADnq5_NPa_=tdHGvV_C16fQ-TdpywNiq_jz-njfN=kb8y-+TvA@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <9c093aa2-ed93-2140-f32b-5c726f502726@amd.com>
Date: Fri, 14 Aug 2020 17:32:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <CADnq5_NPa_=tdHGvV_C16fQ-TdpywNiq_jz-njfN=kb8y-+TvA@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::27) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 21:32:34 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca3413da-6d5e-4d7f-fd3c-08d840998ed3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3466CAC51647FA1992E76A5C99400@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(6486002)(52116002)(6506007)(8936002)(16526019)(4326008)(186003)(53546011)(83380400001)(26005)(66946007)(5660300002)(66476007)(31696002)(36756003)(2906002)(956004)(6512007)(66556008)(6916009)(8676002)(316002)(478600001)(2616005)(31686004)(44832011)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3413da-6d5e-4d7f-fd3c-08d840998ed3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 21:32:34.5265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvTcxHGPqFwiC2kpMJydJYRu7palZgc27/Gdof/MNoGT0XniR7bYPlRxxNYBXveg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-14 4:58 p.m., Alex Deucher wrote:
> On Fri, Aug 14, 2020 at 3:33 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> + dri-devel
>>
>> On Fri, Aug 14, 2020 at 3:14 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>>
>>> Remove DRM_SCHED_PRIORITY_LOW, as it was used
>>> in only one place.
>>>
>>> Rename and separate by a line
>>> DRM_SCHED_PRIORITY_MAX to DRM_SCHED_PRIORITY_COUNT
>>> as it represents a (total) count of said
>>> priorities and it is used as such in loops
>>> throughout the code. (0-based indexing is the
>>> the count number.)
>>>
>>> Remove redundant word HIGH in priority names,
>>> and rename *KERNEL* to *HIGH*, as it really
>>> means that, high.
>>>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   |  6 +++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  6 +++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  2 +-
>>>  drivers/gpu/drm/scheduler/sched_main.c    |  8 ++++----
>>>  include/drm/gpu_scheduler.h               | 15 +++++++++------
>>>  8 files changed, 23 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index d85d13f7a043..fd97ac34277b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -46,7 +46,7 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>>>  static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>>>                                       enum drm_sched_priority priority)
>>>  {
>>> -       if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
>>> +       if (priority < 0 || priority >= DRM_SCHED_PRIORITY_COUNT)
>>>                 return -EINVAL;
>>>
>>>         /* NORMAL and below are accessible by everyone */
>>> @@ -65,8 +65,8 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>>>  static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
>>>  {
>>>         switch (prio) {
>>> -       case DRM_SCHED_PRIORITY_HIGH_HW:
>>> -       case DRM_SCHED_PRIORITY_KERNEL:
>>> +       case DRM_SCHED_PRIORITY_HW:
>>> +       case DRM_SCHED_PRIORITY_HIGH:
>>>                 return AMDGPU_GFX_PIPE_PRIO_HIGH;
>>>         default:
>>>                 return AMDGPU_GFX_PIPE_PRIO_NORMAL;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 75d37dfb51aa..bb9e5481ff3c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -251,7 +251,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>>>         int i;
>>>
>>>         /* Signal all jobs not yet scheduled */
>>> -       for (i = DRM_SCHED_PRIORITY_MAX - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
>>> +       for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
>>>                 struct drm_sched_rq *rq = &sched->sched_rq[i];
>>>
>>>                 if (!rq)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 13ea8ebc421c..6d4fc79bf84a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -267,7 +267,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>                         &ring->sched;
>>>         }
>>>
>>> -       for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
>>> +       for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; ++i)
>>>                 atomic_set(&ring->num_jobs[i], 0);
>>>
>>>         return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index da871d84b742..7112137689db 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -243,7 +243,7 @@ struct amdgpu_ring {
>>>         bool                    has_compute_vm_bug;
>>>         bool                    no_scheduler;
>>>
>>> -       atomic_t                num_jobs[DRM_SCHED_PRIORITY_MAX];
>>> +       atomic_t                num_jobs[DRM_SCHED_PRIORITY_COUNT];
>>>         struct mutex            priority_mutex;
>>>         /* protected by priority_mutex */
>>>         int                     priority;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> index c799691dfa84..e05bc22a0a49 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> @@ -36,14 +36,14 @@ enum drm_sched_priority amdgpu_to_sched_priority(int amdgpu_priority)
>>>  {
>>>         switch (amdgpu_priority) {
>>>         case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>> -               return DRM_SCHED_PRIORITY_HIGH_HW;
>>> +               return DRM_SCHED_PRIORITY_HW;
>>>         case AMDGPU_CTX_PRIORITY_HIGH:
>>> -               return DRM_SCHED_PRIORITY_HIGH_SW;
>>> +               return DRM_SCHED_PRIORITY_SW;
>>>         case AMDGPU_CTX_PRIORITY_NORMAL:
>>>                 return DRM_SCHED_PRIORITY_NORMAL;
>>>         case AMDGPU_CTX_PRIORITY_LOW:
>>>         case AMDGPU_CTX_PRIORITY_VERY_LOW:
>>> -               return DRM_SCHED_PRIORITY_LOW;
>>> +               return DRM_SCHED_PRIORITY_MIN;
>>>         case AMDGPU_CTX_PRIORITY_UNSET:
>>>                 return DRM_SCHED_PRIORITY_UNSET;
>>>         default:
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 20fa0497aaa4..bc4bdb90d8f7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -2114,7 +2114,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>>                 ring = adev->mman.buffer_funcs_ring;
>>>                 sched = &ring->sched;
>>>                 r = drm_sched_entity_init(&adev->mman.entity,
>>> -                                         DRM_SCHED_PRIORITY_KERNEL, &sched,
>>> +                                         DRM_SCHED_PRIORITY_HIGH, &sched,
>>>                                           1, NULL);
>>>                 if (r) {
>>>                         DRM_ERROR("Failed setting up TTM BO move entity (%d)\n",
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>>> index 2f319102ae9f..c2947e73d1b6 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -335,9 +335,9 @@ void drm_sched_increase_karma(struct drm_sched_job *bad)
>>>          * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
>>>          * corrupt but keep in mind that kernel jobs always considered good.
>>>          */
>>> -       if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
>>> +       if (bad->s_priority != DRM_SCHED_PRIORITY_HIGH) {
>>>                 atomic_inc(&bad->karma);
>>> -               for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
>>> +               for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_HIGH;
>>>                      i++) {
>>>                         struct drm_sched_rq *rq = &sched->sched_rq[i];
>>>
>>> @@ -623,7 +623,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
>>>                 return NULL;
>>>
>>>         /* Kernel run queue has higher priority than normal run queue*/
>>> -       for (i = DRM_SCHED_PRIORITY_MAX - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
>>> +       for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
>>>                 entity = drm_sched_rq_select_entity(&sched->sched_rq[i]);
>>>                 if (entity)
>>>                         break;
>>> @@ -851,7 +851,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>>>         sched->name = name;
>>>         sched->timeout = timeout;
>>>         sched->hang_limit = hang_limit;
>>> -       for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_MAX; i++)
>>> +       for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; i++)
>>>                 drm_sched_rq_init(sched, &sched->sched_rq[i]);
>>>
>>>         init_waitqueue_head(&sched->wake_up_worker);
>>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>>> index 26b04ff62676..8ae9b8f73bf9 100644
>>> --- a/include/drm/gpu_scheduler.h
>>> +++ b/include/drm/gpu_scheduler.h
>>> @@ -33,14 +33,17 @@
>>>  struct drm_gpu_scheduler;
>>>  struct drm_sched_rq;
>>>
>>> +/* These are often used as an (initial) index
>>> + * to an array, and as such should start at 0.
>>> + */
>>>  enum drm_sched_priority {
>>>         DRM_SCHED_PRIORITY_MIN,
>>> -       DRM_SCHED_PRIORITY_LOW = DRM_SCHED_PRIORITY_MIN,
>>>         DRM_SCHED_PRIORITY_NORMAL,
>>> -       DRM_SCHED_PRIORITY_HIGH_SW,
>>> -       DRM_SCHED_PRIORITY_HIGH_HW,
>>
>> We originally added HIGH_SW and HIGH_HW to differentiate between two
>> different high priority modes; e.g., HIGH_SW meant that the gpu
>> scheduler would schedule with high priority, HIGH_HW meant that the
>> hardware would schedule with high priority. You can set different
>> queue priorities in the hardware and work from the high priority queue
>> will get scheduled on the hw sooner than lower priority queues.  Not
>> all engines support HW queue priorities however.
> 
> Thinking about this more, I think we can probably just get rid of the
> SW and HW settings and just have a HIGH setting.  We can use HIGH
> whether or not we have additional hw priority features or not.  We
> want to keep KERNEL however since that is the highest priority and it
> makes it obvious what it is for.  Submissions from the kernel need to
> be the highest priority (e.g., memory managment or page table
> updates).
> 

"MIN, NORMAL, HIGH, KERNEL", sure we can do that. That's better
and gets rid of the ambiguous "SW, HW". I'll do that.

Regards,
Luben

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
