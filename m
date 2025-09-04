Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7010CA1002
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 13:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FAB10EA41;
	Thu,  4 Sep 2025 13:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hAZif2Bs";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0E810EA41
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 13:40:52 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-24b157ba91bso2066285ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Sep 2025 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756993252; x=1757598052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAd0vb8SPzK3n+a8BmbMpIt4egGx4i/Z//KkZpIiHLs=;
 b=hAZif2Bs8mO3j4r8n+Dc0bN4JHP35NEP7fU6PDLRcpPHINvXUprxMf2dvdaBHgKz0n
 8nQNuiynb0hV/8zmCiKEcz8SYibXVaspekkjQDKWmeuQclVRhYYQ5l20s2UCZowgyoB+
 k79PPJ36ntAmUhZNeAuapi5hmHp3/lgBHESViEc7ryAi4S07FexilUg1hTuxl2vj61uR
 3GJABPHoemRA79EWbbwlMuh6GJgotHYAjlvsmhyS3JcoKeJ2q/JsBqVlUkx4aqj98fk+
 Su1ImFWlB1bBE3BuID0VwHfxu2CRX9gSxD5mfaoEjHcb5IhpPLHze+j+SeWl6+9u88ql
 zE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756993252; x=1757598052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAd0vb8SPzK3n+a8BmbMpIt4egGx4i/Z//KkZpIiHLs=;
 b=uHH+4wTGfdBSffqgOlO1KCbKzcj6d9uYWzjysK7TZBbqZwnZiqAQCd5rZbrXawVRCW
 QmBEgYmxGhZHYEqC8sOtVb2uggWAxetwBN0b/6Hxd6oDz69Np/Q8HpHxGM9tsct6FXvC
 2Yz+ExWYq8vWc6U4qYbl0WgIbgYMG+laggb/1tOoV1EDn2lEZuIXkn+Hh41ByucNnd1l
 jLX4qVX2q69McmA1MV8/WHcJNZNlFTnfQ9pd6M5XjHsQKaD7M5a0FDcdKQ/VuI3+OY4f
 +gxYq5ci4EReS8lxR59FvqzLzNdn0sgZ6jJzRdgl9jf+OVk8Wqk8qtDXMZO3GTiuuohQ
 l41g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS9jAiPfxrOrYkZ0uHN86l5NrmO9tu5ddWi7Gd6OvX9rknoLkrlzY65O8LOjaHz6MAPk33jkuV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMS/5kx4n6GR6blhT+dQ9d5b9txFbJpyTFbubz7bullh6eNYK6
 /gPUpYZb3mLt4insGB7olPz3JGZQwmbMjKNpD3rfS59El5UT3L+GbJ2+26cvsGy+UPgLfhFzwy1
 GIcU8D+obENMygGy0NyPHL+yZHToATcVpZQ==
X-Gm-Gg: ASbGnctugqiPOILBv2JTar3P7E8q1FK7O4xItnNZTqhJrjMRskmhDYmfse6SXB0gABJ
 9lg4dsRO3Y8Am7nRUHIXk87DqL+bqjDIFGtsaNwHEtBigRhKbD8y8AbhADtmOJPj0FMT8KGTF1r
 lhZd0za1SmU8Sp2XmQ3Ybiyt1kEkno1A3Y9my2UOgvd7qomicL+Xa0zrjIvWNZ1l6yBG968F9qo
 +9cchwGsPvyqdo/eVe6thcOvtzN
X-Google-Smtp-Source: AGHT+IF38ICYrwYXg/0f6HC2AuLx0WDOcA4wjd3nT2KLBzpgvH4v6FrD+lIFfYRvqsM33F4faJVdrXMXgvl6x5CDb14=
X-Received: by 2002:a17:902:d488:b0:24c:b6b6:e54c with SMTP id
 d9443c01a7336-24cb6b6e5f9mr26560675ad.3.1756993252107; Thu, 04 Sep 2025
 06:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250903203601.839525-1-pratap.nirujogi@amd.com>
 <20250903203601.839525-2-pratap.nirujogi@amd.com>
 <2a0c1e16-8594-439f-95a2-763ca5e92ac4@amd.com>
 <CY5PR12MB6429886911C284A3F4777BBAFE01A@CY5PR12MB6429.namprd12.prod.outlook.com>
 <003cf58a-3b4a-4b7b-b320-22b7df9343cc@amd.com>
