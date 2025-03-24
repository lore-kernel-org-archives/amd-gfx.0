Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A86FC36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 14:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C7110E3D9;
	Mon, 24 Mar 2025 14:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZmu1Ott";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70AF610E41D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 14:18:51 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso710189a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742825931; x=1743430731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GD186GdfRZ5fEouD+IULoHDjefXEdvcB78S9f2BbhBQ=;
 b=SZmu1Ott5UlbxlSbP2QX7Mu/jiTeK2u01Sb9Zb5M+On47Zm9hMHXNtMZA4i4aPpPr7
 omatRVmntWNawa/fin00ZFfdSzfEhBZHfL/7AOnGALZN1mHj5DHEuT7Bk/iu5+oGUWif
 wCof5jCo2B7WLymcYaYvtwbgViwpJsySyLDSrQ0eFp7+hkwzmvKPlQHJ3kq4yMsUJmB+
 4rMLgIfLwilI9a3O6swoJyt3mXKs49N9q9EVFWShnLmFdERkgqPXuvjSjfZem+4Q9LvQ
 pOgvCmpNxVb2e9gFw6mMV/G7r5ZDiPap1diiPHFze4nnZiwezroQTNfBllFmTZjTTzFg
 L9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742825931; x=1743430731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GD186GdfRZ5fEouD+IULoHDjefXEdvcB78S9f2BbhBQ=;
 b=I+nCC2KdVnOeLnkXKFYijjwAjx3GG2hps4Fsgyqbp6+sVVRkY/koN8ufQ+cWwKgokw
 gDy6DuuDt0xbp3kTgzcXZRZoZZy0DUY6mHHvVpVOmS56bR5qzARfLyj3ctWcgpkZdMyj
 l5MATi0nLMCfTa8F5XgjECUnl/T6ux1UegcURGdtruQuBQuWfEocrokkGqP4bp7OQFW6
 uWk6Vz7LgzDHUoCJsDWUXoQuijchM2wBjRJZfNPi6yjFKPST5HGrtd88aoyA9c+gzQ0Z
 70idrILmkFbCuN5HMjMunDWugh2C5smxckBqSJOGo9RlhbEik30KoerEyBfMgmPcgInF
 snRQ==
X-Gm-Message-State: AOJu0YxEDilA0xdAQgT+lGnUUy7R63Lod3tVvMd0GlrDJtFqAs3gXZQ+
 q4TLv3tR+x0VMNfpmQFTcpR//4wkxnFSCnqZ8ftougNZXz0VsblUZhc2qPaEZRdUc5BsWrz+fz2
 eDYQom5hdw7zsyZNHYuHk/qbx7oYY/gMh
X-Gm-Gg: ASbGncvDCe1cVszUwiL9XLyK62NIAkYfQ1M+q7JXCsnCwpiz+5KvYSfuSS0K6IRx225
 JiWcSKjf9nsjhXOZ9+/E0VH1vE8jE13wd5FINJP68cY190E5XU65IBDdmXWHR/k/Do1dTlMMcW4
 nS0CStKlQ0oIu0bD44PlHO43hHDQ==
X-Google-Smtp-Source: AGHT+IE5kobTdk8PYULEocSO6fyKbkl1FRMJAN/AUrumid2vsJ7Q8aogXye2qoQg0TFrkHVi/kjjppwajBEJf2GZl14=
X-Received: by 2002:a17:90b:4b02:b0:2ff:682b:b754 with SMTP id
 98e67ed59e1d1-3031f40ec58mr6860763a91.2.1742825930678; Mon, 24 Mar 2025
 07:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250221130030.3703750-1-Prike.Liang@amd.com>
 <CADnq5_N+=TF6EvmoOEV3RNayDHtbZBysopu1=CcuKiL9DFtQxg@mail.gmail.com>
In-Reply-To: <CADnq5_N+=TF6EvmoOEV3RNayDHtbZBysopu1=CcuKiL9DFtQxg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 10:18:38 -0400
X-Gm-Features: AQ5f1Jp59930Nf1mrYDgfTZYkvJrM1SLZWDNgbRbinit2NeBWqwobCIdVlYWYMw
Message-ID: <CADnq5_OmNa-_PNzt3Pmp_wbb_GwPEeSzf=6j1mJKN4yX0DScJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/amdgpu/gfx11: Implement the GFX11 KGQ pipe
 reset
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Mon, Mar 3, 2025 at 9:46=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Fri, Feb 21, 2025 at 8:38=E2=80=AFAM Prike Liang <Prike.Liang@amd.com>=
 wrote:
