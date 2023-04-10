Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D43EC76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 14:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B421510E0BD;
	Mon, 10 Apr 2023 14:06:35 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F5810E0BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 14:06:33 +0000 (UTC)
Received: by mail-yb1-xb2f.google.com with SMTP id e127so4657160ybf.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681135592; x=1683727592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJ86gJ2ZHc59e1oDkLRLZKwb0S7biLsle9ub3HstFls=;
 b=QJQEptcQFvxRqlV51gEE86z3HjQpmlBJTli0rPghmbIeRFBxkQ6He5DcyLwEIise6Q
 voHu2wJC2i/UDQRkX4z91syxPQQtlWevJZ0tz+YonJ7X6vuLgNsq85uFGvKtCdmsm+ja
 kyRggvCZdJ5jswkTKF7AxgUJfWtq4B3DgDPmbq19w8Wxc0PKYHg+5FENTG1RTK++V2eQ
 G8R54VD1j9ZjT8WJZGc5WsHxCqPpL9hWxNwZck/A1FU+F4Bf7S1YBE2Td7eyl9K6n2vy
 /yD8ICfxepE4EyBHn2rAM0GE8p/T2ePqrLajj4El1PABvduWkRVEsV5fRVVUmxWLYFaS
 EIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681135592; x=1683727592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJ86gJ2ZHc59e1oDkLRLZKwb0S7biLsle9ub3HstFls=;
 b=zfoL6jxGyklTgKmsR1S6i/WEC7C7p5k9VrdgRrHssI9ktZ2od6WUjg9mGpEHMNFgs4
 uqXETe08xIPbR0/mCvIHvyBoUxPMKi27NdRCZA6Ho2q9c+Kqn4rPPzQ8ZTPJ6alvcYy3
 q0MDNIFe6Rc6yX9JKpaJNS++qFrhOOCXOCQjniJXaHX3OIW9/Vpw2mhms0CKSPjpR7iN
 z9ZZG0GzyX8rxfReZwXaJYRbHMrNkxxf3XdAyU7DD/9tT27/xpEJTxq1j1vz1eQbVGcG
 2FBZY9Ls4QuP1i1HxZkRAdH3uZciVbhuxBzOz+8UB9R/nvs6uchlryfz9cJJ0hG8U8Vv
 qKcg==
X-Gm-Message-State: AAQBX9cdgmrqffIj2sfrNOzFPRMt4BmRxnZo5IKsGG2VvhM7LqRRRXAt
 /I/wxFiLLJCUSk7jfBJERF0e1MRp4WG4815Qvm3Gkg==
X-Google-Smtp-Source: AKy350bdZebcxee/JyOoWnm/1DnjeMVIZssweGo99otFnTJjEwdjLDiX+D3rwGkP0XllJQAXgNjv2HldhNHV7xp4Tvg=
X-Received: by 2002:a25:d10c:0:b0:b79:22d7:95ff with SMTP id
 i12-20020a25d10c000000b00b7922d795ffmr7127326ybg.2.1681135592475; Mon, 10 Apr
 2023 07:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
 <MW4PR12MB5667D4837CFDEE7230F5423DF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyGthhzm6291=jiydsNgK3suGdi4cMM7GMhTW_j3mdgCgQ@mail.gmail.com>
 <MW4PR12MB5667EC2D2E57FDDE93EE546FF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyH9GsyiUPvyeHfgG=TOOywxA42vubsYPWB9mPiexHBG_A@mail.gmail.com>
 <07322367-bbf1-cf82-0a21-15d453fe4dae@amd.com>
In-Reply-To: <07322367-bbf1-cf82-0a21-15d453fe4dae@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 10 Apr 2023 16:04:19 +0200
Message-ID: <CAP+8YyEDW7JNQ1C9j0NZqXuLAnXPduSAye7esSOOwPpLNT9yYA@mail.gmail.com>
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
 Felix" <Felix.Kuehling@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 10, 2023 at 4:01=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
