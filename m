Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DDDC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 03:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B12F206EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 03:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WBaS45ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B12F206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B486E0AA;
	Fri, 20 Dec 2019 03:48:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370376E0AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 03:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFl7QJiBNKLP7P10E5upC9Mqcp5c6MIRAKN/NC8rn5/QmamMOrBpBDVAUcnFcQ8YHgwRCnR9wtEshlxL0g2lv4MRKNDlnKfiSW6G3HMxUa1AxAgKhS89WfkeOPARlADL1DOJpkpEQ4uzjydSU8GMh8uxqTFQLK+QnRA+2zoBQO4x9P9zNGuGyX0Q9Vjobn06epT9ihDpTfEyBD+0VWL3ARXLFB/ysPVCspvjHeLLerDaXW/n5yJvrlOVqK1P+8SzifjBvKQJw2k4HLBXsMSioQcRI70QCZm5EDepNywzhGjo+TXCrGgG/c1WbDMXqqtnjFVusQW8eT2hHXo6ekWRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwNkJng57T8CyFZvAVKm7K7YlQkBdNmFIMu/eDf1f9M=;
 b=NjaqCObyTSk77OSdI4VDJtDvkyMfY5rpizK4V7mW4rLI/X3gJxVwUOW9Jv4akrarDoLDeI95evZUFW1iXQF1GVMlqZFkA5ev2L/HNAQYYyoLUCG83B6GCeo8QPeGU7tFMPL/qynNJxNjqjLH0AYxmfqg0xznlySzU69oEAtcWeLe1EzrjD4pNDcMOgt1TZy26vwaq0V+hjPt382Wm5gE0DZM9Cn2e/hO4Nj3b+6M1uDhN3RdT4ISuLBpuK+2f0KlOSj9aYfBIzCY5rj/otif1YBG9ZzSYh6BsvBfVG29YllDdmFlqsWq5eLoOE2Q23yEpPxvXDHJGkOPecLgn4Er6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwNkJng57T8CyFZvAVKm7K7YlQkBdNmFIMu/eDf1f9M=;
 b=WBaS45ol54G7ia4amAkqnUB/RYMERSib2lN36+9prxoOt3PKkms0+0FT6LNWIwUa1X/6f0bcQQF+FLjEog5iitRoc9Fx0gu5JOnlYvkvP+8lQloHdlO6oha3QM4ivWd+hTddGJ4JMkXNO1z37jy69ysgzBVOfyD/GvYw/Jd6a/I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3231.namprd12.prod.outlook.com (20.179.83.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 03:33:56 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 03:33:56 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Don't touch the hardware in pre_reset
 callback
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, Monk" <Monk.Liu@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
References: <20191220020907.6896-1-Felix.Kuehling@amd.com>
 <d130b573-f087-4ba0-e586-d898886ac13b@amd.com>
 <DM6PR12MB32417F69354B176C28AB3ACBF42D0@DM6PR12MB3241.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3d746045-d2ea-7ad4-0df1-64d6c3fc70d6@amd.com>
Date: Thu, 19 Dec 2019 22:33:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <DM6PR12MB32417F69354B176C28AB3ACBF42D0@DM6PR12MB3241.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
Received: from [172.27.233.207] (165.204.55.251) by
 YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::42) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 03:33:55 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed6b7d2c-8843-4e7b-ef73-08d784fd7161
X-MS-TrafficTypeDiagnostic: MN2PR12MB3231:|MN2PR12MB3231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3231C2F2328D3FE27B8C9F4E922D0@MN2PR12MB3231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(43544003)(2616005)(6636002)(86362001)(30864003)(16526019)(8676002)(66476007)(8936002)(66556008)(956004)(53546011)(316002)(16576012)(26005)(2906002)(66946007)(81166006)(81156014)(36756003)(33964004)(31696002)(5660300002)(478600001)(52116002)(4001150100001)(31686004)(186003)(6486002)(110136005)(44832011)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3231;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilCQ039NPcStosov3IebtKocCgU9u6Z1JdbAdP/YSV2xpCDRyTbMRNwg5m2scuRr850rvzvg+ZbKKQOZVXGdhmTjWcXnXZHZ/hQOIsJL9W8keZZp7q4Umnscdj8SHxYIAH8hK+wyeljrzJS69mbEJjrAv1J4iN2Mtw28ULuikzUwHqhMValn6mQo9epbWV+wwMekdfvlzMHf3/zSPWQTV5uP9G1wHYOv5WWet92jv26eymSUdxXrAcGKWl9uG1fUADFx46CQBFOriHcpkphOvbRc4fVw6f64LyXzQTORexOZ+2jD6dWCbzc9rLTk74hgQ4VCt029WRE126AZi/PjpNyhN4zEvTtm4ygL5everb+pXwHY9eq3FG2atbdBVKZHAWX2GDJ+62a14OtGnrSuY5W1QzCEhcYfyWeIvTZVF56u+UwZ+KyfiGwKfOFAPIoiad+ZQ8PzVAo7SlF1bsz7A80zXztYcw+gUvUSRXcHPz9NNF90JVxJrSEKf54bSnSefuzWEEH1CXCJIh6k0gsvkA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6b7d2c-8843-4e7b-ef73-08d784fd7161
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 03:33:56.2119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtTo7hMRg7VRSDb6KF1F+D6n+bJtoWT4awClabcn5uHpxVSq58RLiA2+zrGAkLz0KgkvupTwkbn0xwly5Yp0OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3231
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
Content-Type: multipart/mixed; boundary="===============1226101414=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1226101414==
Content-Type: multipart/alternative;
 boundary="------------BEE0C75844F6D718DD6AEC3F"
