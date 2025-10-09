Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC7FCCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 19:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35CD510EB03;
	Thu,  9 Oct 2025 19:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVIxxe0V";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5679610EB02
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 19:28:47 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2680ee37b21so2349955ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760038127; x=1760642927; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRaVyNgWCzunGS3PrEyefzQxjhKPb91BULKZ7AvRvto=;
 b=MVIxxe0VYbGXsa/Q7XAd+Zw9wkev5ta27LMrRfY2PMTqal9FaFLP/l6GdsLXCr02Te
 dmzSGstm3vrpa0EL3DNP7r6kFp6yrz099BXHUnvNxYhf8iTbtoHDnzJcQxkdlmM+5imp
 S4WK4/eyRhyYhXt8Qd2k0FjfJmY7EesOTTFcvuitNg1aSuevDTaDzYIxS5CcBXP5HyjQ
 frjsXfjbbqUztbhKZ9sLKv+BmtOrTovjbUVED43M9AZf8Mu97tAYYzeKWfH8JkTVV+/8
 O2mHj1FWpN26AF1TRXN8MiGSn/Mk6RT3S1041rdM30WvUbMdukcGI62gCt5qaD04RYtQ
 rRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760038127; x=1760642927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRaVyNgWCzunGS3PrEyefzQxjhKPb91BULKZ7AvRvto=;
 b=Jf8MnFdqvvj78CMbwbGte4Hm64/ZV79idT+yXhXuA44iHC8hVLt5PYl/HYi6YcaTfK
 1UiGceTcQUzweToiVKYCXbsgYHOz1Zt0pYarWnAnGS8eL+pzoQ/MPPHOX9ozBLhLVg13
 +B1nUduNHRW7FTV0AfQecJWyHG1jzBLnVziNeQYlL8fq2SdpkQkd4I8JeeKeA/qtk701
 +BB6FTCTtYCEpFZyTfZaHAQ1GN+SuwomcKdSJVdcQ1mMNRgCEonYRXhuQwpkaM2HZMpF
 xNplhwycRGtP+66dpcoNEN+z1wxnJ/41T0YFNjZfP4KmAZNaI4W/8DI5WKrD0dVjPYh4
 jBnw==
X-Gm-Message-State: AOJu0Yws1Y66It7Gb2S5NvnD+cQeeYejzQzYSEIJsKcul5S4WvuNvYLA
 b7yRnTPVZf2E/kBldyrF0A2gxxwJ7Dj9PeRVG0pvdhGlb+IDOyMjmbRAWHWwKtbA4ut4mc3E6Mr
 CtfezImFiVkYLA2UjHQaq1AdkKFS3MBM=
X-Gm-Gg: ASbGnctjcpFHkqzz6m7zY1qBZLJfXfI/yPSEZKPHRTfh7qXEn3Tyn29opo6j2MJDqu1
 XHhQki07fqBJo7/Wp3H1t7FRSEKNn5mnUqjQdu+qURIeUsPr0/vxhvb6g8EPpZv1MOTeccnHMFc
 LbVARLonuP4tT8HOr3sgCkuId2/9YoGKwcx5ltkPL2AT4H4+AQxJsY/U95bF0vxhCrSQ2qdX4Nu
 kD3eU1tCvPTj4sgy0SXUU2mqcbmtHw=
X-Google-Smtp-Source: AGHT+IFc2RlH9G0XT7U2TnH1WBqvHe7tJOYI+YuDFXdJQGI/Dyxtsm28K/T3kbQEHyrqmE/zZo9DRZeUREbZe5CTNjc=
X-Received: by 2002:a17:902:da92:b0:267:bd8d:1b6 with SMTP id
 d9443c01a7336-290272e1e45mr67269865ad.6.1760038126697; Thu, 09 Oct 2025
 12:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
 <20251009184929.1038298-4-jonathan.kim@amd.com>
 <CADnq5_Moqk8zHiXyvj7_BfHwH4W3dQqNfvhRQcyj4mw-9tM19Q@mail.gmail.com>
 <CY8PR12MB743546724A4EB526E5AC9B5785EEA@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB743546724A4EB526E5AC9B5785EEA@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 15:28:35 -0400