In-Reply-To: <003cf58a-3b4a-4b7b-b320-22b7df9343cc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Sep 2025 09:40:39 -0400
X-Gm-Features: Ac12FXxuZzlBStQljDMLRgRiym1TYHey_tt49pIPsDIcUoMSjLSP9j2bId5XJmc
Message-ID: <CADnq5_PiF_9A-Oc-=JKScmcP+S=9oV2y8NmZOWRqMp0GZxDZ_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd/amdgpu: Move isp firmware load into
 isp_v4_1_x modules
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>, "Du, Bin" <Bin.Du@amd.com>,
 "Rosikopulos, Gjorgji" <Gjorgji.Rosikopulos@amd.com>, "Li,
 King" <King.Li@amd.com>, 
 "Antony, Dominic" <Dominic.Antony@amd.com>, "Jawich,
 Phil" <Phil.Jawich@amd.com>, "xglooom@gmail.com" <xglooom@gmail.com>
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

On Wed, Sep 3, 2025 at 5:14=E2=80=AFPM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> On 9/3/25 4:01 PM, Nirujogi, Pratap wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Wednesday, September 3, 2025 4:40 PM
> > To: Nirujogi, Pratap <Pratap.Nirujogi@amd.com>; amd-gfx@lists.freedeskt=
op.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <=
Christian.Koenig@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Chan, Benjamin (Koon Pan) <Benjamin.Chan@amd.com>; Du, Bin <Bin.Du@=
amd.com>; Rosikopulos, Gjorgji <Gjorgji.Rosikopulos@amd.com>; Li, King <Kin=
g.Li@amd.com>; Antony, Dominic <Dominic.Antony@amd.com>; Jawich, Phil <Phil=
.Jawich@amd.com>; xglooom@gmail.com
> > Subject: Re: [PATCH v2 1/2] drm/amd/amdgpu: Move isp firmware load into=
 isp_v4_1_x modules
> >
> > On 9/3/25 3:35 PM, Nirujogi, Pratap wrote:
> >> Move isp firmware load from generic amdgpu_isp driver to isp version
> >> specific driver modules isp_v4_1_0 and isp_v4_1_1.
> >
> > I don't really understand why to do this change.  Isn't it just more co=
de duplication with this patch?
> >
> > Hi Mario, I have added this to show the reference of calling the fw loa=
d in the same file where MODULE_FIRMWARE is added. This aligns with the app=
roach followed in other drivers (amdgpu_vcn, gfx_v11_0 etc.).
> >

I think it depends a bit on the individual IP.  VCN has all of the
firmware handling in a common helper because it's common for all VCN
versions.  Each GFX IP has has its own firmware handling because there
are IP specific handlings required.  I think it's fine to keep the ISP
firwmare handling in once place unless you feel it would make sense to
have it per IP version for some reason going forward.

Alex