Content-Language: en-US

--------------BEE0C75844F6D718DD6AEC3F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2019-12-19 21:34, Liu, Shaoyun wrote:
> Will it looks cleaner if we keep a pre_reset flag in per device 
> structure and check it in the function when talk to hw?

I was briefly considering that when I saw how many function needed that 
pre_reset flag. But this could lead to race conditions with other 
threads doing evictions concurrently (e.g. MMU notifiers). I think we 
want concurrent evictions to hang until the GPU reset is done, not just 
skip the actual eviction quietly.

Hmm, I need to think more about the interaction between evictions and 
resets.

Regards,
   Felix

>
> Regards
> Shaoyun.liu
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* December 19, 2019 9:21:08 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> Liu, Monk <Monk.Liu@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; 
> Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *Subject:* Re: [PATCH 1/1] drm/amdkfd: Don't touch the hardware in 
> pre_reset callback
> [+Andrey]
>
> Hi Shaoyun, Monk, and Andrey,
>
> I tested this on my bare-metal Vega10 system. GPU reset (using BACO) is
> flaky on this system with and without this patch. The first reset seems
> to work OK, the second one fails in different ways. In theory this
> change should be an improvement as it eliminated at least one failure
> mode (hanging before the actual reset). A least I don't think I'm making
> anything worse.
>
> My test is to run KFDTest and trigger a GPU reset while it's busy with
> the eviction test. This test runs multiple KFD processes and also
> performs graphics memory allocations and command submissions to force
> TTM to evict KFD processes. I trigger the reset by hanging the HWS
> through a debugfs hook:
>
>      # cat /sys/class/kfd/kfd/topology/nodes/1/gpu_id >
> /sys/kernel/debug/kfd/hang_hws
>
> Please give this patch a try and reinstate the pre_reset call before the
> FLR for SRIOV.
>
> Regards,
>    Felix
>
> On 2019-12-19 9:09 p.m., Felix Kuehling wrote:
> > The intention of the pre_reset callback is to update the driver
> > state to reflect that all user mode queues are preempted and the
> > HIQ is destroyed. However we should not actually preempt any queues
> > or otherwise touch the hardware because it is presumably hanging.
> > The impending reset will take care of actually stopping all queues.
> >
> > This should prevent KIQ register access hanging on SRIOV function
> > level reset (FLR). It should also speed up the reset by avoiding
> > unnecessary timeouts from a potentially hanging GPU scheduler.
> >
> > CC: shaoyunl <shaoyun.liu@amd.com>
> > CC: Liu Monk <Monk.Liu@amd.com>
> > Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 24 ++++++++++-------
> >   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 ++++++++++++-------
> >   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  5 ++--
> >   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  8 +++---
> >   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +--
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  8 +++---
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 11 ++++----
> >   .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
> >   8 files changed, 53 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index c6b6901bbda3..796996a0d926 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -486,6 +486,7 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, 
> unsigned int buf_size,
> >                                unsigned int chunk_size);
> >   static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
> >
> > +static void kfd_suspend(struct kfd_dev *kfd, bool pre_reset);
> >   static int kfd_resume(struct kfd_dev *kfd);
> >
> >   struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
> > @@ -728,7 +729,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> >   {
> >        if (!kfd->init_complete)
> >                return 0;
> > -     kgd2kfd_suspend(kfd);
> > +     kfd_suspend(kfd, true);
> >
> >        kfd_signal_reset_event(kfd);
> >        return 0;
> > @@ -767,13 +768,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd)
> >        if (!kfd->init_complete)
> >                return;
> >
> > -     /* For first KFD device suspend all the KFD processes */
> > -     if (atomic_inc_return(&kfd_locked) == 1)
> > -             kfd_suspend_all_processes();
> > -
> > -     kfd->dqm->ops.stop(kfd->dqm);
> > -
> > -     kfd_iommu_suspend(kfd);
> > +     kfd_suspend(kfd, false);
> >   }
> >
> >   int kgd2kfd_resume(struct kfd_dev *kfd)
> > @@ -795,6 +790,17 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
> >        return ret;
> >   }
> >
> > +static void kfd_suspend(struct kfd_dev *kfd, bool pre_reset)
> > +{
> > +     /* For first KFD device suspend all the KFD processes */
> > +     if (atomic_inc_return(&kfd_locked) == 1)
> > +             kfd_suspend_all_processes(pre_reset);
> > +
> > +     kfd->dqm->ops.stop(kfd->dqm, pre_reset);
> > +
> > +     kfd_iommu_suspend(kfd);
> > +}
> > +
> >   static int kfd_resume(struct kfd_dev *kfd)
> >   {
> >        int err = 0;
> > @@ -877,7 +883,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
> >        if (!p)
> >                return -ESRCH;
> >
> > -     r = kfd_process_evict_queues(p);
> > +     r = kfd_process_evict_queues(p, false);
> >
> >        kfd_unref_process(p);
> >        return r;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index f7f6df40875e..3a49944164da 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -592,7 +592,8 @@ static int update_queue(struct 
> device_queue_manager *dqm, struct queue *q)
> >   }
> >
> >   static int evict_process_queues_nocpsch(struct 
> device_queue_manager *dqm,
> > -                                     struct qcm_process_device *qpd)
> > +                                     struct qcm_process_device *qpd,
> > +                                     bool pre_reset)
> >   {
> >        struct queue *q;
> >        struct mqd_manager *mqd_mgr;
> > @@ -622,6 +623,8 @@ static int evict_process_queues_nocpsch(struct 
> device_queue_manager *dqm,
> >
> >                if (WARN_ONCE(!dqm->sched_running, "Evict when 
> stopped\n"))
> >                        continue;
> > +             if (pre_reset)
> > +                     continue;
> >
> >                retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
> > KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
> > @@ -639,7 +642,8 @@ static int evict_process_queues_nocpsch(struct 
> device_queue_manager *dqm,
> >   }
> >
> >   static int evict_process_queues_cpsch(struct device_queue_manager 
> *dqm,
> > -                                   struct qcm_process_device *qpd)
> > +                                   struct qcm_process_device *qpd,
> > +                                   bool pre_reset)
> >   {
> >        struct queue *q;
> >        struct kfd_process_device *pdd;
> > @@ -664,6 +668,10 @@ static int evict_process_queues_cpsch(struct 
> device_queue_manager *dqm,
> >                q->properties.is_active = false;
> >                dqm->queue_count--;
> >        }
> > +
> > +     if (pre_reset)
> > +             goto out;
> > +
> >        retval = execute_queues_cpsch(dqm,
> >                                qpd->is_debug ?
> > KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
> > @@ -944,10 +952,10 @@ static int start_nocpsch(struct 
> device_queue_manager *dqm)
> >        return 0;
> >   }
> >
> > -static int stop_nocpsch(struct device_queue_manager *dqm)
> > +static int stop_nocpsch(struct device_queue_manager *dqm, bool 
> pre_reset)
> >   {
> >        if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
> > -             pm_uninit(&dqm->packets);
> > +             pm_uninit(&dqm->packets, pre_reset);
> >        dqm->sched_running = false;
> >
> >        return 0;
> > @@ -1107,20 +1115,21 @@ static int start_cpsch(struct 
> device_queue_manager *dqm)
> >        return 0;
> >   fail_allocate_vidmem:
> >   fail_set_sched_resources:
> > -     pm_uninit(&dqm->packets);
> > +     pm_uninit(&dqm->packets, false);
> >   fail_packet_manager_init:
> >        return retval;
> >   }
> >
> > -static int stop_cpsch(struct device_queue_manager *dqm)
> > +static int stop_cpsch(struct device_queue_manager *dqm, bool pre_reset)
> >   {
> >        dqm_lock(dqm);
> > -     unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
> > +     if (!pre_reset)
> > +             unmap_queues_cpsch(dqm, 
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
> >        dqm->sched_running = false;
> >        dqm_unlock(dqm);
> >
> >        kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
> > -     pm_uninit(&dqm->packets);
> > +     pm_uninit(&dqm->packets, pre_reset);
> >
> >        return 0;
> >   }
> > @@ -1891,7 +1900,7 @@ int kfd_process_vm_fault(struct 
> device_queue_manager *dqm,
> >                return -EINVAL;
> >        pdd = kfd_get_process_device_data(dqm->dev, p);
> >        if (pdd)
> > -             ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> > +             ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd, 
> false);
> >        kfd_unref_process(p);
> >
> >        return ret;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> > index a8c37e6da027..9f82f95f6a92 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> > @@ -103,7 +103,7 @@ struct device_queue_manager_ops {
> >
> >        int     (*initialize)(struct device_queue_manager *dqm);
> >        int     (*start)(struct device_queue_manager *dqm);
> > -     int     (*stop)(struct device_queue_manager *dqm);
> > +     int     (*stop)(struct device_queue_manager *dqm, bool pre_reset);
> >        void    (*uninitialize)(struct device_queue_manager *dqm);
> >        int     (*create_kernel_queue)(struct device_queue_manager *dqm,
> >                                        struct kernel_queue *kq,
> > @@ -129,7 +129,8 @@ struct device_queue_manager_ops {
> >                        struct qcm_process_device *qpd);
> >
> >        int (*evict_process_queues)(struct device_queue_manager *dqm,
> > -                                 struct qcm_process_device *qpd);
> > +                                 struct qcm_process_device *qpd,
> > +                                 bool pre_reset);
> >        int (*restore_process_queues)(struct device_queue_manager *dqm,
> >                                      struct qcm_process_device *qpd);
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> > index 2d56dc534459..dbd2e8e9ae69 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> > @@ -195,9 +195,9 @@ static bool kq_initialize(struct kernel_queue 
> *kq, struct kfd_dev *dev,
> >   }
> >
> >   /* Uninitialize a kernel queue and free all its memory usages. */
> > -static void kq_uninitialize(struct kernel_queue *kq)
> > +static void kq_uninitialize(struct kernel_queue *kq, bool pre_reset)
> >   {
> > -     if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ)
> > +     if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && 
> !pre_reset)
> > kq->mqd_mgr->destroy_mqd(kq->mqd_mgr,
> > kq->queue->mqd,
> > KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
> > @@ -337,9 +337,9 @@ struct kernel_queue *kernel_queue_init(struct 
> kfd_dev *dev,
> >        return NULL;
> >   }
> >
> > -void kernel_queue_uninit(struct kernel_queue *kq)
> > +void kernel_queue_uninit(struct kernel_queue *kq, bool pre_reset)
> >   {
> > -     kq_uninitialize(kq);
> > +     kq_uninitialize(kq, pre_reset);
> >        kfree(kq);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > index 6cabed06ef5d..7732a3bbebd6 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > @@ -264,10 +264,10 @@ int pm_init(struct packet_manager *pm, struct 
> device_queue_manager *dqm)
> >        return 0;
> >   }
> >
> > -void pm_uninit(struct packet_manager *pm)
> > +void pm_uninit(struct packet_manager *pm, bool pre_reset)
> >   {
> >        mutex_destroy(&pm->lock);
> > -     kernel_queue_uninit(pm->priv_queue);
> > +     kernel_queue_uninit(pm->priv_queue, pre_reset);
> >   }
> >
> >   int pm_send_set_resources(struct packet_manager *pm,
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index 087e96838997..9bc4ced4acba 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -762,9 +762,9 @@ struct kfd_process *kfd_get_process(const struct 
> task_struct *);
> >   struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid);
> >   struct kfd_process *kfd_lookup_process_by_mm(const struct 
> mm_struct *mm);
> >   void kfd_unref_process(struct kfd_process *p);
> > -int kfd_process_evict_queues(struct kfd_process *p);
> > +int kfd_process_evict_queues(struct kfd_process *p, bool pre_reset);
> >   int kfd_process_restore_queues(struct kfd_process *p);
> > -void kfd_suspend_all_processes(void);
> > +void kfd_suspend_all_processes(bool pre_reset);
> >   int kfd_resume_all_processes(void);
> >
> >   int kfd_process_device_init_vm(struct kfd_process_device *pdd,
> > @@ -883,7 +883,7 @@ struct device_queue_manager 
> *device_queue_manager_init(struct kfd_dev *dev);
> >   void device_queue_manager_uninit(struct device_queue_manager *dqm);
> >   struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
> >                                        enum kfd_queue_type type);
> > -void kernel_queue_uninit(struct kernel_queue *kq);
> > +void kernel_queue_uninit(struct kernel_queue *kq, bool pre_reset);
> >   int kfd_process_vm_fault(struct device_queue_manager *dqm, 
> unsigned int pasid);
> >
> >   /* Process Queue Manager */
> > @@ -974,7 +974,7 @@ extern const struct packet_manager_funcs 
> kfd_vi_pm_funcs;
> >   extern const struct packet_manager_funcs kfd_v9_pm_funcs;
> >
> >   int pm_init(struct packet_manager *pm, struct device_queue_manager 
> *dqm);
> > -void pm_uninit(struct packet_manager *pm);
> > +void pm_uninit(struct packet_manager *pm, bool pre_reset);
> >   int pm_send_set_resources(struct packet_manager *pm,
> >                                struct scheduling_resources *res);
> >   int pm_send_runlist(struct packet_manager *pm, struct list_head 
> *dqm_queues);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > index 536a153ac9a4..7bcadd3a1e3b 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -948,7 +948,7 @@ struct kfd_process 
> *kfd_lookup_process_by_mm(const struct mm_struct *mm)
> >    * Eviction is reference-counted per process-device. This means 
> multiple
> >    * evictions from different sources can be nested safely.
> >    */
> > -int kfd_process_evict_queues(struct kfd_process *p)
> > +int kfd_process_evict_queues(struct kfd_process *p, bool pre_reset)
> >   {
> >        struct kfd_process_device *pdd;
> >        int r = 0;
> > @@ -956,7 +956,8 @@ int kfd_process_evict_queues(struct kfd_process *p)
> >
> >        list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
> >                r = 
> pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
> > - &pdd->qpd);
> > + &pdd->qpd,
> > + pre_reset);
> >                if (r) {
> >                        pr_err("Failed to evict process queues\n");
> >                        goto fail;
> > @@ -1026,7 +1027,7 @@ static void evict_process_worker(struct 
> work_struct *work)
> >        flush_delayed_work(&p->restore_work);
> >
> >        pr_debug("Started evicting pasid 0x%x\n", p->pasid);
> > -     ret = kfd_process_evict_queues(p);
> > +     ret = kfd_process_evict_queues(p, false);
> >        if (!ret) {
> >                dma_fence_signal(p->ef);
> >                dma_fence_put(p->ef);
> > @@ -1082,7 +1083,7 @@ static void restore_process_worker(struct 
> work_struct *work)
> >                pr_err("Failed to restore queues of pasid 0x%x\n", 
> p->pasid);
> >   }
> >
> > -void kfd_suspend_all_processes(void)
> > +void kfd_suspend_all_processes(bool pre_reset)
> >   {
> >        struct kfd_process *p;
> >        unsigned int temp;
> > @@ -1092,7 +1093,7 @@ void kfd_suspend_all_processes(void)
> > cancel_delayed_work_sync(&p->eviction_work);
> > cancel_delayed_work_sync(&p->restore_work);
> >
> > -             if (kfd_process_evict_queues(p))
> > +             if (kfd_process_evict_queues(p, pre_reset))
> >                        pr_err("Failed to suspend process 0x%x\n", 
> p->pasid);
> >                dma_fence_signal(p->ef);
> >                dma_fence_put(p->ef);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > index d3eacf72e8db..8fa856e6a03f 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > @@ -374,7 +374,7 @@ int pqm_destroy_queue(struct 
> process_queue_manager *pqm, unsigned int qid)
> >                /* destroy kernel queue (DIQ) */
> >                dqm = pqn->kq->dev->dqm;
> >                dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
> > -             kernel_queue_uninit(pqn->kq);
> > +             kernel_queue_uninit(pqn->kq, false);
> >        }
> >
> >        if (pqn->q) {

--------------BEE0C75844F6D718DD6AEC3F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 2019-12-19 21:34, Liu, Shaoyun
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB32417F69354B176C28AB3ACBF42D0@DM6PR12MB3241.namprd12.prod.outlook.com">
      
      Will it looks cleaner if we keep a pre_reset flag in per device
      structure and check it in the function when talk to hw?<br>
    </blockquote>
    <p>I was briefly considering that when I saw how many function
      needed that pre_reset flag. But this could lead to race conditions
      with other threads doing evictions concurrently (e.g. MMU
      notifiers). I think we want concurrent evictions to hang until the
      GPU reset is done, not just skip the actual eviction quietly.<br>
    </p>
    <p>Hmm, I need to think more about the interaction between evictions
      and resets.</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <blockquote type="cite" cite="mid:DM6PR12MB32417F69354B176C28AB3ACBF42D0@DM6PR12MB3241.namprd12.prod.outlook.com"><br>
      Regards<br>
      Shaoyun.liu
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
          <b>Sent:</b> December 19, 2019 9:21:08 PM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Liu, Monk
          <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Liu, Shaoyun
          <a class="moz-txt-link-rfc2396E" href="mailto:Shaoyun.Liu@amd.com">&lt;Shaoyun.Liu@amd.com&gt;</a>; Grodzovsky, Andrey
          <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH 1/1] drm/amdkfd: Don't touch the
          hardware in pre_reset callback</font>
        <div>&nbsp;</div>
      </div>
      <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
            <div class="PlainText">[&#43;Andrey]<br>
              <br>
              Hi Shaoyun, Monk, and Andrey,<br>
              <br>
              I tested this on my bare-metal Vega10 system. GPU reset
              (using BACO) is <br>
              flaky on this system with and without this patch. The
              first reset seems <br>
              to work OK, the second one fails in different ways. In
              theory this <br>
              change should be an improvement as it eliminated at least
              one failure <br>
              mode (hanging before the actual reset). A least I don't
              think I'm making <br>
              anything worse.<br>
              <br>
              My test is to run KFDTest and trigger a GPU reset while
              it's busy with <br>
              the eviction test. This test runs multiple KFD processes
              and also <br>
              performs graphics memory allocations and command
              submissions to force <br>
              TTM to evict KFD processes. I trigger the reset by hanging
              the HWS <br>
              through a debugfs hook:<br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp; # cat /sys/class/kfd/kfd/topology/nodes/1/gpu_id &gt;
              <br>
              /sys/kernel/debug/kfd/hang_hws<br>
              <br>
              Please give this patch a try and reinstate the pre_reset
              call before the <br>
              FLR for SRIOV.<br>
              <br>
              Regards,<br>
              &nbsp;&nbsp; Felix<br>
              <br>
              On 2019-12-19 9:09 p.m., Felix Kuehling wrote:<br>
              &gt; The intention of the pre_reset callback is to update
              the driver<br>
              &gt; state to reflect that all user mode queues are
              preempted and the<br>
              &gt; HIQ is destroyed. However we should not actually
              preempt any queues<br>
              &gt; or otherwise touch the hardware because it is
              presumably hanging.<br>
              &gt; The impending reset will take care of actually
              stopping all queues.<br>
              &gt;<br>
              &gt; This should prevent KIQ register access hanging on
              SRIOV function<br>
              &gt; level reset (FLR). It should also speed up the reset
              by avoiding<br>
              &gt; unnecessary timeouts from a potentially hanging GPU
              scheduler.<br>
              &gt;<br>
              &gt; CC: shaoyunl <a class="moz-txt-link-rfc2396E" href="mailto:shaoyun.liu@amd.com">&lt;shaoyun.liu@amd.com&gt;</a><br>
              &gt; CC: Liu Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a><br>
              &gt; Signed-off-by: Felix Kuehling
              <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
              &gt; ---<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 24
              &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
              &gt;&nbsp;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27
              &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
              &gt;&nbsp;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.h |&nbsp; 5
              &#43;&#43;--<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |&nbsp; 8
              &#43;&#43;&#43;---<br>
              &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_packet_manager.c&nbsp;&nbsp; |&nbsp; 4
              &#43;--<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8
              &#43;&#43;&#43;---<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 11
              &#43;&#43;&#43;&#43;----<br>
              &gt;&nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp; |&nbsp; 2
              &#43;-<br>
              &gt;&nbsp;&nbsp; 8 files changed, 53 insertions(&#43;), 36 deletions(-)<br>
              &gt;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
              &gt; index c6b6901bbda3..796996a0d926 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
              &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
              &gt; @@ -486,6 &#43;486,7 @@ static int kfd_gtt_sa_init(struct
              kfd_dev *kfd, unsigned int buf_size,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int
              chunk_size);<br>
              &gt;&nbsp;&nbsp; static void kfd_gtt_sa_fini(struct kfd_dev *kfd);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; &#43;static void kfd_suspend(struct kfd_dev *kfd, bool
              pre_reset);<br>
              &gt;&nbsp;&nbsp; static int kfd_resume(struct kfd_dev *kfd);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp; struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,<br>
              &gt; @@ -728,7 &#43;729,7 @@ int kgd2kfd_pre_reset(struct
              kfd_dev *kfd)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd-&gt;init_complete)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_suspend(kfd);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfd_suspend(kfd, true);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_signal_reset_event(kfd);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              &gt; @@ -767,13 &#43;768,7 @@ void kgd2kfd_suspend(struct
              kfd_dev *kfd)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd-&gt;init_complete)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* For first KFD device suspend all the KFD
              processes */<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_inc_return(&amp;kfd_locked) == 1)<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_suspend_all_processes();<br>
              &gt; -<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm);<br>
              &gt; -<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfd_iommu_suspend(kfd);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfd_suspend(kfd, false);<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp; int kgd2kfd_resume(struct kfd_dev *kfd)<br>
              &gt; @@ -795,6 &#43;790,17 @@ int kgd2kfd_resume(struct
              kfd_dev *kfd)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; &#43;static void kfd_suspend(struct kfd_dev *kfd, bool
              pre_reset)<br>
              &gt; &#43;{<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* For first KFD device suspend all the KFD
              processes */<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_inc_return(&amp;kfd_locked) == 1)<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_suspend_all_processes(pre_reset);<br>
              &gt; &#43;<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm,
              pre_reset);<br>
              &gt; &#43;<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfd_iommu_suspend(kfd);<br>
              &gt; &#43;}<br>
              &gt; &#43;<br>
              &gt;&nbsp;&nbsp; static int kfd_resume(struct kfd_dev *kfd)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err = 0;<br>
              &gt; @@ -877,7 &#43;883,7 @@ int kgd2kfd_quiesce_mm(struct
              mm_struct *mm)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ESRCH;<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; r = kfd_process_evict_queues(p);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r = kfd_process_evict_queues(p, false);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
              &gt; index f7f6df40875e..3a49944164da 100644<br>
              &gt; ---
              a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
              &gt; &#43;&#43;&#43;
              b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
              &gt; @@ -592,7 &#43;592,8 @@ static int update_queue(struct
              device_queue_manager *dqm, struct queue *q)<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp; static int evict_process_queues_nocpsch(struct
              device_queue_manager *dqm,<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              qcm_process_device *qpd)<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              qcm_process_device *qpd,<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pre_reset)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
              &gt; @@ -622,6 &#43;623,8 @@ static int
              evict_process_queues_nocpsch(struct device_queue_manager
              *dqm,<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ONCE(!dqm-&gt;sched_running,
              &quot;Evict when stopped\n&quot;))<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pre_reset)<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =
              mqd_mgr-&gt;destroy_mqd(mqd_mgr, q-&gt;mqd,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,<br>
              &gt; @@ -639,7 &#43;642,8 @@ static int
              evict_process_queues_nocpsch(struct device_queue_manager
              *dqm,<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp; static int evict_process_queues_cpsch(struct
              device_queue_manager *dqm,<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              qcm_process_device *qpd)<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              qcm_process_device *qpd,<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pre_reset)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;<br>
              &gt; @@ -664,6 &#43;668,10 @@ static int
              evict_process_queues_cpsch(struct device_queue_manager
              *dqm,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active = false;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;queue_count--;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
              &gt; &#43;<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (pre_reset)<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
              &gt; &#43;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = execute_queues_cpsch(dqm,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;is_debug ?<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :<br>
              &gt; @@ -944,10 &#43;952,10 @@ static int start_nocpsch(struct
              device_queue_manager *dqm)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; -static int stop_nocpsch(struct device_queue_manager
              *dqm)<br>
              &gt; &#43;static int stop_nocpsch(struct device_queue_manager
              *dqm, bool pre_reset)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
              (dqm-&gt;dev-&gt;device_info-&gt;asic_family ==
              CHIP_HAWAII)<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_uninit(&amp;dqm-&gt;packets);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_uninit(&amp;dqm-&gt;packets,
              pre_reset);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sched_running = false;<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              &gt; @@ -1107,20 &#43;1115,21 @@ static int start_cpsch(struct
              device_queue_manager *dqm)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              &gt;&nbsp;&nbsp; fail_allocate_vidmem:<br>
              &gt;&nbsp;&nbsp; fail_set_sched_resources:<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; pm_uninit(&amp;dqm-&gt;packets);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_uninit(&amp;dqm-&gt;packets, false);<br>
              &gt;&nbsp;&nbsp; fail_packet_manager_init:<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; -static int stop_cpsch(struct device_queue_manager
              *dqm)<br>
              &gt; &#43;static int stop_cpsch(struct device_queue_manager
              *dqm, bool pre_reset)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; unmap_queues_cpsch(dqm,
              KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!pre_reset)<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unmap_queues_cpsch(dqm,
              KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sched_running = false;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(dqm-&gt;dev,
              dqm-&gt;fence_mem);<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; pm_uninit(&amp;dqm-&gt;packets);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pm_uninit(&amp;dqm-&gt;packets, pre_reset);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt; @@ -1891,7 &#43;1900,7 @@ int kfd_process_vm_fault(struct
              device_queue_manager *dqm,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = kfd_get_process_device_data(dqm-&gt;dev,
              p);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd)<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
              dqm-&gt;ops.evict_process_queues(dqm, &amp;pdd-&gt;qpd);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
              dqm-&gt;ops.evict_process_queues(dqm, &amp;pdd-&gt;qpd,
              false);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
              b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
              &gt; index a8c37e6da027..9f82f95f6a92 100644<br>
              &gt; ---
              a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
              &gt; &#43;&#43;&#43;
              b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
              &gt; @@ -103,7 &#43;103,7 @@ struct device_queue_manager_ops {<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; (*initialize)(struct
              device_queue_manager *dqm);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; (*start)(struct device_queue_manager
              *dqm);<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; (*stop)(struct device_queue_manager
              *dqm);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; (*stop)(struct device_queue_manager
              *dqm, bool pre_reset);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp; (*uninitialize)(struct
              device_queue_manager *dqm);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; (*create_kernel_queue)(struct
              device_queue_manager *dqm,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              kernel_queue *kq,<br>
              &gt; @@ -129,7 &#43;129,8 @@ struct device_queue_manager_ops {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device
              *qpd);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*evict_process_queues)(struct
              device_queue_manager *dqm,<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              qcm_process_device *qpd);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              qcm_process_device *qpd,<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pre_reset);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*restore_process_queues)(struct
              device_queue_manager *dqm,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              qcm_process_device *qpd);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
              &gt; index 2d56dc534459..dbd2e8e9ae69 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
              &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
              &gt; @@ -195,9 &#43;195,9 @@ static bool kq_initialize(struct
              kernel_queue *kq, struct kfd_dev *dev,<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp; /* Uninitialize a kernel queue and free all its
              memory usages. */<br>
              &gt; -static void kq_uninitialize(struct kernel_queue *kq)<br>
              &gt; &#43;static void kq_uninitialize(struct kernel_queue *kq,
              bool pre_reset)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (kq-&gt;queue-&gt;properties.type ==
              KFD_QUEUE_TYPE_HIQ)<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (kq-&gt;queue-&gt;properties.type ==
              KFD_QUEUE_TYPE_HIQ &amp;&amp; !pre_reset)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              kq-&gt;mqd_mgr-&gt;destroy_mqd(kq-&gt;mqd_mgr,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              kq-&gt;queue-&gt;mqd,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_PREEMPT_TYPE_WAVEFRONT_RESET,<br>
              &gt; @@ -337,9 &#43;337,9 @@ struct kernel_queue
              *kernel_queue_init(struct kfd_dev *dev,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; -void kernel_queue_uninit(struct kernel_queue *kq)<br>
              &gt; &#43;void kernel_queue_uninit(struct kernel_queue *kq,
              bool pre_reset)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; kq_uninitialize(kq);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kq_uninitialize(kq, pre_reset);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(kq);<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c<br>
              &gt; index 6cabed06ef5d..7732a3bbebd6 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c<br>
              &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c<br>
              &gt; @@ -264,10 &#43;264,10 @@ int pm_init(struct
              packet_manager *pm, struct device_queue_manager *dqm)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; -void pm_uninit(struct packet_manager *pm)<br>
              &gt; &#43;void pm_uninit(struct packet_manager *pm, bool
              pre_reset)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;pm-&gt;lock);<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; kernel_queue_uninit(pm-&gt;priv_queue);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kernel_queue_uninit(pm-&gt;priv_queue,
              pre_reset);<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp; int pm_send_set_resources(struct packet_manager
              *pm,<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
              b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
              &gt; index 087e96838997..9bc4ced4acba 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
              &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
              &gt; @@ -762,9 &#43;762,9 @@ struct kfd_process
              *kfd_get_process(const struct task_struct *);<br>
              &gt;&nbsp;&nbsp; struct kfd_process
              *kfd_lookup_process_by_pasid(unsigned int pasid);<br>
              &gt;&nbsp;&nbsp; struct kfd_process *kfd_lookup_process_by_mm(const
              struct mm_struct *mm);<br>
              &gt;&nbsp;&nbsp; void kfd_unref_process(struct kfd_process *p);<br>
              &gt; -int kfd_process_evict_queues(struct kfd_process *p);<br>
              &gt; &#43;int kfd_process_evict_queues(struct kfd_process *p,
              bool pre_reset);<br>
              &gt;&nbsp;&nbsp; int kfd_process_restore_queues(struct kfd_process
              *p);<br>
              &gt; -void kfd_suspend_all_processes(void);<br>
              &gt; &#43;void kfd_suspend_all_processes(bool pre_reset);<br>
              &gt;&nbsp;&nbsp; int kfd_resume_all_processes(void);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp; int kfd_process_device_init_vm(struct
              kfd_process_device *pdd,<br>
              &gt; @@ -883,7 &#43;883,7 @@ struct device_queue_manager
              *device_queue_manager_init(struct kfd_dev *dev);<br>
              &gt;&nbsp;&nbsp; void device_queue_manager_uninit(struct
              device_queue_manager *dqm);<br>
              &gt;&nbsp;&nbsp; struct kernel_queue *kernel_queue_init(struct
              kfd_dev *dev,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum
              kfd_queue_type type);<br>
              &gt; -void kernel_queue_uninit(struct kernel_queue *kq);<br>
              &gt; &#43;void kernel_queue_uninit(struct kernel_queue *kq,
              bool pre_reset);<br>
              &gt;&nbsp;&nbsp; int kfd_process_vm_fault(struct
              device_queue_manager *dqm, unsigned int pasid);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp; /* Process Queue Manager */<br>
              &gt; @@ -974,7 &#43;974,7 @@ extern const struct
              packet_manager_funcs kfd_vi_pm_funcs;<br>
              &gt;&nbsp;&nbsp; extern const struct packet_manager_funcs
              kfd_v9_pm_funcs;<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp; int pm_init(struct packet_manager *pm, struct
              device_queue_manager *dqm);<br>
              &gt; -void pm_uninit(struct packet_manager *pm);<br>
              &gt; &#43;void pm_uninit(struct packet_manager *pm, bool
              pre_reset);<br>
              &gt;&nbsp;&nbsp; int pm_send_set_resources(struct packet_manager
              *pm,<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              scheduling_resources *res);<br>
              &gt;&nbsp;&nbsp; int pm_send_runlist(struct packet_manager *pm,
              struct list_head *dqm_queues);<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
              &gt; index 536a153ac9a4..7bcadd3a1e3b 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
              &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
              &gt; @@ -948,7 &#43;948,7 @@ struct kfd_process
              *kfd_lookup_process_by_mm(const struct mm_struct *mm)<br>
              &gt;&nbsp;&nbsp;&nbsp; * Eviction is reference-counted per
              process-device. This means multiple<br>
              &gt;&nbsp;&nbsp;&nbsp; * evictions from different sources can be nested
              safely.<br>
              &gt;&nbsp;&nbsp;&nbsp; */<br>
              &gt; -int kfd_process_evict_queues(struct kfd_process *p)<br>
              &gt; &#43;int kfd_process_evict_queues(struct kfd_process *p,
              bool pre_reset)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;<br>
              &gt; @@ -956,7 &#43;956,8 @@ int
              kfd_process_evict_queues(struct kfd_process *p)<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(pdd,
              &amp;p-&gt;per_device_data, per_device_list) {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
              pdd-&gt;dev-&gt;dqm-&gt;ops.evict_process_queues(pdd-&gt;dev-&gt;dqm,<br>
              &gt;
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &amp;pdd-&gt;qpd);<br>
              &gt;
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &amp;pdd-&gt;qpd,<br>
              &gt;
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              pre_reset);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to evict
              process queues\n&quot;);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
              &gt; @@ -1026,7 &#43;1027,7 @@ static void
              evict_process_worker(struct work_struct *work)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_delayed_work(&amp;p-&gt;restore_work);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Started evicting pasid 0x%x\n&quot;,
              p-&gt;pasid);<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret = kfd_process_evict_queues(p);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret = kfd_process_evict_queues(p, false);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_signal(p-&gt;ef);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(p-&gt;ef);<br>
              &gt; @@ -1082,7 &#43;1083,7 @@ static void
              restore_process_worker(struct work_struct *work)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to restore queues of
              pasid 0x%x\n&quot;, p-&gt;pasid);<br>
              &gt;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; -void kfd_suspend_all_processes(void)<br>
              &gt; &#43;void kfd_suspend_all_processes(bool pre_reset)<br>
              &gt;&nbsp;&nbsp; {<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int temp;<br>
              &gt; @@ -1092,7 &#43;1093,7 @@ void
              kfd_suspend_all_processes(void)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              cancel_delayed_work_sync(&amp;p-&gt;eviction_work);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              cancel_delayed_work_sync(&amp;p-&gt;restore_work);<br>
              &gt;&nbsp;&nbsp; <br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_process_evict_queues(p))<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_process_evict_queues(p,
              pre_reset))<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to suspend
              process 0x%x\n&quot;, p-&gt;pasid);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_signal(p-&gt;ef);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(p-&gt;ef);<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
              &gt; index d3eacf72e8db..8fa856e6a03f 100644<br>
              &gt; ---
              a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
              &gt; &#43;&#43;&#43;
              b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
              &gt; @@ -374,7 &#43;374,7 @@ int pqm_destroy_queue(struct
              process_queue_manager *pqm, unsigned int qid)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* destroy kernel queue (DIQ) */<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm = pqn-&gt;kq-&gt;dev-&gt;dqm;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;ops.destroy_kernel_queue(dqm,
              pqn-&gt;kq, &amp;pdd-&gt;qpd);<br>
              &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel_queue_uninit(pqn-&gt;kq);<br>
              &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel_queue_uninit(pqn-&gt;kq, false);<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
              &gt;&nbsp;&nbsp; <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pqn-&gt;q) {<br>
            </div>
          </span></font></div>
    </blockquote>
  </body>
</html>

--------------BEE0C75844F6D718DD6AEC3F--

--===============1226101414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1226101414==--