X-Gm-Features: AS18NWAxBFaUIhtNNVSJlUMCIoAtS7CnUZkXl_Sq9Jmyq7YptxtP8IN4LoCfjtU
Message-ID: <CADnq5_P60WCeJ+1NAECzhpdEoz5Mi214=u8XJHgC32MYNT6TYw@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu: fix hung reset queue array return for hws
 user compute
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>, 
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Lin,
 Amber" <Amber.Lin@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 9, 2025 at 3:24=E2=80=AFPM Kim, Jonathan <Jonathan.Kim@amd.com>=
 wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, October 9, 2025 3:17 PM
> > To: Kim, Jonathan <Jonathan.Kim@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>;
> > Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Lin, Amber
> > <Amber.Lin@amd.com>
> > Subject: Re: [PATCH 3/6] drm/amdgpu: fix hung reset queue array return =
for hws
> > user compute
> >
> > On Thu, Oct 9, 2025 at 2:50=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.c=
om> wrote:
> > >
> > > By design the MES will return an array result that is twice the numbe=
r
> > > of hung doorbells it can report.
> > >
> > > i.e. if up k reported doorbells are supported, then the
> > > second half of the array, also of length k, holds the HQD information
> > > (type/queue/pipe) where queue 1 corresponds to index 0 and k,
> > > queue 2 corresponds to index 1 and k + 1 etc ...
> >
> > Has this always been the case?  If not, what mes version changed this?
>
> It's been around since the beginning.
>
> >
> > >
> > > The driver will use the HDQ info to target queue/pipe reset for
> > > hardware scheduled user compute queues.
> > >
> > > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 20 ++++++++++++++++----
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  1 +
> > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  6 +++---
> > >  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     |  8 +++++---
> > >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  8 +++++---
> > >  5 files changed, 30 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > index c698e183beda..1af3ddb6f65c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > @@ -419,12 +419,24 @@ int
> > amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
> > >         if (r) {
> > >                 dev_err(adev->dev, "failed to detect and reset\n");
> > >         } else {
> > > +               int array_hqd_info_offset =3D adev->mes.hung_queue_hq=
d_info_offset;
> > > +               int array_size =3D adev->mes.hung_queue_db_array_size=
;
> > >                 *hung_db_num =3D 0;
> > > -               for (i =3D 0; i < adev->mes.hung_queue_db_array_size;=
 i++) {
> > > -                       if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OF=
FSET) {
> > > +
> > > +               for (i =3D 0; i < array_hqd_info_offset; i++) {
> > > +                       if (db_array[i] =3D=3D AMDGPU_MES_INVALID_DB_=
OFFSET)
> > > +                               continue;
> > > +
> > > +                       hung_db_array[i] =3D db_array[i];
> > > +                       *hung_db_num +=3D 1;
> > > +               }
> > > +
> > > +               for (i =3D array_hqd_info_offset; i < array_size; i++=
) {
> > > +                       if (!hung_db_num || queue_type !=3D
> > AMDGPU_RING_TYPE_COMPUTE)
> >
> > Might be better to move the queue_type check before the loop.
>
> Ack.
>
> >
> > > +                               break;
> > > +
> > > +                       if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OF=
FSET)
> > >                                 hung_db_array[i] =3D db_array[i];
> >
> > What is the point of this?  If this is hqd info, then it's not a
> > doorbell, so why add it to the list?  Maybe drop the hqd array
> > handling until we actually use it.
>
> It's for later use with the current KFD.
> We need to steer to the right queue/pipe coordinates for pipe reset and H=
QD active checks later via mmio r/w.
> Sure, I can squash this patch into a follow on series when we actually st=
art to resetting queues.

We should still increase the array size so that we allocate enough
memory, but maybe hold off on returning the hqd info until you use it.

Alex

>
> Jon
>
>
> >
> > Alex
> >
> > > -                               *hung_db_num +=3D 1;
> > > -                       }
> > >                 }
> > >         }
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > > index 6b506fc72f58..97c137c90f97 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > > @@ -149,6 +149,7 @@ struct amdgpu_mes {
> > >         void                *resource_1_addr[AMDGPU_MAX_MES_PIPES];
> > >
> > >         int                             hung_queue_db_array_size;
> > > +       int                             hung_queue_hqd_info_offset;
> > >         struct amdgpu_bo                *hung_queue_db_array_gpu_obj;
> > >         uint64_t                        hung_queue_db_array_gpu_addr;
> > >         void                            *hung_queue_db_array_cpu_addr=
;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > index 829129ad7bd1..5c63480dda9c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > @@ -208,10 +208,10 @@ static int mes_userq_detect_and_reset(struct
> > amdgpu_device *adev,
> > >         struct amdgpu_userq_mgr *uqm, *tmp;
> > >         unsigned int hung_db_num =3D 0;
> > >         int queue_id, r, i;
> > > -       u32 db_array[4];
> > > +       u32 db_array[8];
> > >
> > > -       if (db_array_size > 4) {
> > > -               dev_err(adev->dev, "DB array size (%d vs 4) too small=
\n",
> > > +       if (db_array_size > 8) {
> > > +               dev_err(adev->dev, "DB array size (%d vs 8) too small=
\n",
> > >                         db_array_size);
> > >                 return -EINVAL;
> > >         }
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > index e82188431f79..da575bb1377f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > @@ -66,7 +66,8 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_devi=
ce
> > *adev);
> > >  #define GFX_MES_DRAM_SIZE      0x80000
> > >  #define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
> > >
> > > -#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 4
> > > +#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] =3D db offset, [4=
:7] =3D
> > hqd info */
> > > +#define MES11_HUNG_HQD_INFO_OFFSET     4
> > >
> > >  static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
> > >  {
> > > @@ -1720,8 +1721,9 @@ static int mes_v11_0_early_init(struct
> > amdgpu_ip_block *ip_block)
> > >         struct amdgpu_device *adev =3D ip_block->adev;
> > >         int pipe, r;
> > >
> > > -       adev->mes.hung_queue_db_array_size =3D
> > > -               MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
> > > +       adev->mes.hung_queue_db_array_size =3D
> > MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
> > > +       adev->mes.hung_queue_hqd_info_offset =3D
> > MES11_HUNG_HQD_INFO_OFFSET;
> > > +
> > >         for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
> > >                 if (!adev->enable_mes_kiq && pipe =3D=3D AMDGPU_MES_K=
IQ_PIPE)
> > >                         continue;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > index be8a352f9771..79dd2261ad04 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > @@ -47,7 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_devi=
ce
> > *adev);
> > >
> > >  #define MES_EOP_SIZE   2048
> > >
> > > -#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
> > > +#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] =3D db offset [4:=
7]
> > hqd info */
> > > +#define MES12_HUNG_HQD_INFO_OFFSET     4
> > >
> > >  static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
> > >  {
> > > @@ -1899,8 +1900,9 @@ static int mes_v12_0_early_init(struct
> > amdgpu_ip_block *ip_block)
> > >         struct amdgpu_device *adev =3D ip_block->adev;
> > >         int pipe, r;
> > >
> > > -       adev->mes.hung_queue_db_array_size =3D
> > > -               MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
> > > +       adev->mes.hung_queue_db_array_size =3D
> > MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
> > > +       adev->mes.hung_queue_hqd_info_offset =3D
> > MES12_HUNG_HQD_INFO_OFFSET;
> > > +
> > >         for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
> > >                 r =3D amdgpu_mes_init_microcode(adev, pipe);
> > >                 if (r)
> > > --
> > > 2.34.1
> > >
