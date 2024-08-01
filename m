Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27587C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC7C10E87F;
	Thu,  1 Aug 2024 03:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BUymXaeH";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C7110E87F
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:23:21 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a7a9185e1c0so644023066b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 20:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722482600; x=1723087400; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/ZtSeCTZabsRSMs6G0dnOZaha28km1/LzVo8kvY8M0=;
 b=BUymXaeHpz91I5rsjP1QaJ49fmX+IN01z6xlgRQjLI47JvlIpolq3P8sRb2sodzhRi
 ByP9eUFm+CotSLs+8cnR6O9X7X8Ip3gqdNYU4zh2bvZq8mu3nX7qiHmrEwup6zWn4E79
 tPTTjS2cJN23etm/McJ/C58zlnGApMoh0S5j5KYmPufIbAZRMtFwhdqAuBXAxymhWZrz
 UQFiqqBXBr4QTYh1WBxfqrxrigrybRv4IjGBeS1Sfi1CsK+xPZgJC+DKIjUCXxj8pOVC
 OiFe+q/Y/ErAVD5KHAQ/yBKvIawbcHD5ZwEyYzFT4QhvzgdlzU9HWoSeG1ZJ+iU0RS18
 MNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722482600; x=1723087400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/ZtSeCTZabsRSMs6G0dnOZaha28km1/LzVo8kvY8M0=;
 b=N53YBRLTtZWiMQZNs6HzLlY27MHt6pyxRlcFVdhOC+oMsGAJ8lkRtjHRlACfQZKKPg
 sZW01g69XCpLSdU3wrebbNubvWBH3Tz7ZQ2CdFhn+6hhX8lAYfG5WPu15nMb/31Djt2i
 SziW5n05k85mAhyVHOjf6dPKXWOEsbevo88Irpi5jh2j8kyCh0C/D5HGi9Dc0ESZhlJH
 /k3RC/++QfLH2RenZha+nDFnWZQA+yu7Iq0tvro6bpkZsSNeW7zYTfYjYvaSVWARg8jn
 ZmcZ9UKu0PVpHIm2zgsqmlrDK6QdKJind1/TKrVHE12L9+jibqxnMlO6q4E9uvoaSBez
 Wcgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhW3xhs2pg2AJM8TrlOVtpcmdysCw4P69XaLkRSR0MolylmKMDF9gklD3/uADkSMRk7wD6T5ld@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1cJ9VtmKVnlT0kLzKXSO0nKLCj4uS5VYMTe2NLsFGLaInFOqL
 zkFvcNS5V2zdRvTo6AHgEMtptaXUuEcKvcyX2PZU1+6y0Fwa1xT3zTLi/kIfmYPjTGItC/M9wRO
 ZRY3AD0kuOA1mI9UyV143D8Jeu7uS5JBG
X-Google-Smtp-Source: AGHT+IGALuZvunBIuVboAcmXo5OHRVWvqqH5gasTD2/LjKanTPf/szRc/6R+dmFO6HUOljpcJ3Qq4fcUS+/7ym+Oh7g=
X-Received: by 2002:a17:907:6d17:b0:a7d:a080:b97 with SMTP id
 a640c23a62f3a-a7daf536532mr64757966b.29.1722482599916; Wed, 31 Jul 2024
 20:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
In-Reply-To: <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 31 Jul 2024 23:22:43 -0400
Message-ID: <CAAxE2A7CcN+ePP83Z55X-gqFdBg0YTPxRniLtphiJdMrZEXAcA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

On Wed, Jul 31, 2024 at 11:19=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmai=
l.com> wrote:
>
> On Tue, Jul 30, 2024 at 8:43=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.co=
m> wrote:
> >
> > Adding NOP packets one by one in the ring
> > does not use the CP efficiently.
> >
> > Solution:
> > Use CP optimization while adding NOP packet's so PFP
> > can discard NOP packets based on information of count
> > from the Header instead of fetching all NOP packets
> > one by one.
> >
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> > Cc: Tvrtko Ursulin <tursulin@igalia.com>
> > Cc: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> > Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 853084a2ce7f..edf5b5c4d185 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -9397,6 +9397,24 @@ static void gfx_v10_0_emit_mem_sync(struct amdgp=
u_ring *ring)
> >         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> >  }
> >
> > +static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring, uin=
t32_t num_nop)
> > +{
> > +       int i;
> > +
> > +       /* Header itself is a NOP packet */
> > +       if (num_nop =3D=3D 1) {
> > +               amdgpu_ring_write(ring, ring->funcs->nop);
> > +               return;
> > +       }
> > +
> > +       /* Max HW optimization till 0x3ffe, followed by remaining one N=
OP at a time*/
> > +       amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0=
x3ffe)));
> > +
> > +       /* Header is at index 0, followed by num_nops - 1 NOP packet's =
*/
> > +       for (i =3D 1; i < num_nop; i++)
> > +               amdgpu_ring_write(ring, ring->funcs->nop);
>
> This loop should be removed. It's unnecessary CPU overhead and we
> should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving the
> whole packet body uninitialized is the fastest option.

If you remove amdgpu_ring_write, you still need to move wptr somehow.
amdgpu_ring_write_multiple gives a hint about how to do it:

ring->wptr +=3D count_dw;
ring->wptr &=3D ring->ptr_mask;
ring->count_dw -=3D count_dw;

Marek

>
> Marek
>
> > +}
> > +
> >  static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
> >  {
> >         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > @@ -9588,7 +9606,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_r=
ing_funcs_gfx =3D {
> >         .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
> >         .test_ring =3D gfx_v10_0_ring_test_ring,
> >         .test_ib =3D gfx_v10_0_ring_test_ib,
> > -       .insert_nop =3D amdgpu_ring_insert_nop,
> > +       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
> >         .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >         .emit_switch_buffer =3D gfx_v10_0_ring_emit_sb,
> >         .emit_cntxcntl =3D gfx_v10_0_ring_emit_cntxcntl,
> > @@ -9629,7 +9647,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_r=
ing_funcs_compute =3D {
> >         .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
> >         .test_ring =3D gfx_v10_0_ring_test_ring,
> >         .test_ib =3D gfx_v10_0_ring_test_ib,
> > -       .insert_nop =3D amdgpu_ring_insert_nop,
> > +       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
> >         .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> >         .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
> > @@ -9659,7 +9677,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_r=
ing_funcs_kiq =3D {
> >         .emit_fence =3D gfx_v10_0_ring_emit_fence_kiq,
> >         .test_ring =3D gfx_v10_0_ring_test_ring,
> >         .test_ib =3D gfx_v10_0_ring_test_ib,
> > -       .insert_nop =3D amdgpu_ring_insert_nop,
> > +       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
> >         .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >         .emit_rreg =3D gfx_v10_0_ring_emit_rreg,
> >         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> > --
> > 2.34.1
> >
