Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE38CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F5A10E4A6;
	Mon, 15 Sep 2025 13:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H91jfjst";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA7D10E4A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:14:12 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-26654749271so1898415ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757942051; x=1758546851; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GVcscEk5zkt8amUfQo20Yo2e1zKLYd8MODT3d0aaEo=;
 b=H91jfjstD/6NDCH7rOt7BNQqil1u161CH2CzoyWu5XWLQpqs013fJKCQ9SaTymlsvn
 sDyilvWjeci0+QWkM3f5GlsIvBPQ9HYwSAVSprY+LnE1eyFyNlAUCOZAdNU7/LRXiHqJ
 +UfqL1ckMK0ELdPeiV+lVlwWnFIjzrrEd1nEj6HguzQMNDQkZ29hf+Tzxm05B0jvHIAw
 Uo3LQsbpzZhs7c7ouewieDIL/3GAFVtl0f/WzDAZZQZJtb2DpJOVG1WfuseudvRaHVl3
 HfmMK+ajCsMkduAZ2aCnpz1xU1vPDBjcAfXTzl/z9jhYUTBJGTzoVup1iBCInrC07lNM
 iZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757942051; x=1758546851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GVcscEk5zkt8amUfQo20Yo2e1zKLYd8MODT3d0aaEo=;
 b=sLnSLkJWHcBu9Cu1ualcSt/ZoQPA9MN40GCO3UXApgsvP7f/N0jLV35XEc0qu/CWrU
 K2Qin/C/PryStf38kkJ8vv3l8wVGc9iecqbtmDPsISGmyTZ7iPU4lxYEvxIm8pKSQfLF
 dpbCNC+kXMQ3VssGGc8wq6xnUlV0Hest9jWhl49PgsYYJWFi6quuUElERV0S53OTmIQl
 P7MXgQkh3rnED+Hkx0mACa3ECpeRv1kn3lf3ptIAl6JmusASKjuh8vxfudRjCv1mSTt9
 VeXfE6GbdQq21iQuMHj4Dtbi5Vg5qwGsgnP6o6iTv92FsN7pBDKtc6j1S299/c7SPTLI
 aqpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSOKhcViBl3HM2DkzUX7Vyw8zwRXdNZddRxUo0Vzixy2oe4PVZIp1CodZG+jpSvYPXIIstExfD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpPdZhfra7QVPlS8TG5Lvi8fH5JXwjVbCib5t+5d7sU5QyyjSx
 XpjgcRJL0rcaHq2goxZup12x9M1gVaTum3co+588P8Q1CxqGPoKCo4t6NEv6H9HfRvYKEsZSyCG
 nKZ0NaElqg26KPKgyOHHd3uoMjMVcS1g=
X-Gm-Gg: ASbGncsXpgx6KY1wzN3nxQrdP1mgA82U4Vf4sZFQPErjELf4gAydd+r1San6JewVzaJ
 lUvOElVazhbf9LnVbCEunUjzYv2aWPF2Mt639PvuWTtM24QyT0RJ0zu1El0CXphzdEtrKG8M44q
 Nldmk5bEBToJLhga52PeGdCi5PYF70Jand7/oDTxpPQllJ+1v4wtcm+5YQRYyV9vXIApvdL4Cwt
 nSRIcDOYH5CbWM9eQ==
X-Google-Smtp-Source: AGHT+IH2mu+hS8EcI0kDl407TbviibQGxVzT9eN/xz5ink7YC96vSgLisc6MiQA9qjRYbY56Za3LF8wuZYG9jlYJz2Q=
X-Received: by 2002:a17:902:bb97:b0:24c:c445:87c2 with SMTP id
 d9443c01a7336-25d24f976c3mr54498485ad.4.1757942051523; Mon, 15 Sep 2025
 06:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250905124742.11305-1-christian.koenig@amd.com>
 <f247fd27-5e20-402d-91f4-68fa27657b3b@amd.com>
In-Reply-To: <f247fd27-5e20-402d-91f4-68fa27657b3b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Sep 2025 09:13:59 -0400
X-Gm-Features: Ac12FXy4Khzl-jqLyxNPwBE7Ni-ddp3UeCR8YpPTEhvBvG2ZEC47SakgT9SmCCU
Message-ID: <CADnq5_M+12pSHpn8PS2UaWs=GvxMMgRkW4_GEr9zRMZ=syxJ5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add AMDGPU_IDS_FLAGS_GANG_SUBMIT
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, timur.kristof@gmail.com, 
 amd-gfx@lists.freedesktop.org
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

On Mon, Sep 15, 2025 at 9:13=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Ping?
>
> Alex can we commit this until we have found a solution for SRIOV?

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards,
> Christian.
>
> On 05.09.25 14:47, Christian K=C3=B6nig wrote:
> > Add a UAPI flag indicating if gang submit is supported or not.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
> >  include/uapi/drm/amdgpu_drm.h           | 9 +++++----
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 8a76960803c6..8676400834fc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -939,6 +939,10 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
> >               if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
> >                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_CONFORM=
ANT_TRUNC_COORD;
> >
> > +             /* Gang submit is not supported under SRIOV currently */
> > +             if (!amdgpu_sriov_vf(adev))
> > +                     dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_GANG_SU=
BMIT;
> > +
> >               if (amdgpu_passthrough(adev))
> >                       dev_info->ids_flags |=3D (AMDGPU_IDS_FLAGS_MODE_P=
T <<
> >                                               AMDGPU_IDS_FLAGS_MODE_SHI=
FT) &
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 9cebd072a042..7a228c4d1325 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -1084,10 +1084,11 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> >   *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
> >   *
> >   */
> > -#define AMDGPU_IDS_FLAGS_FUSION         0x1
> > -#define AMDGPU_IDS_FLAGS_PREEMPTION     0x2
> > -#define AMDGPU_IDS_FLAGS_TMZ            0x4
> > -#define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD 0x8
> > +#define AMDGPU_IDS_FLAGS_FUSION                      0x01
> > +#define AMDGPU_IDS_FLAGS_PREEMPTION          0x02
> > +#define AMDGPU_IDS_FLAGS_TMZ                 0x04
> > +#define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD      0x08
> > +#define AMDGPU_IDS_FLAGS_GANG_SUBMIT         0x10
> >
> >  /*
> >   *  Query h/w info: Flag identifying VF/PF/PT mode
>
