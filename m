Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5662C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 19:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E76B6E418;
	Wed,  8 Dec 2021 19:48:31 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB6A6E418
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 19:48:30 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 r10-20020a056830080a00b0055c8fd2cebdso3834337ots.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=joHzcM2oUIT9yNo8mUIAAVuLsnnWdlGAhkAaPG1KIAQ=;
 b=UjCdQd49avgLqDHd8CdLzn1mIAbzPhh6soiVKNt9Lwxg3Am2II4tHnyaywQFb2fOza
 uF+NXzmmM/ze8U58jp9nEjEfISeX1+eyQNtiEwaSlXePfqzlCrjDn84rwLuVpI/KCkgR
 gfDR7DD4mnb/WRlLu3kg7lEIwzneGl0Qeu+8QkYr3U86UtF1PUVSgGfl1Ephs1KEQ6D+
 CBP10LkNtjkS9Ls6zd2zGbpsbzWivOq5nJAMmVhXTVaDLwt2a01OlI017X4I/2OuiPhv
 Ylt9uWWMs1Mv7EdwuK2aT8BGT0cgurdN1X0fZZoPmHrtOPrxHbquEGZv7kaYuI1nACMw
 I4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=joHzcM2oUIT9yNo8mUIAAVuLsnnWdlGAhkAaPG1KIAQ=;
 b=aqzRsnbf0NmNrQUNcGv/ilHZFjOGv/Uali6LYO7X56PY2rb9qVSsDiaZ1dMB68ZSSk
 1Qb5XodtnJa+sIrKm4KLnvWNpUYQBpYBrAWVPLmn/Sj9v4WtbfDCI533OMpZnFJLTJdL
 0UDvnM8UuP5uBApWgLC0X8PqORmdTpxLPibUcL+ol/Z+enHQPxKCijlfJstlajRg/LBz
 CskRg+8NRTm5FalPWV2ouKHTHT6kASEOzsQAlSBgHu1tg2JsCmxDG0Cg7Y/HBfrYXM1M
 /5z/KVuaBrwd4L96Ul2tSRi1BjvmqS7QPBG8ooUsFFfSdIK0xT1YXfBZngy9lXypmlsa
 dPmA==
X-Gm-Message-State: AOAM533W6nqCh8n9esGrA51MStRot2Tr1Gd91qUf+8ejX56e/hmy7Sdd
 9nVUa5+8qqEAOYS3YyQ8LTuyH7dgpPQmSZL1mLYtOYRG
X-Google-Smtp-Source: ABdhPJxCdvkOgK+ZmqE6H+jAfhwRZ49SF38wL+pVHkgQCo5G4KKNyyBSxwSjHBiRxBlXH50zuH0o6bYGUkjoRrVsOdg=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr1452940ota.200.1638992909858; 
 Wed, 08 Dec 2021 11:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-8-isabbasso@riseup.net>
 <3e643175-3d25-d48d-8930-47b398d65b76@amd.com>
In-Reply-To: <3e643175-3d25-d48d-8930-47b398d65b76@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 14:48:18 -0500
Message-ID: <CADnq5_MQXW0Cyiyjszch=7YOjCvZxt4bnagiWEK=i5OPDuy60w@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/amd: append missing includes
To: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Isabella Basso <isabbasso@riseup.net>,
 "Wentland, Harry" <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Wed, Dec 8, 2021 at 10:11 AM Rodrigo Siqueira Jordao
