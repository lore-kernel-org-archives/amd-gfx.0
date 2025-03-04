Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B404BC021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 21:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6631410E0A5;
	Tue,  4 Mar 2025 21:05:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MIpybNa4";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D91D10E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 21:05:28 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2217875d103so16873975ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Mar 2025 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741122327; x=1741727127; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdwAAQfPVPzXNMJ8ecw+Wf8hcePSHtzSA0PvIKW1iTA=;
 b=MIpybNa4dxQYe/7zo5rNMWe0PTOqnVLwYJpmxM466/BoSoNDyky/eKHFuvBC/jX8nu
 msRwgYZT9rBydlI6fMVEEBQo4HuI/64ePU8zwPEcYJkqEs/kl/T7wJnsh3XlloA1FWn5
 Ari0gIwBA+sG8jDwh5jhTtBVXm7r0woth9R8V86vjqRvPTZj9TaMsUoKWKgocSQZeQGr
 6zKNCPYKv/D09FmvX9239FEd0WIdjVjOf+UGY+Oq7+ziQuU3b7wA8NqGt2wAXeZ1OGdU
 cMa7/DBN0yRmPonc333nr82wE0e3qjV3ruk9GelKiaC1ywzhGiW9Y5P1uYNzI6CY3K8+
 rZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741122327; x=1741727127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdwAAQfPVPzXNMJ8ecw+Wf8hcePSHtzSA0PvIKW1iTA=;
 b=oPRTHTWE1zjojqUFip3kR3xCpH5uBFLanaA8CyerO56rFwLqyzzafrfmR0fR1HHLXR
 0vPwvi+gs8pMLtF+Yp+ErlCRgqCDpxw9JTFLlccvBCu4OnCYRn+wdZSWlmPMsXLns1qa
 tJQXFkchEoGyYcjXLiz+PVGRz+PWHqtZdyoOmptJOizm5Ef3FMvaopUK4r/FJMiCEIR8
 CT0griNQOsCislRK1R4B09jjzFXvSsFOtgIl1m/Ibbk24ihDZ0Lefr3F/KM7Of9lEEt3
 XTfwb6P8D3oNU5ILJKBaFT8lDy6oQjtIeG5zy0X6rGtA+hoEsuj2YsuuQWAoqj1mI8sT
 T1qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHYR7A6g6YeXFFPJojG25qqFdrzb6BikkQLBnqSMs77AB88gQg8+0G/vmLQZfM7RDMiGelftx+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRVLobYngAZ62oLCYUrlPwbmmDkLXjYHEGc51pAB0q+wTiInv/
 RvJ4qsH6YV82NgQ9YLZLDAKZwoh1EsMZawSrdLHzz8Kt7pbDIhWaLhGKcPd5YeGX5j8lr2JJq2W
 IW0X55w5JNy5ckogWQo08f5N5Agag9g==
X-Gm-Gg: ASbGnctPbWWfz3b9q/C9diSRpYWMF2zmvJLSD0rX2dnnFz1pR8OOf4e+9pl19J/ntq/
 jPjL4LCafxiSThavlZZcJ7nVIYRLKF+sNUEzgXlgxip0qpvitYgE7oOyB4NDZaYzzWfwvjBu9Da
 3XcNtXS+ueKIx8qM890nKUQWVsSw==
X-Google-Smtp-Source: AGHT+IELVPizVOKkv5ZY82WMLIkyyp+lmLA9GiR4Y1K/iqTh1KSB9Aw1ECL/lq1D9/7hEeilHqzalKx6PXlCBcuTdV8=
X-Received: by 2002:a17:902:e74f:b0:21b:d105:26a7 with SMTP id
 d9443c01a7336-223f1c992cdmr3616855ad.6.1741122326662; Tue, 04 Mar 2025
 13:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20250304162242.4029795-1-alexander.deucher@amd.com>
 <0358291a-7744-4e91-9442-3dd9f999d4d0@amd.com>
