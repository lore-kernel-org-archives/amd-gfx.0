Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAD5C7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 10:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D20D10E0C1;
	Tue, 11 Apr 2023 10:02:51 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412B810E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 10:02:50 +0000 (UTC)
Received: by mail-yb1-xb30.google.com with SMTP id u13so7562520ybu.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681207369; x=1683799369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MR+ZToA22Hr3V0k82iGEnXD3VPd5UnCHR4n/9nVtcKc=;
 b=frPpYf67jGoibAOwdEZ3ycBrSE354qJiV7ZjDdVZHRTdznbWYLxQhj7p0Jfte7Ki3B
 Y30kwe7IPqY59rrAtKK2gHjh8z0QohDdrOv6XvVbBFHtqiNranRI8s1VIO8CdmZYo0v6
 iu7Y34nRRNYNNxIzM1cVb1KTvZihQSaGSduODPRIww2rDKVLrMKn4JRdrgRgM3by/FbH
 EKynjUA3vu6SeVIikxALU7SndpafXjSrna5XMWhloOx9N3QKOfFvrbDKKDTMACWpAnb9
 TyOkHlNiDDs/0IsQcnqGdzZl/pGYn1HzLYhpe6jqDfVLFNH+bNB5iAIUI7PLTHdkTAvf
 9Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681207369; x=1683799369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MR+ZToA22Hr3V0k82iGEnXD3VPd5UnCHR4n/9nVtcKc=;
 b=X1r8/RD/1sK0VtoyKdffUWUKCdrPERy1B5q6dQvrvvjSps9PGXEpFG/SIvLlAWh+B+
 qqS5TdRhgk898yxzXUrZ/qpIWXLLnoAGJObH/pgkIi8Yb+3VQA7kdjhxOS0Gty+8ePkA
 V+HvUzHFJOa9GawP2O7HM8cZUcFgXx/UbmCj5KBD0EKzR4npFxVpNO7SvC/5BbAGjFfa
 KHb/p+M5BOOsyC/7moIpVUVORNcOpOgEPxIIRTA3SHb3G2RrKp+nC4ZHGQhtfMkN4/t0
 IKwucx4fPc4a5jU0P3Yx+MDKyOnibLyCR+XQuD4O7tNzl5iMZMKPHZy1REDjxSRt11zr
 yRWg==
X-Gm-Message-State: AAQBX9fdN87SlUIItpJZAOMJ1LpFSG8x0kdTX4KN18Go4sCKlmSJKcL1
 JHW+lzWR0OQrl00S0hvNdneth8wrMCuzootMS/7Jbw==
X-Google-Smtp-Source: AKy350YTPUWHU+R44n0wT1vKh667BKP+6i7FczVZahgd/+xi5YeA8O40rnL75PwvxbNQUQPufDxn6ZIuYuLcu/7pBNo=
X-Received: by 2002:a25:7397:0:b0:b8b:fe5f:2eaa with SMTP id
 o145-20020a257397000000b00b8bfe5f2eaamr5127782ybc.2.1681207368980; Tue, 11
 Apr 2023 03:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
 <MW4PR12MB5667D4837CFDEE7230F5423DF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyGthhzm6291=jiydsNgK3suGdi4cMM7GMhTW_j3mdgCgQ@mail.gmail.com>
 <MW4PR12MB5667EC2D2E57FDDE93EE546FF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyH9GsyiUPvyeHfgG=TOOywxA42vubsYPWB9mPiexHBG_A@mail.gmail.com>
 <07322367-bbf1-cf82-0a21-15d453fe4dae@amd.com>
 <CAP+8YyEDW7JNQ1C9j0NZqXuLAnXPduSAye7esSOOwPpLNT9yYA@mail.gmail.com>
 <bc5752cd-fe72-a72d-4f35-92bcfdbe289c@amd.com>
 <e144baff-847b-9c59-6792-ff3c6167d19d@amd.com>
 <63178153-bd90-8b82-6fa7-241ec5b3d242@amd.com>
