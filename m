Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44B3C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 13:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFDD10E0F4;
	Mon, 10 Apr 2023 13:48:57 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C6410E0F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 13:48:56 +0000 (UTC)
Received: by mail-yb1-xb36.google.com with SMTP id f188so36399576ybb.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681134535; x=1683726535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZ0G4xA3YnA3kH45nn5s6+/AgE58uI1V1smo4A0XzJY=;
 b=edrHu32cwAf5e5PL7MzOko9fQbaXvl+7z+Az8o1wjBL+M46aT1nHmyZwb6A8bC22MT
 UhZikeDThRNGOx0fxW++85oBZck1iNEyJ8UJbHxB3UGLn91oJl1ASyzNoaDhlboii3nv
 MnKamjKJCL5wwIKUHiyYFLKuhSkA5NKoxbg9a7RykyY1ZaP6hnP1wi+hWtASn1QsDMuj
 Dh9F+fbf9SVGNbr86xENzybNtpezcwcyX/XqkbV1ijPtlbKozK/IeRQz8H6T8f+v3zKf
 kvGm5NTA6thOfbtk1fHUthN2SBPzjZapF51vmyNf3VPWXKUXWbV30kLHvTWN6CB7zC2k
 N45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681134535; x=1683726535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZ0G4xA3YnA3kH45nn5s6+/AgE58uI1V1smo4A0XzJY=;
 b=5sNsp6RBDI5P8YQqo5xeicBEF5/NuZ0ONXDRuvWOk94ci/BxCGdkaAlNskTos3rBcC
 2zmryAqobdlf68i9/KI+o66cGneoYmtX2J8YUYTekp1yL0cKFfZ+w336VpMfFdlqQSfX
 m3SmRFlTsi3cN+OSFtUu/WIrsvaukIjr4dFnFo/26Xzp40JGLwn+G5yWB0BitAJUHjFJ
 b0+ZVoQDwrZCxMNk4pg4wPEhCvNhjUF/PiqjpTmgZvoIHLREDMnUVj7JiY6vorp8gfvk
 BbAfa5ZUWx/jVLzmguYJn1byVYx0SvCqpXfMzONpRKI/sFl3sEtiQkdZn+DAKEJQPBkE
 E2zA==
X-Gm-Message-State: AAQBX9eOR7fRCSq7r+HizCi91lsq8s/Nm8insq2T7sTIX1z7deTJ/gxI
 BreNsOa6ILxYRhjvwlPTFqkEWFlf/mub/9LHJpBY8nd9bc14wLIcpfpNZw==
X-Google-Smtp-Source: AKy350aAumX4S/6R8Od0bvYSkoDOel5GT+Df3eEqRtcuX9PzL21KF5IuWXKjL7/9ZyqHdVt/gyet8UD6ZJLBAMlNQ80=
X-Received: by 2002:a25:7397:0:b0:b8b:fe5f:2eaa with SMTP id
 o145-20020a257397000000b00b8bfe5f2eaamr3654556ybc.2.1681134535343; Mon, 10
 Apr 2023 06:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
 <MW4PR12MB5667D4837CFDEE7230F5423DF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyGthhzm6291=jiydsNgK3suGdi4cMM7GMhTW_j3mdgCgQ@mail.gmail.com>
 <MW4PR12MB5667EC2D2E57FDDE93EE546FF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB5667EC2D2E57FDDE93EE546FF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 10 Apr 2023 15:46:42 +0200
Message-ID: <CAP+8YyH9GsyiUPvyeHfgG=TOOywxA42vubsYPWB9mPiexHBG_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>
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

