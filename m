Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82634C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1337E10E70F;
	Wed, 21 Aug 2024 22:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X6RRmEb4";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0599410E70F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:22:39 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2022fea51fdso221545ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724278959; x=1724883759; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgh98HwJ64Vkc4vo2gzsPKXGMTDRFd/hRlsBZWjEuGw=;
 b=X6RRmEb4e3UlI9mNoKg67ABlrN7EcweJFRbZhFah/NvBSmVxe6Qj4SET3j9vf4yrlE
 NbMFQp2/DVG8P7F1Npjois0VFCmolVTNRLmy/bya7fybha/cVBtDgNKVWy0TnpQ0A7SP
 oI5n41FgXJja+lTNcWx/Zr8FPzRbV51dRyiwZ8BpvPJg++aerBLwFP3PRwWJBB57MR8m
 Zja/nSnHSRkdZEs/Eul+p01cMh3pjs4Q47iONnmH+fFvH5IdeMmQchdxXm5JbL+YIbq3
 9Jl2cb+vwqilo1X5EOg+CLqz65LcDqFNITedczDQQPteTpTUYcYP9A1WPx5O3Fx6Gt/K
 Wwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724278959; x=1724883759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgh98HwJ64Vkc4vo2gzsPKXGMTDRFd/hRlsBZWjEuGw=;
 b=U31g8uv2CQyBLdVIvYTCHFX40RM759EM2/LgzoeJcbNKYe3pTkcOUSZ84FaIEAjSNF
 29YS8sdj3ZLv38K8c4EUVf4Vf1BqXHtBviNGaavtgL+E7ty/Ap+X64VNWprJe53EYKhI
 mQKKrCfZQbRYQtg5PBWGhhEycGAR0bnEaLatOE6BSi0Hxv/CW8b7kKFczt5/qsO/b6db
 JSeYujVVy7DoR39uyxAeAXInAUtSRgpF8ugmkShtDel4cjv+N3nr07NI4S3GK/kZyXSd
 zOqkNio1KxB8XmlZZdEnIkP0QPc1AV3ihuXx2FqmH+TErN77SDkVBnfvO49R9tFP8xVe
 wC8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0xT+dKyU30j95IKqvEBBx1fqysAwhZTiq/kVtCyJbnC3SnQfNJs+8R1ccCprsEtwhC2jwGZNv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFKJIiVgUEaw5bOVhQRtdoMtCuCOoIP/tvh3+vj8vZzBI9KsVm
 zJUR/C2JCP79no9eqcPv9qdNvD5omY1Ozv30rO6vWGn2CauzoG04l/2e3HiK9XRJ7Z/anBXx84S
 XeImCALbqICTKC2sbIru6rRAGaEk0mA==
X-Google-Smtp-Source: AGHT+IGikbF/F6zYY0CwksfjnEYDz0lFgPeA4om3rF2Xmc7kox9QuMPcjILFpSRhzxbHmcRMdXJgqG+/shYiJ04Msgs=
X-Received: by 2002:a17:903:32d0:b0:202:5add:b245 with SMTP id
 d9443c01a7336-20368095b70mr22950105ad.8.1724278959251; Wed, 21 Aug 2024
 15:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240820202518.2110483-1-alexander.deucher@amd.com>
 <20240820202518.2110483-2-alexander.deucher@amd.com>
 <7755e287-6572-4b7d-96c1-98521702c2c9@amd.com>
In-Reply-To: <7755e287-6572-4b7d-96c1-98521702c2c9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Aug 2024 18:22:27 -0400
Message-ID: <CADnq5_Nq+rCt4ybJFgMHda9sMdDpL2UufSHoKMV=Y6i0UJCYFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx9: put queue resets behind a debug
 option
To: Felix Kuehling <felix.kuehling@amd.com>
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

On Wed, Aug 21, 2024 at 5:59=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
>
> On 2024-08-20 16:25, Alex Deucher wrote:
> > Pending extended validation.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 6 ++++++
> >   3 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > index c63528a4e8941..1254a43ec96b6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > @@ -1151,6 +1151,10 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgp=
u_device *adev,
> >       uint32_t low, high;
> >       uint64_t queue_addr =3D 0;
> >
> > +     if (!adev->debug_exp_resets &&
> > +         !adev->gfx.num_gfx_rings)
> > +             return 0;
> > +
>
> Did you put this in the HW-specific code path intentionally? If you want
> this check to apply to all ASICs, you should put it into
> detect_queue_hang in kfd_device_queue_manager.c. But maybe the extended
> validation is HW-specific.

I only want to apply it to MI parts at this point.  We will likely
have a different default on other parts.

Alex

>
> Either way, the patch is
>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
> >       kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
> >       amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index 21089aadbb7b4..8cf5d7925b51c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -7233,6 +7233,10 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring=
 *ring,
> >       unsigned long flags;
> >       int i, r;
> >
> > +     if (!adev->debug_exp_resets &&
> > +         !adev->gfx.num_gfx_rings)
> > +             return -EINVAL;
> > +
> >       if (amdgpu_sriov_vf(adev))
> >               return -EINVAL;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_4_3.c
> > index 2067f26d3a9d8..f8649546b9c4c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -3052,6 +3052,9 @@ static void gfx_v9_4_3_ring_soft_recovery(struct =
amdgpu_ring *ring,
> >       struct amdgpu_device *adev =3D ring->adev;
> >       uint32_t value =3D 0;
> >
> > +     if (!adev->debug_exp_resets)
> > +             return;
> > +
> >       value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> >       value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> >       value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> > @@ -3475,6 +3478,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_rin=
g *ring,
> >       unsigned long flags;
> >       int r, i;
> >
> > +     if (!adev->debug_exp_resets)
> > +             return -EINVAL;
> > +
> >       if (amdgpu_sriov_vf(adev))
> >               return -EINVAL;
> >