>
> I guess I don't see a strong argument for doing it, but let's see what
> others think.
>
> > Thanks,
> > Pratap
> >
> >>
> >> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> >> ---
> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 22 +++++++++-------------
> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 ++
> >>    drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 12 +++++++++++-
> >>    drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h |  2 +-
> >>    drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 12 +++++++++++-
> >>    drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h |  2 +-
> >>    6 files changed, 35 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> >> index 9cddbf50442a..90af35ee8f6e 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> >> @@ -68,7 +68,7 @@ static int isp_hw_fini(struct amdgpu_ip_block *ip_bl=
ock)
> >>        return -ENODEV;
> >>    }
> >>
> >> -static int isp_load_fw_by_psp(struct amdgpu_device *adev)
> >> +int isp_load_fw_by_psp(struct amdgpu_device *adev)
> >>    {
> >>        const struct common_firmware_header *hdr;
> >>        char ucode_prefix[10];
> >> @@ -80,7 +80,7 @@ static int isp_load_fw_by_psp(struct amdgpu_device
> >> *adev)
> >>
> >>        /* read isp fw */
> >>        r =3D amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_OP=
TIONAL,
> >> -                             "amdgpu/%s.bin", ucode_prefix);
> >> +                              "amdgpu/%s.bin", ucode_prefix);
> >>        if (r) {
> >>                amdgpu_ucode_release(&adev->isp.fw);
> >>                return r;
> >> @@ -103,27 +103,23 @@ static int isp_early_init(struct amdgpu_ip_block
> >> *ip_block)
> >>
> >>        struct amdgpu_device *adev =3D ip_block->adev;
> >>        struct amdgpu_isp *isp =3D &adev->isp;
> >> +     int r;
> >> +
> >> +     isp->adev =3D adev;
> >> +     isp->parent =3D adev->dev;
> >>
> >>        switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
> >>        case IP_VERSION(4, 1, 0):
> >> -             isp_v4_1_0_set_isp_funcs(isp);
> >> +             r =3D isp_v4_1_0_set_isp_funcs(isp);
> >>                break;
> >>        case IP_VERSION(4, 1, 1):
> >> -             isp_v4_1_1_set_isp_funcs(isp);
> >> +             r =3D isp_v4_1_1_set_isp_funcs(isp);
> >>                break;
> >>        default:
> >>                return -EINVAL;
> >>        }
> >>
> >> -     isp->adev =3D adev;
> >> -     isp->parent =3D adev->dev;
> >> -
> >> -     if (isp_load_fw_by_psp(adev)) {
> >> -             DRM_DEBUG_DRIVER("%s: isp fw load failed\n", __func__);
> >> -             return -ENOENT;
> >> -     }
> >> -
> >> -     return 0;
> >> +     return r;
> >>    }
> >>
> >>    static bool isp_is_idle(struct amdgpu_ip_block *ip_block) diff --gi=
t
> >> a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> >> index d6f4ffa4c97c..36750123ed46 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> >> @@ -57,4 +57,6 @@ struct amdgpu_isp {
> >>    extern const struct amdgpu_ip_block_version isp_v4_1_0_ip_block;
> >>    extern const struct amdgpu_ip_block_version isp_v4_1_1_ip_block;
> >>
> >> +int isp_load_fw_by_psp(struct amdgpu_device *adev);
> >> +
> >>    #endif /* __AMDGPU_ISP_H__ */
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
> >> index 0027a639c7e6..926947a612a4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
> >> @@ -185,7 +185,17 @@ static const struct isp_funcs isp_v4_1_0_funcs =
=3D {
> >>        .hw_fini =3D isp_v4_1_0_hw_fini,
> >>    };
> >>
> >> -void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp)
> >> +int isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp)
> >>    {
> >> +     struct amdgpu_device *adev =3D isp->adev;
> >> +
> >>        isp->funcs =3D &isp_v4_1_0_funcs;
> >> +
> >> +     /* load isp firmware */
> >> +     if (isp_load_fw_by_psp(adev)) {
> >> +             drm_err(&adev->ddev, "isp fw load failed\n");
> >> +             return -ENOENT;
> >> +     }
> >> +
> >> +     return 0;
> >>    }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
> >> b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
> >> index 4d239198edd0..5e43ba064708 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
> >> @@ -45,6 +45,6 @@
> >>    #define ISP410_GPIO_SENSOR_OFFSET 0x6613C
> >>    #define ISP410_GPIO_SENSOR_SIZE 0x54
> >>
> >> -void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
> >> +int isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
> >>
> >>    #endif
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >> b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >> index a887df520414..9766c6056dc4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >> @@ -369,7 +369,17 @@ static const struct isp_funcs isp_v4_1_1_funcs =
=3D {
> >>        .hw_fini =3D isp_v4_1_1_hw_fini,
> >>    };
> >>
> >> -void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
> >> +int isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
> >>    {
> >> +     struct amdgpu_device *adev =3D isp->adev;
> >> +
> >>        isp->funcs =3D &isp_v4_1_1_funcs;
> >> +
> >> +     /* load isp firmware */
> >> +     if (isp_load_fw_by_psp(adev)) {
> >> +             drm_err(&adev->ddev, "isp fw load failed\n");
> >> +             return -ENOENT;
> >> +     }
> >> +
> >> +     return 0;
> >>    }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
> >> b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
> >> index fe45d70d87f1..b221d8b81983 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
> >> @@ -44,6 +44,6 @@
> >>    #define ISP411_GPIO_SENSOR_OFFSET 0x6613C
> >>    #define ISP411_GPIO_SENSOR_SIZE 0x54
> >>
> >> -void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
> >> +int isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
> >>
> >>    #endif
> >
>