In-Reply-To: <63178153-bd90-8b82-6fa7-241ec5b3d242@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Tue, 11 Apr 2023 12:00:32 +0200
Message-ID: <CAP+8YyF_oPCbCK2xBEU+=vXKtfTFUZvcQoX_P8fHnS+wcBJhoA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
To: Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Yadav,
 Arvind" <Arvind.Yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 11, 2023 at 11:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
>
> On 11/04/2023 11:37, Christian K=C3=B6nig wrote:
> > Am 10.04.23 um 16:26 schrieb Shashank Sharma:
> >>
> >> On 10/04/2023 16:04, Bas Nieuwenhuizen wrote:
> >>> On Mon, Apr 10, 2023 at 4:01=E2=80=AFPM Shashank Sharma
> >>> <shashank.sharma@amd.com> wrote:
> >>>>
> >>>> On 10/04/2023 15:46, Bas Nieuwenhuizen wrote:
> >>>>> On Mon, Apr 10, 2023 at 3:40=E2=80=AFPM Sharma, Shashank
> >>>>> <Shashank.Sharma@amd.com> wrote:
> >>>>>> [AMD Official Use Only - General]
> >>>>>>
> >>>>>> Hello Bas,
> >>>>>>
> >>>>>> This is not the correct interpretation of the code, the
> >>>>>> USERQ_IOCTL has both the OPs (create and destroy), but th euser
> >>>>>> has to exclusively call  it.
> >>>>>>
> >>>>>> Please see the sample test program in the existing libDRM series
> >>>>>> (userq_test.c, it specifically calls amdgpu_free_userq, which
> >>>>>> does the destroy_OP
> >>>>>>
> >>>>>> for the IOCTL.
> >>>>> In the presence of crashes the kernel should always be able to clea=
n
> >>>>> this up no? Otherwise there is a resource leak?
> >>>> The crash handling is the same as any of the existing GPU resource
> >>>> which
> >>>> are allocated and freed with IOCTL_OPs.
> >>> Most of those are handled in the when the DRM fd gets closed (i.e.
> >>> when the process exits):
> >>>
> >>> - buffers through drm_gem_release()
> >>> - mappings in amdgpu_vm_fini
> >>> - contexts in amdgpu_ctx_mgr_fini
> >>>
> >>> etc.
> >>>
> >>> Why would we do things differently for userspace queues? It doesn't
> >>> look complicated looking at the above patch (which does seem to work)=
.
> >>
> >> As the code is in initial stage, I have not given much thoughts about
> >> handling resource leak due to app crash, but this seems like a good
> >> suggestion.
> >>
> >> I am taking a note and will try to accommodate this in an upcoming
> >> version of the series.
> >
> > Bas is right, the application doesn't necessary needs to clean up on
> > exit (but it's still good custody to do so).
> >
> > See amdgpu_driver_postclose_kms() for how we cleanup (for example) the
> > ctx manager by calling amdgpu_ctx_mgr_fini() or the BO lists.
> >
> Thanks for the pointers Christian,
>
> I also feel like that its good to have this cleanup for those apps which
> did not clean-up themselves (due to crash or coding error).

I think the patch I linked earlier does exactly this: keep the IOCTL,
but on fini goes through the list and destroys the queue:
https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c12837973ced=
df55ccc85d29
>
> So something like,
>
> on close_fd,
>
> for_idr_each {
>
>     get_queue()
>
>     if (queue)
>
>         free_queue
>
> }
>
> But we will also keep the queue_free_OP as well, so that if an app
> allocate multiple queues, and wants to free some in between, it can do it=
.
>
> - Shashank
>
> > Regards,
> > Christian.
> >
> >>
> >> - Shashank
> >>
> >>>> To be honest a crash handling can be very elaborated and complex one=
,
> >>>> and hence only can be done at the driver unload IMO, which doesn't
> >>>> help
> >>>> at that stage,
> >>>>
> >>>> coz anyways driver will re-allocate the resources on next load.
> >>>>
> >>>> - Shashank
> >>>>
> >>>>>> - Shashank
> >>>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> >>>>>> Sent: 10 April 2023 11:26
> >>>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
> >>>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> >>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix
> >>>>>> <Felix.Kuehling@amd.com>; Koenig, Christian
> >>>>>> <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
> >>>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
> >>>>>>
> >>>>>> Hi Shashank,
> >>>>>>
> >>>>>> I think I found the issue: I wasn't destroying the user queue in
> >>>>>> my program and the kernel doesn't clean up any remaining user
> >>>>>> queues in the postclose hook. I think we need something like
> >>>>>> https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c12=
837973ceddf55ccc85d29
> >>>>>>
> >>>>>> ?
> >>>>>>
> >>>>>> While running things multiple times now works, I still have
> >>>>>> problems doing multiple submissions from the same queue. Looking
> >>>>>> forward to the updated test/sample
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Bas
> >>>>>>
> >>>>>> On Mon, Apr 10, 2023 at 9:32=E2=80=AFAM Sharma, Shashank
> >>>>>> <Shashank.Sharma@amd.com> wrote:
> >>>>>>> [AMD Official Use Only - General]
> >>>>>>>
> >>>>>>> Hello Bas,
> >>>>>>> Thanks for trying this out.
> >>>>>>>
> >>>>>>> This could be due to the doorbell as you mentioned, Usermode
> >>>>>>> queue uses doorbell manager internally.
> >>>>>>> This week, we are planning to publis the latest libDRM sample
> >>>>>>> code which uses a doorbell object (instead of the doorbell hack
> >>>>>>> IOCTL), adapting to that should fix your problem in my opinion.
> >>>>>>> We have tested this full stack (libDRM test + Usermode queue +
> >>>>>>> doorbell manager) for 500+ consecutive runs, and it worked well
> >>>>>>> for us.
> >>>>>>>
> >>>>>>> You can use this integrated kernel stack (1+2) from my gitlab to
> >>>>>>> build
> >>>>>>> your kernel:
> >>>>>>> https://gitlab.freedesktop.org/contactshashanksharma/userq-amdgpu=
/-/tr
> >>>>>>>
> >>>>>>> ee/integrated-db-and-uq-v3 Please stay tuned for updated libDRM
> >>>>>>> changes with doorbell objects.
> >>>>>>>
> >>>>>>> Regards
> >>>>>>> Shashank
> >>>>>>> -----Original Message-----
> >>>>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> >>>>>>> Sent: 10 April 2023 02:37
> >>>>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
> >>>>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> >>>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix
> >>>>>>> <Felix.Kuehling@amd.com>;
> >>>>>>> Koenig, Christian <Christian.Koenig@amd.com>
> >>>>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
> >>>>>>>
> >>>>>>> Hi Shashank,
> >>>>>>>
> >>>>>>> I tried writing a program to experiment with usermode queues and
> >>>>>>> I found some weird behavior: The first run of the program works
> >>>>>>> as expected, while subsequent runs don't seem to do anything
> >>>>>>> (and I allocate everything in GTT, so it should be zero
> >>>>>>> initialized consistently). Is this a known issue?
> >>>>>>>
> >>>>>>> The linked libdrm code for the uapi still does a doorbell ioctl
> >>>>>>> so it could very well be that I do the doorbell wrong
> >>>>>>> (especially since the ioctl implementation was never shared
> >>>>>>> AFAICT?), but it seems like the kernel submissions (i.e. write
> >>>>>>> wptr in dwords to the wptr va and to the doorbell). Is it
> >>>>>>> possible to update the test in libdrm?
> >>>>>>>
> >>>>>>> Code: https://gitlab.freedesktop.org/bnieuwenhuizen/usermode-queu=
e
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Bas
> >>>>>>>
> >>>>>>> On Wed, Mar 29, 2023 at 6:05=E2=80=AFPM Shashank Sharma
> >>>>>>> <shashank.sharma@amd.com> wrote:
> >>>>>>>> This patch series introduces AMDGPU usermode queues for gfx
> >>>>>>>> workloads.
> >>>>>>>> Usermode queues is a method of GPU workload submission into the
> >>>>>>>> graphics hardware without any interaction with kernel/DRM
> >>>>>>>> schedulers.
> >>>>>>>> In this method, a userspace graphics application can create its
> >>>>>>>> own
> >>>>>>>> workqueue and submit it directly in the GPU HW.
> >>>>>>>>
> >>>>>>>> The general idea of how this is supposed to work:
> >>>>>>>> - The application creates the following GPU objetcs:
> >>>>>>>>     - A queue object to hold the workload packets.
> >>>>>>>>     - A read pointer object.
> >>>>>>>>     - A write pointer object.
> >>>>>>>>     - A doorbell page.
> >>>>>>>> - The application picks a 32-bit offset in the doorbell page
> >>>>>>>> for this queue.
> >>>>>>>> - The application uses the usermode_queue_create IOCTL
> >>>>>>>> introduced in
> >>>>>>>>     this patch, by passing the the GPU addresses of these
> >>>>>>>> objects (read
> >>>>>>>>     ptr, write ptr, queue base address and 32-bit doorbell
> >>>>>>>> offset from
> >>>>>>>>     the doorbell page)
> >>>>>>>> - The kernel creates the queue and maps it in the HW.
> >>>>>>>> - The application can start submitting the data in the queue as
> >>>>>>>> soon as
> >>>>>>>>     the kernel IOCTL returns.
> >>>>>>>> - After filling the workload data in the queue, the app must
> >>>>>>>> write the
> >>>>>>>>     number of dwords added in the queue into the doorbell
> >>>>>>>> offset, and the
> >>>>>>>>     GPU will start fetching the data.
> >>>>>>>>
> >>>>>>>> libDRM changes for this series and a sample DRM test program
> >>>>>>>> can be
> >>>>>>>> found in the MESA merge request here:
> >>>>>>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
> >>>>>>>>
> >>>>>>>> This patch series depends on the doorbell-manager changes,
> >>>>>>>> which are
> >>>>>>>> being reviewed here:
> >>>>>>>> https://patchwork.freedesktop.org/series/115802/
> >>>>>>>>
> >>>>>>>> Alex Deucher (1):
> >>>>>>>>     drm/amdgpu: UAPI for user queue management
> >>>>>>>>
> >>>>>>>> Arvind Yadav (2):
> >>>>>>>>     drm/amdgpu: add new parameters in v11_struct
> >>>>>>>>     drm/amdgpu: map wptr BO into GART
> >>>>>>>>
> >>>>>>>> Shashank Sharma (6):
> >>>>>>>>     drm/amdgpu: add usermode queue base code
> >>>>>>>>     drm/amdgpu: add new IOCTL for usermode queue
> >>>>>>>>     drm/amdgpu: create GFX-gen11 MQD for userqueue
> >>>>>>>>     drm/amdgpu: create context space for usermode queue
> >>>>>>>>     drm/amdgpu: map usermode queue into MES
> >>>>>>>>     drm/amdgpu: generate doorbell index for userqueue
> >>>>>>>>
> >>>>>>>>    drivers/gpu/drm/amd/amdgpu/Makefile           | 3 +
> >>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +-
> >>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 2 +
> >>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 6 +
> >>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298
> >>>>>>>> ++++++++++++++++++ .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c=
 |
> >>>>>>>> ++++++++++++++++++ 230 ++++++++++++++
> >>>>>>>>    .../gpu/drm/amd/include/amdgpu_userqueue.h    | 66 ++++
> >>>>>>>>    drivers/gpu/drm/amd/include/v11_structs.h     | 16 +-
> >>>>>>>>    include/uapi/drm/amdgpu_drm.h                 | 55 ++++
> >>>>>>>>    9 files changed, 677 insertions(+), 9 deletions(-) create mod=
e
> >>>>>>>> 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>>>>>    create mode 100644
> >>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> >>>>>>>>    create mode 100644
> >>>>>>>> drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> 2.40.0
> >>>>>>>>
> >