>
> On 10/04/2023 15:46, Bas Nieuwenhuizen wrote:
> > On Mon, Apr 10, 2023 at 3:40=E2=80=AFPM Sharma, Shashank
> > <Shashank.Sharma@amd.com> wrote:
> >> [AMD Official Use Only - General]
> >>
> >> Hello Bas,
> >>
> >> This is not the correct interpretation of the code, the USERQ_IOCTL ha=
s both the OPs (create and destroy), but th euser has to exclusively call  =
it.
> >>
> >> Please see the sample test program in the existing libDRM series (user=
q_test.c, it specifically calls amdgpu_free_userq, which does the destroy_O=
P
> >>
> >> for the IOCTL.
> > In the presence of crashes the kernel should always be able to clean
> > this up no? Otherwise there is a resource leak?
>
> The crash handling is the same as any of the existing GPU resource which
> are allocated and freed with IOCTL_OPs.

Most of those are handled in the when the DRM fd gets closed (i.e.
when the process exits):

- buffers through drm_gem_release()
- mappings in amdgpu_vm_fini
- contexts in amdgpu_ctx_mgr_fini

etc.

Why would we do things differently for userspace queues? It doesn't
look complicated looking at the above patch (which does seem to work).


>
> To be honest a crash handling can be very elaborated and complex one,
> and hence only can be done at the driver unload IMO, which doesn't help
> at that stage,
>
> coz anyways driver will re-allocate the resources on next load.
>
> - Shashank
>
> >
> >> - Shashank
> >>
> >> -----Original Message-----
> >> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> >> Sent: 10 April 2023 11:26
> >> To: Sharma, Shashank <Shashank.Sharma@amd.com>
> >> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <C=
hristian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
> >> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
> >>
> >> Hi Shashank,
> >>
> >> I think I found the issue: I wasn't destroying the user queue in my pr=
ogram and the kernel doesn't clean up any remaining user queues in the post=
close hook. I think we need something like
> >> https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c128379=
73ceddf55ccc85d29
> >> ?
> >>
> >> While running things multiple times now works, I still have problems d=
oing multiple submissions from the same queue. Looking forward to the updat=
ed test/sample
> >>
> >> Thanks,
> >> Bas
> >>
> >> On Mon, Apr 10, 2023 at 9:32=E2=80=AFAM Sharma, Shashank <Shashank.Sha=
rma@amd.com> wrote:
> >>> [AMD Official Use Only - General]
> >>>
> >>> Hello Bas,
> >>> Thanks for trying this out.
> >>>
> >>> This could be due to the doorbell as you mentioned, Usermode queue us=
es doorbell manager internally.
> >>> This week, we are planning to publis the latest libDRM sample code wh=
ich uses a doorbell object (instead of the doorbell hack IOCTL), adapting t=
o that should fix your problem in my opinion.
> >>> We have tested this full stack (libDRM test + Usermode queue + doorbe=
ll manager) for 500+ consecutive runs, and it worked well for us.
> >>>
> >>> You can use this integrated kernel stack (1+2) from my gitlab to buil=
d
> >>> your kernel:
> >>> https://gitlab.freedesktop.org/contactshashanksharma/userq-amdgpu/-/t=
r
> >>> ee/integrated-db-and-uq-v3 Please stay tuned for updated libDRM
> >>> changes with doorbell objects.
> >>>
> >>> Regards
> >>> Shashank
> >>> -----Original Message-----
> >>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> >>> Sent: 10 April 2023 02:37
> >>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
> >>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> >>> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>=
;
> >>> Koenig, Christian <Christian.Koenig@amd.com>
> >>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
> >>>
> >>> Hi Shashank,
> >>>
> >>> I tried writing a program to experiment with usermode queues and I fo=
und some weird behavior: The first run of the program works as expected, wh=
ile subsequent runs don't seem to do anything (and I allocate everything in=
 GTT, so it should be zero initialized consistently). Is this a known issue=