On Mon, Apr 10, 2023 at 3:40=E2=80=AFPM Sharma, Shashank
<Shashank.Sharma@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hello Bas,
>
> This is not the correct interpretation of the code, the USERQ_IOCTL has b=
oth the OPs (create and destroy), but th euser has to exclusively call  it.
>
> Please see the sample test program in the existing libDRM series (userq_t=
est.c, it specifically calls amdgpu_free_userq, which does the destroy_OP
>
> for the IOCTL.

In the presence of crashes the kernel should always be able to clean
this up no? Otherwise there is a resource leak?

>
> - Shashank
>
> -----Original Message-----
> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Sent: 10 April 2023 11:26
> To: Sharma, Shashank <Shashank.Sharma@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@=
amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>
> Hi Shashank,
>
> I think I found the issue: I wasn't destroying the user queue in my progr=
am and the kernel doesn't clean up any remaining user queues in the postclo=
se hook. I think we need something like
> https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c12837973c=
eddf55ccc85d29
> ?
>
> While running things multiple times now works, I still have problems doin=
g multiple submissions from the same queue. Looking forward to the updated =
test/sample
>
> Thanks,
> Bas
>
> On Mon, Apr 10, 2023 at 9:32=E2=80=AFAM Sharma, Shashank <Shashank.Sharma=
@amd.com> wrote:
> >
> > [AMD Official Use Only - General]
> >
> > Hello Bas,
> > Thanks for trying this out.
> >
> > This could be due to the doorbell as you mentioned, Usermode queue uses=
 doorbell manager internally.
> > This week, we are planning to publis the latest libDRM sample code whic=
h uses a doorbell object (instead of the doorbell hack IOCTL), adapting to =
that should fix your problem in my opinion.
> > We have tested this full stack (libDRM test + Usermode queue + doorbell=
 manager) for 500+ consecutive runs, and it worked well for us.
> >
> > You can use this integrated kernel stack (1+2) from my gitlab to build
> > your kernel:
> > https://gitlab.freedesktop.org/contactshashanksharma/userq-amdgpu/-/tr
> > ee/integrated-db-and-uq-v3 Please stay tuned for updated libDRM
> > changes with doorbell objects.
> >
> > Regards
> > Shashank
> > -----Original Message-----
> > From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Sent: 10 April 2023 02:37
> > To: Sharma, Shashank <Shashank.Sharma@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> > Koenig, Christian <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
> >
> > Hi Shashank,
> >
> > I tried writing a program to experiment with usermode queues and I foun=
d some weird behavior: The first run of the program works as expected, whil=
e subsequent runs don't seem to do anything (and I allocate everything in G=
TT, so it should be zero initialized consistently). Is this a known issue?
> >
> > The linked libdrm code for the uapi still does a doorbell ioctl so it c=
ould very well be that I do the doorbell wrong (especially since the ioctl =
implementation was never shared AFAICT?), but it seems like the kernel subm=
issions (i.e. write wptr in dwords to the wptr va and to the doorbell). Is =
it possible to update the test in libdrm?
> >
> > Code: https://gitlab.freedesktop.org/bnieuwenhuizen/usermode-queue
> >
> > Thanks,
> > Bas
> >
> > On Wed, Mar 29, 2023 at 6:05=E2=80=AFPM Shashank Sharma <shashank.sharm=
a@amd.com> wrote:
> > >
> > > This patch series introduces AMDGPU usermode queues for gfx workloads=
.
> > > Usermode queues is a method of GPU workload submission into the
> > > graphics hardware without any interaction with kernel/DRM schedulers.
> > > In this method, a userspace graphics application can create its own
> > > workqueue and submit it directly in the GPU HW.
> > >
> > > The general idea of how this is supposed to work:
> > > - The application creates the following GPU objetcs:
> > >   - A queue object to hold the workload packets.
> > >   - A read pointer object.
> > >   - A write pointer object.
> > >   - A doorbell page.
> > > - The application picks a 32-bit offset in the doorbell page for this=
 queue.
> > > - The application uses the usermode_queue_create IOCTL introduced in
> > >   this patch, by passing the the GPU addresses of these objects (read
> > >   ptr, write ptr, queue base address and 32-bit doorbell offset from
> > >   the doorbell page)
> > > - The kernel creates the queue and maps it in the HW.
> > > - The application can start submitting the data in the queue as soon =
as
> > >   the kernel IOCTL returns.
> > > - After filling the workload data in the queue, the app must write th=
e
> > >   number of dwords added in the queue into the doorbell offset, and t=
he
> > >   GPU will start fetching the data.
> > >
> > > libDRM changes for this series and a sample DRM test program can be
> > > found in the MESA merge request here:
> > > https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
> > >
> > > This patch series depends on the doorbell-manager changes, which are
> > > being reviewed here:
> > > https://patchwork.freedesktop.org/series/115802/
> > >
> > > Alex Deucher (1):
> > >   drm/amdgpu: UAPI for user queue management
> > >
> > > Arvind Yadav (2):
> > >   drm/amdgpu: add new parameters in v11_struct
> > >   drm/amdgpu: map wptr BO into GART
> > >
> > > Shashank Sharma (6):
> > >   drm/amdgpu: add usermode queue base code
> > >   drm/amdgpu: add new IOCTL for usermode queue
> > >   drm/amdgpu: create GFX-gen11 MQD for userqueue
> > >   drm/amdgpu: create context space for usermode queue
> > >   drm/amdgpu: map usermode queue into MES
> > >   drm/amdgpu: generate doorbell index for userqueue
> > >
> > >  drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298
> > > ++++++++++++++++++  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |
> > > ++++++++++++++++++ 230 ++++++++++++++
> > >  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  66 ++++
> > >  drivers/gpu/drm/amd/include/v11_structs.h     |  16 +-
> > >  include/uapi/drm/amdgpu_drm.h                 |  55 ++++
> > >  9 files changed, 677 insertions(+), 9 deletions(-)  create mode
> > > 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > >  create mode 100644
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> > >  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> > >
> > > --
> > > 2.40.0
> > >