> >
> > Implement the kernel graphics queue pipe reset,and the driver
> > will fallback to pipe reset when the queue reset fails. However,
> > the ME FW hasn't fully supported pipe reset yet so disable the
> > KGQ pipe reset temporarily.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  2 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 71 ++++++++++++++++++++++-
> >  2 files changed, 71 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ucode.h
> > index 4eedd92f000b..06fe21e15ed6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> > @@ -25,6 +25,8 @@
> >
> >  #include "amdgpu_socbb.h"
> >
> > +#define RS64_FW_UC_START_ADDR_LO 0x3000
> > +
> >  struct common_firmware_header {
> >         uint32_t size_bytes; /* size of the entire header+image(s) in b=
ytes */
> >         uint32_t header_size_bytes; /* size of just the header in bytes=
 */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 2c7f0bb242ff..7e53c0b63f88 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -6653,6 +6653,68 @@ static void gfx_v11_0_emit_mem_sync(struct amdgp=
u_ring *ring)
> >         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> >  }
> >
> > +static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
> > +{
> > +       /* Disable the pipe reset until the CPFW fully support it.*/
> > +       dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset ye=
t.\n");
>
> I'd drop these or make them debug only for now.  Same for gfx12.  With
> that fixed, the series is:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Just in case you missed my reply.  See above ^^^^

Alex

>
>
> > +       return false;
> > +}
> > +
> > +
> > +static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
> > +{
> > +       struct amdgpu_device *adev =3D ring->adev;
> > +       uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> > +       int r;
> > +
> > +       if (!gfx_v11_pipe_reset_support(adev))
> > +               return -EOPNOTSUPP;
> > +
> > +       gfx_v11_0_set_safe_mode(adev, 0);
> > +       mutex_lock(&adev->srbm_mutex);
> > +       soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> > +
> > +       switch (ring->pipe) {
> > +       case 0:
> > +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> > +                                          PFP_PIPE0_RESET, 1);
> > +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> > +                                          ME_PIPE0_RESET, 1);
> > +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> > +                                          PFP_PIPE0_RESET, 0);
> > +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> > +                                          ME_PIPE0_RESET, 0);
> > +               break;
> > +       case 1:
> > +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> > +                                          PFP_PIPE1_RESET, 1);
> > +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> > +                                          ME_PIPE1_RESET, 1);
> > +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> > +                                          PFP_PIPE1_RESET, 0);
> > +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> > +                                          ME_PIPE1_RESET, 0);
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
> > +       WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
> > +
> > +       r =3D (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR=
1)) << 2) - RS64_FW_UC_START_ADDR_LO;
> > +       soc21_grbm_select(adev, 0, 0, 0, 0);
> > +       mutex_unlock(&adev->srbm_mutex);
> > +       gfx_v11_0_unset_safe_mode(adev, 0);
> > +
> > +       dev_info(adev->dev,"The ring %s pipe reset to the ME firmware s=
tart PC: %s\n", ring->name,
> > +                       r =3D=3D 0 ? "successfuly" : "failed");
> > +       /* FIXME: Sometimes driver can't cache the ME firmware start PC=
 correctly, so the pipe reset status
> > +        * relies on the later gfx ring test result.
> > +        */
> > +       return 0;
> > +}
> > +
> >  static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int =
vmid)
> >  {
> >         struct amdgpu_device *adev =3D ring->adev;
> > @@ -6662,8 +6724,13 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_rin=
g *ring, unsigned int vmid)
> >                 return -EINVAL;
> >
> >         r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, fal=
se);
> > -       if (r)
> > -               return r;
> > +       if (r) {
> > +
> > +               dev_warn(adev->dev,"reset via MES failed and try pipe r=
eset %d\n", r);
> > +               r =3D gfx_v11_reset_gfx_pipe(ring);
> > +               if (r)
> > +                       return r;
> > +       }
> >
> >         r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> >         if (unlikely(r !=3D 0)) {
> > --
> > 2.34.1
> >