<rjordrigo@amd.com> wrote:
>
>
>
> On 2021-12-07 8:25 p.m., Isabella Basso wrote:
> > This fixes warnings caused by global functions lacking prototypes:, suc=
h as:
> >
> >   warning: no previous prototype for 'dcn303_hw_sequencer_construct'
> >   [-Wmissing-prototypes]
> >   12 | void dcn303_hw_sequencer_construct(struct dc *dc)
> >      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ...
> >   warning: no previous prototype for =E2=80=98amdgpu_has_atpx=E2=80=99
> >   [-Wmissing-prototypes]
> >   76 | bool amdgpu_has_atpx(void) {
> >      |      ^~~~~~~~~~~~~~~
> >
> > Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c                | 1 +
> >   .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c    | 2 +=
+
> >   .../gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c | 2 +=
+
> >   drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c     | 2 +=
+
> >   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c               | 2 +=
+
> >   drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c               | 2 +=
+
> >   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c               | 2 +=
+
> >   drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c             | 2 +=
+
> >   drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c             | 2 +=
+
> >   drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c             | 2 +=
+
> >   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c               | 2 +=
+
> >   11 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > index c2be6ad62308..d6d986be906a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/pci.h>
> >   #include <linux/delay.h>
> >
> > +#include "amdgpu.h"
> >   #include "amd_acpi.h"
> >
> >   #define AMDGPU_PX_QUIRK_FORCE_ATPX  (1 << 0)
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_v=
bios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios=
_smu.c
> > index fe18bb9e19aa..06bab24d8e27 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_sm=
u.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_sm=
u.c
> > @@ -28,6 +28,8 @@
> >   #include "reg_helper.h"
> >   #include <linux/delay.h>
> >
> > +#include "rv1_clk_mgr_vbios_smu.h"
> > +
> >   #define MAX_INSTANCE        5
> >   #define MAX_SEGMENT         5
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vb=
ios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_s=
mu.c
> > index 0c963fc0523f..8161a6ae410d 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu=
.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu=
.c
> > @@ -33,6 +33,8 @@
> >   #include "mp/mp_12_0_0_offset.h"
> >   #include "mp/mp_12_0_0_sh_mask.h"
> >
> > +#include "rn_clk_mgr_vbios_smu.h"
> > +
> >   #define REG(reg_name) \
> >       (MP0_BASE.instance[0].segment[mm ## reg_name ## _BASE_IDX] + mm #=
# reg_name)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.=
c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > index a6bc3c7673ba..abef132fa016 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > @@ -69,6 +69,8 @@
> >
> >   #include "dcn10/dcn10_hw_sequencer.h"
> >
> > +#include "dce110_hw_sequencer.h"
> > +
> >   #define GAMMA_HW_POINTS_NUM 256
> >
> >   /*
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> > index 5cfd4b0afea5..91e4885b743e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> > @@ -27,6 +27,8 @@
> >   #include "dcn10/dcn10_hw_sequencer.h"
> >   #include "dcn20_hwseq.h"
> >
> > +#include "dcn20_init.h"
> > +
> >   static const struct hw_sequencer_funcs dcn20_funcs =3D {
> >       .program_gamut_remap =3D dcn10_program_gamut_remap,
> >       .init_hw =3D dcn10_init_hw,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/driver=
s/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> > index 54c11ba550ae..b270f0b194dc 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> > @@ -28,6 +28,8 @@
> >   #include "dcn20/dcn20_hwseq.h"
> >   #include "dcn21_hwseq.h"
> >
> > +#include "dcn21_init.h"
> > +
> >   static const struct hw_sequencer_funcs dcn21_funcs =3D {
> >       .program_gamut_remap =3D dcn10_program_gamut_remap,
> >       .init_hw =3D dcn10_init_hw,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> > index 93f32a312fee..4926771ddeee 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> > @@ -29,6 +29,8 @@
> >   #include "dcn21/dcn21_hwseq.h"
> >   #include "dcn30_hwseq.h"
> >
> > +#include "dcn30_init.h"
> > +
> >   static const struct hw_sequencer_funcs dcn30_funcs =3D {
> >       .program_gamut_remap =3D dcn10_program_gamut_remap,
> >       .init_hw =3D dcn30_init_hw,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> > index e85b695f2351..3d42a1a337ec 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> > @@ -30,6 +30,8 @@
> >   #include "dcn30/dcn30_hwseq.h"
> >   #include "dcn301_hwseq.h"
> >
> > +#include "dcn301_init.h"
> > +
> >   static const struct hw_sequencer_funcs dcn301_funcs =3D {
> >       .program_gamut_remap =3D dcn10_program_gamut_remap,
> >       .init_hw =3D dcn10_init_hw,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
> > index d88b9011c502..eb375f30f5bc 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
> > @@ -29,6 +29,8 @@
> >
> >   #include "dc.h"
> >
> > +#include "dcn302_init.h"
> > +
> >   void dcn302_hw_sequencer_construct(struct dc *dc)
> >   {
> >       dcn30_hw_sequencer_construct(dc);
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/driv=
ers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> > index aa5dbbade2bd..f499f8ab5e47 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> > @@ -9,6 +9,8 @@
> >   #include "dcn30/dcn30_init.h"
> >   #include "dc.h"
> >
> > +#include "dcn303_init.h"
> > +
> >   void dcn303_hw_sequencer_construct(struct dc *dc)
> >   {
> >       dcn30_hw_sequencer_construct(dc);
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/driver=
s/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
> > index e175b6cc0125..e5885f62a764 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
> > @@ -31,6 +31,8 @@
> >   #include "dcn301/dcn301_hwseq.h"
> >   #include "dcn31/dcn31_hwseq.h"
> >
> > +#include "dcn31_init.h"
> > +
> >   static const struct hw_sequencer_funcs dcn31_funcs =3D {
> >       .program_gamut_remap =3D dcn10_program_gamut_remap,
> >       .init_hw =3D dcn31_init_hw,
> >
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