?
> >>>
> >>> The linked libdrm code for the uapi still does a doorbell ioctl so it=
 could very well be that I do the doorbell wrong (especially since the ioct=
l implementation was never shared AFAICT?), but it seems like the kernel su=
bmissions (i.e. write wptr in dwords to the wptr va and to the doorbell). I=
s it possible to update the test in libdrm?
> >>>
> >>> Code: https://gitlab.freedesktop.org/bnieuwenhuizen/usermode-queue
> >>>
> >>> Thanks,
> >>> Bas
> >>>
> >>> On Wed, Mar 29, 2023 at 6:05=E2=80=AFPM Shashank Sharma <shashank.sha=
rma@amd.com> wrote:
> >>>> This patch series introduces AMDGPU usermode queues for gfx workload=
s.
> >>>> Usermode queues is a method of GPU workload submission into the
> >>>> graphics hardware without any interaction with kernel/DRM schedulers=
.
> >>>> In this method, a userspace graphics application can create its own
> >>>> workqueue and submit it directly in the GPU HW.
> >>>>
> >>>> The general idea of how this is supposed to work:
> >>>> - The application creates the following GPU objetcs:
> >>>>    - A queue object to hold the workload packets.
> >>>>    - A read pointer object.
> >>>>    - A write pointer object.
> >>>>    - A doorbell page.
> >>>> - The application picks a 32-bit offset in the doorbell page for thi=
s queue.
> >>>> - The application uses the usermode_queue_create IOCTL introduced in
> >>>>    this patch, by passing the the GPU addresses of these objects (re=
ad
> >>>>    ptr, write ptr, queue base address and 32-bit doorbell offset fro=
m
> >>>>    the doorbell page)
> >>>> - The kernel creates the queue and maps it in the HW.
> >>>> - The application can start submitting the data in the queue as soon=
 as
> >>>>    the kernel IOCTL returns.
> >>>> - After filling the workload data in the queue, the app must write t=
he
> >>>>    number of dwords added in the queue into the doorbell offset, and=
 the
> >>>>    GPU will start fetching the data.
> >>>>
> >>>> libDRM changes for this series and a sample DRM test program can be
> >>>> found in the MESA merge request here:
> >>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
> >>>>
> >>>> This patch series depends on the doorbell-manager changes, which are
> >>>> being reviewed here:
> >>>> https://patchwork.freedesktop.org/series/115802/
> >>>>
> >>>> Alex Deucher (1):
> >>>>    drm/amdgpu: UAPI for user queue management
> >>>>
> >>>> Arvind Yadav (2):
> >>>>    drm/amdgpu: add new parameters in v11_struct
> >>>>    drm/amdgpu: map wptr BO into GART
> >>>>
> >>>> Shashank Sharma (6):
> >>>>    drm/amdgpu: add usermode queue base code
> >>>>    drm/amdgpu: add new IOCTL for usermode queue
> >>>>    drm/amdgpu: create GFX-gen11 MQD for userqueue
> >>>>    drm/amdgpu: create context space for usermode queue
> >>>>    drm/amdgpu: map usermode queue into MES
> >>>>    drm/amdgpu: generate doorbell index for userqueue
> >>>>
> >>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298
> >>>> ++++++++++++++++++  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |
> >>>> ++++++++++++++++++ 230 ++++++++++++++
> >>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  66 ++++
> >>>>   drivers/gpu/drm/amd/include/v11_structs.h     |  16 +-
> >>>>   include/uapi/drm/amdgpu_drm.h                 |  55 ++++
> >>>>   9 files changed, 677 insertions(+), 9 deletions(-)  create mode
> >>>> 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>   create mode 100644
> >>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> >>>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >>>>
> >>>> --
> >>>> 2.40.0
> >>>>