In-Reply-To: <0358291a-7744-4e91-9442-3dd9f999d4d0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Mar 2025 16:05:14 -0500
X-Gm-Features: AQ5f1JqekZiV7v3jXR50jDz2Ot_U3VfGhVx8kV4r9WffOHcNsGgquMmrO0qjjaw
Message-ID: <CADnq5_NHyAZMKan0fOOzF_1VBAHxPFkhcyVCp6s5QyHgdtzT1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
To: Boyuan Zhang <Boyuan.Zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Mar 4, 2025 at 4:00=E2=80=AFPM Boyuan Zhang <Boyuan.Zhang@amd.com> =
wrote:
>
>
> On 2025-03-04 11:22, Alex Deucher wrote:
> > VCN 2.5 uses the PG callback to enable VCN DPM which is
> > a global state.  As such, we need to make sure all instances
> > are in the same state.
> >
> > v2: switch to a ref count (Lijo)
> >
> > Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for id=
le work handler")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +++
> >   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 41 +++++++++++++++++++-----=
-
> >   2 files changed, 36 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.h
> > index 26c9c2d90f455..3bc4fe4aeb481 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > @@ -358,6 +358,10 @@ struct amdgpu_vcn {
> >
> >       bool                    per_inst_fw;
> >       unsigned                fw_version;
> > +     /* VCN 2.5 global PG handling */
> > +     struct mutex            global_pg_lock;
> > +     unsigned int            global_pg_count;
> > +     enum amd_powergating_state global_pg_state;
> >   };
> >
> >   struct amdgpu_fw_shared_rb_ptrs_struct {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v2_5.c
> > index dff1a88590363..972f0842ea47b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > @@ -172,6 +172,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block =
*ip_block)
> >       uint32_t *ptr;
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > +     mutex_init(&adev->vcn.global_pg_lock);
> > +
> >       for (j =3D 0; j < adev->vcn.num_vcn_inst; j++) {
> >               volatile struct amdgpu_fw_shared *fw_shared;
> >
> > @@ -1853,21 +1855,42 @@ static int vcn_v2_5_set_pg_state(struct amdgpu_=
vcn_inst *vinst,
> >                                enum amd_powergating_state state)
> >   {
> >       struct amdgpu_device *adev =3D vinst->adev;
> > -     int ret;
> > +     struct amdgpu_vcn_inst *v;
> > +     int ret =3D 0, i;
> >
> >       if (amdgpu_sriov_vf(adev))
> >               return 0;
> >
> > -     if (state =3D=3D vinst->cur_state)
> > -             return 0;
> > +     mutex_lock(&adev->vcn.global_pg_lock);
> > +     if (state =3D=3D AMD_PG_STATE_GATE) {
> > +             if (adev->vcn.global_pg_count =3D=3D 0)
> > +                     goto unlock;
> > +             adev->vcn.global_pg_count--;
> > +             if (adev->vcn.global_pg_count =3D=3D 0 &&
> > +                 adev->vcn.global_pg_state =3D=3D AMD_PG_STATE_UNGATE)=
 {
> > +                     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > +                             v =3D &adev->vcn.inst[i];
> > +
> > +                             ret =3D vcn_v2_5_stop(v);
> > +                     }
> > +                     adev->vcn.global_pg_state =3D AMD_PG_STATE_GATE;
> > +             }
> > +     } else {
> > +             if (adev->vcn.global_pg_count =3D=3D 0 &&
> > +                 adev->vcn.global_pg_state =3D=3D AMD_PG_STATE_GATE) {
> > +                     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > +                             v =3D &adev->vcn.inst[i];
> >
> > -     if (state =3D=3D AMD_PG_STATE_GATE)
> > -             ret =3D vcn_v2_5_stop(vinst);
> > -     else
> > -             ret =3D vcn_v2_5_start(vinst);
> > +                             ret =3D vcn_v2_5_start(v);
> > +                     }
> > +                     adev->vcn.global_pg_state =3D AMD_PG_STATE_UNGATE=
;
> > +             }
> > +             adev->vcn.global_pg_count++;
> > +     }
> >
> > -     if (!ret)
> > -             vinst->cur_state =3D state;
> > +unlock:
> > +     vinst->cur_state =3D state;
>
>
> I guess we don't need to bother this per instant (vinst->cur_state) at
> all in this case? Other than this, this patch is

I figured it would be good to keep it up to date just in case, but
it's not strictly required.

>
> Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>

Thanks,

Alex

>
>
> > +     mutex_unlock(&adev->vcn.global_pg_lock);
> >
> >       return ret;
> >   }
