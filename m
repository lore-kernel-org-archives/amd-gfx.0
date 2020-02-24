Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE1EC38BE1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 18:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4DA20836
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 18:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RYmMhWH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4DA20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658AD6E851;
	Mon, 24 Feb 2020 18:44:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738E189A92
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 18:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd6KFDbfidApf84HY2qCIJ7EPGThozSfGOVi/rxrHOh9pEPbosAtwLiCYTn9pLJRuLog5IUPSEUY0BlSwkLd06v6uEfRY7j5mnkodijXOU/ymRoTSiGal9j4Z0AWqhQPZlptVGzAWrXy9sB12G1ptTqHvfk1gTUY1cbkD/pkroOgWyFmXwHAJAsAqEwgSLjfODrGqY1y9f7cvf8IWedyUxOvQInrobLMYxRHDUG6f28/wKg+jwnxab6CpgRjIXPkKmeDxjxehirZDiGUF3fLDawyXMqBLzBgGtmTsT7nh90shGnE5d6UeMjMsWH396Ve3tByou6nJJ2FWQmbUid1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwvZZEp6gDdPK5zLe16HvkyY5DrHMA8nuuCD0VBSODk=;
 b=CMk62WoimhRw+H6ZASD933qXRaWt6A/oYOBYQzy2pePY3BeJZ33mFKFGx5GSMN1g0XRahkHv2y4Q7sAQaFYGgiGLQhG1WxkHJmax/B62psnrJkGB02ZsAsoZvXv6BwU62n9eqx8GiFWJlSrDd440C4vq9IrChu80RpQfDI5RywGglaP9B2uDEtH1NVB9ftjYrGqs6aTNbOqe4XALMRU/eHQI7L/ACbIW6Rsrk+YARSUKQYTvGqqHm2eGWDY6qwKhEnZvC2Y4/YSAgIb1/+l6QhGhwlvSkBbBQhS37/PugYg0GLGcqSldM6cZMTNIqC/vuLumC0DsKACB/7CAyQfk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwvZZEp6gDdPK5zLe16HvkyY5DrHMA8nuuCD0VBSODk=;
 b=RYmMhWH1NNQJcT7Ipw9AV6boDppSLPjMqUYF/nyhpzBqa4OcO1cVTGH4grdawQZOE0LByICtci6vSt06SGMyLH5JeHWngFmFHIIC2Oi6YSh3XKBvN+JhTi3XbS8UBKnas8xu3rj8XnDqR4ycc2DH6zTvTFEwmSZ6LpWzJSCCuGY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB2390.namprd12.prod.outlook.com (2603:10b6:4:b5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 18:44:12 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Mon, 24 Feb
 2020 18:44:12 +0000
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: wait for sched to become ready on job
 submit
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>
References: <9d1fd4e5-adcb-470b-a0be-5528af050d14@email.android.com>
 <DM5PR12MB23765A9C06DB2B62ECF0B6208BEC0@DM5PR12MB2376.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3d10260f-5d51-8733-af47-0b9b9d3c041d@amd.com>
Date: Mon, 24 Feb 2020 19:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <DM5PR12MB23765A9C06DB2B62ECF0B6208BEC0@DM5PR12MB2376.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0067.eurprd03.prod.outlook.com
 (2603:10a6:207:5::25) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR03CA0067.eurprd03.prod.outlook.com (2603:10a6:207:5::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 18:44:10 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 213cd3c7-633c-4fce-1318-08d7b9598a2e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2390:|DM5PR12MB2390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23905F45B6C1468567B113F583EC0@DM5PR12MB2390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:177;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(2906002)(6636002)(36756003)(2616005)(33964004)(45080400002)(37006003)(54906003)(8936002)(6486002)(8676002)(186003)(16526019)(6666004)(52116002)(316002)(53546011)(66946007)(478600001)(4326008)(66476007)(66556008)(86362001)(5660300002)(81166006)(30864003)(31696002)(81156014)(6862004)(31686004)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2390;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86Y3jXgNGfm0d1RJ+zrgRNGFzfPOxyeekzj5QU4aRxPGBCeCoV5XALUancaiYWPujCddJ3cLhjRF0k5LEDBre0WbfgiXjH6N5bbqLH4Pb7ri7hCqZeGGgYsFizDfA+5I/mpMEAqLsh3I35vBKqI+z1Ez7qjY690tETBPBPbdcm1YVNmR6H/YF7N0xBg1R4i3knOB7ZPW7vzp4hjTb/ABg5wtvtxC7BNh/5fAZVOo14GlDySAU89THXUW6vm4keeRzV33qg9OebEmX5RuVBCEUmFIGKtdO/bDJyuKSX2fIibraBp35OQ5FvjhhMMzkpcQhwBTusP8T8W4g/JVSgmKnRJnf47f+1CjM72oP3L5+zP7zUGXBrr6uII3F9S8zHDfHp8NlNAM3+cdL3qGD1Z2yqn6F/UT3iMCj+4xjTU8GMmaPJs1Ijk9uiRDPtcbUYvA6Fsny5zBEJFIhsVfEvUHvRLvoU3dxFWC25KlSlfWvp94ZrHMhPLXWbSer9sV3yBKIhSLsA9AzSfEkoemqsBDUQ==
X-MS-Exchange-AntiSpam-MessageData: BkY6xf2lqcHaAT4FYqlrzImLES78uMkPuyvnZhlRveCBvhCRbB7cfZAK122mxeCvIinR3j2pDBRzuKhD4mFc72u56LO9sn396OBwFSZlc2rmbAt5d4Yf4tCWt8TLOxomAhsuW19Fb9osDDF+cv8B0SmADDM2A+h13QrOzo/HZQxAmoueg2xdT9r4quRgKFYAdNjQrU/RRGdQ03yOFLhlXg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213cd3c7-633c-4fce-1318-08d7b9598a2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 18:44:12.3275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr5MFT+HtaMWNM2YNrxYR5Mx1TtbpIyx8m3THZqXsxYUTEtNj/SrofVd/bfY8qX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2390
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Dennis" <Dennis.Li@amd.com>
Content-Type: multipart/mixed; boundary="===============0202070741=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0202070741==
Content-Type: multipart/alternative;
 boundary="------------77674B422E8A3B6ADA9B2A96"
Content-Language: en-US

--------------77674B422E8A3B6ADA9B2A96
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I think that the IB tests already set the ready flag to false when 
something goes wrong, but for the ring tests your probably want to 
double check and maybe generalize that.

Christian.

Am 24.02.20 um 19:15 schrieb Das, Nirmoy:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Thanks Christian. I will try to send a updated patch soon.
>
> Get Outlook for Android <https://aka.ms/ghei36>
>
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Monday, February 24, 2020, 18:06
> *To:* Nirmoy Das
> *Cc:* amd-gfx@lists.freedesktop.org; Deucher, Alexander; Liu, Monk; 
> Li, Dennis; Das, Nirmoy
> *Subject:* Re: [RFC PATCH 1/1] drm/amdgpu: wait for sched to become 
> ready on job submit
>
> Hi Nirmoy,
>
> Am 24.02.2020 17:48 schrieb Nirmoy Das <nirmoy.aiemd@gmail.com>:
>
>     On reset, amdgpu can set a drm sched's ready status to false
>     temporarily. drm job
>     init will fail if all of the drm scheds are not ready for a HW IP.
>     This patch tries to make
>     kernel's internal drm job submit handle, amdgpu_job_submit() a bit
>     more fault tolerant.
>
>
> I don't think that this approach makes sense. Since it is a front end 
> property we should rather stop setting the scheduler ready status to 
> false during reset.
>
> Instead we should only set it to false when the ring/IB test fails and 
> we can't bring the ring back to life again.
>
> Christian.
>
>
>     Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>     ---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 35 +++++++++++++++++++--
>      drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  5 +--
>      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  6 ++--
>      drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c |  2 +-
>      drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |  2 +-
>      drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
>      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  2 +-
>      7 files changed, 43 insertions(+), 11 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>     index d42be880a236..0745df80112f 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>     @@ -139,7 +139,38 @@ void amdgpu_job_free(struct amdgpu_job *job)
>              kfree(job);
>      }
>
>     -int amdgpu_job_submit(struct amdgpu_job *job, struct
>     drm_sched_entity *entity,
>     +static int amdgpu_job_try_init(struct amdgpu_device *adev,
>     +                              struct drm_sched_job *base,
>     +                              struct drm_sched_entity *entity,
>     +                              void *owner)
>     +{
>     +       int r, i;
>     +
>     +       r = drm_sched_job_init(base, entity, owner);
>     +       if (r == -ENOENT) {
>     +               /* retry till we come out of reset phase */
>     +               while (!mutex_trylock(&adev->lock_reset))
>     +                       msleep(10);
>     +               /* retry for a second for the sched to get ready*/
>     +               for (i = 0; i < 100; i++) {
>     +                       msleep(10);
>     +                       r = drm_sched_job_init(base, entity, owner);
>     +                       if (r == -ENOENT)
>     +                               continue;
>     +               }
>     +
>     + mutex_unlock(&adev->lock_reset);
>     +               /* If after all these we failed to initialize a job
>     +                * it means the IP is unrecoverable */
>     +               if (r == -ENOENT)
>     +                       return -ENODEV;
>     +       }
>     +
>     +       return r;
>     +}
>     +
>     +int amdgpu_job_submit(struct amdgpu_device *adev,struct
>     amdgpu_job *job,
>     +                     struct drm_sched_entity *entity,
>                            void *owner, struct dma_fence **f)
>      {
>              enum drm_sched_priority priority;
>     @@ -149,7 +180,7 @@ int amdgpu_job_submit(struct amdgpu_job *job,
>     struct drm_sched_entity *entity,
>              if (!f)
>                      return -EINVAL;
>
>     -       r = drm_sched_job_init(&job->base, entity, owner);
>     +       r = amdgpu_job_try_init(adev, &job->base, entity, owner);
>              if (r)
>                      return r;
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>     index 2e2110dddb76..fed87e96cacc 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>     @@ -70,8 +70,9 @@ int amdgpu_job_alloc_with_ib(struct
>     amdgpu_device *adev, unsigned size,
>
>      void amdgpu_job_free_resources(struct amdgpu_job *job);
>      void amdgpu_job_free(struct amdgpu_job *job);
>     -int amdgpu_job_submit(struct amdgpu_job *job, struct
>     drm_sched_entity *entity,
>     -                     void *owner, struct dma_fence **f);
>     +int amdgpu_job_submit(struct amdgpu_device *adev, struct
>     amdgpu_job *job,
>     +                     struct drm_sched_entity *entity, void *owner,
>     +                     struct dma_fence **f);
>      int amdgpu_job_submit_direct(struct amdgpu_job *job, struct
>     amdgpu_ring *ring,
>                                   struct dma_fence **fence);
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     index 660867cf2597..adfde07eb75f 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     @@ -2066,7 +2066,7 @@ static int amdgpu_map_buffer(struct
>     ttm_buffer_object *bo,
>              if (r)
>                      goto error_free;
>
>     -       r = amdgpu_job_submit(job, &adev->mman.entity,
>     +       r = amdgpu_job_submit(adev, job, &adev->mman.entity,
>     AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>              if (r)
>                      goto error_free;
>     @@ -2137,7 +2137,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring
>     *ring, uint64_t src_offset,
>              if (direct_submit)
>                      r = amdgpu_job_submit_direct(job, ring, fence);
>              else
>     -               r = amdgpu_job_submit(job, &adev->mman.entity,
>     +               r = amdgpu_job_submit(adev, job, &adev->mman.entity,
>     AMDGPU_FENCE_OWNER_UNDEFINED, fence);
>              if (r)
>                      goto error_free;
>     @@ -2231,7 +2231,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>
>              amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>              WARN_ON(job->ibs[0].length_dw > num_dw);
>     -       r = amdgpu_job_submit(job, &adev->mman.entity,
>     +       r = amdgpu_job_submit(adev, job, &adev->mman.entity,
>     AMDGPU_FENCE_OWNER_UNDEFINED, fence);
>              if (r)
>                      goto error_free;
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>     index 5fd32ad1c575..8ff97b24914e 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>     @@ -1104,7 +1104,7 @@ static int amdgpu_uvd_send_msg(struct
>     amdgpu_ring *ring, struct amdgpu_bo *bo,
>                      if (r)
>                              goto err_free;
>
>     -               r = amdgpu_job_submit(job, &adev->uvd.entity,
>     +               r = amdgpu_job_submit(adev, job, &adev->uvd.entity,
>     AMDGPU_FENCE_OWNER_UNDEFINED, &f);
>                      if (r)
>                              goto err_free;
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>     index 59ddba137946..e721d3367783 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>     @@ -554,7 +554,7 @@ static int amdgpu_vce_get_destroy_msg(struct
>     amdgpu_ring *ring, uint32_t handle,
>              if (direct)
>                      r = amdgpu_job_submit_direct(job, ring, &f);
>              else
>     -               r = amdgpu_job_submit(job, &ring->adev->vce.entity,
>     +               r = amdgpu_job_submit(ring->adev, job,
>     &ring->adev->vce.entity,
>     AMDGPU_FENCE_OWNER_UNDEFINED, &f);
>              if (r)
>                      goto err;
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>     index 4cc7881f438c..b536962c22d9 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>     @@ -100,7 +100,7 @@ static int amdgpu_vm_sdma_commit(struct
>     amdgpu_vm_update_params *p,
>              WARN_ON(ib->length_dw == 0);
>              amdgpu_ring_pad_ib(ring, ib);
>              WARN_ON(ib->length_dw > p->num_dw_left);
>     -       r = amdgpu_job_submit(p->job, entity,
>     AMDGPU_FENCE_OWNER_VM, &f);
>     +       r = amdgpu_job_submit(p->adev, p->job, entity,
>     AMDGPU_FENCE_OWNER_VM, &f);
>              if (r)
>                      goto error;
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     index 9775eca6fe43..a4aaa2a1f878 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     @@ -377,7 +377,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct
>     amdgpu_device *adev, uint32_t vmid,
>              job->vm_needs_flush = true;
>     job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>              amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>     -       r = amdgpu_job_submit(job, &adev->mman.entity,
>     +       r = amdgpu_job_submit(adev, job, &adev->mman.entity,
>     AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>              if (r)
>                      goto error_submit;
>     -- 
>     2.25.0
>
>
>


--------------77674B422E8A3B6ADA9B2A96
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">I think that the IB tests already set
      the ready flag to false when something goes wrong, but for the
      ring tests your probably want to double check and maybe generalize
      that.<br>
      <br>
      Christian.<br>
      <br>
      Am 24.02.20 um 19:15 schrieb Das, Nirmoy:<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR12MB23765A9C06DB2B62ECF0B6208BEC0@DM5PR12MB2376.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div data-ogsc="" style="">
          <meta content="text/html; charset=us-ascii" data-ogsc="" style="">
        </div>
        <div dir="auto" style="color: rgb(33, 33, 33); background-color:
          rgb(255, 255, 255); text-align: left;">
          Thanks Christian. I will try to send a updated patch soon.&nbsp;</div>
        <div id="ms-outlook-mobile-signature" data-ogsc="" style="text-align: left;" dir="auto">
          <div><br>
          </div>
          Get <a href="https://aka.ms/ghei36" moz-do-not-send="true">Outlook
            for Android</a></div>
        <div id="id-3a39905a-0ef3-4e35-9b95-a5c89c0aa02a" class="ms-outlook-mobile-reference-message" data-ogsc="" style="">
          <div style="font-family: sans-serif; font-size: 12pt; color:
            rgb(0, 0, 0);"><br>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg"><strong>From:</strong> Koenig,
            Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <strong>Sent:</strong> Monday, February 24, 2020, 18:06<br>
            <strong>To:</strong> Nirmoy Das<br>
            <strong>Cc:</strong> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher,
            Alexander; Liu, Monk; Li, Dennis; Das, Nirmoy<br>
            <strong>Subject:</strong> Re: [RFC PATCH 1/1] drm/amdgpu:
            wait for sched to become ready on job submit<br>
          </div>
          <br>
          <meta content="text/html; charset=utf-8">
          <div dir="auto">
            <div>Hi Nirmoy,<br>
              <div class="gmail_extra"><br>
                <div class="gmail_quote">Am 24.02.2020 17:48 schrieb
                  Nirmoy Das <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.aiemd@gmail.com">&lt;nirmoy.aiemd@gmail.com&gt;</a>:<br type="attribution">
                  <blockquote class="quote" style="margin:0 0 0 .8ex;
                    border-left:1px #ccc solid; padding-left:1ex">
                    <div><font size="2"><span style="font-size:11pt">
                          <div>On reset, amdgpu can set a drm sched's
                            ready status to false temporarily. drm job<br>
                            init will fail if all of the drm scheds are
                            not ready for a HW IP. This patch tries to
                            make<br>
                            kernel's internal drm job submit handle,
                            amdgpu_job_submit() a bit more fault
                            tolerant.<br>
                          </div>
                        </span></font></div>
                  </blockquote>
                </div>
              </div>
            </div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">I don't think that this approach makes
              sense. Since it is a front end property we should rather
              stop setting the scheduler ready status to false during
              reset.</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">Instead we should only set it to false when
              the ring/IB test fails and we can't bring the ring back to
              life again.</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">Christian.</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">
              <div class="gmail_extra">
                <div class="gmail_quote">
                  <blockquote class="quote" style="margin:0 0 0 .8ex;
                    border-left:1px #ccc solid; padding-left:1ex">
                    <div><font size="2"><span style="font-size:11pt">
                          <div><br>
                            Signed-off-by: Nirmoy Das
                            <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.das@amd.com">&lt;nirmoy.das@amd.com&gt;</a><br>
                            ---<br>
                            &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp;&nbsp;
                            | 35 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
                            &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.h&nbsp;&nbsp;&nbsp;&nbsp;
                            |&nbsp; 5 &#43;--<br>
                            &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp;
                            |&nbsp; 6 &#43;&#43;--<br>
                            &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c&nbsp;&nbsp;&nbsp;&nbsp;
                            |&nbsp; 2 &#43;-<br>
                            &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c&nbsp;&nbsp;&nbsp;&nbsp;
                            |&nbsp; 2 &#43;-<br>
                            &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
                            |&nbsp; 2 &#43;-<br>
                            &nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            |&nbsp; 2 &#43;-<br>
                            &nbsp;7 files changed, 43 insertions(&#43;), 11
                            deletions(-)<br>
                            <br>
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
                            index d42be880a236..0745df80112f 100644<br>
                            ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
                            &#43;&#43;&#43;
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
                            @@ -139,7 &#43;139,38 @@ void
                            amdgpu_job_free(struct amdgpu_job *job)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(job);<br>
                            &nbsp;}<br>
                            &nbsp;<br>
                            -int amdgpu_job_submit(struct amdgpu_job
                            *job, struct drm_sched_entity *entity,<br>
                            &#43;static int amdgpu_job_try_init(struct
                            amdgpu_device *adev,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                            drm_sched_job *base,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                            drm_sched_entity *entity,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *owner)<br>
                            &#43;{<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<br>
                            &#43;<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = drm_sched_job_init(base, entity,
                            owner);<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -ENOENT) {<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* retry till we come out of
                            reset phase */<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while
                            (!mutex_trylock(&amp;adev-&gt;lock_reset))<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(10);<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* retry for a second for
                            the sched to get ready*/<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; 100; i&#43;&#43;)
                            {<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(10);<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                            drm_sched_job_init(base, entity, owner);<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -ENOENT)<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                            &#43;<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            mutex_unlock(&amp;adev-&gt;lock_reset);<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If after all these we
                            failed to initialize a job<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * it means the IP is
                            unrecoverable */<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -ENOENT)<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                            &#43;<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                            &#43;}<br>
                            &#43;<br>
                            &#43;int amdgpu_job_submit(struct amdgpu_device
                            *adev,struct amdgpu_job *job,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                            drm_sched_entity *entity,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *owner, struct
                            dma_fence **f)<br>
                            &nbsp;{<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum drm_sched_priority priority;<br>
                            @@ -149,7 &#43;180,7 @@ int
                            amdgpu_job_submit(struct amdgpu_job *job,
                            struct drm_sched_entity *entity,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!f)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                            &nbsp;<br>
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                            drm_sched_job_init(&amp;job-&gt;base,
                            entity, owner);<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_try_init(adev,
                            &amp;job-&gt;base, entity, owner);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                            &nbsp;<br>
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
                            index 2e2110dddb76..fed87e96cacc 100644<br>
                            ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
                            &#43;&#43;&#43;
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
                            @@ -70,8 &#43;70,9 @@ int
                            amdgpu_job_alloc_with_ib(struct
                            amdgpu_device *adev, unsigned size,<br>
                            &nbsp;<br>
                            &nbsp;void amdgpu_job_free_resources(struct
                            amdgpu_job *job);<br>
                            &nbsp;void amdgpu_job_free(struct amdgpu_job
                            *job);<br>
                            -int amdgpu_job_submit(struct amdgpu_job
                            *job, struct drm_sched_entity *entity,<br>
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *owner, struct
                            dma_fence **f);<br>
                            &#43;int amdgpu_job_submit(struct amdgpu_device
                            *adev, struct amdgpu_job *job,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                            drm_sched_entity *entity, void *owner,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **f);<br>
                            &nbsp;int amdgpu_job_submit_direct(struct
                            amdgpu_job *job, struct amdgpu_ring *ring,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                            dma_fence **fence);<br>
                            &nbsp;<br>
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                            index 660867cf2597..adfde07eb75f 100644<br>
                            ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                            &#43;&#43;&#43;
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                            @@ -2066,7 &#43;2066,7 @@ static int
                            amdgpu_map_buffer(struct ttm_buffer_object
                            *bo,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;<br>
                            &nbsp;<br>
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(job,
                            &amp;adev-&gt;mman.entity,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(adev, job,
                            &amp;adev-&gt;mman.entity,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMDGPU_FENCE_OWNER_UNDEFINED, &amp;fence);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;<br>
                            @@ -2137,7 &#43;2137,7 @@ int
                            amdgpu_copy_buffer(struct amdgpu_ring *ring,
                            uint64_t src_offset,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (direct_submit)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                            amdgpu_job_submit_direct(job, ring, fence);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(job,
                            &amp;adev-&gt;mman.entity,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(adev,
                            job, &amp;adev-&gt;mman.entity,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMDGPU_FENCE_OWNER_UNDEFINED, fence);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;<br>
                            @@ -2231,7 &#43;2231,7 @@ int
                            amdgpu_fill_buffer(struct amdgpu_bo *bo,<br>
                            &nbsp;<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring,
                            &amp;job-&gt;ibs[0]);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;ibs[0].length_dw
                            &gt; num_dw);<br>
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(job,
                            &amp;adev-&gt;mman.entity,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(adev, job,
                            &amp;adev-&gt;mman.entity,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMDGPU_FENCE_OWNER_UNDEFINED, fence);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;<br>
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
                            index 5fd32ad1c575..8ff97b24914e 100644<br>
                            ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
                            &#43;&#43;&#43;
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
                            @@ -1104,7 &#43;1104,7 @@ static int
                            amdgpu_uvd_send_msg(struct amdgpu_ring
                            *ring, struct amdgpu_bo *bo,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_free;<br>
                            &nbsp;<br>
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(job,
                            &amp;adev-&gt;uvd.entity,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(adev,
                            job, &amp;adev-&gt;uvd.entity,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMDGPU_FENCE_OWNER_UNDEFINED, &amp;f);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_free;<br>
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
                            index 59ddba137946..e721d3367783 100644<br>
                            ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
                            &#43;&#43;&#43;
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
                            @@ -554,7 &#43;554,7 @@ static int
                            amdgpu_vce_get_destroy_msg(struct
                            amdgpu_ring *ring, uint32_t handle,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (direct)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                            amdgpu_job_submit_direct(job, ring, &amp;f);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(job,
                            &amp;ring-&gt;adev-&gt;vce.entity,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                            amdgpu_job_submit(ring-&gt;adev, job,
                            &amp;ring-&gt;adev-&gt;vce.entity,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMDGPU_FENCE_OWNER_UNDEFINED, &amp;f);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err;<br>
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
                            index 4cc7881f438c..b536962c22d9 100644<br>
                            ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
                            &#43;&#43;&#43;
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
                            @@ -100,7 &#43;100,7 @@ static int
                            amdgpu_vm_sdma_commit(struct
                            amdgpu_vm_update_params *p,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw == 0);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring, ib);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw &gt;
                            p-&gt;num_dw_left);<br>
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(p-&gt;job,
                            entity, AMDGPU_FENCE_OWNER_VM, &amp;f);<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(p-&gt;adev,
                            p-&gt;job, entity, AMDGPU_FENCE_OWNER_VM,
                            &amp;f);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<br>
                            &nbsp;<br>
                            diff --git
                            a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
                            b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                            index 9775eca6fe43..a4aaa2a1f878 100644<br>
                            --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                            &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                            @@ -377,7 &#43;377,7 @@ static void
                            gmc_v10_0_flush_gpu_tlb(struct amdgpu_device
                            *adev, uint32_t vmid,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_needs_flush = true;<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            job-&gt;ibs-&gt;ptr[job-&gt;ibs-&gt;length_dw&#43;&#43;]
                            = ring-&gt;funcs-&gt;nop;<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring,
                            &amp;job-&gt;ibs[0]);<br>
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(job,
                            &amp;adev-&gt;mman.entity,<br>
                            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_job_submit(adev, job,
                            &amp;adev-&gt;mman.entity,<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMDGPU_FENCE_OWNER_UNDEFINED, &amp;fence);<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_submit;<br>
                            -- <br>
                            2.25.0<br>
                            <br>
                          </div>
                        </span></font></div>
                  </blockquote>
                </div>
                <br>
              </div>
            </div>
          </div>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------77674B422E8A3B6ADA9B2A96--

--===============0202070741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0202070741==--
