Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F396CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 21:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4AA910E48D;
	Mon,  3 Nov 2025 21:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VMjhanql";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8E710E48D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 21:01:00 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b62e55af64aso301439a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 13:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762203660; x=1762808460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUiOW7C4ZwqDySbPGivni2RWh2UM6Po2g+8lmO4Et7s=;
 b=VMjhanqlPMegQrpn39qfiIKn/jmzXs62qyQRpoD0WomFTEyy18HuppSB129xcJbX88
 +yo7tRetoqDPukb3fTEvMD0WLb6uQ3wyMP83SM+jOalByG7Z668JgUqQo5UrP5L3B1MD
 WGU74Ja+y8RcbanW034WVOmeyj8PPdabINlPGgtHAweAXh7DeSuJFGFLSN+E29B+hIyQ
 vXsHZSYPfRzG8FCDfLO+Vrp8ahMIsDwYcar8gBREJnLoTFE9/64svGaFF8zge8k74NtW
 16T8sA88UKcDKp2M6FD6UGJPX9/R+TXfo0DFPLzDof51eZLLCq4YkKtaYZOEyeDibK3t
 FOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203660; x=1762808460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUiOW7C4ZwqDySbPGivni2RWh2UM6Po2g+8lmO4Et7s=;
 b=awSxY1pLBjsXEc8aBevoaYoLHKMVkkgLc8XtODdScYpebIkMs7vEMZCGvzxv/y1KrZ
 Q0yDqEXr0IlPyQ9HcDASPvgBrIH6aHEQ5rKZWHuGRrc/5RDqOZIOwZ2mi3gdG5OkaHlE
 ZStK5BkLkLE3AJBeucPN1IA5sazSQ9B3O+QrjszCR5Gice9xE1osUBldQHSPgWAv6QAz
 fCbGFRP24LBQRMB5tL7WThAiXmKoJD5byZ39KYgljWMXj9K/PaxI2SfjiujnR/il/XAz
 05/qma5PkQCk/ejtgtA3c3vpwVi0U4d3vRyc4xVwYNryLu1LalC74DvqD9aCfcInSYzk
 exsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuNr8mlE+4xkEsPjDd910123zkoN6vZHxy+0Hw65DNhY9F9P0A4Bgw1tZaS5RAb+YQj4/BlO6A@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbdxV+mfjpoCd3sCUbP0JKYzZDoauhs5ogNyNAnyPGb0FmLxU/
 If3Ze477a35dhGzSgaCtfNW/YvFdo/sMCTLzej1fXyxd7RHgFDEI3S5AGvwnjYmQIRNjtEnwZHZ
 sCSHmPW+VyRyF9S6gdgfANVoLPxy09F8=
X-Gm-Gg: ASbGncvb9UMpbuvUep1HVLggBMIAvtG9qz4TMeIiH797lpkGVciuyZJ0Hynx0FM+HGZ
 dt4y/WagcJrRfUTE8h6rUEPg9qSGjgNwfQ529AH13BlvmI8DN795jxCgEK/smU6FNJt180G4jYN
 Qkmy8v62WGQKneLBJK0+Pn7xkQOKXiXITkUhtcdJG/WwvAPAfmw1Ow52G3GIU86v+9phnLr4G7a
 3JnZKAukaVMEBka+IcDORld5XujxB2RkHbJDnOmaShdZEYmNJFv+VFpa4QljNxVg7vf3Iw=
X-Google-Smtp-Source: AGHT+IHkzMTK9kV4npXgkeCC86YJACmCSvUutLpqeeiG97BaVIlSB72JjrDvMuew1Gq6j5UaU8oI/dq0MtKOEZvGYEY=
X-Received: by 2002:a17:902:e88c:b0:295:4d64:3c88 with SMTP id
 d9443c01a7336-2954d643e50mr79889435ad.7.1762203659703; Mon, 03 Nov 2025
 13:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20251103152401.9304-1-saleemkhan083@gmail.com>
 <c982e61c-976e-49de-af88-5bedde45eab9@amd.com>
In-Reply-To: <c982e61c-976e-49de-af88-5bedde45eab9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Nov 2025 16:00:46 -0500
X-Gm-Features: AWmQ_bmAoVDiP-qul9u2RiX4RFSRgmETxZ8KJ_1lS3zYPclQwguC7Xu0hezJ_ok
Message-ID: <CADnq5_Piohu=UfD3PLQzjewpLfRBnda-1=Ea3G0xrz=fz7=VuA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: do not use amdgpu_bo_gpu_offset_no_check
 individually
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Saleemkhan Jamadar <saleemkhan083@gmail.com>, alexander.deucher@amd.com, 
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

On Mon, Nov 3, 2025 at 2:11=E2=80=AFPM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
>
>
> On 11/3/25 16:24, Saleemkhan Jamadar wrote:
> > This should not be used indiviually, use amdgpu_bo_gpu_offset
> > with bo reserved.
> >
> > Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail.com>
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c       | 10 +++++++++-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> > index 3040437d99c2..bc7858567321 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> > @@ -129,7 +129,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu=
_device *adev,
> >  {
> >       int db_bo_offset;
> >
> > -     db_bo_offset =3D amdgpu_bo_gpu_offset_no_check(db_bo);
> > +     db_bo_offset =3D amdgpu_bo_gpu_offset(db_bo);
> >
> >       /* doorbell index is 32 bit but doorbell's size can be 32 bit
> >        * or 64 bit, so *db_size(in byte)/4 for alignment.
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/d=
rm/amd/amdgpu/mes_userqueue.c
> > index b1ee9473d628..0a244f80426c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > @@ -93,7 +93,15 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mg=
r *uq_mgr,
> >               return ret;
> >       }
> >
> > -     queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset_no_check(wptr_o=
bj->obj);
> > +     ret =3D amdgpu_bo_reserve(wptr_obj->obj, true);
> > +     if (ret) {
> > +             DRM_ERROR("Failed to reserve wptr bo\n");
> > +             return ret;
> > +     }
> > +
> > +     queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset(wptr_obj->obj);
> > +     amdgpu_bo_unreserve(wptr_obj->obj);
>
> The problem here is that the return value of amdgpu_bo_gpu_offset() can c=
hange as soon as you unlock the BO.
>
> So that wptr BO either need to be pinned or fenced for this to work.

amdgpu_amdkfd_map_gtt_bo_to_gart() and mes_userq_map_gtt_bo_to_gart()
differ in how they handle this.  amdgpu_amdkfd_map_gtt_bo_to_gart()
pins the BO while mes_userq_map_gtt_bo_to_gart() does not.

Alex

>
> Regards,
> Christian.
>
> > +
> >       return 0;
> >  }
> >
>
